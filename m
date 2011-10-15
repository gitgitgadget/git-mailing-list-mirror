From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/9 v2] completion: optimize refs completion
Date: Sat, 15 Oct 2011 14:57:23 +0200
Message-ID: <1318683443-1896-1-git-send-email-szeder@ira.uka.de>
References: <20111014121609.GB2208@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 15 14:58:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RF3oV-0001yq-BX
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 14:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482Ab1JOM5t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Oct 2011 08:57:49 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:58623 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476Ab1JOM5r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 08:57:47 -0400
Received: from localhost6.localdomain6 (p5B1305FA.dip0.t-ipconnect.de [91.19.5.250])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MY4Jc-1RbBAq3EYK-00V2bL; Sat, 15 Oct 2011 14:57:41 +0200
X-Mailer: git-send-email 1.7.7.197.g04a3e
In-Reply-To: <20111014121609.GB2208@goldbirke>
X-Provags-ID: V02:K0:HZUUSfeJUHO4KYWzdgFRMK86cgzjEOj/IIMPI+7lgcJ
 6tQW6qSJoUBuyjnHaocmbayJCfwKeRxOARFh9mqhzjDUcylCQh
 +Tn/rOz0W2ljFgX1HM3uFDEUcYqWt4i23HxG5Lcy34a8BSh2sX
 4jqAfPOGFBLaGgfTBlRsQD5T3UuAar41bBfkjShePd2kElowko
 Q09I6T9sxyiuDOZw1GI3WlhC+tKUwgHvD2WWTZ5Ef7tJ/cTafR
 ZEAkJXsaWH2E9Acd2WRCZjEvLDH7CjaruWHOki25wb2sQuQ/0Q
 t0Biras9Drh4zbmlP7upWljm3U62YbRR3tC7VmdCihXPtM4lDj
 3RS8jqh7Wc5BnG4rSPZ1OPdIZ62x+2G7DlE0+sMHG2lXYBEDkk
 GeyJQUXsmppag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183652>

After a unique command or option is completed, in most cases it is a
good thing to add a trailing a space, but sometimes it doesn't make
sense, e.g. when the completed word is an option taking an argument
('--option=3D') or a configuration section ('core.').  Therefore the
completion script uses the '-o nospace' option to prevent bash from
automatically appending a space to unique completions, and it has the
__gitcomp() function to add that trailing space only when necessary.
See 72e5e989 (bash: Add space after unique command name is completed.,
2007-02-04), 78d4d6a2 (bash: Support unique completion on git-config.,
2007-02-04), and b3391775 (bash: Support unique completion when
possible., 2007-02-04).

__gitcomp() therefore iterates over all possible completion words it
got as argument, and checks each word whether a trailing space is
necessary or not.  This is ok for commands, options, etc., i.e. when
the number of words is relatively small, but can be noticeably slow
for large number of refs.  However, while options might or might not
need that trailing space, refs are always handled uniformly and always
get that trailing space (or a trailing '.' for 'git config
branch.<head>.').  Since refs listed by __git_refs() & co. are
separated by newline, this allows us some optimizations with
'compgen'.

So, add a specialized variant of __gitcomp() that only deals with
possible completion words separated by a newline and uniformly appends
the trailing space to all words using 'compgen -S " "' (or any other
suffix, if specified), so no iteration over all words is needed.  But
we need to fiddle with IFS, because the default IFS containing a space
would cause the added space suffix to be stripped off when compgen's
output is stored in the COMPREPLY array.  Therefore we use only
newline as IFS, hence the requirement for the newline-separated
possible completion words.

Convert all callsites of __gitcomp() where it's called with refs, i.e.
when it gets the output of either __git_refs(), __git_heads(),
__git_tags(), __git_refs2(), __git_refs_remotes(), or the odd 'git
for-each-ref' somewhere in _git_config().  Also convert callsites
where it gets other uniformly handled newline separated word lists,
i.e. either remotes from __git_remotes(), names of set configuration
variables from __git_config_get_set_variables(), stashes, or commands.

Here are some timing results for dealing with 10000 refs.
Before:

  $ refs=3D"$(__git_refs ~/tmp/git/repo-with-10k-refs/)"
  $ time __gitcomp "$refs"

  real	0m1.134s
  user	0m1.060s
  sys	0m0.130s

After:

  $ time __gitcomp_nl "$refs"

  real	0m0.373s
  user	0m0.360s
  sys	0m0.020s

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

On Fri, Oct 14, 2011 at 02:16:09PM +0200, SZEDER G=C3=A1bor wrote:
> Oops, this last hunk is wrong.

Here's the update with that buggy hunk removed.  I also updated the
comments before __gitcomp_nl() to be more explicit, and the commit
message with the IFS fiddling and the grammar errors you pointed out
earlier.

These changes don't conflict with later patches, so I resend only this
patch but not the whole series.

 contrib/completion/git-completion.bash |  115 +++++++++++++++++++-----=
-------
 1 files changed, 70 insertions(+), 45 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index c0fb6e15..daabf827 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -512,6 +512,31 @@ __gitcomp ()
 	esac
 }
