From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] One-Git Part 2 (Patch 3/3)
Date: Wed, 1 Jun 2005 14:23:08 -0400
Message-ID: <20050601182308.GA2704@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 01 20:34:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdXyp-000459-UA
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 20:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVFAScI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 14:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVFAS3m
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 14:29:42 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:48335 "EHLO
	timesys.com") by vger.kernel.org with ESMTP id S261562AbVFASXM
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 14:23:12 -0400
Received: by timesys.com (Postfix, from userid 623)
	id 495B6EB2F; Wed,  1 Jun 2005 14:23:08 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add: 'compiled in' scripts, using zlib

one-git now includes everything!

Requires: one-git Part 1 (all patches), and one-git Part 2 (pre 1, pre 2)

Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -20,18 +20,16 @@ CC=gcc
 AR=ar
 INSTALL=install
 
-SCRIPTS=git git-apply-patch-script git-merge-one-file-script git-prune-script \
-	git-pull-script git-tag-script git-resolve-script git-whatchanged \
-	git-deltafy-script git-fetch-script git-status-script git-commit-script \
-	git-log-script
-
 # The following order determines 'git help' command order.
 # The general idea is 'pull, push, inspect, commit, db, misc'
 PROG=   \
+	git-pull \
 	git-local-pull \
 	git-http-pull \
 	git-rpull \
 	git-rpush \
+	git-whatchanged \
+	git-log \
 	git-rev-tree \
 	git-rev-list \
 	git-export \
@@ -45,20 +43,29 @@ PROG=   \
 	git-diff-files \
 	git-diff-cache \
 	git-diff-tree \
+	git-status \
 	git-merge-base \
 	git-merge-cache \
+	git-merge-one-file \
+	git-resolve \
 	git-apply \
+	git-apply-patch \
 	git-check-files \
 	git-write-tree \
 	git-commit-tree \
+	git-commit \
 	git-mktag \
+	git-tag \
 	git-init-db \
 	git-fsck-cache \
+	git-prune \
 	git-convert-cache \
 	git-mkdelta \
+	git-deltafy \
 	git-tar-tree \
 	git-get-tar-commit-id \
 	git-write-blob \
+	git-fetch \
 	git-diff-helper \
 	git-stripspace
 
@@ -86,6 +93,8 @@ LIB_OBJS += pull.o
 
 LIB_OBJS += rsh.o
 
+LIB_OBJS += zscript.o
+
 LIBS = $(LIB_FILE)
 LIBS += -lz
 
@@ -116,8 +125,14 @@ test-date: test-date.c date.o
 test-delta: test-delta.c diff-delta.o patch-delta.o
 	$(CC) $(CFLAGS) -o $@ $^
 
-git-%.o: %.c #Makefile
-	$(CC) $(CFLAGS) -c -o $@ $*.c -Dmain=git_$(subst -,_,$*) -Ddesc=git_$(subst -,_,$*)_desc
+git-%-script.h: git-%-script
+	./zwrap script <git-$*-script >git-$*-script.h
+
+git-%.o: zwrap git-%-script git-%-script.h git-script.c
+	$(CC) $(CFLAGS) -c -o $@ git-script.c -Dscript=git_$(subst -,_,$*)_script -Dmain=git_$(subst -,_,$*) --include git-$*-script.h
+
+git-%.o: %.c Makefile
+	$(CC) $(CFLAGS) -c -o $@ $*.c -Dmain=git_$(subst -,_,$*)
 
 $(PROG):
 	ln -s git $@
@@ -127,7 +142,10 @@ git.o: git-commands.h
 git: git.o $(patsubst %,%.o,$(PROG)) $(LIBS)
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
-git-commands.h: Makefile $(patsubst %,Documentation/%.txt,$(PROG))
+zwrap: zwrap.o $(LIBS)
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+
+git-commands.h: Makefile #$(patsubst %,Documentation/%.txt,$(PROG))
 	echo -n >git-commands.h
 	for prog in $(subst -,_,$(PROG)); do \
 		echo "extern int $${prog}(int argc, char **argv);" >>git-commands.h ; \
