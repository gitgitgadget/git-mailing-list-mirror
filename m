From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 0/2] Make git-completion Bash 4 compatible
Date: Thu, 2 Dec 2010 03:16:24 -0600
Message-ID: <20101202091624.GB1771@burratino>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 10:16:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO5HR-0003PC-N0
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 10:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330Ab0LBJQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 04:16:39 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63824 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab0LBJQg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 04:16:36 -0500
Received: by yxt3 with SMTP id 3so3453043yxt.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 01:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6Fdmsowm5zns4NXk7bT1jOA8q1vMgJ25W+ucfcAPGmE=;
        b=jAe0WuTuZd5rDC058w6N5NiO2JrTkEMuG0JtMlhGsxmBt3Uv1QMiXjcdFIEGprW4ig
         9EZQaKUAH8mYYG/OHET0Jwerff4Ibw50AhYM7bGqog9rHQ8UYQIFduI2tvTVFQNnsO4A
         QShGC+BJzuATLc0PIO34IEjRwFNzD435kzO9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sO+HVsNGQeJhYqlf53jSOJm0rvmh7AkkgLXsVuoc4dgXXHhJPlzLuXHEzHELJd6jro
         wZUVP8kqCtWxtw286rKPSek/jb2dx68qsYkwPBXFCFbClXMOVhFQnDK0GknaIaXswwT9
         S2egNV7qRyfAqAEFK1JUZFovdbbyMxdMdX/4M=
Received: by 10.150.49.12 with SMTP id w12mr975442ybw.422.1291281395344;
        Thu, 02 Dec 2010 01:16:35 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id x29sm181256yhc.46.2010.12.02.01.16.31
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 01:16:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162686>

Hi again,

Peter van der Does wrote:

> Make git-completion Bash 4 compatible.

Thanks again for this work and sorry for all the fuss.

> Peter van der Does (2):
>   Introduce functions from bash-completion project.

This patch introduces a minor regression in that it breaks the
(already somewhat incomplete) zsh support.  Should be fixable by
falling back to using COMP_WORDS on zsh.

>   Use the new functions to get the current cword.

This one introduces some subtle differences between commands and imho
does more than it set out to do, by differentiating word splitting
behavior between commands.  bash 3 was not splitting COMP_WORDS at
equal signs or colons, ever.  Maybe we can start with that and then
make refinements on top later.

While trying that out, I had an idea.  The patch depends on
understanding the bash-completion library function introduced by patch
1, but I think we can avoid that by rearranging the patch series like
this:

 1. If _get_comp_words_by_ref is already defined, use it to fetch
    completion words.  Otherwise, just use COMP_WORDS (using a stub
    _get_comp_words_by_ref), maintaining the current behavior.
    [shown below]

 2. Import the definition of _get_comp_words_by_ref from the
    bash-completion lib and use it if ZSH_VERSION is unset.

 3. Further refinements, if needed.

What do you think?

-- 8< --
From: Peter van der Does <peter@avirtualhome.com>
Subject: bash: work around bash 4.0 change in COMP_WORDS semantics

Before bash 4, running

	$ git log --pretty=m <tab><tab>

would give a list of pretty formats starting with 'm', but now it
completes on ordinary files instead.  It seems that as part of a
rework of completion word splitting, bash 4.0 changed the semantics of
the COMP_WORDS array: previously, --pretty=m was treated as one word,
but now it breaks on '=' if COMP_WORDBREAKS contains an equal sign.

It would be possible to work around that by removing '=' and ':' from
COMP_WORDBREAKS, but as noticed in v1.5.6.4~9^2 (bash completion:
Resolve git show ref:path<tab> losing ref: portion, 2008-07-15), doing
so is likely to break *other* completion scripts.  Luckily, the
bash-completion library includes a better workaround --- a
_get_comp_words_by_ref function to retrieve an array somewhat like
COMP_WORDS but:

 * excluding some word break characters of your choice
 * returning correct results even when the cursor is in the middle of
   a word.

Use it.  To avoid breaking setups where the bash-completion library is
not already loaded, if that function is not defined then a shim
replacement that just reads COMP_WORDS will be used instead.

Signed-off-by: Peter van der Does <peter@avirtualhome.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/completion/git-completion.bash |  236 +++++++++++++++++++++----------
 1 files changed, 160 insertions(+), 76 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index feab651..0b0eb45 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -327,11 +327,39 @@ __gitcomp_1 ()
 	done
 }
 
