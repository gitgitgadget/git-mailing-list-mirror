From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: [PATCH] submodule: Add --force option for git submodule update
Date: Wed, 30 Mar 2011 09:56:21 +0200
Message-ID: <4D92E225.3040602@morey-chaisemartin.com>
Reply-To: devel-git@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 09:56:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4qGS-0007xw-Hn
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 09:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218Ab1C3H4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 03:56:25 -0400
Received: from 30.mail-out.ovh.net ([213.186.62.213]:44852 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752641Ab1C3H4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 03:56:24 -0400
Received: (qmail 5431 invoked by uid 503); 30 Mar 2011 07:45:56 -0000
Received: from b9.ovh.net (HELO mail417.ha.ovh.net) (213.186.33.59)
  by 30.mail-out.ovh.net with SMTP; 30 Mar 2011 07:45:56 -0000
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 30 Mar 2011 09:56:21 +0200
Received: from mailhost.kalray.eu (HELO sat.lin.mbt.kalray.eu) (devel-git@morey-chaisemartin.com@217.108.237.233)
  by ns0.ovh.net with SMTP; 30 Mar 2011 09:56:21 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.9
X-Ovh-Tracer-Id: 16295430827636285406
X-Ovh-Remote: 217.108.237.233 (mailhost.kalray.eu)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170362>

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
Also when --force is specified, git checkout -f is always called on
submodules whether their HEAD matches the reference or not.

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 Documentation/git-submodule.txt |    5 ++-
 git-submodule.sh                |   68 ++++++++++++++++++++------------------
 t/t7406-submodule-update.sh     |   23 +++++++++++++
 3 files changed, 62 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 3a5aa01..6482a84 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -185,8 +185,9 @@ OPTIONS
 
 -f::
 --force::
-	This option is only valid for the add command.
-	Allow adding an otherwise ignored submodule path.
+	This option is only valid for add and update commands.
+	When running add, allow adding an otherwise ignored submodule path.
+	When running update, throw away local changes in submodules.
 
 --cached::
 	This option is only valid for status and summary commands.  These
diff --git a/git-submodule.sh b/git-submodule.sh
index 3a13397..a195879 100755
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
+		-f | --force)
+			force=$1
+			;;
 		-r|--rebase)
 			update="rebase"
 			;;
@@ -430,6 +433,7 @@ cmd_update()
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
 		update_module=$(git config submodule."$name".update)
+		force_checkout=
 		if test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
@@ -456,13 +460,38 @@ cmd_update()
 			update_module=$update
 		fi
 
-		if test "$subsha1" != "$sha1"
+		if test -z "$subsha1" -a -z "$force"
+		then
+		    force_checkout="-f"
+		fi
+
+		# Is this something we just cloned?
+		case ";$cloned_modules;" in
+		    *";$name;"*)
+			 # then there is no local change to integrate
+			 update_module= ;;
+		esac
+
+		case "$update_module" in
+		    rebase)
+			 command="git rebase"
+			 action="rebase"
+			 msg="rebased onto"
+			 ;;
+		    merge)
+			 command="git merge"
+			 action="merge"
+			 msg="merged in"
+			 ;;
+		    *)
+			 command="git checkout $force $force_checkout -q"
+			 action="checkout"
+			 msg="checked out"
+			 ;;
+		esac
+
+		if test "$subsha1" != "$sha1" || test -n "$force" -a "$action" = "checkout"
 		then
-			force=
-			if test -z "$subsha1"
-			then
-				force="-f"
-			fi
 
 			if test -z "$nofetch"
 			then
@@ -471,31 +500,6 @@ cmd_update()
 				die "Unable to fetch in submodule path '$path'"
 			fi
 
-			# Is this something we just cloned?
-			case ";$cloned_modules;" in
-			*";$name;"*)
-				# then there is no local change to integrate
-				update_module= ;;
-			esac
-
-			case "$update_module" in
-			rebase)
-				command="git rebase"
-				action="rebase"
-				msg="rebased onto"
-				;;
-			merge)
-				command="git merge"
-				action="merge"
-				msg="merged in"
-				;;
-			*)
-				command="git checkout $force -q"
-				action="checkout"
-				msg="checked out"
-				;;
-			esac
-
 			(clear_local_git_env; cd "$path" && $command "$sha1") ||
 			die "Unable to $action '$sha1' in submodule path '$path'"
 			say "Submodule path '$path': $msg '$sha1'"
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
