From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH] C implementation of the 'git' program.
Date: Thu, 10 Nov 2005 19:26:31 +0100 (CET)
Message-ID: <20051110182631.3C5615BF90@nox.op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 10 19:28:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaH89-0001fi-7r
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 19:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVKJS0e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 13:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbVKJS0e
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 13:26:34 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:22430 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932127AbVKJS0d
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 13:26:33 -0500
Received: from nox.op5.se (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 5B39C6BCFF
	for <git@vger.kernel.org>; Thu, 10 Nov 2005 19:26:31 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 3C5615BF90; Thu, 10 Nov 2005 19:26:31 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11499>

Subject: [PATCH] C implementation of the 'git' program.

This patch provides a C implementation of the 'git' program and introduces
support for putting the git-* commands in their own directory. It also
saves some time on executing git-* commands in a tight loop and it prints
the currently available git commands in a nicely formatted list.

The location of the GIT_LIB can be obtained by running

	git --lib

which will hopefully give porcelainistas ample time to adapt their heavy-duty
loops to use the programs in the library directly if they wish, although
that's strictly speaking not really necessary any more.

Some timing values for 10000 invocations of git-var >&/dev/null;
git.sh: 24.194s
git.c: 9.044s
git-var: 7.377s

The git-<tab><tab> behaviour can still be obtained by adding

	PATH=$PATH:$(git --lib)

to one's .profile.

Experimental libraries can be used by either setting the environment variable
GIT_LIB, or by using

	git --lib=/some/experimental/lib

As a nice side-effect, the patch also fixes the problem with
	make
	make prefix=/usr install

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Documentation/git.txt |    6 +
 Makefile              |   24 ++---
 git.c                 |  224 +++++++++++++++++++++++++++++++++++++++++++++++++
 git.sh                |   76 -----------------
 4 files changed, 239 insertions(+), 91 deletions(-)
 create mode 100644 git.c
 delete mode 100755 git.sh

applies-to: 6466c53ae80cddbb581c5fdb2332f9321fade867
b2b97ed9901915dce573516e3a6f10a60bc0c04a
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2f9622f..848d09a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -8,7 +8,7 @@ git - the stupid content tracker
 
 SYNOPSIS
 --------
-'git-<command>' <args>
+'git' [--version] [--lib[=GIT_LIB]] [--help] <command> <args>
 
 DESCRIPTION
 -----------
@@ -535,7 +535,9 @@ include::../README[]
 
 Author
 ------
-Written by Linus Torvalds <torvalds@osdl.org> and the git-list <git@vger.kernel.org>.
+git's founding father is Linus Torvalds <torvalds@osdl.org>.
+The current git nurse is Junio C. Hamano <junkio@cox.net>.
+Numerous contributions stem from the git-list <git@vger.kernel.org>.
 
 Documentation
 --------------
diff --git a/Makefile b/Makefile
index b202be1..80d865b 100644
--- a/Makefile
+++ b/Makefile
@@ -59,6 +59,8 @@ ALL_CFLAGS = $(CFLAGS)
 
 prefix = $(HOME)
 bindir = $(prefix)/bin
+# XXX set libdir to bindir for now to not break the porcelain
+libdir = $(bindir)
 template_dir = $(prefix)/share/git-core/templates/
 GIT_PYTHON_DIR = $(prefix)/share/git-core/python
 # DESTDIR=
@@ -86,7 +88,7 @@ SCRIPT_SH = \
 	git-prune.sh git-pull.sh git-push.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
 	git-resolve.sh git-revert.sh git-sh-setup.sh git-status.sh \
-	git-tag.sh git-verify-tag.sh git-whatchanged.sh git.sh \
+	git-tag.sh git-verify-tag.sh git-whatchanged.sh \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh git-grep.sh
@@ -323,19 +325,13 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)
 export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
 ### Build rules
 
-all: $(PROGRAMS) $(SCRIPTS)
+all: $(PROGRAMS) $(SCRIPTS) git
 
-all:
-	$(MAKE) -C templates
+git: git.c
+	$(CC) $(CFLAGS) $< -o $@ -DDEFAULT_GIT_LIB='"$(libdir)"' -DGIT_VERSION='"$(GIT_VERSION)"'
 
