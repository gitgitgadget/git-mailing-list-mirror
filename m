From: Peter van der Does <peter@avirtualhome.com>
Subject: [PATCH v3/RFC 2/2] Use the new functions to get the current cword.
Date: Sat, 30 Oct 2010 16:42:30 -0400
Message-ID: <1288471350-5392-3-git-send-email-peter@avirtualhome.com>
References: <1288471350-5392-1-git-send-email-peter@avirtualhome.com>
Cc: Peter van der Does <peter@avirtualhome.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 30 22:43:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCIHN-0004PD-9p
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 22:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355Ab0J3Um4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 16:42:56 -0400
Received: from morn.lunarbreeze.com ([216.227.218.220]:40321 "EHLO
	morn.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab0J3Umw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 16:42:52 -0400
Received: from c-69-248-103-68.hsd1.nj.comcast.net ([69.248.103.68] helo=monza.grandprix.int)
	by morn.lunarbreeze.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@avirtualhome.com>)
	id 1PCIGB-0008Fc-1K; Sat, 30 Oct 2010 13:42:43 -0700
Received: from MonteCarlo.grandprix.int (montecarlo.grandprix.int [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id 3257F101F84;
	Sat, 30 Oct 2010 16:42:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1288471350-5392-1-git-send-email-peter@avirtualhome.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - morn.lunarbreeze.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - avirtualhome.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160407>

Change the completion functions to use the newly introduced functions to
get the current and/or previous cword and to reassemble the COMP_CWORDS,
making sure the options are correctly split.

Signed-off-by: Peter van der Does <peter@avirtualhome.com>
---
 contrib/completion/git-completion.bash |  223 ++++++++++++++++++++------------
 1 files changed, 140 insertions(+), 83 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e0f5893..3115377 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -554,7 +554,8 @@ __gitcomp_1 ()
 # generates completion reply with compgen
 __gitcomp ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	if [ $# -gt 2 ]; then
 		cur="$3"
 	fi
@@ -613,7 +614,8 @@ __git_tags ()
 __git_refs ()
 {
 	local i is_hash=y dir="$(__gitdir "${1-}")"
-	local cur="${COMP_WORDS[COMP_CWORD]}" format refs
+	local cur format refs
+	_get_comp_words_by_ref cur
 	if [ -d "$dir" ]; then
 		case "$cur" in
 		refs|refs/*)
@@ -711,7 +713,8 @@ __git_compute_merge_strategies ()
 
 __git_complete_file ()
 {
-	local pfx ls ref cur="${COMP_WORDS[COMP_CWORD]}"
+	local pfx ls ref cur
+	_get_comp_words_by_ref -n ":" cur
 	case "$cur" in
 	?*:*)
 		ref="${cur%%:*}"
@@ -759,7 +762,8 @@ __git_complete_file ()
 
 __git_complete_revlist ()
 {
-	local pfx cur="${COMP_WORDS[COMP_CWORD]}"
+	local pfx cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	*...*)
 		pfx="${cur%...*}..."
@@ -779,11 +783,13 @@ __git_complete_revlist ()
 
 __git_complete_remote_or_refspec ()
 {
-	local cmd="${COMP_WORDS[1]}"
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur words cword
+	_get_comp_words_by_ref -n ":" cur words cword
+	local cmd="${words[1]}"
 	local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0
-	while [ $c -lt $COMP_CWORD ]; do
-		i="${COMP_WORDS[c]}"
+
+	while [ $c -lt $cword ]; do
+		i="${words[c]}"
 		case "$i" in
 		--mirror) [ "$cmd" = "push" ] && no_complete_refspec=1 ;;
 		--all)
@@ -851,13 +857,15 @@ __git_complete_remote_or_refspec ()
 
 __git_complete_strategy ()
 {
+	local cur prev
+	_get_comp_words_by_ref -n "=" cur prev
 	__git_compute_merge_strategies
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	case "${prev}" in
 	-s|--strategy)
 		__gitcomp "$__git_merge_strategies"
 		return 0
 	esac
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+
 	case "$cur" in
 	--strategy=*)
 		__gitcomp "$__git_merge_strategies" "" "${cur##--strategy=}"
@@ -1017,10 +1025,11 @@ __git_aliased_command ()
 # __git_find_on_cmdline requires 1 argument
 __git_find_on_cmdline ()
 {
-	local word subcommand c=1
+	local word subcommand c=1 words cword
 
-	while [ $c -lt $COMP_CWORD ]; do
-		word="${COMP_WORDS[c]}"
+	_get_comp_words_by_ref words cword
+	while [ $c -lt $cword ]; do
+		word="${words[c]}"
 		for subcommand in $1; do
 			if [ "$subcommand" = "$word" ]; then
 				echo "$subcommand"
@@ -1033,9 +1042,10 @@ __git_find_on_cmdline ()
 
 __git_has_doubledash ()
 {
-	local c=1
-	while [ $c -lt $COMP_CWORD ]; do
-		if [ "--" = "${COMP_WORDS[c]}" ]; then
+	local c=1, words cword
+	_get_comp_words_by_ref words cword
+	while [ $c -lt $cwords ]; do
+		if [ "--" = "${words[c]}" ]; then
 			return 0
 		fi
 		c=$((++c))
@@ -1047,7 +1057,9 @@ __git_whitespacelist="nowarn warn error error-all fix"
 
 _git_am ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}" dir="$(__gitdir)"
+	local cur dir="$(__gitdir)"
+
+	_get_comp_words_by_ref -n "=" cur
 	if [ -d "$dir"/rebase-apply ]; then
 		__gitcomp "--skip --continue --resolved --abort"
 		return
@@ -1071,7 +1083,8 @@ _git_am ()
 
 _git_apply ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--whitespace=*)
 		__gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=}"
@@ -1094,7 +1107,8 @@ _git_add ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1108,7 +1122,8 @@ _git_add ()
 
 _git_archive ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--format=*)
 		__gitcomp "$(git archive --list)" "" "${cur##--format=}"
@@ -1152,10 +1167,11 @@ _git_bisect ()
 
 _git_branch ()
 {
-	local i c=1 only_local_ref="n" has_r="n"
+	local i c=1 only_local_ref="n" has_r="n" cur words cword
+	_get_comp_words_by_ref cur words cword
 
-	while [ $c -lt $COMP_CWORD ]; do
-		i="${COMP_WORDS[c]}"
+	while [ $c -lt $cword ]; do
+		i="${words[c]}"
 		case "$i" in
 		-d|-m)	only_local_ref="y" ;;
 		-r)	has_r="y" ;;
@@ -1163,7 +1179,7 @@ _git_branch ()
 		c=$((++c))
 	done
 
-	case "${COMP_WORDS[COMP_CWORD]}" in
+	case "$cur" in
 	--*)
 		__gitcomp "
 			--color --no-color --verbose --abbrev= --no-abbrev
@@ -1183,8 +1199,10 @@ _git_branch ()
 
 _git_bundle ()
 {
-	local cmd="${COMP_WORDS[2]}"
-	case "$COMP_CWORD" in
+	local words cword
+	_get_comp_words_by_ref words cword
+	local cmd="${words[2]}"
+	case "$cword" in
 	2)
 		__gitcomp "create list-heads verify unbundle"
 		;;
@@ -1205,7 +1223,8 @@ _git_checkout ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--conflict=*)
 		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
@@ -1229,7 +1248,8 @@ _git_cherry ()
 
 _git_cherry_pick ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--edit --no-commit"
@@ -1244,7 +1264,8 @@ _git_clean ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--dry-run --quiet"
@@ -1256,7 +1277,8 @@ _git_clean ()
 
 _git_clone ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1283,7 +1305,8 @@ _git_commit ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--cleanup=*)
 		__gitcomp "default strip verbatim whitespace
@@ -1318,7 +1341,8 @@ _git_commit ()
 
 _git_describe ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1350,7 +1374,8 @@ _git_diff ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
@@ -1371,7 +1396,8 @@ _git_difftool ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--tool=*)
 		__gitcomp "$__git_mergetools_common kompare" "" "${cur##--tool=}"
@@ -1396,7 +1422,8 @@ __git_fetch_options="
 
 _git_fetch ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "$__git_fetch_options"
@@ -1408,7 +1435,8 @@ _git_fetch ()
 
 _git_format_patch ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--thread=*)
 		__gitcomp "
@@ -1440,7 +1468,8 @@ _git_format_patch ()
 
 _git_fsck ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1455,7 +1484,8 @@ _git_fsck ()
 
 _git_gc ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--prune --aggressive"
@@ -1474,7 +1504,8 @@ _git_grep ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1497,7 +1528,8 @@ _git_grep ()
 
 _git_help ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--all --info --man --web"
@@ -1515,7 +1547,8 @@ _git_help ()
 
 _git_init ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--shared=*)
 		__gitcomp "
@@ -1535,7 +1568,8 @@ _git_ls_files ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --deleted --modified --others --ignored
@@ -1589,7 +1623,8 @@ _git_log ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	local g="$(git rev-parse --git-dir 2>/dev/null)"
 	local merge=""
 	if [ -f "$g/MERGE_HEAD" ]; then
@@ -1648,7 +1683,8 @@ _git_merge ()
 {
 	__git_complete_strategy && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "$__git_merge_options"
@@ -1659,7 +1695,8 @@ _git_merge ()
 
 _git_mergetool ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--tool=*)
 		__gitcomp "$__git_mergetools_common tortoisemerge" "" "${cur##--tool=}"
@@ -1680,7 +1717,8 @@ _git_merge_base ()
 
 _git_mv ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--dry-run"
@@ -1697,13 +1735,14 @@ _git_name_rev ()
 
 _git_notes ()
 {
-	local subcommands="edit show"
+	local subcommands="edit show" prev
+	_get_comp_words_by_ref prev
 	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
 		__gitcomp "$subcommands"
 		return
 	fi
 
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	case "${prev}" in
 	-m|-F)
 		COMPREPLY=()
 		;;
@@ -1717,7 +1756,8 @@ _git_pull ()
 {
 	__git_complete_strategy && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1733,8 +1773,9 @@ _git_pull ()
 
 _git_push ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	local cur prev
+	_get_comp_words_by_ref -n "=" cur prev
+	case "$prev" in
 	--repo)
 		__gitcomp "$(__git_remotes)"
 		return
@@ -1757,7 +1798,9 @@ _git_push ()
 
 _git_rebase ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}" dir="$(__gitdir)"
+	local cur
+	local dir="$(__gitdir)"
+	_get_comp_words_by_ref -n "=" cur
 	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
 		__gitcomp "--continue --skip --abort"
 		return
@@ -1787,7 +1830,8 @@ __git_send_email_suppresscc_options="author self cc bodycc sob cccmd body all"
 
 _git_send_email ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--confirm=*)
 		__gitcomp "
@@ -1829,9 +1873,10 @@ _git_stage ()
 
 __git_config_get_set_variables ()
 {
-	local prevword word config_file= c=$COMP_CWORD
-	while [ $c -gt 1 ]; do
-		word="${COMP_WORDS[c]}"
+	local prevword word config_file= words cword
+	_get_comp_words_by_ref -n "=" words cword
+	while [ $cword -gt 1 ]; do
+		word="${words[cword]}"
 		case "$word" in
 		--global|--system|--file=*)
 			config_file="$word"
@@ -1843,7 +1888,7 @@ __git_config_get_set_variables ()
 			;;
 		esac
 		prevword=$word
-		c=$((--c))
+		cword=$((--cword))
 	done
 
 	git --git-dir="$(__gitdir)" config $config_file --list 2>/dev/null |
@@ -1859,9 +1904,9 @@ __git_config_get_set_variables ()
 
 _git_config ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-	local prv="${COMP_WORDS[COMP_CWORD-1]}"
-	case "$prv" in
+	local cur prev
+	_get_comp_words_by_ref cur prev
+	case "$prev" in
 	branch.*.remote)
 		__gitcomp "$(__git_remotes)"
 		return
@@ -1871,13 +1916,13 @@ _git_config ()
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
@@ -2268,7 +2313,8 @@ _git_reset ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--merge --mixed --hard --soft --patch"
@@ -2280,7 +2326,8 @@ _git_reset ()
 
 _git_revert ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--edit --mainline --no-edit --no-commit --signoff"
@@ -2294,7 +2341,8 @@ _git_rm ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur=
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
@@ -2308,7 +2356,8 @@ _git_shortlog ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -2326,7 +2375,8 @@ _git_show ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--pretty=*)
 		__gitcomp "$__git_log_pretty_formats
@@ -2350,7 +2400,8 @@ _git_show ()
 
 _git_show_branch ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -2367,10 +2418,11 @@ _git_show_branch ()
 
 _git_stash ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
 	local save_opts='--keep-index --no-keep-index --quiet --patch'
 	local subcommands='save list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	_get_comp_words_by_ref cur
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
@@ -2412,7 +2464,8 @@ _git_submodule ()
 
 	local subcommands="add status init update summary foreach sync"
 	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
-		local cur="${COMP_WORDS[COMP_CWORD]}"
+		local cur
+		_get_comp_words_by_ref cur
 		case "$cur" in
 		--*)
 			__gitcomp "--quiet --cached"
@@ -2456,7 +2509,8 @@ _git_svn ()
 			--edit --rmdir --find-copies-harder --copy-similarity=
 			"
 
-		local cur="${COMP_WORDS[COMP_CWORD]}"
+		local cur
+		_get_comp_words_by_ref cur
 		case "$subcommand,$cur" in
 		fetch,--*)
 			__gitcomp "--revision= --fetch-all $fc_opts"
@@ -2527,9 +2581,10 @@ _git_svn ()
 
 _git_tag ()
 {
-	local i c=1 f=0
-	while [ $c -lt $COMP_CWORD ]; do
-		i="${COMP_WORDS[c]}"
+	local i c=1 f=0 words cword prev
+	_get_comp_words_by_ref prev words cword
+	while [ $c -lt $cword ]; do
+		i="${words[c]}"
 		case "$i" in
 		-d|-v)
 			__gitcomp "$(__git_tags)"
@@ -2542,7 +2597,7 @@ _git_tag ()
 		c=$((++c))
 	done
 
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	case "${prev}" in
 	-m|-F)
 		COMPREPLY=()
 		;;
@@ -2566,15 +2621,16 @@ _git_whatchanged ()
 
 _git ()
 {
-	local i c=1 command __git_dir
+	local i c=1 command __git_dir words cword
 
-	if [[ -n ${ZSH_VERSION-} ]]; then
+	if [[ -n $ZSH_VERSION ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
 	fi
 
-	while [ $c -lt $COMP_CWORD ]; do
-		i="${COMP_WORDS[c]}"
+	_get_comp_words_by_ref -n "=" words cword
+	while [ $c -lt $cword ]; do
+		i="${words[c]}"
 		case "$i" in
 		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
 		--bare)      __git_dir="." ;;
@@ -2586,7 +2642,7 @@ _git ()
 	done
 
 	if [ -z "$command" ]; then
-		case "${COMP_WORDS[COMP_CWORD]}" in
+		case "${words[cword]}" in
 		--*)   __gitcomp "
 			--paginate
 			--no-pager
@@ -2617,19 +2673,20 @@ _git ()
 
 _gitk ()
 {
-	if [[ -n ${ZSH_VERSION-} ]]; then
+	if [[ -n $ZSH_VERSION ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
 	fi
 
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
 	local g="$(__gitdir)"
 	local merge=""
 	if [ -f "$g/MERGE_HEAD" ]; then
 		merge="--merge"
 	fi
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -2657,7 +2714,7 @@ complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/null \
 	|| complete -o default -o nospace -F _git git.exe
 fi
 
-if [[ -n ${ZSH_VERSION-} ]]; then
+if [[ -n $ZSH_VERSION ]]; then
 	shopt () {
 		local option
 		if [ $# -ne 2 ]; then
-- 
1.7.3.2
