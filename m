From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v4 3/4] git-submodule update: Add --branch option
Date: Mon, 26 Nov 2012 16:00:18 -0500
Message-ID: <95edff1c97c513c555652014f9c2bbf61c8e7560.1353962698.git.wking@tremily.us>
References: <20121123175402.GH2806@odin.tremily.us>
 <cover.1353962698.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:02:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td5og-0005Fr-PP
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 22:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab2KZVBu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2012 16:01:50 -0500
Received: from vms173007pub.verizon.net ([206.46.173.7]:19610 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab2KZVBt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 16:01:49 -0500
Received: from odin.tremily.us ([unknown] [72.68.108.240])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME400F9S51QNV40@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 26 Nov 2012 15:01:31 -0600 (CST)
Received: from localhost (tyr.tremily.us [192.168.0.5])
	by odin.tremily.us (Postfix) with ESMTP id 48AB16DEFCD; Mon,
 26 Nov 2012 16:01:02 -0500 (EST)
X-Mailer: git-send-email 1.8.0.3.g95edff1.dirty
In-reply-to: <cover.1353962698.git.wking@tremily.us>
In-reply-to: <cover.1353962698.git.wking@tremily.us>
References: <cover.1353962698.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210494>

=46rom: "W. Trevor King" <wking@tremily.us>

This allows users to checkout the current
superproject-recorded-submodule-sha as a branch, avoiding the detached
head state that the standard submodule update creates.  This may be
useful for the existing --rebase/--merge workflows which already avoid
detached heads.

It is also useful if you want easy tracking of upstream branches.  The
particular upstream branch to be tracked is configured locally with
=2Egit/modules/<name>/config.  With the new option =C3=86var's suggeste=
d

  $ git submodule foreach 'git checkout $(git config --file $toplevel/.=
gitm
odules submodule.$name.branch) && git pull'

reduces to a

  $ git submodule update --branch

after each supermodule .gitmodules edit, and a

  $ git submodule foreach 'git pull'

whenever you feel like updating the submodules.  Your still on you're
own to commit (or not) the updated submodule hashes in the
superproject's .gitmodules.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-submodule.txt | 20 +++++++++++------
 git-submodule.sh                | 48 +++++++++++++++++++++++++++++----=
------
 t/t7406-submodule-update.sh     | 50 +++++++++++++++++++++++++++++++++=
+++++++-
 3 files changed, 98 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submod=
ule.txt
index d0b4436..34392a1 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	      [-f|--force] [--reference <repository>] [--] <repository> [<pat=
h>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>=
=2E..]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
+'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--branch] [=
--rebase]
 	      [--reference <repository>] [--merge] [--recursive] [--] [<path>=
=2E..]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-li=
mit) <n>]
 	      [commit] [--] [<path>...]
@@ -136,11 +136,11 @@ init::
=20
 update::
 	Update the registered submodules, i.e. clone missing submodules and
-	checkout the commit specified in the index of the containing reposito=
ry.
-	This will make the submodules HEAD be detached unless `--rebase` or
-	`--merge` is specified or the key `submodule.$name.update` is set to
-	`rebase`, `merge` or `none`. `none` can be overridden by specifying
-	`--checkout`.
+	checkout the commit specified in the index of the containing
+	repository.  This will make the submodules HEAD be detached unless
+	`--branch`, `--rebase`, `--merge` is specified or the key
+	`submodule.$name.update` is set to `branch`, `rebase`, `merge` or
+	`none`. `none` can be overridden by specifying `--checkout`.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
@@ -207,7 +207,13 @@ OPTIONS
=20
 -b::
 --branch::
-	Branch of repository to add as submodule.
+	When used with the add command, gives the branch of repository to
+	add as submodule.
++
+When used with the update command, checks out a branch named
+`submodule.<name>.branch` (as set by `--local-branch`) pointing at the
+current HEAD SHA-1.  This is useful for commands like `update
+--rebase` that do not work on detached heads.
=20
 --local-branch::
 	Record a branch name used as `submodule.<path>.branch` in
diff --git a/git-submodule.sh b/git-submodule.sh
index c51b6ae..28eb4b1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -8,7 +8,7 @@ dashless=3D$(basename "$0" | sed -e 's/-/ /')
 USAGE=3D"[--quiet] add [-b branch] [--local-branch[=3D<branch>]] [-f|-=
-force] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path=
>...]
    or: $dashless [--quiet] init [--] [<path>...]
-   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force=
] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<=
path>...]
+   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force=
] [--branch] [--rebase] [--reference <repository>] [--merge] [--recursi=
ve] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit=
 <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--] [<path>...]"
@@ -539,6 +539,9 @@ cmd_update()
 		-f|--force)
 			force=3D$1
 			;;
+		-b|--branch)
+			update=3D"branch"
+			;;
 		-r|--rebase)
 			update=3D"rebase"
 			;;
