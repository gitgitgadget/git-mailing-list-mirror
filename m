From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] bash: get --pretty=m<tab> completion to work with bash v4
Date: Wed, 15 Dec 2010 00:26:52 -0600
Message-ID: <20101215062652.GB20492@burratino>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
 <20101202091624.GB1771@burratino>
 <20101202091613.6ac8f816@MonteCarlo.grandprix.int>
 <20101202210207.GA4994@burratino>
 <20101207160747.GD1867@neumann>
 <20101207194923.GD22587@burratino>
 <7v1v5tpa7b.fsf@alter.siamese.dyndns.org>
 <20101215062403.GA20492@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Peter van der Does <peter@avirtualhome.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 07:27:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSkpj-00058k-33
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 07:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab0LOG1J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 01:27:09 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50128 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab0LOG1F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Dec 2010 01:27:05 -0500
Received: by yxt3 with SMTP id 3so855187yxt.19
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 22:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=aGcQhZ3sDmu7cY3++rd623R0MN8+aZfLMWrB5zJKocI=;
        b=Qa+3S6q1WuqYc+HHthsWQpyTMyjxd7lx8S8V04UY7QXeVV0TyMz9uAxL8TyqOjAy6v
         SRk+k3povk2fLhM+KmPWPRtgojwKV5PzZWNpclWN3Y+ilcYmPZqqxrtb0xC2Y+mKxQKi
         Sj+YaUVcZguf0plPbHztT812acvuloXIQWa68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=gy0KyLrLddzcfnh9VCd1oaSAWpQBJzkyxsquPmTAiUgQNEP2dHHJHtM2DS3ZaiG7qv
         as72U/nlGL3QRyWsrGVZTmII0/Zwca2nHygDYvKSUmFnjurKdvp8Cvyc2xqFoFThAx/P
         NvHWDjE4PzH0lD7Dt3YNwUpndgv6pD3taEaUw=
Received: by 10.151.43.7 with SMTP id v7mr9249572ybj.201.1292394425064;
        Tue, 14 Dec 2010 22:27:05 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.ameritech.net [69.209.48.248])
        by mx.google.com with ESMTPS id k2sm639733ybj.10.2010.12.14.22.27.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Dec 2010 22:27:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101215062403.GA20492@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163734>

=46rom: Peter van der Does <peter@avirtualhome.com>

Bash's programmable completion provides the COMP_WORDS array variable,
which holds the individual words in the current command line.  In bash
versions prior to v4 "words are split on shell metacharacters as the
shell parser would separate them" (quote from bash v3.2.48's man
page).  This behavior has changed with bash v4, and the command line
"is split into words as readline would split it, using COMP_WORDBREAKS
as" "the set of characters that the readline library treats as word
separators" (quote from bash v4's man page).

Since COMP_WORDBREAKS contains the characters : and =3D by default, thi=
s
behavior change in bash affects git's completion script.  For example,
before bash 4, running

	$ git log --pretty=3Dm <tab><tab>

would give a list of pretty-printing formats starting with 'm' but now
it completes on branch names.

It would be possible to work around this by removing '=3D' and ':' from
COMP_WORDBREAKS, but as noticed in v1.5.6.4~9^2 (bash completion:
Resolve git show ref:path<tab> losing ref: portion, 2008-07-15), that
would break *other* completion scripts.  The bash-completion library
includes a better workaround: the _get_comp_words_by_ref function
re-assembles a copy of COMP_WORDS, excluding a collection of word
separators of the caller's choice.  Use it.

As a bonus, this improves behavior when tab is pressed with the cursor
in the middle of a word if the bash-completion lib is loaded.

To avoid breaking setups with the bash-completion library not already
loaded, if the _get_comp_words_by_ref function is not defined then use
a shim that just reads COMP_WORDS instead (no change from the current
behavior in that case).

Signed-off-by: Peter van der Does <peter@avirtualhome.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Explained-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |  236 +++++++++++++++++++++---=
-------
 1 files changed, 160 insertions(+), 76 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 82e6609..68b68d0 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -321,11 +321,39 @@ __gitcomp_1 ()
 	done
 }