-git: git.sh Makefile
-	rm -f $@+ $@
-	sed -e '1s|#!.*/sh|#!$(call shq,$(SHELL_PATH))|' \
-	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    -e 's/@@X@@/$(X)/g' \
-	    $(GIT_LIST_TWEAK) <$@.sh >$@+
-	chmod +x $@+
-	mv $@+ $@
+# Force rebuild so that "make prefix=<something> install" Just Works.
+.PHONY: git
 
 $(filter-out git,$(patsubst %.sh,%,$(SCRIPT_SH))) : % : %.sh
 	rm -f $@
@@ -420,8 +416,10 @@ check:
 ### Installation rules
 
 install: $(PROGRAMS) $(SCRIPTS)
+	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(libdir))
+	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(call shellquote,$(DESTDIR)$(libdir))
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(bindir))
-	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(call shellquote,$(DESTDIR)$(bindir))
+	$(INSTALL) git $(call shellquote,$(DESTDIR)$(bindir))
 	$(MAKE) -C templates install
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
 	$(INSTALL) $(PYMODULES) $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
diff --git a/git.c b/git.c
new file mode 100644
index 0000000..8c01723
--- /dev/null
+++ b/git.c
@@ -0,0 +1,224 @@
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <limits.h>
+#include <stdarg.h>
+#include <glob.h>
+
+#ifndef PATH_MAX
+# define PATH_MAX 4096
+#endif
+
+static const char git_usage[] =
+	"Usage: git [--version] [--lib[=<GIT_LIB>]] COMMAND [ OPTIONS ]";
+
+struct string_list {
+	size_t len;
+	char *str;
+	struct string_list *next;
+};
+
+/* most gui terms set COLUMNS (although some don't export it) */
+static int columns(void)
+{
+	char *col_string = getenv("COLUMNS");
+	int n_cols = 0;
+
+	if (col_string && (n_cols = atoi(col_string)) > 0)
+		return n_cols;
+
+	return 80;
+}
+
+static inline void mput_char(char c, unsigned int num)
+{
+	unsigned int i;
+
+	for(i = 0; i < num; i++)
+		putchar(c);
+}
+
+static void fmt_print_string_list(struct string_list *list, int longest)
+{
+	int cols;
+	int space = longest + 1; /* space between start of string1 and string2 */
+	int max_cols = columns() - 1;
+
+	cols = max_cols / space;
+
+	if(cols < 1) {
+		cols = 1;
+		space = 0;
+	}
+
+	while (list) {
+		int c = cols;
+		printf("  ");
+
+		for(c = cols; c; c--) {
+			if (!list)
+				break;
+
+			printf("%s", list->str);
+
+			if (space && c != 1)
+				mput_char(' ', space - list->len);
+
+			list = list->next;
+		}
+
+		putchar('\n');
+	}
+}
+
+#ifdef __GNUC__
+static void usage(char *path, const char *fmt, ...)
+	__attribute__((__format__(__printf__, 2, 3), __noreturn__));
+#endif
+
+static void usage(char *path, const char *fmt, ...)
+{
+	struct string_list *list, *tail;
+	unsigned int longest = 0, i;
+	glob_t gl;
+
+	list = tail = NULL;
+
+	if (!fmt)
+		puts(git_usage);
+	else {
+		printf("git: ");
+		va_list ap;
+		va_start(ap, fmt);
+		vprintf(fmt, ap);
+		va_end(ap);
+		putchar('\n');
+	}
+
+	putchar('\n');
+
+	if (!path)
+		exit(1);
+
+	if (chdir(path) < 0) {
+		printf("git: '%s': %s\n", path, strerror(errno));
+		exit(1);
+	}
+
+	i = glob("git-*", 0, NULL, &gl);
+	if (i) {
+		switch(i) {
+		case GLOB_NOSPACE:
+			puts("Out of memory while glob()'ing commands");
+			exit(2);
+		case GLOB_ABORTED:
+			printf("'%s': Read error: %s\n", path, strerror(errno));
+			exit(2);
+		case GLOB_NOMATCH:
+			printf("No git commands available in '%s'.\n", path);
+			printf("Do you need to specify --lib or set GIT_LIB?\n");
+			exit(1);
+		}
+	}
+
+	for (i = 0; i < gl.gl_pathc; i++) {
+		int len = strlen(gl.gl_pathv[i] + 4);
+
+		if(access(gl.gl_pathv[i], X_OK))
+			continue;
+
+		if (longest < len)
+			longest = len;
+
+		if (!tail)
+			tail = list = malloc(sizeof(struct string_list));
+		else {
+			tail->next = malloc(sizeof(struct string_list));
+			tail = tail->next;
+		}
+		tail->len = len;
+		tail->str = gl.gl_pathv[i] + 4;
+		tail->next = NULL;
+	}
+
+	printf("git commands available in '%s'\n", path);
+	printf("----------------------------");
+	mput_char('-', strlen(path));
+	putchar('\n');
+	fmt_print_string_list(list, longest);
+
+	puts("\nman-pages can be reached through 'man git-<COMMAND>'\n");
+
+	exit(1);
+}
+
+int main(int argc, char **argv, char **envp)
+{
+	char git_command[PATH_MAX + 1];
+	char wd[PATH_MAX + 1];
+	char *git_lib = getenv("GIT_LIB");
+	int i, len;
+
+	getcwd(wd, PATH_MAX);
+
+	if (!git_lib)
+		git_lib = DEFAULT_GIT_LIB;
+
+	if (argc == 1)
+		usage(git_lib, NULL);
+
+	for (i = 1; i < argc; i++) {
+		char *arg = argv[i];
+
+		if (strncmp(arg, "--", 2))
+			break;
+
+		arg += 2;
+
+		if (!strncmp(arg, "lib", 3)) {
+			arg += 3;
+			if (*arg == '=')
+				git_lib = arg + 1;
+			else {
+				puts(git_lib);
+				exit(0);
+			}
+		}
+		else if (!strcmp(arg, "version")) {
+			printf("git version %s\n", GIT_VERSION);
+			exit(0);
+		}
+		else if (!strcmp(arg, "help"))
+			usage(git_lib, NULL);
+		else
+			usage(NULL, NULL);
+	}
+
+	if (i >= argc)
+		usage(NULL, NULL);
+
+	/* allow relative paths, but run with exact */
+	if (chdir(git_lib)) {
+		printf("git: '%s': %s\n", git_lib, strerror(errno));
+		exit (1);
+	}
+
+	getcwd(git_command, sizeof(git_command));
+	chdir(wd);
+
+	len = strlen(git_command);
+	strncat(&git_command[len], "/git-", sizeof(git_command) - len);
+	len += 5;
+	strncat(&git_command[len], argv[i], sizeof(git_command) - len);
+
+	if (access(git_command, X_OK))
+		usage(git_lib, "'%s' is not a git-command", argv[i]);
+
+	/* execve() can only ever return if it fails */
+	execve(git_command, &argv[i], envp);
+	printf("Failed to run command '%s': %s\n", git_command, strerror(errno));
+
+	return 1;
+}
diff --git a/git.sh b/git.sh
deleted file mode 100755
index 94940ae..0000000
--- a/git.sh
+++ /dev/null
@@ -1,76 +0,0 @@
-#!/bin/sh
-
-cmd=
-path=$(dirname "$0")
-case "$#" in
-0)	;;
-*)	cmd="$1"
-	shift
-	case "$cmd" in
-	-v|--v|--ve|--ver|--vers|--versi|--versio|--version)
-		echo "git version @@GIT_VERSION@@"
-		exit 0 ;;
-	esac
-	
-	test -x "$path/git-$cmd" && exec "$path/git-$cmd" "$@"
-	
-	case '@@X@@' in
-	    '')
-		;;
-	    *)
-		test -x "$path/git-$cmd@@X@@" &&
-		exec "$path/git-$cmd@@X@@" "$@"
-		;;
-	esac
-	;;
-esac
-
-echo "Usage: git COMMAND [OPTIONS] [TARGET]"
-if [ -n "$cmd" ]; then
-    echo "git command '$cmd' not found."
-fi
-echo "git commands are:"
-
-fmt <<\EOF | sed -e 's/^/    /'
-add
-apply
-archimport
-bisect
-branch
-checkout
-cherry
-clone
-commit
-count-objects
-cvsimport
-diff
-fetch
-format-patch
-fsck-objects
-get-tar-commit-id
-init-db
-log
-ls-remote
-octopus
-pack-objects
-parse-remote
-patch-id
-prune
-pull
-push
-rebase
-relink
-rename
-repack
-request-pull
-reset
-resolve
-revert
-send-email
-shortlog
-show-branch
-status
-tag
-verify-tag
-whatchanged
-EOF
---
0.99.9.GIT
