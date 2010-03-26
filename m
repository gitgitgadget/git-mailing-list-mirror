From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH 02/12] Implement "git mv" for submodules
Date: Fri, 26 Mar 2010 15:25:30 +0000
Message-ID: <1269617140-7827-3-git-send-email-peter@pcc.me.uk>
References: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 16:26:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvBQc-0005ou-Pn
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358Ab0CZPZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:25:59 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:55540 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710Ab0CZPZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 11:25:56 -0400
Received: from [10.179.145.9] (helo=lapas.pcc.me.uk)
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ2-0001o3-19; Fri, 26 Mar 2010 15:25:54 +0000
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ0-000237-Us; Fri, 26 Mar 2010 15:25:52 +0000
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143240>

This patch teaches "git mv" how to handle moving submodules, including
how to update the .gitmodules file.

The .gitmodules update is handled by an undocumented subcommand to
"git submodule" named "mvconfig".

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 Documentation/git-mv.txt |    7 ++-
 builtin/mv.c             |   33 ++++++++++++++--
 git-submodule.sh         |   16 +++++++-
 t/t7409-submodule-mv.sh  |   94 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 143 insertions(+), 7 deletions(-)
 create mode 100755 t/t7409-submodule-mv.sh

diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index bdcb585..632a6a9 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -14,8 +14,8 @@ DESCRIPTION
 -----------
 This script is used to move or rename a file, directory or symlink.
 
- git mv [-f] [-n] <source> <destination>
- git mv [-f] [-n] [-k] <source> ... <destination directory>
+ git mv [-f] [-n] [-M] <source> <destination>
+ git mv [-f] [-n] [-k] [-M] <source> ... <destination directory>
 
 In the first form, it renames <source>, which must exist and be either
 a file, symlink or directory, to <destination>.
@@ -39,6 +39,9 @@ OPTIONS
 --dry-run::
 	Do nothing; only show what would happen
 
+-M::
+	Do not try to update submodule paths in .gitmodules
+
 
 Author
 ------
diff --git a/builtin/mv.c b/builtin/mv.c
index c07f53b..21fd03f 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "run-command.h"
 
 static const char * const builtin_mv_usage[] = {
 	"git mv [options] <source>... <destination>",
@@ -53,11 +54,12 @@ static struct lock_file lock_file;
 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
 	int i, newfd;
-	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0;
+	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0, skip_module_update = 0;
 	struct option builtin_mv_options[] = {
 		OPT__DRY_RUN(&show_only),
 		OPT_BOOLEAN('f', "force", &force, "force move/rename even if target exists"),
 		OPT_BOOLEAN('k', NULL, &ignore_errors, "skip move/rename errors"),
+		OPT_BOOLEAN('M', NULL, &skip_module_update, "don't update submodule entries"),
 		OPT_END(),
 	};
 	const char **source, **destination, **dest_path;
@@ -96,13 +98,14 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	/* Checking */
 	for (i = 0; i < argc; i++) {
 		const char *src = source[i], *dst = destination[i];
-		int length, src_is_dir;
+		int length, src_is_dir, pos;
 		const char *bad = NULL;
 
 		if (show_only)
 			printf("Checking rename of '%s' to '%s'\n", src, dst);
 
 		length = strlen(src);
+		pos = cache_name_pos(src, length);
 		if (lstat(src, &st) < 0)
 			bad = "bad source";
 		else if (!strncmp(src, dst, length) &&
@@ -111,7 +114,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		} else if ((src_is_dir = S_ISDIR(st.st_mode))
 				&& lstat(dst, &st) == 0)
 			bad = "cannot move directory over file";
-		else if (src_is_dir) {
+		else if (src_is_dir &&
+				!(pos >= 0 &&
+				  S_ISGITLINK(active_cache[pos]->ce_mode))) {
 			const char *src_w_slash = add_slash(src);
 			int len_w_slash = length + 1;
 			int first, last;
@@ -162,7 +167,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				}
 				argc += last - first;
 			}
-		} else if (cache_name_pos(src, length) < 0)
+		} else if (pos < 0)
 			bad = "not under version control";
 		else if (lstat(dst, &st) == 0) {
 			bad = "destination exists";
@@ -223,5 +228,25 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			die("Unable to write new index file");
 	}
 
