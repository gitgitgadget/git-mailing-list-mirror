From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH v2 9/9] git rm: remove submodule entries from .gitmodules
Date: Sat, 10 Apr 2010 19:23:50 +0100
Message-ID: <1270923830-11830-10-git-send-email-peter@pcc.me.uk>
References: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 20:24:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0fMQ-0007O3-7C
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 20:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab0DJSYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 14:24:20 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:37798 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063Ab0DJSX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 14:23:57 -0400
Received: from lapas.pcc.me.uk ([10.179.130.3])
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLW-0006qW-69; Sat, 10 Apr 2010 19:23:55 +0100
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLU-00036W-PN; Sat, 10 Apr 2010 19:23:52 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144569>

This patch teaches "git rm" how to remove submodules from the
.gitmodules file.  The .gitmodules update is handled by an undocumented
subcommand to "git submodule" named "rmconfig".

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 Documentation/git-rm.txt   |    5 ++-
 builtin/rm.c               |   25 ++++++++++-
 git-submodule.sh           |   45 ++++++++++++++++++-
 t/t7409-submodule-mv-rm.sh |  105 ++++++++++++++++++++++++++++++++++++++++++++
 t/t7409-submodule-mv.sh    |   94 ---------------------------------------
 5 files changed, 177 insertions(+), 97 deletions(-)
 create mode 100755 t/t7409-submodule-mv-rm.sh
 delete mode 100755 t/t7409-submodule-mv.sh

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index c21d19e..81c1bbd 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -7,7 +7,7 @@ git-rm - Remove files from the working tree and from the index
 
 SYNOPSIS
 --------
-'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <file>...
+'git rm' [-f | --force] [-n] [-r] [-M] [--cached] [--ignore-unmatch] [--quiet] [--] <file>...
 
 DESCRIPTION
 -----------
@@ -49,6 +49,9 @@ OPTIONS
         Allow recursive removal when a leading directory name is
         given.
 
+-M::
+	Do not try to remove submodule entry in .gitmodules
+
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
diff --git a/builtin/rm.c b/builtin/rm.c
index 02ee259..3c26a43 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "tree-walk.h"
 #include "parse-options.h"
+#include "run-command.h"
 
 static const char * const builtin_rm_usage[] = {
 	"git rm [options] [--] <file>...",
@@ -139,7 +140,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 static struct lock_file lock_file;
 
 static int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
-static int ignore_unmatch = 0;
+static int ignore_unmatch = 0, skip_module_update = 0;
 
 static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only),
@@ -149,6 +150,8 @@ static struct option builtin_rm_options[] = {
 	OPT_BOOLEAN('r', NULL,             &recursive,  "allow recursive removal"),
 	OPT_BOOLEAN( 0 , "ignore-unmatch", &ignore_unmatch,
 				"exit with a zero status even if nothing matched"),
+	OPT_BOOLEAN('M', NULL,             &skip_module_update,
+				"don't update submodule entries"),
 	OPT_END(),
 };
 
@@ -276,5 +279,25 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			die("Unable to write new index file");
 	}
 
+	if (!skip_module_update)
+		for (i = 0; i < list.nr; i++) {
+			if (S_ISGITLINK(list.mode[i])) {
+				const char *path = list.name[i];
+
+				const char *argv_submodule[] = {
+					"submodule", "rmconfig", NULL, NULL, NULL, NULL
+				};
+				int argc = 2;
+
+				if (index_only)
+					argv_submodule[argc++] = "--cached";
+
+				argv_submodule[argc++] = "--";
+				argv_submodule[argc++] = path;
+
+				run_command_v_opt(argv_submodule, RUN_GIT_CMD);
+			}
+		}
+
 	return 0;
 }
diff --git a/git-submodule.sh b/git-submodule.sh
index 75c50b8..baadaa5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -879,6 +879,49 @@ cmd_mvconfig()
 		die "Could not update .gitmodules entry for $name"
 	git add .gitmodules || die "Could not add .gitmodules to index"
 }
+#
+# Removes the entry in .gitmodules to remove a submodule.
+# This command is called by "git rm" for each submodule it removes.
+#
+cmd_rmconfig()
+{
+	while test $# -ne 0
+	do
+		case "$1" in
+		--cached)
+			index_only=1
+			shift
+			;;
+		--)
+			shift
+			break
+			;;
+		*)
+			break
+			;;
+		esac
+	done
+	path="$1"
+
+	if test -z "$index_only"
+	then
+		name=$(module_name "$path") || exit
+		git config -f .gitmodules --remove-section submodule."$name" ||
+			die "Could not update .gitmodules entry for $name"
+		git add .gitmodules || die "Could not add .gitmodules to index"
+	else
+		git cat-file -p :0:.gitmodules > .git/gitmodules.index ||
+			{ rm .git/gitmodules.index; die "Could not extract .gitmodules from index"; }
+		name=$(module_name "$path" .git/gitmodules.index) || { rm .git/gitmodules.index; exit; }
+		git config -f .git/gitmodules.index --remove-section submodule."$name" ||
+			{ rm .git/gitmodules.index; die "Could not update .gitmodules entry for $name"; }
+		blob=$(git hash-object -w --stdin < .git/gitmodules.index) ||
+			{ rm .git/gitmodules.index; die "Could not create blob for .gitmodules"; }
+		rm .git/gitmodules.index || die "Could not remove temporary .gitmodules file"
+		git update-index --cacheinfo 100644 "$blob" .gitmodules ||
+			die "Could not add .gitmodules to index"
+	fi
+}
 
 # This loop parses the command line arguments to find the
 # subcommand name to dispatch.  Parsing of the subcommand specific