=20
+# Generates completion reply with compgen from newline-separated possi=
ble
+# completion words by appending a space to all of them.
+# It accepts 1 to 4 arguments:
+# 1: List of possible completion words, separated by a single newline.
+# 2: A prefix to be added to each possible completion word (optional).
+# 3: Generate possible completion matches for this word (optional).
+# 4: A suffix to be appended to each possible completion word instead =
of
+#    the default space (optional).  If specified but empty, nothing is
+#    appended.
+__gitcomp_nl ()
+{
+	local s=3D$'\n' IFS=3D' '$'\t'$'\n'
+	local cur_=3D"$cur" suffix=3D" "
+
+	if [ $# -gt 2 ]; then
+		cur_=3D"$3"
+		if [ $# -gt 3 ]; then
+			suffix=3D"$4"
+		fi
+	fi
+
+	IFS=3D$s
+	COMPREPLY=3D($(compgen -P "${2-}" -S "$suffix" -W "$1" -- "$cur_"))
+}
+
 # __git_heads accepts 0 or 1 arguments (to pass to __gitdir)
 __git_heads ()
 {
@@ -716,15 +741,15 @@ __git_complete_revlist_file ()
 	*...*)
 		pfx=3D"${cur_%...*}..."
 		cur_=3D"${cur_#*...}"
-		__gitcomp "$(__git_refs)" "$pfx" "$cur_"
+		__gitcomp_nl "$(__git_refs)" "$pfx" "$cur_"
 		;;
 	*..*)
 		pfx=3D"${cur_%..*}.."
 		cur_=3D"${cur_#*..}"
-		__gitcomp "$(__git_refs)" "$pfx" "$cur_"
+		__gitcomp_nl "$(__git_refs)" "$pfx" "$cur_"
 		;;
 	*)
-		__gitcomp "$(__git_refs)"
+		__gitcomp_nl "$(__git_refs)"
 		;;
 	esac
 }
@@ -764,7 +789,7 @@ __git_complete_remote_or_refspec ()
 		c=3D$((++c))
 	done
 	if [ -z "$remote" ]; then
-		__gitcomp "$(__git_remotes)"
+		__gitcomp_nl "$(__git_remotes)"
 		return
 	fi
 	if [ $no_complete_refspec =3D 1 ]; then
@@ -789,23 +814,23 @@ __git_complete_remote_or_refspec ()
 	case "$cmd" in
 	fetch)
 		if [ $lhs =3D 1 ]; then
-			__gitcomp "$(__git_refs2 "$remote")" "$pfx" "$cur_"
+			__gitcomp_nl "$(__git_refs2 "$remote")" "$pfx" "$cur_"
 		else
-			__gitcomp "$(__git_refs)" "$pfx" "$cur_"
+			__gitcomp_nl "$(__git_refs)" "$pfx" "$cur_"
 		fi
 		;;
 	pull)
 		if [ $lhs =3D 1 ]; then
-			__gitcomp "$(__git_refs "$remote")" "$pfx" "$cur_"
+			__gitcomp_nl "$(__git_refs "$remote")" "$pfx" "$cur_"
 		else
-			__gitcomp "$(__git_refs)" "$pfx" "$cur_"
+			__gitcomp_nl "$(__git_refs)" "$pfx" "$cur_"
 		fi
 		;;
 	push)
 		if [ $lhs =3D 1 ]; then
-			__gitcomp "$(__git_refs)" "$pfx" "$cur_"
+			__gitcomp_nl "$(__git_refs)" "$pfx" "$cur_"
 		else
-			__gitcomp "$(__git_refs "$remote")" "$pfx" "$cur_"
+			__gitcomp_nl "$(__git_refs "$remote")" "$pfx" "$cur_"
 		fi
 		;;
 	esac
@@ -1084,7 +1109,7 @@ _git_archive ()
 		return
 		;;
 	--remote=3D*)
-		__gitcomp "$(__git_remotes)" "" "${cur##--remote=3D}"
+		__gitcomp_nl "$(__git_remotes)" "" "${cur##--remote=3D}"
 		return
 		;;
 	--*)
@@ -1115,7 +1140,7 @@ _git_bisect ()
=20
 	case "$subcommand" in
 	bad|good|reset|skip|start)
-		__gitcomp "$(__git_refs)"
+		__gitcomp_nl "$(__git_refs)"
 		;;
 	*)
 		COMPREPLY=3D()