+	if (!show_only && !skip_module_update)
+		for (i = 0; i < argc; i++) {
+			const char *src = source[i], *dst = destination[i];
+			int pos;
+
+			if (modes[i] == WORKING_DIRECTORY)
+				continue;
+
+			pos = cache_name_pos(dst, strlen(dst));
+			assert(pos >= 0);
+
+			if (S_ISGITLINK(active_cache[pos]->ce_mode)) {
+				const char *argv_submodule[] = {
+					"submodule", "mvconfig", src, dst, NULL
+				};
+
+				run_command_v_opt(argv_submodule, RUN_GIT_CMD);
+			}
+		}
+
 	return 0;
 }
diff --git a/git-submodule.sh b/git-submodule.sh
index f05ff4e..d0b7a79 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -856,6 +856,20 @@ cmd_sync()
 		fi
 	done
 }
+#
+# Updates the entry in .gitmodules to move a submodule.
+# This command is called by "git mv" for each submodule it moves.
+#
+cmd_mvconfig()
+{
+	src="$1"
+	dst="$2"
+
+	name=$(module_name "$src") || exit
+	git config -f .gitmodules submodule."$name".path "$dst" ||
+		die "Could not update .gitmodules entry for $name"
+	git add .gitmodules || die "Could not add .gitmodules to index"
+}
 
 # This loop parses the command line arguments to find the
 # subcommand name to dispatch.  Parsing of the subcommand specific
@@ -866,7 +880,7 @@ cmd_sync()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | update | status | summary | sync)
+	add | foreach | init | update | status | summary | sync | mvconfig)
 		command=$1
 		;;
 	-q|--quiet)
diff --git a/t/t7409-submodule-mv.sh b/t/t7409-submodule-mv.sh
new file mode 100755
index 0000000..9eb3fb1
--- /dev/null
+++ b/t/t7409-submodule-mv.sh
@@ -0,0 +1,94 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Peter Collingbourne
+#
+
+test_description='git submodule mv
+
+These tests exercise the "git mv" command for submodules.
+'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo file > file &&
+	git add file &&
+	test_tick &&
+	git commit -m upstream
+	git clone . super &&
+	git clone super submodule &&
+	(cd super &&
+	 git submodule add -n reg ../submodule reg &&
+	 git clone reg unreg &&
+	 git add unreg &&
+	 test_tick &&
+	 git commit -m "submodules"
+	)'
+
+test_expect_success 'move registered submodule' '
+	(cd super &&
+	 git mv reg reg2 &&
+	 test -z "$(git ls-files reg)" &&
+	 test -n "$(git ls-files reg2)" &&
+	 test ! -d reg &&
+	 test -d reg2 &&
+	 test -d reg2/.git &&
+	 test "$(git config -f .gitmodules submodule.reg.path)" = "reg2" &&
+	 test_tick &&
+	 git commit -a -m "move reg"
+	)
+'
+
+test_expect_success 'move unregistered submodule' '
+	(cd super &&
+	 git mv unreg unreg2 &&
+	 test ! -d unreg &&
+	 test -d unreg2 &&
+	 test -d unreg2/.git &&
+	 test_tick &&
+	 git commit -a -m "move unreg"
+	)
+'
+
+test_expect_success 'move unregistered uninitialised submodule' '
+	(cd super &&
+	 rm -rf unreg2 &&
+	 mkdir unreg2 &&
+	 git mv unreg2 unreg &&
+	 test -z "$(git ls-files unreg2)" &&
+	 test -n "$(git ls-files unreg)" &&
+	 test ! -d unreg2 &&
+	 test -d unreg &&
+	 test_tick &&
+	 git commit -a -m "move unreg2"
+	)
+'
+
+test_expect_success 'move registered submodule without changing .gitmodules' '
+	(cd super &&
+	 git mv -M reg2 reg &&
+	 test ! -d reg2 &&
+	 test -d reg &&
+	 test -d reg/.git &&
+	 test "$(git config -f .gitmodules submodule.reg.path)" = "reg2" &&
+	 git mv -M reg reg2
+	)
+'
+
+test_expect_success 'move multiple submodules at once' '
+	(cd super &&
+	 mkdir test\ dir &&
+	 git mv unreg reg2 test\ dir/ &&
+	 test ! -d unreg && 
+	 test ! -d reg2 && 
+	 test -d test\ dir/unreg && 
+	 test -d test\ dir/reg2 && 
+	 test -z "$(git ls-files unreg)" &&
+	 test -n "$(git ls-files test\ dir/unreg)" &&
+	 test -z "$(git ls-files reg2)" &&
+	 test -n "$(git ls-files test\ dir/reg2)" &&
+	 test "$(git config -f .gitmodules submodule.reg.path)" = "test dir/reg2"
+	)
+'
+
+test_done
-- 
1.6.5
