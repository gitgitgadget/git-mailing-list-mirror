From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v4] submodule: add 'deinit' command
Date: Wed, 06 Feb 2013 22:11:18 +0100
Message-ID: <5112C6F6.4030607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Phil Hord <phil.hord@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 22:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3CHZ-00008Q-0z
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 22:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758648Ab3BFVLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 16:11:30 -0500
Received: from mout.web.de ([212.227.17.11]:61800 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758462Ab3BFVL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 16:11:29 -0500
Received: from [192.168.178.41] ([79.193.84.147]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LyDdJ-1Uzbpy3HS1-015xLa; Wed, 06 Feb 2013 22:11:20
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:iKHJx9wVw+akN0bXLxRrzj9WMa6ijGGW4dtwPmiWAIp
 B0upwqt99HbSJw6IQ2f4UZ0ZeqQvG4JODfIYMKMKLsof0T68ay
 +al91rV4MHNBcBDUVPDvW+SG/MvbgEpWwgP2ekESJh1mz8ERn0
 1Gv4lDpFAtDs716eqb7yVx3yq8Z/gYi6Hoit9c9AROYD1LMzSw
 OMJANBuU+SY5gGlxlrjYQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215643>

With "git submodule init" the user is able to tell git he cares about one
or more submodules and wants to have it populated on the next call to "git
submodule update". But currently there is no easy way he could tell git he
does not care about a submodule anymore and wants to get rid of his local
work tree (except he knows a lot about submodule internals and removes the
"submodule.$name.url" setting from .git/config together with the work tree
himself).

Help those users by providing a 'deinit' command. This removes the whole
submodule.<name> section from .git/config either for the given
submodule(s) or for all those which have been initialized if '.' is
given. Fail if the current work tree contains modifications unless
forced. Complain when for a submodule given on the command line the url
setting can't be found in .git/config, but nonetheless don't fail.

Add tests and link the man pages of "git submodule deinit" and "git rm"
to assist the user in deciding whether removing or unregistering the
submodule is the right thing to do for him.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Changes since v3:
- Add deinit to the --force documentation of "git submodule"
- Never remove submodules containing a .git dir, even when forced
- Diagnostic output when "rm -rf" or "mkdir" fails
- More test cases


 Documentation/git-rm.txt        |   4 ++
 Documentation/git-submodule.txt |  18 +++++++-
 git-submodule.sh                |  78 ++++++++++++++++++++++++++++++-
 t/t7400-submodule-basic.sh      | 100 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 198 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 92bac27..1d876c2 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -149,6 +149,10 @@ files that aren't ignored are present in the submodules work tree.
 Ignored files are deemed expendable and won't stop a submodule's work
 tree from being removed.

+If you only want to remove the local checkout of a submodule from your
+work tree without committing the removal,
+use linkgit:git-submodule[1] `deinit` instead.
+
 EXAMPLES
 --------
 `git rm Documentation/\*.txt`::
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index a0c9df8..bc06159 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	      [--reference <repository>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
+'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch] [--rebase]
 	      [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
@@ -134,6 +135,19 @@ init::
 	the explicit 'init' step if you do not intend to customize
 	any submodule locations.

+deinit::
+	Unregister the given submodules, i.e. remove the whole
+	`submodule.$name` section from .git/config together with their work
+	tree. Further calls to `git submodule update`, `git submodule foreach`
+	and `git submodule sync` will skip any unregistered submodules until
+	they are initialized again, so use this command if you don't want to
+	have a local checkout of the submodule in your work tree anymore. If
+	you really want to remove a submodule from the repository and commit
+	that use linkgit:git-rm[1] instead.
++
+If `--force` is specified, the submodule's work tree will be removed even if
+it contains local modifications.
+
 update::
 	Update the registered submodules, i.e. clone missing submodules and
 	checkout the commit specified in the index of the containing repository.
@@ -213,8 +227,10 @@ OPTIONS

 -f::
 --force::
-	This option is only valid for add and update commands.
+	This option is only valid for add, deinit and update commands.
 	When running add, allow adding an otherwise ignored submodule path.
+	When running deinit the submodule work trees will be removed even if
+	they contain local changes.
 	When running update, throw away local changes in submodules when
 	switching to a different commit; and always run a checkout operation
 	in the submodule, even if the commit listed in the index of the
diff --git a/git-submodule.sh b/git-submodule.sh
index 004c034..f1b552f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -8,6 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
+   or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
    or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
@@ -547,6 +548,81 @@ cmd_init()
 }

 #
+# Unregister submodules from .git/config and remove their work tree
+#
+# $@ = requested paths (use '.' to deinit all submodules)
+#
+cmd_deinit()
+{
+	# parse $args after "submodule ... init".
+	while test $# -ne 0
+	do
+		case "$1" in
+		-f|--force)
+			force=$1
+			;;
+		-q|--quiet)
+			GIT_QUIET=1
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
+	if test $# = 0
+	then
+		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
+	fi
+
+	module_list "$@" |
+	while read mode sha1 stage sm_path
+	do
+		die_if_unmatched "$mode"
+		name=$(module_name "$sm_path") || exit
+		url=$(git config submodule."$name".url)
+		if test -z "$url"
+		then
+			say "$(eval_gettext "No url found for submodule path '\$sm_path' in .git/config")"
+			continue
+		fi
+
+		# Remove the submodule work tree (unless the user already did it)
+		if test -d "$sm_path"
+		then
+			# Protect submodules containing a .git directory
+			if test -d "$sm_path/.git"
+			then
+				echo >&2 "$(eval_gettext "Submodule work tree $sm_path contains a .git directory")"
+				die "$(eval_gettext "(use 'rm -rf' if you really want to remove it including all of its history)")"
+			fi
+
+			if test -z "$force"
+			then
+				git rm -n "$sm_path" ||
+				die "$(eval_gettext "Submodule work tree $sm_path contains local modifications, use '-f' to discard them")"
+			fi
+			rm -rf "$sm_path" || say "$(eval_gettext "Could not remove submodule work tree '\$sm_path'")"
+		fi
+
+		mkdir "$sm_path" || say "$(eval_gettext "Could not create empty submodule directory '\$sm_path'")"
+
+		# Remove the whole section so we have a clean state when the
+		# user later decides to init this submodule again
+		git config --remove-section submodule."$name" &&
+		say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$sm_path'")"
+	done
+}
+
+#
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
 # $@ = requested paths (default to all)
@@ -1157,7 +1233,7 @@ cmd_sync()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | update | status | summary | sync)
+	add | foreach | init | deinit | update | status | summary | sync)
 		command=$1
 		;;
 	-q|--quiet)
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 2683cba..f54a40d 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -757,4 +757,104 @@ test_expect_success 'submodule add with an existing name fails unless forced' '
 	)
 '

