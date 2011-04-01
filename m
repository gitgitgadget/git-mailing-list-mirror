From: Nicolas Morey-Chaisemartin <nmorey@kalray.eu>
Subject: [PATCH v2] submodule: Add --force option for git submodule update
Date: Fri, 1 Apr 2011 11:42:03 +0200
Message-ID: <4D959DEB.3010206@kalray.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 11:42:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5aru-0001KD-9c
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 11:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438Ab1DAJmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 05:42:09 -0400
Received: from mailhost.kalray.eu ([217.108.237.233]:45996 "EHLO EKA.kalray.eu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755396Ab1DAJmH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 05:42:07 -0400
Received: from sat.lin.mbt.kalray.eu (192.168.37.91) by EKA.kalray.eu
 (192.168.38.100) with Microsoft SMTP Server id 8.3.83.0; Fri, 1 Apr 2011
 11:41:11 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170577>

By default git submodule update runs a simple checkout on submodules
that are not up-to-date.
If the submodules contains modified or untracked files, the command may
exit sanely with an error:

$ git submodule update
error: Your local changes to the following files would be overwritten by
checkout:
	file
Please, commit your changes or stash them before you can switch branches.
Aborting
Unable to checkout '1b69c6e55606b48d3284a3a9efe4b58bfb7e8c9e' in
submodule path 'test1'

This implies that to reset a whole git submodule tree, a user has to run
first 'git submodule foreach --recursive git checkout -f' to then be
able to run git submodule update.

This patch adds a --force option for the update command (only used for
submodules without --rebase or --merge options). It passes the --force
option to git checkout which will throw away the local changes.

Signed-off-by: Nicolas Morey-Chaisemartin <nmorey@kalray.eu>
---

Much less intrusive patch that only adds the --force option but do not
add unnecessary checkouts to throw away *all* the changes

 Documentation/git-submodule.txt |    6 ++++--
 git-submodule.sh                |   14 +++++++++-----
 t/t7406-submodule-update.sh     |   23 +++++++++++++++++++++++
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 3a5aa01..328bdad 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -185,8 +185,10 @@ OPTIONS
 
 -f::
 --force::
-	This option is only valid for the add command.
-	Allow adding an otherwise ignored submodule path.
+	This option is only valid for add and update commands.
+	When running add, allow adding an otherwise ignored submodule path.
+	When running update, throw away local changes in submodules when
+	switching to a different commit.
 
 --cached::
 	This option is only valid for status and summary commands.  These
diff --git a/git-submodule.sh b/git-submodule.sh
index 3a13397..f732709 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -8,7 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
-   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--] [<path>...]"
@@ -385,6 +385,9 @@ cmd_update()
 		-N|--no-fetch)
 			nofetch=1
 			;;
+		-f|--force)
+			force=$1
+			;;
 		-r|--rebase)
 			update="rebase"
 			;;
@@ -458,10 +461,11 @@ cmd_update()
 
 		if test "$subsha1" != "$sha1"
 		then
-			force=
-			if test -z "$subsha1"
+			subforce=$force
+			# If we don't already have a -f flag and the submodule has never been checked out
+			if test -z "$subsha1" -a -z "$force"
 			then
-				force="-f"
+				subforce="-f"
 			fi
 
 			if test -z "$nofetch"
@@ -490,7 +494,7 @@ cmd_update()
 				msg="merged in"
 				;;
 			*)
-				command="git checkout $force -q"
+				command="git checkout $subforce -q"
 				action="checkout"
 				msg="checked out"
 				;;
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index fa9d23a..5d24d9f 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -74,6 +74,29 @@ test_expect_success 'submodule update detaching the HEAD ' '
 	)
 '
 
+test_expect_success 'submodule update should fail due to local changes' '
+	(cd super/submodule &&
+	 git reset --hard HEAD~1 &&
+	 echo "local change" > file
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 test_must_fail git submodule update submodule
+	)
+'
+test_expect_success 'submodule update should throw away changes with --force ' '
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update --force submodule &&
+	 cd submodule &&
+	 ! compare_head
+	)
+'
+
 test_expect_success 'submodule update --rebase staying on master' '
 	(cd super/submodule &&
 	  git checkout master
-- 
1.7.5.rc0.1.g9f07f.dirty