@@ -1146,9 +1171,9 @@ _git_branch ()
 		;;
 	*)
 		if [ $only_local_ref =3D "y" -a $has_r =3D "n" ]; then
-			__gitcomp "$(__git_heads)"
+			__gitcomp_nl "$(__git_heads)"
 		else
-			__gitcomp "$(__git_refs)"
+			__gitcomp_nl "$(__git_refs)"
 		fi
 		;;
 	esac
@@ -1195,7 +1220,7 @@ _git_checkout ()
 		if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
 			track=3D''
 		fi
-		__gitcomp "$(__git_refs '' $track)"
+		__gitcomp_nl "$(__git_refs '' $track)"
 		;;
 	esac
 }
@@ -1212,7 +1237,7 @@ _git_cherry_pick ()
 		__gitcomp "--edit --no-commit"
 		;;
 	*)
-		__gitcomp "$(__git_refs)"
+		__gitcomp_nl "$(__git_refs)"
 		;;
 	esac
 }
@@ -1266,7 +1291,7 @@ _git_commit ()
 		;;
 	--reuse-message=3D*|--reedit-message=3D*|\
 	--fixup=3D*|--squash=3D*)
-		__gitcomp "$(__git_refs)" "" "${cur#*=3D}"
+		__gitcomp_nl "$(__git_refs)" "" "${cur#*=3D}"
 		return
 		;;
 	--untracked-files=3D*)
@@ -1297,7 +1322,7 @@ _git_describe ()
 			"
 		return
 	esac
-	__gitcomp "$(__git_refs)"
+	__gitcomp_nl "$(__git_refs)"
 }
=20
 __git_diff_common_options=3D"--stat --numstat --shortstat --summary
@@ -1456,7 +1481,7 @@ _git_grep ()
 		;;
 	esac
=20
-	__gitcomp "$(__git_refs)"
+	__gitcomp_nl "$(__git_refs)"
 }
=20
 _git_help ()
@@ -1514,7 +1539,7 @@ _git_ls_files ()
=20
 _git_ls_remote ()
 {
-	__gitcomp "$(__git_remotes)"
+	__gitcomp_nl "$(__git_remotes)"
 }
=20
 _git_ls_tree ()
@@ -1610,7 +1635,7 @@ _git_merge ()
 		__gitcomp "$__git_merge_options"
 		return
 	esac
-	__gitcomp "$(__git_refs)"
+	__gitcomp_nl "$(__git_refs)"
 }
=20
 _git_mergetool ()
@@ -1630,7 +1655,7 @@ _git_mergetool ()
=20
 _git_merge_base ()
 {
-	__gitcomp "$(__git_refs)"
+	__gitcomp_nl "$(__git_refs)"
 }
=20
 _git_mv ()
@@ -1661,7 +1686,7 @@ _git_notes ()
 	,*)
 		case "${words[cword-1]}" in
 		--ref)
-			__gitcomp "$(__git_refs)"
+			__gitcomp_nl "$(__git_refs)"
 			;;
 		*)
 			__gitcomp "$subcommands --ref"
@@ -1670,7 +1695,7 @@ _git_notes ()
 		;;
 	add,--reuse-message=3D*|append,--reuse-message=3D*|\
 	add,--reedit-message=3D*|append,--reedit-message=3D*)
-		__gitcomp "$(__git_refs)" "" "${cur#*=3D}"
+		__gitcomp_nl "$(__git_refs)" "" "${cur#*=3D}"
 		;;
 	add,--*|append,--*)
 		__gitcomp '--file=3D --message=3D --reedit-message=3D
@@ -1689,7 +1714,7 @@ _git_notes ()
 		-m|-F)
 			;;
 		*)
-			__gitcomp "$(__git_refs)"
+			__gitcomp_nl "$(__git_refs)"
 			;;
 		esac
 		;;
@@ -1717,12 +1742,12 @@ _git_push ()
 {
 	case "$prev" in
 	--repo)
-		__gitcomp "$(__git_remotes)"
+		__gitcomp_nl "$(__git_remotes)"
 		return
 	esac
 	case "$cur" in
 	--repo=3D*)
-		__gitcomp "$(__git_remotes)" "" "${cur##--repo=3D}"
+		__gitcomp_nl "$(__git_remotes)" "" "${cur##--repo=3D}"
 		return
 		;;
 	--*)
@@ -1760,7 +1785,7 @@ _git_rebase ()
=20
 		return
 	esac
-	__gitcomp "$(__git_refs)"
+	__gitcomp_nl "$(__git_refs)"
 }
=20
 _git_reflog ()
@@ -1771,7 +1796,7 @@ _git_reflog ()
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
 	else
-		__gitcomp "$(__git_refs)"
+		__gitcomp_nl "$(__git_refs)"
 	fi
 }