+test_expect_success 'set up a second submodule' '
+	git submodule add ./init2 example2 &&
+	git commit -m "submodle example2 added"
+'
+
+test_expect_success 'submodule deinit should remove the whole submodule section from .git/config' '
+	git config submodule.example.foo bar &&
+	git config submodule.example2.frotz nitfol &&
+	git submodule deinit init &&
+	test -z "$(git config submodule.example.url)" &&
+	test -z "$(git config submodule.example.foo)" &&
+	test -n "$(git config submodule.example2.url)" &&
+	test -n "$(git config submodule.example2.frotz)" &&
+	test -f example2/.git &&
+	rmdir init
+'
+
+test_expect_success 'submodule deinit . deinits all initialized submodules' '
+	git submodule update --init &&
+	git config submodule.example.foo bar &&
+	git config submodule.example2.frotz nitfol &&
+	test_must_fail git submodule deinit &&
+	git submodule deinit . &&
+	test -z "$(git config submodule.example.url)" &&
+	test -z "$(git config submodule.example.foo)" &&
+	test -z "$(git config submodule.example2.url)" &&
+	test -z "$(git config submodule.example2.frotz)" &&
+	rmdir init example2
+'
+
+test_expect_success 'submodule deinit deinits a submodule when its work tree is missing or empty' '
+	git submodule update --init &&
+	rm -rf init example2/* example2/.git &&
+	git submodule deinit init example2 &&
+	test -z "$(git config submodule.example.url)" &&
+	test -z "$(git config submodule.example2.url)" &&
+	rmdir init
+'
+
+test_expect_success 'submodule deinit fails when the submodule contains modifications unless forced' '
+	git submodule update --init &&
+	echo X >>init/s &&
+	test_must_fail git submodule deinit init &&
+	test -n "$(git config submodule.example.url)" &&
+	test -f example2/.git &&
+	git submodule deinit -f init &&
+	test -z "$(git config submodule.example.url)" &&
+	rmdir init
+'
+
+test_expect_success 'submodule deinit fails when the submodule contains untracked files unless forced' '
+	git submodule update --init &&
+	echo X >>init/untracked &&
+	test_must_fail git submodule deinit init &&
+	test -n "$(git config submodule.example.url)" &&
+	test -f example2/.git &&
+	git submodule deinit -f init &&
+	test -z "$(git config submodule.example.url)" &&
+	rmdir init
+'
+
+test_expect_success 'submodule deinit fails when the submodule HEAD does not match unless forced' '
+	git submodule update --init &&
+	(
+		cd init &&
+		git checkout HEAD^
+	) &&
+	test_must_fail git submodule deinit init &&
+	test -n "$(git config submodule.example.url)" &&
+	test -f example2/.git &&
+	git submodule deinit -f init &&
+	test -z "$(git config submodule.example.url)" &&
+	rmdir init
+'
+
+test_expect_success 'submodule deinit complains but does not fail when used on an uninitialized submodule' '
+	git submodule update --init &&
+	git submodule deinit init >actual &&
+	test_i18ngrep "Submodule .example. (.*) unregistered for path .init" actual
+	git submodule deinit init >actual &&
+	test_i18ngrep "No url found for submodule path .init. in .git/config" actual &&
+	git submodule deinit . >actual &&
+	test_i18ngrep "Submodule .example2. (.*) unregistered for path .example2" actual
+	rmdir init example2
+'
+
+test_expect_success 'submodule deinit fails when submodule has a .git directory even when forced' '
+	git submodule update --init &&
+	(
+		cd init &&
+		rm .git &&
+		cp -R ../.git/modules/example .git &&
+		GIT_WORK_TREE=. git config --unset core.worktree
+	) &&
+	test_must_fail git submodule deinit init &&
+	test_must_fail git submodule deinit -f init &&
+	test -d init/.git &&
+	test -n "$(git config submodule.example.url)"
+'
+
 test_done
-- 
1.8.1.2.546.gea155c0
