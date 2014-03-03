From: Henri GEIST <geist.henri@laposte.net>
Subject: [PATCH] submodule : Add --no-separate-git-dir option to add and
 update command.
Date: Mon, 03 Mar 2014 15:47:46 +0100
Message-ID: <1393858066.7891.20.camel@Naugrim>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 15:55:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKUHW-0005vB-1Z
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 15:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbaCCOzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 09:55:43 -0500
Received: from smtpout6.laposte.net ([193.253.67.231]:27763 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876AbaCCOzj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 09:55:39 -0500
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Mar 2014 09:55:39 EST
Received: from [192.168.0.8] ([82.242.149.125])
	by mwinf8512-out with ME
	id Z2nm1n00B2iaXuy032nmpG; Mon, 03 Mar 2014 15:47:47 +0100
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243227>

This new option prevent git submodule <add|update> to clone the missing
submodules with the --separate-git-dir option.
Then the submodule will be regular repository and their gitdir will not
be placed in the superproject gitdir/modules directory.

Signed-off-by: Henri GEIST <geist.henri@laposte.net>
---
 Documentation/git-submodule.txt |   18 ++++++++++++++++--
 git-submodule.sh                |   22 ++++++++++++++++++++--
 t/t7400-submodule-basic.sh      |   12 ++++++++++++
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 21cb59a..303a475 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -10,13 +10,14 @@ SYNOPSIS
 --------
 [verse]
 'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
-	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
+	      [--reference <repository>] [--depth <depth>] [--no-separate-git-dir]
+	      [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase|--merge|--checkout] [--reference <repository>]
-	      [--depth <depth>] [--recursive] [--] [<path>...]
+	      [--depth <depth>] [--recursive] [--no-separate-git-dir] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -107,6 +108,10 @@ is the superproject and submodule repositories will be kept
 together in the same relative location, and only the
 superproject's URL needs to be provided: git-submodule will correctly
 locate the submodule using the relative URL in .gitmodules.
++
+If `--no-separate-git-dir` is specified, missing submodules will be cloned
+has normal git repository without the option `--separate-git-dir` pointing
+to the modules directory of the superproject gitdir.
 
 status::
 	Show the status of the submodules. This will print the SHA-1 of the
@@ -185,6 +190,10 @@ If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
 submodule with the `--init` option.
 +
+If `--no-separate-git-dir` is specified, missing submodules will be cloned
+has normal git repository without the option `--separate-git-dir` pointing
+to the modules directory of the superproject gitdir.
++
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 +
@@ -363,6 +372,11 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 	clone with a history truncated to the specified number of revisions.
 	See linkgit:git-clone[1]
 
+--no-separate-git-dir::
+	This option is valid for add and update commands. Specify that missing
+	submodules should be clonned as self contain repository without a
+	separate gitdir placed in the modules directory of the superproject
+	gitdir.
 
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
diff --git a/git-submodule.sh b/git-submodule.sh
index a33f68d..36eaf31 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,11 +5,11 @@
 # Copyright (c) 2007 Lars Hjemli
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
+USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--no-separate-git-dir] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--no-separate-git-dir] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
@@ -36,6 +36,7 @@ update=
 prefix=
 custom_name=
 depth=
+noseparategitdir=
 
 # The function takes at most 2 arguments. The first argument is the
 # URL that navigates to the submodule origin repo. When relative, this URL
@@ -270,6 +271,17 @@ module_clone()
 		quiet=-q
 	fi
 
+
+	if test -n "$noseparategitdir"
+	then
+		(
+			clear_local_git_env
+			git clone $quiet ${depth:+"$depth"} -n ${reference:+"$reference"} "$url" "$sm_path"
+		) ||
+		die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path' failed")"
+		return
+	fi
+
 	gitdir=
 	gitdir_base=
 	base_name=$(dirname "$name")
@@ -359,6 +371,9 @@ cmd_add()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
+		--no-separate-git-dir)
+			noseparategitdir=1
+			;;
 		--reference)
 			case "$2" in '') usage ;; esac
 			reference_path=$2
@@ -758,6 +773,9 @@ cmd_update()
 		-f|--force)
 			force=$1
 			;;
+		--no-separate-git-dir)
+			noseparategitdir=1
+			;;
 		-r|--rebase)
 			update="rebase"
 			;;
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index c28e8d8..aa2df3d 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -81,6 +81,18 @@ inspect() {
 	)
 }
 
+test_expect_success 'submodule add --no-separate-git-dir' '
+	(
+		cd addtest &&
+		rm -rf submod &&
+		git submodule add --no-separate-git-dir -q "$submodurl" submod >actual &&
+		test_must_be_empty actual &&
+		test -d submod/.git &&
+		rm -rf submod &&
+		git reset --hard
+	)
+'
+
 test_expect_success 'submodule add' '
 	echo "refs/heads/master" >expect &&
 	>empty &&
-- 
1.7.9.3.369.gd715.dirty
