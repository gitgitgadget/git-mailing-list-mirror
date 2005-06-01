From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] One Git To Rule Them All - Final
Date: Wed, 1 Jun 2005 02:00:17 -0400
Message-ID: <20050601060017.GA15937@port.evillabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 01 07:58:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdMFB-0001Xo-9j
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 07:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVFAGBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 02:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVFAGBF
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 02:01:05 -0400
Received: from c-67-163-246-116.hsd1.pa.comcast.net ([67.163.246.116]:15304
	"EHLO port.evillabs.net") by vger.kernel.org with ESMTP
	id S261289AbVFAGAR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 02:00:17 -0400
Received: by port.evillabs.net (Postfix, from userid 500)
	id A61D84001; Wed,  1 Jun 2005 02:00:17 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

one-git

One git to rule them all... 

This patch make a 'git' binary that has all of the git-* commands linked in,
instead of a zillion little git-* commands. As an interesting side effect,
documentation for each command is required in Documention/git-<mumble>.txt
for compilation to succeed. ;^)

The install still creates git-<mumble> commands in $HOME/bin, so there should
be no compatability issues.

This patch saves 2.4M on my Athlon 64 system - a 7x size reduction. Whee!

REQURIES one-git pre patches 1 and 2

Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -24,19 +24,48 @@ SCRIPTS=git-apply-patch-script git-merge
 	git-pull-script git-tag-script git-resolve-script git-whatchanged \
 	git-deltafy-script git-fetch-script git-status-script git-commit-script
 
-PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
-	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
-	git-checkout-cache git-diff-tree git-rev-tree git-ls-files \
-	git-check-files git-ls-tree git-merge-base git-merge-cache \
-	git-unpack-file git-export git-diff-cache git-convert-cache \
-	git-http-pull git-rpush git-rpull git-rev-list git-mktag \
-	git-diff-helper git-tar-tree git-local-pull git-write-blob \
-	git-get-tar-commit-id git-mkdelta git-apply git-stripspace
-
-all: $(PROG)
-
-install: $(PROG) $(SCRIPTS)
-	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bin)
+# The following order determines 'git help' command order.
+# The general idea is 'pull, push, inspect, commit, db, misc'
+PROG=   \
+	git-local-pull \
+	git-http-pull \
+	git-rpull \
+	git-rpush \
+	git-rev-tree \
+	git-rev-list \
+	git-export \
+	git-read-tree \
+	git-checkout-cache \
+	git-update-cache \
+	git-ls-tree \
+	git-ls-files \
+	git-cat-file \
+	git-unpack-file \
+	git-diff-files \
+	git-diff-cache \
+	git-diff-tree \
+	git-merge-base \
+	git-merge-cache \
+	git-apply \
+	git-check-files \
+	git-write-tree \
+	git-commit-tree \
+	git-mktag \
+	git-init-db \
+	git-fsck-cache \
+	git-convert-cache \
+	git-mkdelta \
+	git-tar-tree \
+	git-get-tar-commit-id \
+	git-write-blob \
+	git-diff-helper \
+	git-stripspace
+
+all: git $(PROG)
+
+install: git $(PROG) $(SCRIPTS)
+	$(INSTALL) git $(SCRIPTS) $(dest)$(bin)
+	for prog in $(PROG); do ln -sf git $(dest)$(bin)/$$prog; done
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o delta.o date.o index.o diff-delta.o patch-delta.o
@@ -52,9 +81,16 @@ LIB_OBJS += diff.o diffcore-rename.o dif
 
 LIB_OBJS += gitenv.o
 
+LIB_OBJS += pull.o
+
+LIB_OBJS += rsh.o
+
 LIBS = $(LIB_FILE)
 LIBS += -lz
 
+# For git-http-pull
+LIBS += -lcurl
+
 ifdef MOZILLA_SHA1
   SHA1_HEADER="mozilla-sha1/sha1.h"
   LIB_OBJS += mozilla-sha1/sha1.o
@@ -79,42 +115,39 @@ test-date: test-date.c date.o
 test-delta: test-delta.c diff-delta.o patch-delta.o
 	$(CC) $(CFLAGS) -o $@ $^
 
-git-%: %.c $(LIB_FILE)
-	$(CC) $(CFLAGS) -o $@ $(filter %.c,$^) $(LIBS)
+git-%.o: %.c #Makefile
+	$(CC) $(CFLAGS) -c -o $@ $*.c -Dmain=git_$(subst -,_,$*) -Ddesc=git_$(subst -,_,$*)_desc
+
+$(PROG):
+	ln -s git $@
+
+git.o: git-commands.h
 