=20
@@ -1853,23 +1878,23 @@ _git_config ()
 {
 	case "$prev" in
 	branch.*.remote)
-		__gitcomp "$(__git_remotes)"
+		__gitcomp_nl "$(__git_remotes)"
 		return
 		;;
 	branch.*.merge)
-		__gitcomp "$(__git_refs)"
+		__gitcomp_nl "$(__git_refs)"
 		return
 		;;
 	remote.*.fetch)
 		local remote=3D"${prev#remote.}"
 		remote=3D"${remote%.fetch}"
-		__gitcomp "$(__git_refs_remotes "$remote")"
+		__gitcomp_nl "$(__git_refs_remotes "$remote")"
 		return
 		;;
 	remote.*.push)
 		local remote=3D"${prev#remote.}"
 		remote=3D"${remote%.push}"
-		__gitcomp "$(git --git-dir=3D"$(__gitdir)" \
+		__gitcomp_nl "$(git --git-dir=3D"$(__gitdir)" \
 			for-each-ref --format=3D'%(refname):%(refname)' \
 			refs/heads)"
 		return
@@ -1916,7 +1941,7 @@ _git_config ()
 		return
 		;;
 	--get|--get-all|--unset|--unset-all)
-		__gitcomp "$(__git_config_get_set_variables)"
+		__gitcomp_nl "$(__git_config_get_set_variables)"
 		return
 		;;
 	*.*)
@@ -1942,7 +1967,7 @@ _git_config ()
 		;;
 	branch.*)
 		local pfx=3D"${cur%.*}." cur_=3D"${cur#*.}"
-		__gitcomp "$(__git_heads)" "$pfx" "$cur_" "."
+		__gitcomp_nl "$(__git_heads)" "$pfx" "$cur_" "."
 		return
 		;;
 	guitool.*.*)
@@ -1971,7 +1996,7 @@ _git_config ()
 	pager.*)
 		local pfx=3D"${cur%.*}." cur_=3D"${cur#*.}"
 		__git_compute_all_commands
-		__gitcomp "$__git_all_commands" "$pfx" "$cur_"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_"
 		return
 		;;
 	remote.*.*)
@@ -1984,7 +2009,7 @@ _git_config ()
 		;;
 	remote.*)
 		local pfx=3D"${cur%.*}." cur_=3D"${cur#*.}"
-		__gitcomp "$(__git_remotes)" "$pfx" "$cur_" "."
+		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
 		return
 		;;
 	url.*.*)
@@ -2285,7 +2310,7 @@ _git_remote ()
=20
 	case "$subcommand" in
 	rename|rm|show|prune)
-		__gitcomp "$(__git_remotes)"
+		__gitcomp_nl "$(__git_remotes)"
 		;;
 	update)
 		local i c=3D'' IFS=3D$'\n'
@@ -2303,7 +2328,7 @@ _git_remote ()
=20
 _git_replace ()
 {
-	__gitcomp "$(__git_refs)"
+	__gitcomp_nl "$(__git_refs)"
 }
=20
 _git_reset ()
@@ -2316,7 +2341,7 @@ _git_reset ()
 		return
 		;;
 	esac
-	__gitcomp "$(__git_refs)"
+	__gitcomp_nl "$(__git_refs)"
 }
=20
 _git_revert ()
@@ -2327,7 +2352,7 @@ _git_revert ()
 		return
 		;;
 	esac
-	__gitcomp "$(__git_refs)"
+	__gitcomp_nl "$(__git_refs)"
 }
=20
 _git_rm ()
@@ -2426,7 +2451,7 @@ _git_stash ()
 			COMPREPLY=3D()
 			;;
 		show,*|apply,*|drop,*|pop,*|branch,*)
-			__gitcomp "$(git --git-dir=3D"$(__gitdir)" stash list \
+			__gitcomp_nl "$(git --git-dir=3D"$(__gitdir)" stash list \
 					| sed -n -e 's/:.*//p')"
 			;;
 		*)
@@ -2560,7 +2585,7 @@ _git_tag ()
 		i=3D"${words[c]}"
 		case "$i" in
 		-d|-v)
-			__gitcomp "$(__git_tags)"
+			__gitcomp_nl "$(__git_tags)"
 			return
 			;;
 		-f)
@@ -2576,13 +2601,13 @@ _git_tag ()
 		;;
 	-*|tag)
 		if [ $f =3D 1 ]; then
-			__gitcomp "$(__git_tags)"
+			__gitcomp_nl "$(__git_tags)"
 		else
 			COMPREPLY=3D()
 		fi
 		;;
 	*)
-		__gitcomp "$(__git_refs)"
+		__gitcomp_nl "$(__git_refs)"
 		;;
 	esac
 }
--=20
1.7.7.197.g04a3e
