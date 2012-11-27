EXECUTABLES :=	usemem \
		usemem_migrate \
		usemem_remap \
		usemem_ksm \
		usemem_ksm_hugepages \
		usemem_direct_write \
		usemem_mbind

all:	$(EXECUTABLES)

clean:
	rm -f *.o

distclean: clean
	rm -f $(EXECUTABLES)

usemem: usemem.o usemem_hugepages.o usemem_mincore.o
	gcc -pthread -Wall -O -g usemem_mincore.o usemem_hugepages.o usemem.o -o usemem

usemem.o: usemem.c
	gcc -O -c -Wall -g  usemem.c -o usemem.o

usemem_hugepages.o: usemem_hugepages.c
	gcc -Wall -O -c -g usemem_hugepages.c -o usemem_hugepages.o

usemem_mincore.o: usemem_mincore.c
	gcc -Wall -O -c -g usemem_mincore.c -o usemem_mincore.o

usemem_migrate: usemem_migrate.c
	gcc -Wall -O -g -o usemem_migrate usemem_migrate.c -lnuma

usemem_ksm: usemem_ksm.c usemem_hugepages.c
	gcc -Wall -g -o usemem_ksm usemem_ksm.c usemem_hugepages.c

usemem_mbind: usemem_mbind.c
	gcc -Wall -g -o usemem_mbind usemem_mbind.c -lnuma

usemem_ksm_hugepages: usemem_ksm_hugepages.c
	gcc -Wall -g -o usemem_ksm_hugepages usemem_ksm_hugepages.c

usemem_direct_write: usemem_direct_write.c
	gcc -Wall -g -o usemem_direct_write usemem_direct_write.c

usemem_remap: usemem_remap.c
	gcc -Wall -g -o usemem_remap usemem_remap.c