-git-update-cache: update-cache.c
-git-diff-files: diff-files.c
-git-init-db: init-db.c
-git-write-tree: write-tree.c
-git-read-tree: read-tree.c
-git-commit-tree: commit-tree.c
-git-cat-file: cat-file.c
-git-fsck-cache: fsck-cache.c
-git-checkout-cache: checkout-cache.c
-git-diff-tree: diff-tree.c
-git-rev-tree: rev-tree.c
-git-ls-files: ls-files.c
-git-check-files: check-files.c
-git-ls-tree: ls-tree.c
-git-merge-base: merge-base.c
-git-merge-cache: merge-cache.c
-git-unpack-file: unpack-file.c
-git-export: export.c
-git-diff-cache: diff-cache.c
-git-convert-cache: convert-cache.c
-git-http-pull: http-pull.c pull.c
-git-local-pull: local-pull.c pull.c
-git-rpush: rsh.c
-git-rpull: rsh.c pull.c
-git-rev-list: rev-list.c
-git-mktag: mktag.c
-git-diff-helper: diff-helper.c
-git-tar-tree: tar-tree.c
-git-write-blob: write-blob.c
-git-mkdelta: mkdelta.c
-git-stripspace: stripspace.c
+git: git.o $(patsubst %,%.o,$(PROG)) $(LIBS)
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+
+git-commands.h: Makefile $(patsubst %,Documentation/%.txt,$(PROG))
+	echo -n >git-commands.h
+	for prog in $(subst -,_,$(PROG)); do \
+		echo "extern int $${prog}(int argc, char **argv);" >>git-commands.h ; \
+		echo "extern const char *$${prog}_desc;" >>git-commands.h ; \
+	done
+	echo "struct git_command { ">>git-commands.h
+	echo "	const char *command;" >>git-commands.h
+	echo "	int (*main)(int argc,char **argv);" >>git-commands.h
+	echo "	const char *desc; } commands[]={" >>git-commands.h
+	for cmd in $(patsubst git-%,%,$(PROG)); do \
+		prog=`echo $$cmd | sed -e 's/-/_/g'` ; \
+		desc=`grep "^git-$$cmd - " Documentation/git-$$cmd.txt | cut -d' ' -f3-` ; \
+		desc=`echo "$$desc" | sed -e 's/"/\\\\"/g'` ; \
+		echo -n "	{ " >>git-commands.h ; \
+		echo -n ".command = \"$${cmd}\", " >>git-commands.h ; \
+		echo -n ".main = git_$${prog}, " >>git-commands.h ; \
+	        echo -n ".desc = \"$$desc\", " >>git-commands.h ; \
+		echo "}," >>git-commands.h ; \
+	done
+	echo "};" >>git-commands.h
 
-git-http-pull: LIBS += -lcurl
 
 # Library objects..
 blob.o: $(LIB_H)
@@ -138,7 +171,7 @@ test: all
 	$(MAKE) -C t/ all
 
 clean:
-	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE)
+	rm -f *.o mozilla-sha1/*.o ppc/*.o git $(PROG) $(LIB_FILE)
 	$(MAKE) -C Documentation/ clean
 
 backup: clean
diff --git a/git.c b/git.c
new file mode 100644
--- /dev/null
+++ b/git.c
@@ -0,0 +1,57 @@
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+
+#include "git-commands.h"
+
+#define COMMAND_LEN	(sizeof(commands)/sizeof(commands[0]))
+
+typedef int (*func)(int argc, char **argv);
+
+func lookup_basename(const char *program)
+{
+	const char *cp;
+	int i;
+
+	cp=strrchr(program,'/');
+	if (cp==NULL)
+		cp=program;
+	else
+		cp++;
+
+	if (strncmp(cp,"git-",4)==0)
+		cp+=4;
+
+	for (i = 0; i < COMMAND_LEN; i++)
+		if (!strcmp(cp,commands[i].command))
+			return commands[i].main;
+
+	return NULL;
+}
+
+int main(int argc, char **argv)
+{
+	int (*do_main)(int argc, char **argv);
+	int i;
+
+	do_main = lookup_basename(argv[0]);
+
+	if (!do_main && argc > 1 ) {
+		do_main = lookup_basename(argv[1]);
+		if (do_main) {
+			argc--;
+			argv++;
+		}
+	}
+
+	if (do_main) {
+		return do_main(argc, argv);
+	}
+
+	fprintf(stderr,"GIT Commands:\n\n");
+	for (i = 0; i < COMMAND_LEN; i++)
+		fprintf(stderr,"\t%-24s%s\n",commands[i].command,commands[i].desc);
+	fprintf(stderr,"\n");
+
+	return 1;
+}
