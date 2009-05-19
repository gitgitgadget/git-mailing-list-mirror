From: Johan Herland <johan@herland.net>
Subject: [PATCH] git-submodule: add support for --merge.
Date: Tue, 19 May 2009 02:35:34 +0200
Message-ID: <200905190235.34720.johan@herland.net>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org>
 <200905182140.29953.markus.heidelberg@web.de>
 <200905182355.21645.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, markus.heidelberg@web.de,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 02:35:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6DJB-0002wU-Td
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 02:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbZESAfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 20:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753381AbZESAfi
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 20:35:38 -0400
Received: from mx.getmail.no ([84.208.15.66]:49520 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752949AbZESAfh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2009 20:35:37 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJV000V98BDWF30@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 19 May 2009 02:35:37 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJV007YD8BBLS30@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 19 May 2009 02:35:37 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.5.19.437
User-Agent: KMail/1.11.3 (Linux/2.6.29-ARCH; KDE/4.2.3; x86_64; ; )
In-reply-to: <200905182355.21645.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119482>

'git submodule update --merge' merges the commit referenced by the
superproject into your local branch, instead of checking it out on
a detached HEAD.

As evidenced by the addition of "git submodule update --rebase", it
is useful to provide alternatives to the default 'checkout' behaviour
of "git submodule update". Another such alternative is, when updating
a submodule to a new commit, to merge that commit into the current
branch. This is useful in workflows where you cannot use --rebase,
because you have downstream people working on top of your submodule
branch, and you don't want to disrupt their work with a rebase, but
you still want to update your submodule from its upstream.

Config variables: The --rebase patch added submodule.<name>.rebase
for turning on --rebase by default for a given submodule. However,
a similar submodule.<name>.merge variable cannot be added since it
would conflict with submodule.<name>.rebase (they cannot both be
true). This patch therefore replaces submodule.<name>.rebase with
submodule.<name>.update, which can be set to the following values:

- 'checkout': This specifies the default behaviour in which "git
  submodule update" checks out the new commit to a detached HEAD.
  Leaving submodule.<name>.update unset also causes this behaviour.

- 'rebase': This specifies the --rebase behaviour (and thus replaces
  submodule.<name>.rebase == true), where the local branch in the
  submodule is rebased onto the new commit.

- 'merge': This specifies the new --merge behaviour in which the new
  commit is merged into the submodule's local branch.

Signed-off-by: Johan Herland <johan@herland.net>
---

Here's a patch implementing my suggestion. I have chosen to avoid
backwards-compatibility for the submodule.<name>.rebase config
variable, since it is not yet present in a released version.


Have fun! :)

...Johan

 Documentation/git-submodule.txt |   19 ++++++++--
 Documentation/gitmodules.txt    |   12 +++++-
 git-submodule.sh                |   43 ++++++++++++++--------
 t/t7406-submodule-update.sh     |   76 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 119 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index acd16ac..1cbb181 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	      [--reference <repository>] [--] <repository> <path>
 'git submodule' [--quiet] status [--cached] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
+'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase|--merge]
 	      [--reference <repository>] [--] [<path>...]
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach <command>
@@ -115,8 +115,9 @@ init::
 update::
 	Update the registered submodules, i.e. clone missing submodules and
 	checkout the commit specified in the index of the containing repository.
-	This will make the submodules HEAD be detached unless '--rebase' is
-	specified or the key `submodule.$name.rebase` is set to `true`.
+	This will make the submodules HEAD be detached unless '--rebase' or
+	'--merge' is specified or the key `submodule.$name.update` is set to
+	`rebase` or `merge`.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
@@ -186,7 +187,17 @@ OPTIONS
 	superproject. If this option is given, the submodule's HEAD will not
 	be detached. If a a merge failure prevents this process, you will have
 	to resolve these failures with linkgit:git-rebase[1].