=20
+if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
+_get_comp_words_by_ref ()
+{
+	while [ $# -gt 0 ]; do
+		case "$1" in
+		cur)
+			cur=3D${COMP_WORDS[COMP_CWORD]}
+			;;
+		prev)
+			prev=3D${COMP_WORDS[COMP_CWORD-1]}
+			;;
+		words)
+			words=3D("${COMP_WORDS[@]}")
+			;;
+		cword)
+			cword=3D$COMP_CWORD
+			;;
+		-n)
+			# assume COMP_WORDBREAKS is already set sanely
+			shift
+			;;
+		esac
+		shift
+	done
+}
+fi
+
 # __gitcomp accepts 1, 2, 3, or 4 arguments
 # generates completion reply with compgen
 __gitcomp ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	if [ $# -gt 2 ]; then
 		cur=3D"$3"
 	fi
@@ -384,7 +412,8 @@ __git_tags ()
 __git_refs ()
 {
 	local i is_hash=3Dy dir=3D"$(__gitdir "${1-}")"
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}" format refs
+	local cur format refs
+	_get_comp_words_by_ref -n =3D: cur
 	if [ -d "$dir" ]; then
 		case "$cur" in
 		refs|refs/*)
@@ -482,7 +511,8 @@ __git_compute_merge_strategies ()
=20
 __git_complete_file ()
 {
-	local pfx ls ref cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local pfx ls ref cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	?*:*)
 		ref=3D"${cur%%:*}"
@@ -530,7 +560,8 @@ __git_complete_file ()
=20
 __git_complete_revlist ()
 {
-	local pfx cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local pfx cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	*...*)
 		pfx=3D"${cur%...*}..."
@@ -550,11 +581,12 @@ __git_complete_revlist ()
=20
 __git_complete_remote_or_refspec ()
 {
-	local cmd=3D"${COMP_WORDS[1]}"
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur words cword
+	_get_comp_words_by_ref -n =3D: cur words cword
+	local cmd=3D"${words[1]}"
 	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
-	while [ $c -lt $COMP_CWORD ]; do
-		i=3D"${COMP_WORDS[c]}"
+	while [ $c -lt $cword ]; do
+		i=3D"${words[c]}"
 		case "$i" in
 		--mirror) [ "$cmd" =3D "push" ] && no_complete_refspec=3D1 ;;
 		--all)
@@ -622,13 +654,14 @@ __git_complete_remote_or_refspec ()
=20
 __git_complete_strategy ()
 {
+	local cur prev
+	_get_comp_words_by_ref -n =3D: cur prev
 	__git_compute_merge_strategies
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	case "$prev" in
 	-s|--strategy)
 		__gitcomp "$__git_merge_strategies"
 		return 0
 	esac
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--strategy=3D*)
 		__gitcomp "$__git_merge_strategies" "" "${cur##--strategy=3D}"
@@ -788,10 +821,10 @@ __git_aliased_command ()
 # __git_find_on_cmdline requires 1 argument
 __git_find_on_cmdline ()
 {
-	local word subcommand c=3D1
-
-	while [ $c -lt $COMP_CWORD ]; do
-		word=3D"${COMP_WORDS[c]}"
+	local word subcommand c=3D1 words cword
+	_get_comp_words_by_ref -n =3D: words cword
+	while [ $c -lt $cword ]; do
+		word=3D"${words[c]}"
 		for subcommand in $1; do
 			if [ "$subcommand" =3D "$word" ]; then
 				echo "$subcommand"
@@ -804,9 +837,10 @@ __git_find_on_cmdline ()
=20
 __git_has_doubledash ()
 {
-	local c=3D1
-	while [ $c -lt $COMP_CWORD ]; do
-		if [ "--" =3D "${COMP_WORDS[c]}" ]; then
+	local c=3D1 words cword
+	_get_comp_words_by_ref -n =3D: words cword
+	while [ $c -lt $cword ]; do
+		if [ "--" =3D "${words[c]}" ]; then
 			return 0
 		fi
 		c=3D$((++c))
@@ -818,7 +852,8 @@ __git_whitespacelist=3D"nowarn warn error error-all=
 fix"
=20
 _git_am ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}" dir=3D"$(__gitdir)"
+	local cur dir=3D"$(__gitdir)"
+	_get_comp_words_by_ref -n =3D: cur
 	if [ -d "$dir"/rebase-apply ]; then
 		__gitcomp "--skip --continue --resolved --abort"
 		return
@@ -842,7 +877,8 @@ _git_am ()
=20
 _git_apply ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--whitespace=3D*)
 		__gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=3D}"
@@ -865,7 +901,8 @@ _git_add ()
 {
 	__git_has_doubledash && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -879,7 +916,8 @@ _git_add ()
=20
 _git_archive ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--format=3D*)
 		__gitcomp "$(git archive --list)" "" "${cur##--format=3D}"
@@ -923,10 +961,11 @@ _git_bisect ()
=20
 _git_branch ()
 {
-	local i c=3D1 only_local_ref=3D"n" has_r=3D"n"
+	local i c=3D1 only_local_ref=3D"n" has_r=3D"n" cur words cword
=20
-	while [ $c -lt $COMP_CWORD ]; do
-		i=3D"${COMP_WORDS[c]}"
+	_get_comp_words_by_ref -n =3D: cur words cword
+	while [ $c -lt $cword ]; do
+		i=3D"${words[c]}"
 		case "$i" in
 		-d|-m)	only_local_ref=3D"y" ;;
 		-r)	has_r=3D"y" ;;
@@ -934,7 +973,7 @@ _git_branch ()
 		c=3D$((++c))
 	done
=20
-	case "${COMP_WORDS[COMP_CWORD]}" in
+	case "$cur" in
 	--*)
 		__gitcomp "
 			--color --no-color --verbose --abbrev=3D --no-abbrev
@@ -954,8 +993,10 @@ _git_branch ()
=20
 _git_bundle ()
 {
-	local cmd=3D"${COMP_WORDS[2]}"
-	case "$COMP_CWORD" in
+	local words cword
+	_get_comp_words_by_ref -n =3D: words cword
+	local cmd=3D"${words[2]}"
+	case "$cword" in
 	2)
 		__gitcomp "create list-heads verify unbundle"
 		;;
@@ -976,7 +1017,8 @@ _git_checkout ()
 {
 	__git_has_doubledash && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--conflict=3D*)
 		__gitcomp "diff3 merge" "" "${cur##--conflict=3D}"
@@ -1000,7 +1042,8 @@ _git_cherry ()
=20
 _git_cherry_pick ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--edit --no-commit"
@@ -1015,7 +1058,8 @@ _git_clean ()
 {
 	__git_has_doubledash && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--dry-run --quiet"
@@ -1027,7 +1071,8 @@ _git_clean ()
=20
 _git_clone ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1054,7 +1099,8 @@ _git_commit ()
 {
 	__git_has_doubledash && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--cleanup=3D*)
 		__gitcomp "default strip verbatim whitespace
@@ -1089,7 +1135,8 @@ _git_commit ()
=20
 _git_describe ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1121,7 +1168,8 @@ _git_diff ()
 {
 	__git_has_doubledash && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
@@ -1142,7 +1190,8 @@ _git_difftool ()
 {
 	__git_has_doubledash && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--tool=3D*)
 		__gitcomp "$__git_mergetools_common kompare" "" "${cur##--tool=3D}"
@@ -1167,7 +1216,8 @@ __git_fetch_options=3D"
=20
 _git_fetch ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "$__git_fetch_options"
@@ -1179,7 +1229,8 @@ _git_fetch ()
=20
 _git_format_patch ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--thread=3D*)
 		__gitcomp "
@@ -1211,7 +1262,8 @@ _git_format_patch ()
=20
 _git_fsck ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1226,7 +1278,8 @@ _git_fsck ()
=20
 _git_gc ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--prune --aggressive"
@@ -1245,7 +1298,8 @@ _git_grep ()
 {
 	__git_has_doubledash && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1268,7 +1322,8 @@ _git_grep ()
=20
 _git_help ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--all --info --man --web"
@@ -1286,7 +1341,8 @@ _git_help ()
=20
 _git_init ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--shared=3D*)
 		__gitcomp "
@@ -1306,7 +1362,8 @@ _git_ls_files ()
 {
 	__git_has_doubledash && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --deleted --modified --others --ignored
@@ -1360,12 +1417,13 @@ _git_log ()
 {
 	__git_has_doubledash && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	local g=3D"$(git rev-parse --git-dir 2>/dev/null)"
 	local merge=3D""
 	if [ -f "$g/MERGE_HEAD" ]; then
 		merge=3D"--merge"
 	fi
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--pretty=3D*)
 		__gitcomp "$__git_log_pretty_formats
@@ -1419,7 +1477,8 @@ _git_merge ()
 {
 	__git_complete_strategy && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "$__git_merge_options"
@@ -1430,7 +1489,8 @@ _git_merge ()
=20
 _git_mergetool ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--tool=3D*)
 		__gitcomp "$__git_mergetools_common tortoisemerge" "" "${cur##--tool=
=3D}"
@@ -1451,7 +1511,8 @@ _git_merge_base ()
=20
 _git_mv ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--dry-run"
@@ -1469,12 +1530,14 @@ _git_name_rev ()
 _git_notes ()
 {
 	local subcommands=3D"edit show"
+	local words cword
+	_get_comp_words_by_ref -n =3D: words cword
 	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
 		__gitcomp "$subcommands"
 		return
 	fi
=20
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	case "${words[cword-1]}" in
 	-m|-F)
 		COMPREPLY=3D()
 		;;
@@ -1488,7 +1551,8 @@ _git_pull ()
 {
 	__git_complete_strategy && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1504,8 +1568,9 @@ _git_pull ()
=20
 _git_push ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	local cur prev
+	_get_comp_words_by_ref -n =3D: cur prev
+	case "$prev" in
 	--repo)
 		__gitcomp "$(__git_remotes)"
 		return
@@ -1528,7 +1593,9 @@ _git_push ()
=20
 _git_rebase ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}" dir=3D"$(__gitdir)"
+	local dir=3D"$(__gitdir)"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
 		__gitcomp "--continue --skip --abort"
 		return
@@ -1558,7 +1625,8 @@ __git_send_email_suppresscc_options=3D"author sel=
f cc bodycc sob cccmd body all"
=20
 _git_send_email ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--confirm=3D*)
 		__gitcomp "
@@ -1600,9 +1668,11 @@ _git_stage ()
=20
 __git_config_get_set_variables ()
 {
-	local prevword word config_file=3D c=3D$COMP_CWORD
+	local words cword
+	_get_comp_words_by_ref -n =3D: words cword
+	local prevword word config_file=3D c=3D$cword
 	while [ $c -gt 1 ]; do
-		word=3D"${COMP_WORDS[c]}"
+		word=3D"${words[c]}"
 		case "$word" in
 		--global|--system|--file=3D*)
 			config_file=3D"$word"
@@ -1630,9 +1700,9 @@ __git_config_get_set_variables ()
=20
 _git_config ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
-	local prv=3D"${COMP_WORDS[COMP_CWORD-1]}"
-	case "$prv" in
+	local cur prev
+	_get_comp_words_by_ref -n =3D: cur prev
+	case "$prev" in
 	branch.*.remote)
 		__gitcomp "$(__git_remotes)"
 		return
@@ -1642,13 +1712,13 @@ _git_config ()
 		return
 		;;
 	remote.*.fetch)
-		local remote=3D"${prv#remote.}"
+		local remote=3D"${prev#remote.}"
 		remote=3D"${remote%.fetch}"
 		__gitcomp "$(__git_refs_remotes "$remote")"
 		return
 		;;
 	remote.*.push)
-		local remote=3D"${prv#remote.}"
+		local remote=3D"${prev#remote.}"
 		remote=3D"${remote%.push}"
 		__gitcomp "$(git --git-dir=3D"$(__gitdir)" \
 			for-each-ref --format=3D'%(refname):%(refname)' \
@@ -2039,7 +2109,8 @@ _git_reset ()
 {
 	__git_has_doubledash && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--merge --mixed --hard --soft --patch"
@@ -2051,7 +2122,8 @@ _git_reset ()
=20
 _git_revert ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--edit --mainline --no-edit --no-commit --signoff"
@@ -2065,7 +2137,8 @@ _git_rm ()
 {
 	__git_has_doubledash && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
@@ -2079,7 +2152,8 @@ _git_shortlog ()
 {
 	__git_has_doubledash && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -2097,7 +2171,8 @@ _git_show ()
 {
 	__git_has_doubledash && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--pretty=3D*)
 		__gitcomp "$__git_log_pretty_formats
@@ -2121,7 +2196,8 @@ _git_show ()
=20
 _git_show_branch ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -2138,7 +2214,8 @@ _git_show_branch ()
=20
 _git_stash ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =3D: cur
 	local save_opts=3D'--keep-index --no-keep-index --quiet --patch'
 	local subcommands=3D'save list show apply clear drop pop create branc=
h'
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
@@ -2183,7 +2260,8 @@ _git_submodule ()
=20
 	local subcommands=3D"add status init update summary foreach sync"
 	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
-		local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+		local cur
+		_get_comp_words_by_ref -n =3D: cur
 		case "$cur" in
 		--*)
 			__gitcomp "--quiet --cached"
@@ -2227,7 +2305,8 @@ _git_svn ()
 			--edit --rmdir --find-copies-harder --copy-similarity=3D
 			"
=20
-		local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+		local cur
+		_get_comp_words_by_ref -n =3D: cur
 		case "$subcommand,$cur" in
 		fetch,--*)
 			__gitcomp "--revision=3D --fetch-all $fc_opts"
@@ -2299,8 +2378,10 @@ _git_svn ()
 _git_tag ()
 {
 	local i c=3D1 f=3D0
-	while [ $c -lt $COMP_CWORD ]; do
-		i=3D"${COMP_WORDS[c]}"
+	local words cword prev
+	_get_comp_words_by_ref -n =3D: words cword prev
+	while [ $c -lt $cword ]; do
+		i=3D"${words[c]}"
 		case "$i" in
 		-d|-v)
 			__gitcomp "$(__git_tags)"
@@ -2313,7 +2394,7 @@ _git_tag ()
 		c=3D$((++c))
 	done
=20
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	case "$prev" in
 	-m|-F)
 		COMPREPLY=3D()
 		;;
@@ -2339,8 +2420,10 @@ _git ()
 {
 	local i c=3D1 command __git_dir
=20
-	while [ $c -lt $COMP_CWORD ]; do
-		i=3D"${COMP_WORDS[c]}"
+	local cur words cword
+	_get_comp_words_by_ref -n =3D: cur words cword
+	while [ $c -lt $cword ]; do
+		i=3D"${words[c]}"
 		case "$i" in
 		--git-dir=3D*) __git_dir=3D"${i#--git-dir=3D}" ;;
 		--bare)      __git_dir=3D"." ;;
@@ -2352,7 +2435,7 @@ _git ()
 	done
=20
 	if [ -z "$command" ]; then
-		case "${COMP_WORDS[COMP_CWORD]}" in
+		case "$cur" in
 		--*)   __gitcomp "
 			--paginate
 			--no-pager
@@ -2385,12 +2468,13 @@ _gitk ()
 {
 	__git_has_doubledash && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur
 	local g=3D"$(__gitdir)"
 	local merge=3D""
 	if [ -f "$g/MERGE_HEAD" ]; then
 		merge=3D"--merge"
 	fi
+	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
--=20
1.7.3.3.573.g0bcfc
