From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH 1/3] git-find-git: a new helper.
Date: Wed, 23 Nov 2005 19:36:22 -0800
Message-ID: <7vmzjuzphl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Thu Nov 24 04:37:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef7uN-0004X6-KP
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 04:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbVKXDgY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 22:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbVKXDgY
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 22:36:24 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:24518 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932619AbVKXDgY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 22:36:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124033556.KIC3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Nov 2005 22:35:56 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12671>

This is part of rev-format check work, which is currently my top
priority that is holding up any new 1.0rc updates to maint
branch.  It adds a new helper, git-find-git command, to the
suite, and rewrites git-sh-setup to use it.

It adds setup_git_directory_gently(), which is a variant of
existing setup_git_directory() but does not die() if we are not
in a git managed repository.  git-find-git uses it to find the
top-level, and if it was run from a subdirectory, outputs shell
script fragments that can be evaled to define the two variables:

    GIT_DIR_PREFIX is a string to be prepended to cwd relative
    paths to make them repository relative.

    GIT_DIR_UPLEVEL is a string (e.g. "../") for the command to
    use to cd to the top-level of repository.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Makefile        |    2 +-
 cache.h         |    1 +
 find-git.c      |   41 +++++++++++++++++++++++++++++++++++++++++
 git-sh-setup.sh |   39 ++++++++++++++++++++++++++++-----------
 setup.c         |   14 ++++++++++++--
 5 files changed, 83 insertions(+), 14 deletions(-)
 create mode 100644 find-git.c

applies-to: 10227b43e837a38d95d472a0b7c400749fbd46e9
15d4e27b74f4ff0c9faa5bbbfe8e915398f3be97
diff --git a/Makefile b/Makefile
index a97a5d9..dda363a 100644
--- a/Makefile
+++ b/Makefile
@@ -110,7 +110,7 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)
 # The ones that do not have to link with lcrypto nor lz.
 SIMPLE_PROGRAMS = \
 	git-get-tar-commit-id$X git-mailinfo$X git-mailsplit$X \
-	git-stripspace$X git-daemon$X
+	git-stripspace$X git-daemon$X git-find-git$X
 
 # ... and all the rest
 PROGRAMS = \
diff --git a/cache.h b/cache.h
index 6ac94c5..3104c59 100644
--- a/cache.h
+++ b/cache.h
@@ -148,6 +148,7 @@ extern char *get_graft_file(void);
 
 extern const char **get_pathspec(const char *prefix, const char **pathspec);
 extern const char *setup_git_directory(void);
+extern const char *setup_git_directory_gently(int *);
 extern const char *prefix_path(const char *prefix, int len, const char *path);
 
 #define alloc_nr(x) (((x)+16)*3/2)
diff --git a/find-git.c b/find-git.c
new file mode 100644
index 0000000..e063425
--- /dev/null
+++ b/find-git.c
@@ -0,0 +1,41 @@
+#include "cache.h"
+#include "quote.h"
+
+int main(int ac, char **av)
+{
+	int not_a_git = 0;
+	const char *prefix = setup_git_directory_gently(&not_a_git);
+
+	if (!prefix && not_a_git)
+		exit(1);
+
+	/* This can die with malformed configuration file --
+	 * exit code from die() is 128.
+	 */
+	git_config(git_default_config);
+
+	/* Later we check repository version and exit with non-zero
+	 * status after issuing an error message here.
+	 */
+
+	if (!prefix)
+		/* we are at the project toplevel or GIT_DIR is set.
+		 * either case we do not have to muck with the
+		 * environment further.
+		 */
+		exit(0);
+
+	/* this leaks but we do not care ;-) */
+	printf("GIT_DIR_PREFIX=%s\n", sq_quote(prefix));
+	printf("GIT_DIR_UPLEVEL='");
+	while (prefix) {
+		prefix = strchr(prefix, '/');
+		if (prefix) {
+			prefix++;
+			printf("../");
+		}
+	}
+	printf("'\n");
+	printf("export GIT_DIR_PREFIX GIT_DIR_UPLEVEL\n");
+	exit(0);
+}
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index dbb9884..8e30bf6 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -3,13 +3,11 @@
 # Set up GIT_DIR and GIT_OBJECT_DIRECTORY
 # and return true if everything looks ok
 #
-: ${GIT_DIR=.git}
-: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
 
 # Having this variable in your environment would break scripts because
-# you would cause "cd" to be be taken to unexpected places.  If you
-# like CDPATH, define it for your interactive shell sessions without
-# exporting it.
+# you would cause "cd" to be taken to unexpected places.  If you line
+# CDPATH, define it for your interactive shell sessions without exporting
+# it.
 unset CDPATH
 
 die() {
@@ -17,9 +15,28 @@ die() {
 	exit 1
 }
 
-case "$(GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD 2>/dev/null)" in
-refs/*)	: ;;
-*)	false ;;
-esac &&
-[ -d "$GIT_DIR/refs" ] &&
-[ -d "$GIT_OBJECT_DIRECTORY/" ]
+eval "`git-find-git`"
+case "$?" in
+0)
+	: ${GIT_DIR=.git}
+	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
+
+	case "$(GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD 2>/dev/null)" in
+	refs/*)	: ;;
+	*)	false ;;
+	esac &&
+	[ -d "$GIT_DIR/refs" ] &&
+	[ -d "$GIT_OBJECT_DIRECTORY/" ]
+	;;
+*)
+	# (1) we did not find a git directory.  This is sometimes OK.
+	# ls-remote (and parse-remote called from it) uses sh-set to
+	# pick up remotes shortcut if available, but outside git the
+	# user would want to use the command with explicitly spelled
+	# out URL.
+
+	# (128) git-find-git died -- malformed configuration and that
+	# is really fatal.  We have already given the error message.
+
+	;;
+esac
diff --git a/setup.c b/setup.c
index c487d7e..f64ca23 100644
--- a/setup.c
+++ b/setup.c
@@ -92,7 +92,7 @@ static int is_toplevel_directory(void)
 	return 1;
 }
 
-const char *setup_git_directory(void)
+const char *setup_git_directory_gently(int *just_fail_on_ungit)
 {
 	static char cwd[PATH_MAX+1];
 	int len, offset;
@@ -113,8 +113,13 @@ const char *setup_git_directory(void)
 			break;
 		chdir("..");
 		do {
-			if (!offset)
+			if (!offset) {
+				if (just_fail_on_ungit) {
+					*just_fail_on_ungit = 1;
+					return NULL;
+				}
 				die("Not a git repository");
+			}
 		} while (cwd[--offset] != '/');
 	}
 
@@ -127,3 +132,8 @@ const char *setup_git_directory(void)
 	cwd[len] = 0;
 	return cwd + offset;
 }
+
+const char *setup_git_directory(void)
+{
+	return setup_git_directory_gently(NULL);
+}
---
0.99.9.GIT