-	If the key `submodule.$name.rebase` is set to `true`, this option is
+	If the key `submodule.$name.update` is set to `rebase`, this option is
+	implicit.
+
+--merge::
+	This option is only valid for the update command.
+	Merge the commit recorded in the superproject into the current branch
+	of the submodule. If this option is given, the submodule's HEAD will
+	not be detached. If a merge failure prevents this process, you will
+	have to resolve the resulting conflicts within the submodule with the
+	usual conflict resolution tools.
+	If the key `submodule.$name.update` is set to `merge`, this option is
 	implicit.
 
 --reference <repository>::
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 7c22c40..5daf750 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -30,8 +30,16 @@ submodule.<name>.path::
 submodule.<name>.url::
 	Defines an url from where the submodule repository can be cloned.
 
-submodule.<name>.rebase::
-	Defines that the submodule should be rebased by default.
+submodule.<name>.update::
+	Defines what to do when the submodule is updated by the superproject.
+	If 'checkout' (the default), the new commit specified in the
+	superproject will be checked out in the submodule on a detached HEAD.
+	If 'rebase', the current branch of the submodule will be rebased onto
+	the commit specified in the superproject. If 'merge', the commit
+	specified in the superproject will be merged into the current branch
+	in the submodule.
+	This config option is overridden if 'git submodule update' is given
+	the '--merge' or '--rebase' options.
 
 
 EXAMPLES
diff --git a/git-submodule.sh b/git-submodule.sh
index bbca183..2a1e73c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli
 
 USAGE="[--quiet] [--cached] \
-[add [-b branch] <repo> <path>]|[status|init|update [-i|--init] [-N|--no-fetch]|summary [-n|--summary-limit <n>] [<commit>]] \
+[add [-b branch] <repo> <path>]|[status|init|update [-i|--init] [-N|--no-fetch] [--rebase|--merge]|summary [-n|--summary-limit <n>] [<commit>]] \
 [--] [<path>...]|[foreach <command>]|[sync [--] [<path>...]]"
 OPTIONS_SPEC=
 . git-sh-setup
@@ -18,7 +18,7 @@ quiet=
 reference=
 cached=
 nofetch=
-rebase=
+update=
 
 #
 # print stuff on stdout unless -q was specified
@@ -311,10 +311,10 @@ cmd_init()
 		git config submodule."$name".url "$url" ||
 		die "Failed to register url for submodule path '$path'"
 
-		test true != "$(git config -f .gitmodules --bool \
-			submodule."$name".rebase)" ||
-		git config submodule."$name".rebase true ||
-		die "Failed to register submodule path '$path' as rebasing"
+		upd="$(git config -f .gitmodules submodule."$name".update)"
+		test -z "$upd" ||
+		git config submodule."$name".update "$upd" ||
+		die "Failed to register update mode for submodule path '$path'"
 
 		say "Submodule '$name' ($url) registered for path '$path'"
 	done
@@ -345,7 +345,11 @@ cmd_update()
 			;;
 		-r|--rebase)
 			shift
-			rebase=true
+			update="rebase"
+			;;
+		-m|--merge)
+			shift
+			update="merge"
 			;;
 		--reference)
 			case "$2" in '') usage ;; esac
@@ -379,7 +383,7 @@ cmd_update()
 	do
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
-		rebase_module=$(git config --bool submodule."$name".rebase)
+		update_module=$(git config submodule."$name".update)
 		if test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
@@ -400,9 +404,9 @@ cmd_update()
 			die "Unable to find current revision in submodule path '$path'"
 		fi
 
-		if test true = "$rebase"
+		if ! test -z "$update"
 		then
-			rebase_module=true
+			update_module=$update
 		fi
 
 		if test "$subsha1" != "$sha1"
@@ -420,16 +424,23 @@ cmd_update()
 				die "Unable to fetch in submodule path '$path'"
 			fi
 
-			if test true = "$rebase_module"
-			then
-				command="git-rebase"
+			case "$update_module" in
+			rebase)
+				command="git rebase"
 				action="rebase"
 				msg="rebased onto"
