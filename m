From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Wed, 9 Nov 2011 18:40:27 +0100
Message-ID: <20111109174027.GA28825@book.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 18:40:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROC8b-0001a8-IL
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 18:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866Ab1KIRk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 12:40:29 -0500
Received: from darksea.de ([83.133.111.250]:48022 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932416Ab1KIRk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 12:40:27 -0500
Received: (qmail 31709 invoked from network); 9 Nov 2011 18:40:25 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 9 Nov 2011 18:40:25 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185164>

This adds the capability to configure a branch which submodule update
will use to checkout the tips sha1 instead of the registered one.

It will first attempt to read the configuration directly from the
currently checked out .gitmodules file from the key
submodule.$name.branch.  This configuration can be overridden by local
user configuration values. The parameter --branch can be used to
specify/override the branch using the commandline. The parameter
--checkout can be used to switch to the exact model for all submodules.

Such a thing is helpful if a user wants to follow a defined branches tip
in the submodule. Image such a branch is the stable branch for some
central library or similar.

When the newly checked out tip will not match the registered sha1 in the
superproject it will show up as a change as usual. You can imagine this
as a configuration which lets the upstream project tell a user the
branch it usually updates to. The usual revision control is still in
place.
---

This is almost ready but I would like to know what users of the
"floating submodule" think about this.

 Documentation/git-submodule.txt |   26 +++++++++--
 git-submodule.sh                |   47 ++++++++++++++++++++
 t/t7406-submodule-update.sh     |   93 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 6ec3fef..b8affa3 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -133,9 +133,11 @@ init::
 update::
 	Update the registered submodules, i.e. clone missing submodules and
 	checkout the commit specified in the index of the containing repository.
-	This will make the submodules HEAD be detached unless `--rebase` or
-	`--merge` is specified or the key `submodule.$name.update` is set to
-	`rebase`, `merge` or `none`.
+	This will make the submodules HEAD be detached. This will not
+	happen if `--rebase`, `--merge` or `--branch` are specified.
+	Also if the key `submodule.$name.update` is set to `rebase`,
+	`merge` or `none`. If `submodule.$name.branch` is set to some
+	local branch this will also not happen.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
@@ -146,7 +148,16 @@ registered submodules, and update any nested submodules within.
 +
 If the configuration key `submodule.$name.update` is set to `none` the
 submodule with name `$name` will not be updated by default. This can be
-overriden by adding `--checkout` to the command.
+overriden by adding `--checkout` to the command. `--checkout` can also
+be used to enforce exact checkout of submodule sha1's.
++
+If the configuration key `submodule.$name.branch` is set to some valid
+branch in the submodule named by `$name` the submodule will be updated
+to the tip of that branch instead of the registered sha1. This option
+can either be set in .gitmodules or via git's configuration. Gits local
+configuration takes precedence over .gitmodules. If you want to override
+the branch checkout you can use the value `HEAD` to tell git to checkout
+exactly the registered sha1.
 
 summary::
 	Show commit summary between the given commit (defaults to HEAD) and
@@ -252,6 +263,13 @@ OPTIONS
 	If the key `submodule.$name.update` is set to `rebase`, this option is
 	implicit.
 
+--branch::
+	This option is only valid for the update command. You can use
+	this parameter to specify which branch you want to update all
+	submodules to. This is helpful if you want to update all
+	submodules to the tip of a certain branch or need to work on a
+	branch for all submodules for some time.
+
 --init::
 	This option is only valid for the update command.
 	Initialize all submodules for which "git submodule init" has not been
diff --git a/git-submodule.sh b/git-submodule.sh
index 3adab93..a4b117b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -465,6 +465,14 @@ cmd_update()
 		--checkout)
 			update="checkout"
 			;;
+		--branch=*)
+			case "$1" in
+			*=*)
+				update="checkout"
+				branch=`expr "z$1" : 'z--[^=]*=\(.*\)'` ;;
+			*)
+				usage ;;
+			esac ;;
 		--)
 			shift
 			break
@@ -504,6 +512,45 @@ cmd_update()
 			update_module=$(git config submodule."$name".update)
 		fi
 
