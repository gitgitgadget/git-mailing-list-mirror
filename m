From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH 1/3] C implementation of the 'git' program, take two.
Date: Wed, 16 Nov 2005 00:31:25 +0100 (CET)
Message-ID: <20051115233125.3153B5BF76@nox.op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 16 00:32:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcAH4-0003qm-Bl
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 00:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbVKOXbd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 18:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbVKOXbd
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 18:31:33 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:52425 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932572AbVKOXbc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 18:31:32 -0500
Received: from vrrx50sn1.teliamobile.net (192.71.148.196) by pne-smtpout2-sn1.fre.skanova.net (7.2.060.1)
        id 4378F3940006B5EF for git@vger.kernel.org; Wed, 16 Nov 2005 00:31:25 +0100
Received: from nox.op5.se (host-n13-90.homerun.telia.com [212.181.228.90])
	by vrrx50sn1.teliamobile.net (8.11.6/8.11.6) with ESMTP id jAFNVPf24371
	for <git@vger.kernel.org>; Wed, 16 Nov 2005 00:31:25 +0100
Received: by nox.op5.se (Postfix, from userid 500)
	id 3153B5BF76; Wed, 16 Nov 2005 00:31:25 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11963>


This patch provides a C implementation of the 'git' program and
introduces support for putting the git-* commands in a directory
of their own. It also saves some time on executing those commands
in a tight loop and it prints the currently available git commands
in a nicely formatted list.

The location of the GIT_EXEC_PATH (name discussion's closed, thank gods)
can be obtained by running

	git --exec-path

which will hopefully give porcelainistas ample time to adapt their
heavy-duty loops to call the core programs directly and thus save
the extra fork() / execve() overhead, although that's not really
necessary any more.

The --exec-path value is prepended to $PATH, so the git-* programs
should Just Work without ever requiring any changes to how they call
other programs in the suite.

Some timing values for 10000 invocations of git-var >&/dev/null:
	git.sh: 24.194s
	git.c:   9.044s
	git-var: 7.377s

The git-<tab><tab> behaviour can, along with the someday-to-be-deprecated
git-<command> form of invocation, be indefinitely retained by adding
the following line to one's .bash_profile or equivalent:

	PATH=$PATH:$(git --exec-path)

Experimental libraries can be used by either setting the environment variable
GIT_EXEC_PATH, or by using

	git --exec-path=/some/experimental/exec-path

Relative paths are properly grok'ed as exec-path values.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Makefile |   20 ++---
 git.c    |  229 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git.sh   |   76 ---------------------
 3 files changed, 237 insertions(+), 88 deletions(-)
 create mode 100644 git.c
 delete mode 100755 git.sh

applies-to: 4b6dbe856a3e63699b299c76f4f1fc5cb34cbe26
d9a0c94f64a140b5e32d8541875e77ee96ed5ff8
diff --git a/Makefile b/Makefile
index 63cb998..0515968 100644
--- a/Makefile
+++ b/Makefile
@@ -88,7 +88,7 @@ SCRIPT_SH = \
 	git-prune.sh git-pull.sh git-push.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
 	git-resolve.sh git-revert.sh git-sh-setup.sh git-status.sh \
-	git-tag.sh git-verify-tag.sh git-whatchanged.sh git.sh \
+	git-tag.sh git-verify-tag.sh git-whatchanged.sh \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh git-grep.sh \
@@ -334,19 +334,15 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)
 export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
 ### Build rules
 
-all: $(PROGRAMS) $(SCRIPTS)
+all: $(PROGRAMS) $(SCRIPTS) git
 
 all:
 	$(MAKE) -C templates
 
-git: git.sh Makefile
-	rm -f $@+ $@
-	sed -e '1s|#!.*/sh|#!$(call shq,$(SHELL_PATH))|' \
-	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    -e 's/@@X@@/$(X)/g' \
-	    $(GIT_LIST_TWEAK) <$@.sh >$@+
-	chmod +x $@+
-	mv $@+ $@
+# Only use $(CFLAGS). We don't need anything else.
+git: git.c Makefile
+	$(CC) -DGIT_EXEC_PATH='"$(bindir)"' -DGIT_VERSION='"$(GIT_VERSION)"' \
+		$(CFLAGS) $@.c -o $@
 
 $(filter-out git,$(patsubst %.sh,%,$(SCRIPT_SH))) : % : %.sh
 	rm -f $@
@@ -431,9 +427,9 @@ check:
 
 ### Installation rules
 
-install: $(PROGRAMS) $(SCRIPTS)
+install: $(PROGRAMS) $(SCRIPTS) git
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(bindir))
-	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(call shellquote,$(DESTDIR)$(bindir))
+	$(INSTALL) git $(PROGRAMS) $(SCRIPTS) $(call shellquote,$(DESTDIR)$(bindir))
 	$(MAKE) -C templates install
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
 	$(INSTALL) $(PYMODULES) $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