-			else
-				command="git-checkout $force -q"
+				;;
+			merge)
+				command="git merge"
+				action="merge"
+				msg="merged in"
+				;;
+			*)
+				command="git checkout $force -q"
 				action="checkout"
 				msg="checked out"
-			fi
+				;;
+			esac
 
 			(unset GIT_DIR; cd "$path" && $command "$sha1") ||
 			die "Unable to $action '$sha1' in submodule path '$path'"
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 3442c05..2d33d9e 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -6,7 +6,7 @@
 test_description='Test updating submodules
 
 This test verifies that "git submodule update" detaches the HEAD of the
-submodule and "git submodule update --rebase" does not detach the HEAD.
+submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
 '
 
 . ./test-lib.sh
@@ -76,9 +76,23 @@ test_expect_success 'submodule update --rebase staying on master' '
 	)
 '
 
-test_expect_success 'submodule update - rebase true in .git/config' '
+test_expect_success 'submodule update --merge staying on master' '
+	(cd super/submodule &&
+	  git reset --hard HEAD~1
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update --merge submodule &&
+	 cd submodule &&
+	 compare_head
+	)
+'
+
+test_expect_success 'submodule update - rebase in .git/config' '
 	(cd super &&
-	 git config submodule.submodule.rebase true
+	 git config submodule.submodule.update rebase
 	) &&
 	(cd super/submodule &&
 	  git reset --hard HEAD~1
@@ -93,9 +107,9 @@ test_expect_success 'submodule update - rebase true in .git/config' '
 	)
 '
 
-test_expect_success 'submodule update - rebase false in .git/config but --rebase given' '
+test_expect_success 'submodule update - checkout in .git/config but --rebase given' '
 	(cd super &&
-	 git config submodule.submodule.rebase false
+	 git config submodule.submodule.update checkout
 	) &&
 	(cd super/submodule &&
 	  git reset --hard HEAD~1
@@ -110,9 +124,43 @@ test_expect_success 'submodule update - rebase false in .git/config but --rebase
 	)
 '
 
-test_expect_success 'submodule update - rebase false in .git/config' '
+test_expect_success 'submodule update - merge in .git/config' '
 	(cd super &&
-	 git config submodule.submodule.rebase false
+	 git config submodule.submodule.update merge
+	) &&
+	(cd super/submodule &&
+	  git reset --hard HEAD~1
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update submodule &&
+	 cd submodule &&
+	 compare_head
+	)
+'
+
+test_expect_success 'submodule update - checkout in .git/config but --merge given' '
+	(cd super &&
+	 git config submodule.submodule.update checkout
+	) &&
+	(cd super/submodule &&
+	  git reset --hard HEAD~1
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update --merge submodule &&
+	 cd submodule &&
+	 compare_head
+	)
+'
+
+test_expect_success 'submodule update - checkout in .git/config' '
+	(cd super &&
+	 git config submodule.submodule.update checkout
 	) &&
 	(cd super/submodule &&
 	  git reset --hard HEAD^
@@ -131,9 +179,19 @@ test_expect_success 'submodule init picks up rebase' '
 	(cd super &&
 	 git config submodule.rebasing.url git://non-existing/git &&
 	 git config submodule.rebasing.path does-not-matter &&
-	 git config submodule.rebasing.rebase true &&
+	 git config submodule.rebasing.update rebase &&
 	 git submodule init rebasing &&
-	 test true = $(git config --bool submodule.rebasing.rebase)
+	 test "rebase" = $(git config submodule.rebasing.update)
+	)
+'
+
+test_expect_success 'submodule init picks up merge' '
+	(cd super &&
+	 git config submodule.merging.url git://non-existing/git &&
+	 git config submodule.merging.path does-not-matter &&
+	 git config submodule.merging.update merge &&
+	 git submodule init merging &&
+	 test "merge" = $(git config submodule.merging.update)
 	)
 '
 
-- 
1.6.3.rc0.1.gf800