+		if ! test -z "$branch"
+		then
+			branch_module=$branch
+		else
+			if test "$update" != "checkout"
+			then
+				branch_module=$(git config submodule."$name".branch)
+				if test -z "$branch_module"
+				then
+					branch_module=$(git config -f .gitmodules --get submodule."$name".branch)
+				fi
+			fi
+		fi
+
+		if test "$branch_module" = "HEAD"
+		then
+			branch_module=
+		fi
+
+		if ! test -z "$branch_module"
+		then
+			(clear_local_git_env; cd "$path" &&
+			 if test ! $nofetch
+			 then
+				git-fetch --all >/dev/null 2>/dev/null || exit 1
+			 fi) ||
+			die "$(eval_gettext "Unable to fetch submodule in path '\$path'")"
+
+			sha1=$(clear_local_git_env; cd "$path" &&
+				git rev-parse $branch_module) ||
+			say "$(eval_gettext "Unable to find branch '\$branch_module' in submodule path '\$path'")"
+		fi
+
+		if test "$branch" -a "$update" != "checkout"
+		then
+			die "$(eval_gettext "You can not set update='\$update' and
+use a branch for submodule '\$path'")"
+		fi
+
 		if test "$update_module" = "none"
 		then
 			echo "Skipping submodule '$path'"
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 33b292b..517ed83 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -611,4 +611,97 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir re
 	)
 '
 
+test_expect_success '--branch updates follow the given branch' '
+	git clone . branch &&
+	(cd branch &&
+		git submodule add ./submodule submodule1 &&
+		git submodule add ./submodule submodule2 &&
+		(cd submodule1 &&
+			git rev-parse HEAD >../expected1 &&
+			git checkout HEAD^) &&
+		(cd submodule2 &&
+			git rev-parse HEAD >../expected2 &&
+			git checkout HEAD^) &&
+		git add submodule1 &&
+		git add submodule2 &&
+		git commit -m "add submodule1 and submodule2" &&
+		git submodule update --branch=origin/master &&
+		(cd submodule1 && git rev-parse HEAD >../actual1) &&
+		(cd submodule2 && git rev-parse HEAD >../actual2) &&
+		test_cmp expected1 actual1 &&
+		test_cmp expected2 actual2
+	)
+'
+
+cat >branch/expect_status <<EOF
+ M submodule1
+EOF
+
+check_submodule_one_follows()
+{
+	(cd submodule1 &&
+		git rev-parse origin/master >../expected1 &&
+		git rev-parse HEAD >../actual1) &&
+	(cd submodule2 &&
+		git rev-parse origin/master^ >../expected2 &&
+		git rev-parse HEAD >../actual2) &&
+	test_cmp expected1 actual1 &&
+	test_cmp expected2 actual2 &&
+	git status --porcelain --untracked-files=no >actual_status &&
+	test_cmp expect_status actual_status
+}
+
+check_both_submodules_exact()
+{
+	(cd submodule1 &&
+		git rev-parse origin/master^ >../expected1 &&
+		git rev-parse HEAD >../actual1) &&
+	(cd submodule2 &&
+		git rev-parse origin/master^ >../expected2 &&
+		git rev-parse HEAD >../actual2) &&
+	test_cmp expected1 actual1 &&
+	test_cmp expected2 actual2 &&
+	test -z "$(git status --porcelain --untracked-files=no)"
+}
+
+test_expect_success 'local branch configuration follows branch' '
+	(cd branch &&
+		git submodule update &&
+		check_both_submodules_exact &&
+		git config submodule.submodule1.branch origin/master &&
+		git submodule update &&
+		check_submodule_one_follows
+	)
+'
+
+test_expect_success '.gitmodules branch configuration follows branch' '
+	(cd branch &&
+		git config --unset submodule.submodule1.branch &&
+		git submodule update &&
+		check_both_submodules_exact &&
+		git config -f .gitmodules submodule.submodule1.branch origin/master &&
+		git add .gitmodules &&
+		git commit -m ".gitmodules follows branch" &&
+		git submodule update &&
+		check_submodule_one_follows
+	)
+'
+
+test_expect_success '--checkout commandline overrides branch config' '
+	(cd branch &&
+		git submodule update --checkout &&
+		check_both_submodules_exact
+	)
+'
+
+test_expect_success 'local config overrides .gitmodules branch config' '
+	(cd branch &&
+		git submodule update &&
+		check_submodule_one_follows &&
+		git config submodule.submodule1.branch HEAD &&
+		git submodule update &&
+		check_both_submodules_exact
+	)
+'
+
 test_done
-- 
1.7.7.433.gcf1e7