@@ -889,7 +932,7 @@ cmd_mvconfig()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | update | status | summary | sync | mvconfig)
+	add | foreach | init | update | status | summary | sync | mvconfig | rmconfig)
 		command=$1
 		;;
 	-q|--quiet)
diff --git a/t/t7409-submodule-mv-rm.sh b/t/t7409-submodule-mv-rm.sh
new file mode 100755
index 0000000..91b7866
--- /dev/null
+++ b/t/t7409-submodule-mv-rm.sh
@@ -0,0 +1,105 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Peter Collingbourne
+#
+
+test_description='git submodule mv, rm
+
+These tests exercise the "git mv" and "git rm" commands for submodules.
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
+test_expect_success 'remove multiple submodules at once' '
+	(cd super &&
+	 git rm -r test\ dir &&
+	 test ! -d test\ dir/unreg && 
+	 test -d test\ dir/reg2 && 
+	 test -z "$(git ls-files test\ dir/unreg)" &&
+	 test -z "$(git ls-files test\ dir/reg2)" &&
+	 test -z "$(git config -f .gitmodules submodule.reg.path)"
+	)
+'
+
+test_done
diff --git a/t/t7409-submodule-mv.sh b/t/t7409-submodule-mv.sh
deleted file mode 100755
index 9eb3fb1..0000000
--- a/t/t7409-submodule-mv.sh
+++ /dev/null
@@ -1,94 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2010 Peter Collingbourne
-#
-
-test_description='git submodule mv
-
-These tests exercise the "git mv" command for submodules.
-'
-
-. ./test-lib.sh
-
-test_expect_success setup '
-	echo file > file &&
-	git add file &&
-	test_tick &&
-	git commit -m upstream
-	git clone . super &&
-	git clone super submodule &&
-	(cd super &&
-	 git submodule add -n reg ../submodule reg &&
-	 git clone reg unreg &&
-	 git add unreg &&
-	 test_tick &&
-	 git commit -m "submodules"
-	)'
-
-test_expect_success 'move registered submodule' '
-	(cd super &&
-	 git mv reg reg2 &&
-	 test -z "$(git ls-files reg)" &&
-	 test -n "$(git ls-files reg2)" &&
-	 test ! -d reg &&
-	 test -d reg2 &&
-	 test -d reg2/.git &&
-	 test "$(git config -f .gitmodules submodule.reg.path)" = "reg2" &&
-	 test_tick &&
-	 git commit -a -m "move reg"
-	)
-'
-
-test_expect_success 'move unregistered submodule' '
-	(cd super &&
-	 git mv unreg unreg2 &&
-	 test ! -d unreg &&
-	 test -d unreg2 &&
-	 test -d unreg2/.git &&
-	 test_tick &&
-	 git commit -a -m "move unreg"
-	)
-'
-
-test_expect_success 'move unregistered uninitialised submodule' '
-	(cd super &&
-	 rm -rf unreg2 &&
-	 mkdir unreg2 &&
-	 git mv unreg2 unreg &&
-	 test -z "$(git ls-files unreg2)" &&
-	 test -n "$(git ls-files unreg)" &&
-	 test ! -d unreg2 &&
-	 test -d unreg &&
-	 test_tick &&
-	 git commit -a -m "move unreg2"
-	)
-'
-
-test_expect_success 'move registered submodule without changing .gitmodules' '
-	(cd super &&
-	 git mv -M reg2 reg &&
-	 test ! -d reg2 &&
-	 test -d reg &&
-	 test -d reg/.git &&
-	 test "$(git config -f .gitmodules submodule.reg.path)" = "reg2" &&
-	 git mv -M reg reg2
-	)
-'
-
-test_expect_success 'move multiple submodules at once' '
-	(cd super &&
-	 mkdir test\ dir &&
-	 git mv unreg reg2 test\ dir/ &&
-	 test ! -d unreg && 
-	 test ! -d reg2 && 
-	 test -d test\ dir/unreg && 
-	 test -d test\ dir/reg2 && 
-	 test -z "$(git ls-files unreg)" &&
-	 test -n "$(git ls-files test\ dir/unreg)" &&
-	 test -z "$(git ls-files reg2)" &&
-	 test -n "$(git ls-files test\ dir/reg2)" &&
-	 test "$(git config -f .gitmodules submodule.reg.path)" = "test dir/reg2"
-	)
-'
-
-test_done
-- 
1.6.5
