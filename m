From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v6] submodule: add 'deinit' command
Date: Mon, 04 Mar 2013 22:20:24 +0100
Message-ID: <51351018.20301@web.de>
References: <5112C6F6.4030607@web.de> <CABURp0oQcPotK20QcqCG1pGQPVoa4RnN2nDA=iQoKS99gnPEAQ@mail.gmail.com> <511BEA75.6000002@web.de> <7vip5w6l8s.fsf@alter.siamese.dyndns.org> <5121384B.10009@web.de> <7v38wufu5t.fsf@alter.siamese.dyndns.org> <51227EFE.6030908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 22:21:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCcok-00021Q-5O
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 22:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758811Ab3CDVUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 16:20:39 -0500
Received: from mout.web.de ([212.227.17.12]:63131 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758669Ab3CDVUj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 16:20:39 -0500
Received: from [192.168.178.41] ([91.3.179.58]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MXYjm-1UGZF01XnS-00WWj2; Mon, 04 Mar 2013 22:20:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <51227EFE.6030908@web.de>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:s2Q1jnL7kwm/Oie069fri9VGMTMbZ4T6NJY2jKKaMix
 kMVxyUKZZ/h2KArGZ+IDM2RNyuAY3J1WkkC2RWvYETJVN0yUs8
 5jwWZjj+FLntVOuEdFXt8DePjWYPmFkX29q42w/evSx+MXN0S6
 IfL8Un75uw9S278dnYxOPLOlJQ5eFOBt0lH6zdaEFeyFSNuX6Y
 HI8jJlGxKpZiIoH/rJhNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217411>

With "git submodule init" the user is able to tell git he cares about one
or more submodules and wants to have it populated on the next call to "git
submodule update". But currently there is no easy way he could tell git he
does not care about a submodule anymore and wants to get rid of his local
work tree (except he knows a lot about submodule internals and removes the
"submodule.$name.url" setting from .git/config together with the work tree
himself).

Help those users by providing a 'deinit' command. This removes the
whole submodule.<name> section from .git/config (either for the given
submodule(s) or for all those which have been initialized if '.' is used)
together with their work tree. Fail if the current work tree contains
modifications (unless forced), but don't complain when either the work
tree is already removed or no settings are found in .git/config.

Add tests and link the man pages of "git submodule deinit" and "git rm"
to assist the user in deciding whether removing or unregistering the
submodule is the right thing to do for him. Also add the deinit subcommand
to the completion list.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 18.02.2013 20:20, schrieb Jens Lehmann:
> Am 17.02.2013 23:32, schrieb Junio C Hamano:
>> It seems that this "warn if user told us to deinitialize a submodule
>> that hasn't been initialized" is from the very initial round of this
>> series, and not something other people asked for during the review.
>> If somebody did
>>
>> 	git submodule deinit foo bar
>>
>> and then later said:
>>
>> 	git submodule deinit foo
>>
>> would it a mistake that the user wants to be warned about?
>>
>> Perhaps the user did not mean to deinitialize foo (e.g. wanted to
>> *initialize* foo instead, or wanted to deinitialize *foz* instead)
>> and that is worth warning about?  I am not sure, but I have a
>> feeling that we can do without this check.
> 
> Hmm, if you would replace "submodule deinit" with "rm" in the above
> example, the "rm" would not only warn but error out the second time.
> But on the other hand doing a "git submodule init" again on already
> initialized submodules will silently do nothing, which seems to be
> the better analogy here. So yes, it looks like we can do without.
> 
> Ok, unless someone speaks up and argues in favor of this message
> I'll remove it in v6.

Nobody spoke up, so here we go.

Changes since v5:

- No warning message when the url setting is not found
- Reword second commit message paragraph accordingly
- Use 'git config --get-regexp "submodule\.example\."' in tests
- Fix a copied comment still talking about "init"

Hopefully this is the final version ;-)


 Documentation/git-rm.txt               |   4 ++
 Documentation/git-submodule.txt        |  18 +++++-
 contrib/completion/git-completion.bash |   2 +-
 git-submodule.sh                       |  77 ++++++++++++++++++++++++-
 t/t7400-submodule-basic.sh             | 100 +++++++++++++++++++++++++++++++++
 5 files changed, 198 insertions(+), 3 deletions(-)

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
index c99d795..74d5bdc 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	      [--reference <repository>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
+'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase] [--reference <repository>]
 	      [--merge] [--recursive] [--] [<path>...]
@@ -135,6 +136,19 @@ init::
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
@@ -214,8 +228,10 @@ OPTIONS

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
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b62bec0..6ab5752 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2413,7 +2413,7 @@ _git_submodule ()
 {
 	__git_has_doubledash && return

-	local subcommands="add status init update summary foreach sync"
+	local subcommands="add status init deinit update summary foreach sync"
 	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
 		case "$cur" in
 		--*)
diff --git a/git-submodule.sh b/git-submodule.sh
index 004c034..44f70c4 100755
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
@@ -547,6 +548,80 @@ cmd_init()
 }

 #
+# Unregister submodules from .git/config and remove their work tree
+#
+# $@ = requested paths (use '.' to deinit all submodules)
+#
+cmd_deinit()
+{
+	# parse $args after "submodule ... deinit".
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
+
+		# Remove the submodule work tree (unless the user already did it)
+		if test -d "$sm_path"
+		then
+			# Protect submodules containing a .git directory
+			if test -d "$sm_path/.git"
+			then
+				echo >&2 "$(eval_gettext "Submodule work tree '\$sm_path' contains a .git directory")"
+				die "$(eval_gettext "(use 'rm -rf' if you really want to remove it including all of its history)")"
+			fi
+
+			if test -z "$force"
+			then
+				git rm -n "$sm_path" ||
+				die "$(eval_gettext "Submodule work tree '\$sm_path' contains local modifications; use '-f' to discard them")"
+			fi
+			rm -rf "$sm_path" || say "$(eval_gettext "Could not remove submodule work tree '\$sm_path'")"
+		fi
+
+		mkdir "$sm_path" || say "$(eval_gettext "Could not create empty submodule directory '\$sm_path'")"
+
+		# Remove the .git/config entries (unless the user already did it)
+		if test -n "$(git config --get-regexp submodule."$name\.")"
+		then
+			# Remove the whole section so we have a clean state when
+			# the user later decides to init this submodule again
+			url=$(git config submodule."$name".url)
+			git config --remove-section submodule."$name" 2>/dev/null &&
+			say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$sm_path'")"
+		fi
+	done
+}
+
+#
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
 # $@ = requested paths (default to all)
@@ -1157,7 +1232,7 @@ cmd_sync()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | update | status | summary | sync)
+	add | foreach | init | deinit | update | status | summary | sync)
 		command=$1
 		;;
 	-q|--quiet)
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 2683cba..5030f1f 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -757,4 +757,104 @@ test_expect_success 'submodule add with an existing name fails unless forced' '
 	)
 '