diff --git a/git.c b/git.c
new file mode 100644
index 0000000..d189801
--- /dev/null
+++ b/git.c
@@ -0,0 +1,229 @@
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
+	"Usage: git [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND [ ARGS ]";
+
+struct string_list {
+	size_t len;
+	char *str;
+	struct string_list *next;
+};
+
+/* most gui terms set COLUMNS (although some don't export it) */
+static int term_columns(void)
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
+	while(num--)
+		putchar(c);
+}
+
+static void pretty_print_string_list(struct string_list *list, int longest)
+{
+	int cols = 1;
+	int space = longest + 1; /* min 1 SP between words */
+	int max_cols = term_columns() - 1; /* don't print *on* the edge */
+
+	if (space < max_cols)
+		cols = max_cols / space;
+
+	while (list) {
+		int c;
+		printf("  ");
+
+		for (c = cols; c && list; list = list->next) {
+			printf("%s", list->str);
+
+			if (--c)
+				mput_char(' ', space - list->len);
+		}
+		putchar('\n');
+	}
+}
+
+static void list_commands(const char *exec_path, const char *pattern)
+{
+	struct string_list *list = NULL, *tail = NULL;
+	unsigned int longest = 0, i;
+	glob_t gl;
+
+	if (chdir(exec_path) < 0) {
+		printf("git: '%s': %s\n", exec_path, strerror(errno));
+		exit(1);
+	}
+
+	i = glob(pattern, 0, NULL, &gl);
+	switch(i) {
+	case GLOB_NOSPACE:
+		puts("Out of memory when running glob()");
+		exit(2);
+	case GLOB_ABORTED:
+		printf("'%s': Read error: %s\n", exec_path, strerror(errno));
+		exit(2);
+	case GLOB_NOMATCH:
+		printf("No git commands available in '%s'.\n", exec_path);
+		printf("Do you need to specify --exec-path or set GIT_EXEC_PATH?\n");
+		exit(1);
+	}
+
+	for (i = 0; i < gl.gl_pathc; i++) {
+		int len = strlen(gl.gl_pathv[i] + 4);
+
+		if (access(gl.gl_pathv[i], X_OK))
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
+	printf("git commands available in '%s'\n", exec_path);
+	printf("----------------------------");
+	mput_char('-', strlen(exec_path));
+	putchar('\n');
+	pretty_print_string_list(list, longest);
+	putchar('\n');
+}
+
+#ifdef __GNUC__
+static void usage(const char *exec_path, const char *fmt, ...)
+	__attribute__((__format__(__printf__, 2, 3), __noreturn__));
+#endif
+static void usage(const char *exec_path, const char *fmt, ...)
+{
+	if (fmt) {
+		va_list ap;
+
+		va_start(ap, fmt);
+		printf("git: ");
+		vprintf(fmt, ap);
+		va_end(ap);
+		putchar('\n');
+	}
+	else
+		puts(git_usage);
+
+	putchar('\n');
+
+	if(exec_path)
+		list_commands(exec_path, "git-*");
+
+	exit(1);
+}
+
+static void prepend_to_path(const char *dir, int len)
+{
+	char *path, *old_path = getenv("PATH");
+	int path_len = len;
+
+	if (!old_path)
+		old_path = "/bin:/usr/bin:.";
+
+	path_len = len + strlen(old_path) + 1;
+
+	path = malloc(path_len + 1);
+	path[path_len + 1] = '\0';
+
+	memcpy(path, dir, len);
+	path[len] = ':';
+	memcpy(path + len + 1, old_path, path_len - len);
+
+	setenv("PATH", path, 1);
+}
+
+int main(int argc, char **argv, char **envp)
+{
+	char git_command[PATH_MAX + 1];
+	char wd[PATH_MAX + 1];
+	int i, len, show_help = 0;
+	char *exec_path = getenv("GIT_EXEC_PATH");
+
+	getcwd(wd, PATH_MAX);
+
+	if (!exec_path)
+		exec_path = GIT_EXEC_PATH;
+
+	for (i = 1; i < argc; i++) {
+		char *arg = argv[i];
+
+		if (strncmp(arg, "--", 2))
+			break;
+
+		arg += 2;
+
+		if (!strncmp(arg, "exec-path", 9)) {
+			arg += 9;
+			if (*arg == '=')
+				exec_path = arg + 1;
+			else {
+				puts(exec_path);
+				exit(0);
+			}
+		}
+		else if (!strcmp(arg, "version")) {
+			printf("git version %s\n", GIT_VERSION);
+			exit(0);
+		}
+		else if (!strcmp(arg, "help"))
+			show_help = 1;
+		else if (!show_help)
+			usage(NULL, NULL);
+	}
+
+	if (i >= argc || show_help)
+		usage(exec_path, NULL);
+
+	/* allow relative paths, but run with exact */
+	if (chdir(exec_path)) {
+		printf("git: '%s': %s\n", exec_path, strerror(errno));
+		exit (1);
+	}
+
+	getcwd(git_command, sizeof(git_command));
+	chdir(wd);
+
+	len = strlen(git_command);
+	prepend_to_path(git_command, len);
+
+	strncat(&git_command[len], "/git-", sizeof(git_command) - len);
+	len += 5;
+	strncat(&git_command[len], argv[i], sizeof(git_command) - len);
+
+	if (access(git_command, X_OK))
+		usage(exec_path, "'%s' is not a git-command", argv[i]);
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
