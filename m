From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH 12/12] git rm: remove submodule entries from .gitmodules
Date: Fri, 26 Mar 2010 15:25:40 +0000
Message-ID: <1269617140-7827-13-git-send-email-peter@pcc.me.uk>
References: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 16:26:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvBQf-0005ou-MY
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab0CZP0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:26:15 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:55554 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754149Ab0CZPZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 11:25:59 -0400
Received: from [10.179.145.9] (helo=lapas.pcc.me.uk)
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ3-0001oE-4R; Fri, 26 Mar 2010 15:25:55 +0000
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ1-00023b-OS; Fri, 26 Mar 2010 15:25:53 +0000
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143246>

This patch teaches "git rm" how to remove submodules from the
.gitmodules file.  The .gitmodules update is handled by an undocumented
subcommand to "git submodule" named "rmconfig".

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 Documentation/git-rm.txt                           |    5 ++-
 builtin/rm.c                                       |   25 ++++++++++-
 git-submodule.sh                                   |   45 +++++++++++++++++++-
 ...09-submodule-mv.sh => t7409-submodule-mv-rm.sh} |   15 ++++++-
 4 files changed, 85 insertions(+), 5 deletions(-)
 rename t/{t7409-submodule-mv.sh => t7409-submodule-mv-rm.sh} (82%)

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
index 3fd067a..6d9c08b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -876,6 +876,49 @@ cmd_mvconfig()
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
@@ -886,7 +929,7 @@ cmd_mvconfig()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | update | status | summary | sync | mvconfig)
+	add | foreach | init | update | status | summary | sync | mvconfig | rmconfig)
 		command=$1
 		;;
 	-q|--quiet)
diff --git a/t/t7409-submodule-mv.sh b/t/t7409-submodule-mv-rm.sh
similarity index 82%
rename from t/t7409-submodule-mv.sh
rename to t/t7409-submodule-mv-rm.sh
index 9eb3fb1..91b7866 100755
--- a/t/t7409-submodule-mv.sh
+++ b/t/t7409-submodule-mv-rm.sh
@@ -3,9 +3,9 @@
 # Copyright (c) 2010 Peter Collingbourne
 #
 
-test_description='git submodule mv
+test_description='git submodule mv, rm
 
-These tests exercise the "git mv" command for submodules.
+These tests exercise the "git mv" and "git rm" commands for submodules.
 '
 
 . ./test-lib.sh
@@ -91,4 +91,15 @@ test_expect_success 'move multiple submodules at once' '
 	)
 '
 
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
 test_done
-- 
1.6.5