+test_expect_success 'set up a second submodule' '
+	git submodule add ./init2 example2 &&
+	git commit -m "submodule example2 added"
+'
+
+test_expect_success 'submodule deinit should remove the whole submodule section from .git/config' '
+	git config submodule.example.foo bar &&
+	git config submodule.example2.frotz nitfol &&
+	git submodule deinit init &&
+	test -z "$(git config --get-regexp "submodule\.example\.")" &&
+	test -n "$(git config --get-regexp "submodule\.example2\.")" &&
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
+	test -z "$(git config --get-regexp "submodule\.example\.")" &&
+	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
+	rmdir init example2
+'
+
+test_expect_success 'submodule deinit deinits a submodule when its work tree is missing or empty' '
+	git submodule update --init &&
+	rm -rf init example2/* example2/.git &&
+	git submodule deinit init example2 &&
+	test -z "$(git config --get-regexp "submodule\.example\.")" &&
+	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
+	rmdir init
+'
+
+test_expect_success 'submodule deinit fails when the submodule contains modifications unless forced' '
+	git submodule update --init &&
+	echo X >>init/s &&
+	test_must_fail git submodule deinit init &&
+	test -n "$(git config --get-regexp "submodule\.example\.")" &&
+	test -f example2/.git &&
+	git submodule deinit -f init &&
+	test -z "$(git config --get-regexp "submodule\.example\.")" &&
+	rmdir init
+'
+
+test_expect_success 'submodule deinit fails when the submodule contains untracked files unless forced' '
+	git submodule update --init &&
+	echo X >>init/untracked &&
+	test_must_fail git submodule deinit init &&
+	test -n "$(git config --get-regexp "submodule\.example\.")" &&
+	test -f example2/.git &&
+	git submodule deinit -f init &&
+	test -z "$(git config --get-regexp "submodule\.example\.")" &&
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
+	test -n "$(git config --get-regexp "submodule\.example\.")" &&
+	test -f example2/.git &&
+	git submodule deinit -f init &&
+	test -z "$(git config --get-regexp "submodule\.example\.")" &&
+	rmdir init
+'
+
+test_expect_success 'submodule deinit is silent when used on an uninitialized submodule' '
+	git submodule update --init &&
+	git submodule deinit init >actual &&
+	test_i18ngrep "Submodule .example. (.*) unregistered for path .init" actual &&
+	git submodule deinit init >actual &&
+	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
+	git submodule deinit . >actual &&
+	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
+	test_i18ngrep "Submodule .example2. (.*) unregistered for path .example2" actual &&
+	git submodule deinit . >actual &&
+	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
+	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .example2" actual &&
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
+	test -n "$(git config --get-regexp "submodule\.example\.")"
+'
+
 test_done
-- 
1.8.2.rc2.5.geb8e692