@@ -139,7 +157,14 @@ git-commands.h: Makefile $(patsubst %,Do
 	echo "	const char *desc; } commands[]={" >>git-commands.h
 	for cmd in $(patsubst git-%,%,$(PROG)); do \
 		prog=`echo $$cmd | sed -e 's/-/_/g'` ; \
-		desc=`grep "^git-$$cmd - " Documentation/git-$$cmd.txt | cut -d' ' -f3-` ; \
+		if [ -f Documentation/git-$${cmd}-script.txt ]; then \
+		  doc=Documentation/git-$${cmd}-script.txt; \
+		else doc=Documentation/git-$${cmd}.txt; fi; \
+		if [ ! -e $${doc} ]; then \
+			echo "MISSING: $$doc" 1>&2; \
+			rm -f git-commands.h; \
+			exit 1; fi; \
+		desc=`grep "^git-$$cmd - " $$doc | cut -d' ' -f3-` ; \
 		desc=`echo "$$desc" | sed -e 's/"/\\\\"/g'` ; \
 		echo -n "	{ " >>git-commands.h ; \
 		echo -n ".command = \"$${cmd}\", " >>git-commands.h ; \
@@ -172,7 +197,8 @@ test: all
 	$(MAKE) -C t/ all
 
 clean:
-	rm -f *.o mozilla-sha1/*.o ppc/*.o git $(PROG) $(LIB_FILE)
+	rm -f *.o mozilla-sha1/*.o ppc/*.o \
+		zwrap git $(PROG) $(LIB_FILE) git-*-script.h
 	$(MAKE) -C Documentation/ clean
 
 backup: clean
diff --git a/git b/git
deleted file mode 100755
--- a/git
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-cmd="git-$1-script"
-shift
-exec $cmd "$@"
diff --git a/git-script.c b/git-script.c
new file mode 100644
--- /dev/null
+++ b/git-script.c
@@ -0,0 +1,8 @@
+#include <stdio.h>
+
+extern int zscript(const void *s, size_t s_len, int argc, char **argv);
+
+int main(int argc, char **argv)
+{
+	return zscript(script,sizeof(script),argc,argv);
+}
diff --git a/zscript.c b/zscript.c
new file mode 100644
--- /dev/null
+++ b/zscript.c
@@ -0,0 +1,62 @@
+#include <stdio.h>
+#include <sys/wait.h>
+#include <sys/types.h>
+
+#include <zlib.h>
+
+#include "cache.h"
+
+int zscript(void *script, size_t script_len, int argc, char **argv)
+{
+	z_stream stream;
+	char buff[8192];
+	int fd, ret, status;
+	pid_t pid;
+	char template[]="/tmp/git-script.XXXXXX";
+
+	fd = mkstemp(template);
+	if (fd < 0)
+		die("Can't create file %s\n",template);
+
+	memset(&stream, 0, sizeof(stream));
+	stream.next_in = script;
+	stream.avail_in = script_len;
+
+	inflateInit(&stream);
+	do {
+		stream.next_out = buff;
+		stream.avail_out = sizeof(buff);
+		ret = inflate(&stream, Z_SYNC_FLUSH);
+		write(fd,buff,sizeof(buff)-stream.avail_out);
+	} while (stream.avail_in && ret == Z_OK);
+	inflateEnd(&stream);
+
+	pid = fork();
+	if (pid < 0) {
+		unlink(template);
+		die("Can't fork.");
+	}
+
+	if (! pid) {	/* Child */
+		char **args;
+		args=xmalloc(sizeof(char *)*(argc+1));
+		memcpy(&args[2],&argv[1],sizeof(char *)*(argc-1));
+		argv[0]="/bin/sh";
+		argv[1]=template;
+		execv("/bin/sh",argv);
+		exit(1);	/* Hopefully unreachable */
+	}
+
+	if (waitpid(pid, &status, 0) < 0 ||
+		!WIFEXITED(status) || WEXITSTATUS(status))
+		goto error;
+
+	unlink(template);
+	return 0;
+
+
+error:
+	unlink(template);
+	return 1;
+}
+		
diff --git a/zwrap.c b/zwrap.c
new file mode 100644
--- /dev/null
+++ b/zwrap.c
@@ -0,0 +1,88 @@
+/* Takes stdin, and makes a C header file out of it, compressed
+ * with zlib.
+ *
+ * Author: Jason McMullan <jason.mcmullan@timesys.com>
+ */
+
+#include <stdio.h>
+#include <zlib.h>
+
+#include "cache.h"
+
+unsigned char *read_from(int fd, size_t *bsize)
+{
+	unsigned char *buff;
+	int len;
+	size_t size;
+
+	buff=xmalloc(1024);
+	size = 0;
+
+	while ((len = read(fd, buff, 1024-(size % 1024))) > 0) {
+		size += len;
+		if ((size % 1024)==0)
+			buff = xrealloc(buff, size+1024);
+	}
+
+	if (len < 0) {
+		size=0;
+		free(buff);
+		buff=NULL;
+	}
+
+	*bsize = size;
+	return buff;
+}
+
+
+int main(int argc, char **argv)
+{
+	const char *name="data";
+	z_stream stream;
+	size_t size, dsize;
+	unsigned char *dbuff,*buff;
+
+	if (argc == 2)
+		name=argv[1];
+	else if (argc != 1) {
+		fprintf(stderr,"Usage:\n%s [name] <somefile\n",argv[0]);
+		return 1;
+	}
+
+	buff=read_from(0, &size);
+	if (buff == NULL)
+		return 1;
+
+	/* Init zlib */
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, Z_BEST_COMPRESSION);
+	dsize = deflateBound(&stream, size);
+	dbuff = xmalloc(dsize);
+
+	stream.next_out = dbuff;
+	stream.avail_out = dsize;
+
+	while (deflate(&stream, 0) == Z_OK)
+		/* nothing */;
+
+	stream.next_in  = buff;
+	stream.avail_in  = size;
+	while (deflate(&stream, Z_FINISH) == Z_OK)
+		/* nothing */;
+	deflateEnd(&stream);
+
+	dsize = stream.total_out;
+
+	printf("const unsigned char %s[] = {\n", name);
+	for ( size = 0; size < dsize; size++) {
+		if ((size % 8) == 0)
+			printf("\t");
+		printf("0x%.2x,",dbuff[size]);
+		if ((size % 8) == 7)
+			printf("\n");
+	}
+	printf("};\n");
+
+	return 0;
+}
+
======== end ========