@@ -593,6 +596,7 @@ cmd_update()
 		fi
 		name=3D$(module_name "$sm_path") || exit
 		url=3D$(git config submodule."$name".url)
+		branch=3D$(git config submodule."$name".branch)
 		if ! test -z "$update"
 		then
 			update_module=3D$update
@@ -627,7 +631,7 @@ Maybe you want to use 'update --init'?")"
 			die "$(eval_gettext "Unable to find current revision in submodule p=
ath '\$sm_path'")"
 		fi
=20
-		if test "$subsha1" !=3D "$sha1" -o -n "$force"
+		if test "$subsha1" !=3D "$sha1" -o -n "$force" -o "$update_module" =3D=
 "branch"
 		then
 			subforce=3D$force
 			# If we don't already have a -f flag and the submodule has never be=
en checked out
@@ -650,16 +654,21 @@ Maybe you want to use 'update --init'?")"
 			case ";$cloned_modules;" in
 			*";$name;"*)
 				# then there is no local change to integrate
-				update_module=3D ;;
+				case "$update_module" in
+					rebase|merge)
+						update_module=3D
+						;;
+				esac
+				;;
 			esac
=20
 			must_die_on_failure=3D
 			case "$update_module" in
 			rebase)
 				command=3D"git rebase"
-				die_msg=3D"$(eval_gettext "Unable to rebase '\$sha1' in submodule =
path '\$sm_path'")"
+				die_msg=3D"$(eval_gettext "Unable to rebase '\$sha1' in submodule =
path '\$sm_path'")"=09
 				say_msg=3D"$(eval_gettext "Submodule path '\$sm_path': rebased int=
o '\$sha1'")"
-				must_die_on_failure=3Dyes
+			must_die_on_failure=3Dyes
 				;;
 			merge)
 				command=3D"git merge"
@@ -674,15 +683,30 @@ Maybe you want to use 'update --init'?")"
 				;;
 			esac
=20
-			if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
+			if test "$subsha1" !=3D "$sha1" -o -n "$force"
 			then
-				say "$say_msg"
-			elif test -n "$must_die_on_failure"
+				if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
+				then
+					say "$say_msg"
+				elif test -n "$must_die_on_failure"
+				then
+					die_with_status 2 "$die_msg"
+				else
+					err=3D"${err};$die_msg"
+					continue
+				fi
+			fi
+
+			if test "$update_module" =3D "branch" -a -n "$branch"
 			then
-				die_with_status 2 "$die_msg"
-			else
-				err=3D"${err};$die_msg"
-				continue
+				if (clear_local_git_env; cd "$sm_path" &&
+					git branch -f "$branch" "$sha1" &&
+					git checkout "$branch")
+				then
+					say "$(eval_gettext "Submodule path '\$sm_path': checked out bran=
ch '\$branch'")"
+				else
+					err=3D"${err};$(eval_gettext "Unable to checkout branch '\$branch=
' in submodule path '\$sm_path'")"
+				fi
 			fi
 		fi
=20
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 1542653..c876a8b 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -6,7 +6,8 @@
 test_description=3D'Test updating submodules
=20
 This test verifies that "git submodule update" detaches the HEAD of th=
e
-submodule and "git submodule update --rebase/--merge" does not detach =
the HEAD.
+submodule and "git submodule update --branch/--rebase/--merge" does no=
t
+detach the HEAD.
 '
=20
 . ./test-lib.sh
@@ -135,6 +136,53 @@ test_expect_success 'submodule update --force forc=
ibly checks out submodules' '
 	)
 '
=20
+test_expect_success 'submodule update --branch detaches without submod=
ule.<name>.branch' '
+	(cd super/submodule &&
+	  git checkout master
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update --branch submodule &&
+	 (cd submodule &&
+	  test "$(git status -s file)" =3D ""
+	 )
+	)
+'
+
+test_expect_success 'submodule update --branch staying on master' '
+	(cd super/submodule &&
+	  git checkout master
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git config submodule.submodule.branch master
+	 git submodule update --branch submodule &&
+	 cd submodule &&
+	 test "refs/heads/master" =3D "$(git symbolic-ref -q HEAD)" &&
+	 compare_head
+	)
+'
+
+test_expect_success 'submodule update --branch creating a new branch' =
'
+	(cd super/submodule &&
+	  git checkout master
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git config submodule.submodule.branch new-branch
+	 git submodule update --branch submodule &&
+	 cd submodule &&
+	 test "refs/heads/new-branch" =3D "$(git symbolic-ref -q HEAD)" &&
+	 compare_head
+	)
+'
+
 test_expect_success 'submodule update --rebase staying on master' '
 	(cd super/submodule &&
 	  git checkout master
--=20
1.8.0.3.g95edff1.dirty