+if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
+_get_comp_words_by_ref ()
+{
+	while [ $# -gt 0 ]; do
+		case "$1" in
+		cur)
+			cur=${COMP_WORDS[COMP_CWORD]}
+			;;
+		prev)
+			prev=${COMP_WORDS[COMP_CWORD-1]}
+			;;
+		words)
+			words=("${COMP_WORDS[@]}")
+			;;
+		cword)
+			cword=$COMP_CWORD
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
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	if [ $# -gt 2 ]; then
 		cur="$3"
 	fi
@@ -390,7 +418,8 @@ __git_tags ()
 __git_refs ()
 {
 	local i is_hash=y dir="$(__gitdir "${1-}")"
-	local cur="${COMP_WORDS[COMP_CWORD]}" format refs
+	local cur format refs
+	_get_comp_words_by_ref -n =: cur
 	if [ -d "$dir" ]; then
 		case "$cur" in
 		refs|refs/*)
@@ -488,7 +517,8 @@ __git_compute_merge_strategies ()
 
 __git_complete_file ()
 {
-	local pfx ls ref cur="${COMP_WORDS[COMP_CWORD]}"
+	local pfx ls ref cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	?*:*)
 		ref="${cur%%:*}"
@@ -536,7 +566,8 @@ __git_complete_file ()
 
 __git_complete_revlist ()
 {
-	local pfx cur="${COMP_WORDS[COMP_CWORD]}"
+	local pfx cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	*...*)
 		pfx="${cur%...*}..."
@@ -556,11 +587,12 @@ __git_complete_revlist ()
 
 __git_complete_remote_or_refspec ()
 {
-	local cmd="${COMP_WORDS[1]}"
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur words cword
+	_get_comp_words_by_ref -n =: cur words cword
+	local cmd="${words[1]}"
 	local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0
-	while [ $c -lt $COMP_CWORD ]; do
-		i="${COMP_WORDS[c]}"
+	while [ $c -lt $cword ]; do
+		i="${words[c]}"
 		case "$i" in
 		--mirror) [ "$cmd" = "push" ] && no_complete_refspec=1 ;;
 		--all)
@@ -628,13 +660,14 @@ __git_complete_remote_or_refspec ()
 
 __git_complete_strategy ()
 {
+	local cur prev
+	_get_comp_words_by_ref -n =: cur prev
 	__git_compute_merge_strategies
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	case "$prev" in
 	-s|--strategy)
 		__gitcomp "$__git_merge_strategies"
 		return 0
 	esac
-	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--strategy=*)
 		__gitcomp "$__git_merge_strategies" "" "${cur##--strategy=}"
@@ -794,10 +827,10 @@ __git_aliased_command ()
 # __git_find_on_cmdline requires 1 argument
 __git_find_on_cmdline ()
 {
-	local word subcommand c=1
-
-	while [ $c -lt $COMP_CWORD ]; do
-		word="${COMP_WORDS[c]}"
+	local word subcommand c=1 words cword
+	_get_comp_words_by_ref -n =: words cword
+	while [ $c -lt $cword ]; do
+		word="${words[c]}"
 		for subcommand in $1; do
 			if [ "$subcommand" = "$word" ]; then
 				echo "$subcommand"
@@ -810,9 +843,10 @@ __git_find_on_cmdline ()
 
 __git_has_doubledash ()
 {
-	local c=1
-	while [ $c -lt $COMP_CWORD ]; do
-		if [ "--" = "${COMP_WORDS[c]}" ]; then
+	local c=1 words cword
+	_get_comp_words_by_ref -n =: words cword
+	while [ $c -lt $cword ]; do
+		if [ "--" = "${words[c]}" ]; then
 			return 0
 		fi
 		c=$((++c))
@@ -824,7 +858,8 @@ __git_whitespacelist="nowarn warn error error-all fix"
 
 _git_am ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}" dir="$(__gitdir)"
+	local cur dir="$(__gitdir)"
+	_get_comp_words_by_ref -n =: cur
 	if [ -d "$dir"/rebase-apply ]; then
 		__gitcomp "--skip --continue --resolved --abort"
 		return
@@ -848,7 +883,8 @@ _git_am ()
 
 _git_apply ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--whitespace=*)
 		__gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=}"
@@ -871,7 +907,8 @@ _git_add ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -885,7 +922,8 @@ _git_add ()
 
 _git_archive ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--format=*)
 		__gitcomp "$(git archive --list)" "" "${cur##--format=}"
@@ -929,10 +967,11 @@ _git_bisect ()
 
 _git_branch ()
 {
-	local i c=1 only_local_ref="n" has_r="n"
+	local i c=1 only_local_ref="n" has_r="n" cur words cword
 
-	while [ $c -lt $COMP_CWORD ]; do
-		i="${COMP_WORDS[c]}"
+	_get_comp_words_by_ref -n =: cur words cword
+	while [ $c -lt $cword ]; do
+		i="${words[c]}"
 		case "$i" in
 		-d|-m)	only_local_ref="y" ;;
 		-r)	has_r="y" ;;
@@ -940,7 +979,7 @@ _git_branch ()
 		c=$((++c))
 	done
 
-	case "${COMP_WORDS[COMP_CWORD]}" in
+	case "$cur" in
 	--*)
 		__gitcomp "
 			--color --no-color --verbose --abbrev= --no-abbrev
@@ -960,8 +999,10 @@ _git_branch ()
 
 _git_bundle ()
 {
-	local cmd="${COMP_WORDS[2]}"
-	case "$COMP_CWORD" in
+	local words cword
+	_get_comp_words_by_ref -n =: words cword
+	local cmd="${words[2]}"
+	case "$cword" in
 	2)
 		__gitcomp "create list-heads verify unbundle"
 		;;
@@ -982,7 +1023,8 @@ _git_checkout ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--conflict=*)
 		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
@@ -1006,7 +1048,8 @@ _git_cherry ()
 
 _git_cherry_pick ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--edit --no-commit"
@@ -1021,7 +1064,8 @@ _git_clean ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--dry-run --quiet"
@@ -1033,7 +1077,8 @@ _git_clean ()
 
 _git_clone ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1060,7 +1105,8 @@ _git_commit ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--cleanup=*)
 		__gitcomp "default strip verbatim whitespace
@@ -1095,7 +1141,8 @@ _git_commit ()
 
 _git_describe ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1127,7 +1174,8 @@ _git_diff ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
@@ -1148,7 +1196,8 @@ _git_difftool ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--tool=*)
 		__gitcomp "$__git_mergetools_common kompare" "" "${cur##--tool=}"
@@ -1173,7 +1222,8 @@ __git_fetch_options="
 
 _git_fetch ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "$__git_fetch_options"
@@ -1185,7 +1235,8 @@ _git_fetch ()
 
 _git_format_patch ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--thread=*)
 		__gitcomp "
@@ -1217,7 +1268,8 @@ _git_format_patch ()
 
 _git_fsck ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1232,7 +1284,8 @@ _git_fsck ()
 
 _git_gc ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--prune --aggressive"
@@ -1251,7 +1304,8 @@ _git_grep ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1274,7 +1328,8 @@ _git_grep ()
 
 _git_help ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--all --info --man --web"
@@ -1292,7 +1347,8 @@ _git_help ()
 
 _git_init ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--shared=*)
 		__gitcomp "
@@ -1312,7 +1368,8 @@ _git_ls_files ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --deleted --modified --others --ignored
@@ -1366,12 +1423,13 @@ _git_log ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
 	local g="$(git rev-parse --git-dir 2>/dev/null)"
 	local merge=""
 	if [ -f "$g/MERGE_HEAD" ]; then
 		merge="--merge"
 	fi
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--pretty=*)
 		__gitcomp "$__git_log_pretty_formats
@@ -1425,7 +1483,8 @@ _git_merge ()
 {
 	__git_complete_strategy && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "$__git_merge_options"
@@ -1436,7 +1495,8 @@ _git_merge ()
 
 _git_mergetool ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--tool=*)
 		__gitcomp "$__git_mergetools_common tortoisemerge" "" "${cur##--tool=}"
@@ -1457,7 +1517,8 @@ _git_merge_base ()
 
 _git_mv ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--dry-run"
@@ -1475,12 +1536,14 @@ _git_name_rev ()
 _git_notes ()
 {
 	local subcommands="edit show"
+	local words cword
+	_get_comp_words_by_ref -n =: words cword
 	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
 		__gitcomp "$subcommands"
 		return
 	fi
 
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	case "${words[cword-1]}" in
 	-m|-F)
 		COMPREPLY=()
 		;;
@@ -1494,7 +1557,8 @@ _git_pull ()
 {
 	__git_complete_strategy && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1510,8 +1574,9 @@ _git_pull ()
 
 _git_push ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	local cur prev
+	_get_comp_words_by_ref -n =: cur prev
+	case "$prev" in
 	--repo)
 		__gitcomp "$(__git_remotes)"
 		return
@@ -1534,7 +1599,9 @@ _git_push ()
 
 _git_rebase ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}" dir="$(__gitdir)"
+	local dir="$(__gitdir)"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
 		__gitcomp "--continue --skip --abort"
 		return
@@ -1564,7 +1631,8 @@ __git_send_email_suppresscc_options="author self cc bodycc sob cccmd body all"
 
 _git_send_email ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--confirm=*)
 		__gitcomp "
@@ -1606,9 +1674,11 @@ _git_stage ()
 
 __git_config_get_set_variables ()
 {
-	local prevword word config_file= c=$COMP_CWORD
+	local words cword
+	_get_comp_words_by_ref -n =: words cword
+	local prevword word config_file= c=$cword
 	while [ $c -gt 1 ]; do
-		word="${COMP_WORDS[c]}"
+		word="${words[c]}"
 		case "$word" in
 		--global|--system|--file=*)
 			config_file="$word"
@@ -1636,9 +1706,9 @@ __git_config_get_set_variables ()
 
 _git_config ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-	local prv="${COMP_WORDS[COMP_CWORD-1]}"
-	case "$prv" in
+	local cur prev
+	_get_comp_words_by_ref -n =: cur prev
+	case "$prev" in
 	branch.*.remote)
 		__gitcomp "$(__git_remotes)"
 		return
@@ -1648,13 +1718,13 @@ _git_config ()
 		return
 		;;
 	remote.*.fetch)
-		local remote="${prv#remote.}"
+		local remote="${prev#remote.}"
 		remote="${remote%.fetch}"
 		__gitcomp "$(__git_refs_remotes "$remote")"
 		return
 		;;
 	remote.*.push)
-		local remote="${prv#remote.}"
+		local remote="${prev#remote.}"
 		remote="${remote%.push}"
 		__gitcomp "$(git --git-dir="$(__gitdir)" \
 			for-each-ref --format='%(refname):%(refname)' \
@@ -2045,7 +2115,8 @@ _git_reset ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--merge --mixed --hard --soft --patch"
@@ -2057,7 +2128,8 @@ _git_reset ()
 
 _git_revert ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--edit --mainline --no-edit --no-commit --signoff"
@@ -2071,7 +2143,8 @@ _git_rm ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
@@ -2085,7 +2158,8 @@ _git_shortlog ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -2103,7 +2177,8 @@ _git_show ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--pretty=*)
 		__gitcomp "$__git_log_pretty_formats
@@ -2127,7 +2202,8 @@ _git_show ()
 
 _git_show_branch ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -2144,7 +2220,8 @@ _git_show_branch ()
 
 _git_stash ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n =: cur
 	local save_opts='--keep-index --no-keep-index --quiet --patch'
 	local subcommands='save list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
@@ -2189,7 +2266,8 @@ _git_submodule ()
 
 	local subcommands="add status init update summary foreach sync"
 	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
-		local cur="${COMP_WORDS[COMP_CWORD]}"
+		local cur
+		_get_comp_words_by_ref -n =: cur
 		case "$cur" in
 		--*)
 			__gitcomp "--quiet --cached"
@@ -2233,7 +2311,8 @@ _git_svn ()
 			--edit --rmdir --find-copies-harder --copy-similarity=
 			"
 
-		local cur="${COMP_WORDS[COMP_CWORD]}"
+		local cur
+		_get_comp_words_by_ref -n =: cur
 		case "$subcommand,$cur" in
 		fetch,--*)
 			__gitcomp "--revision= --fetch-all $fc_opts"
@@ -2305,8 +2384,10 @@ _git_svn ()
 _git_tag ()
 {
 	local i c=1 f=0
-	while [ $c -lt $COMP_CWORD ]; do
-		i="${COMP_WORDS[c]}"
+	local words cword prev
+	_get_comp_words_by_ref -n =: words cword prev
+	while [ $c -lt $cword ]; do
+		i="${words[c]}"
 		case "$i" in
 		-d|-v)
 			__gitcomp "$(__git_tags)"
@@ -2319,7 +2400,7 @@ _git_tag ()
 		c=$((++c))
 	done
 
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	case "$prev" in
 	-m|-F)
 		COMPREPLY=()
 		;;
@@ -2350,8 +2431,10 @@ _git ()
 		setopt KSH_TYPESET
 	fi
 
-	while [ $c -lt $COMP_CWORD ]; do
-		i="${COMP_WORDS[c]}"
+	local cur words cword
+	_get_comp_words_by_ref -n =: cur words cword
+	while [ $c -lt $cword ]; do
+		i="${words[c]}"
 		case "$i" in
 		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
 		--bare)      __git_dir="." ;;
@@ -2363,7 +2446,7 @@ _git ()
 	done
 
 	if [ -z "$command" ]; then
-		case "${COMP_WORDS[COMP_CWORD]}" in
+		case "$cur" in
 		--*)   __gitcomp "
 			--paginate
 			--no-pager
@@ -2401,12 +2484,13 @@ _gitk ()
 
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
 	local g="$(__gitdir)"
 	local merge=""
 	if [ -f "$g/MERGE_HEAD" ]; then
 		merge="--merge"
 	fi
+	_get_comp_words_by_ref -n =: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
-- 
1.7.2.3
