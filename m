From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/3] bash: remove unnecessary _get_comp_words_by_ref()
	invocations
Date: Thu, 28 Apr 2011 18:01:52 +0200
Message-ID: <1304006513-19392-2-git-send-email-szeder@ira.uka.de>
References: <20110428160115.GA19003@goldbirke>
	<1304006513-19392-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>, Stefan Haller <lists@haller-berlin.de>,
	Mark Lodato <lodatom@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:02:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFTfh-0007jN-3a
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 18:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760463Ab1D1QCN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 12:02:13 -0400
Received: from ex-e-1.perimeter.fzi.de ([141.21.8.250]:21721 "EHLO
	EX-E-1.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757715Ab1D1QCM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 12:02:12 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by EX-E-1.perimeter.fzi.de
 (141.21.8.250) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 28 Apr
 2011 18:02:06 +0200
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 28 Apr
 2011 18:02:09 +0200
X-Mailer: git-send-email 1.7.5.86.g799a6
In-Reply-To: <1304006513-19392-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172372>

In v1.7.4-rc0~11^2~2 (bash: get --pretty=3Dm<tab> completion to work
with bash v4, 2010-12-02) we started to use _get_comp_words_by_ref()
to access completion-related variables.  That was large change, and to
make it easily reviewable, we invoked _get_comp_words_by_ref() in each
completion function and systematically replaced every occurance of
bash's completion-related variables ($COMP_WORDS and $COMP_CWORD) with
variables set by _get_comp_words_by_ref().

This has the downside that _get_comp_words_by_ref() is invoked several
times during a single completion.  The worst offender is perhaps 'git
log mas<TAB>': during the completion of 'master'
_get_comp_words_by_ref() is invoked no less than six times.

However, the variables $prev, $cword, and $words provided by
_get_comp_words_by_ref() are not modified in any of the completion
functions, and the previous commit ensures that the $cur variable is
not modified as well.  This makes it possible to invoke
_get_comp_words_by_ref() to get those variables only once in our
toplevel completion functions _git() and _gitk(), and all other
completion functions will inherit them.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |  116 +++---------------------=
--------
 1 files changed, 11 insertions(+), 105 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index a594b40..862b840 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -489,8 +489,6 @@ fi
 # generates completion reply with compgen
 __gitcomp ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	local cur_=3D"$cur"
=20
 	if [ $# -gt 2 ]; then
@@ -553,8 +551,7 @@ __git_tags ()
 __git_refs ()
 {
 	local i is_hash=3Dy dir=3D"$(__gitdir "${1-}")" track=3D"${2-}"
-	local cur format refs
-	_get_comp_words_by_ref -n =3D: cur
+	local format refs
 	if [ -d "$dir" ]; then
 		case "$cur" in
 		refs|refs/*)
@@ -668,9 +665,7 @@ __git_compute_merge_strategies ()
=20
 __git_complete_revlist_file ()
 {
-	local pfx ls ref cur
-	_get_comp_words_by_ref -n =3D: cur
-	local cur_=3D"$cur"
+	local pfx ls ref cur_=3D"$cur"
 	case "$cur_" in
 	*..?*:*)
 		return
@@ -742,8 +737,6 @@ __git_complete_revlist ()
=20
 __git_complete_remote_or_refspec ()
 {
-	local cur words cword
-	_get_comp_words_by_ref -n =3D: cur words cword
 	local cur_=3D"$cur" cmd=3D"${words[1]}"
 	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
 	while [ $c -lt $cword ]; do
@@ -815,8 +808,6 @@ __git_complete_remote_or_refspec ()
=20
 __git_complete_strategy ()
 {
-	local cur prev
-	_get_comp_words_by_ref -n =3D: cur prev
 	__git_compute_merge_strategies
 	case "$prev" in
 	-s|--strategy)
@@ -994,8 +985,7 @@ __git_aliased_command ()
 # __git_find_on_cmdline requires 1 argument
 __git_find_on_cmdline ()
 {
-	local word subcommand c=3D1 words cword
-	_get_comp_words_by_ref -n =3D: words cword
+	local word subcommand c=3D1
 	while [ $c -lt $cword ]; do
 		word=3D"${words[c]}"
 		for subcommand in $1; do
@@ -1010,8 +1000,7 @@ __git_find_on_cmdline ()
=20
 __git_has_doubledash ()
 {
-	local c=3D1 words cword
-	_get_comp_words_by_ref -n =3D: words cword
+	local c=3D1
 	while [ $c -lt $cword ]; do
 		if [ "--" =3D "${words[c]}" ]; then
 			return 0
@@ -1025,8 +1014,7 @@ __git_whitespacelist=3D"nowarn warn error error-a=
ll fix"
=20
 _git_am ()
 {
-	local cur dir=3D"$(__gitdir)"
-	_get_comp_words_by_ref -n =3D: cur
+	local dir=3D"$(__gitdir)"
 	if [ -d "$dir"/rebase-apply ]; then
 		__gitcomp "--skip --continue --resolved --abort"
 		return
@@ -1050,8 +1038,6 @@ _git_am ()
=20
 _git_apply ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--whitespace=3D*)
 		__gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=3D}"
@@ -1074,8 +1060,6 @@ _git_add ()
 {
 	__git_has_doubledash && return
=20
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1089,8 +1073,6 @@ _git_add ()
=20
 _git_archive ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--format=3D*)
 		__gitcomp "$(git archive --list)" "" "${cur##--format=3D}"
@@ -1138,9 +1120,8 @@ _git_bisect ()
=20
 _git_branch ()
 {
-	local i c=3D1 only_local_ref=3D"n" has_r=3D"n" cur words cword
+	local i c=3D1 only_local_ref=3D"n" has_r=3D"n"
=20
-	_get_comp_words_by_ref -n =3D: cur words cword
 	while [ $c -lt $cword ]; do
 		i=3D"${words[c]}"
 		case "$i" in
@@ -1170,8 +1151,6 @@ _git_branch ()
=20
 _git_bundle ()
 {
-	local words cword
-	_get_comp_words_by_ref -n =3D: words cword
 	local cmd=3D"${words[2]}"
 	case "$cword" in
 	2)
@@ -1194,8 +1173,6 @@ _git_checkout ()
 {
 	__git_has_doubledash && return
=20
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--conflict=3D*)
 		__gitcomp "diff3 merge" "" "${cur##--conflict=3D}"
@@ -1225,8 +1202,6 @@ _git_cherry ()
=20
 _git_cherry_pick ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--edit --no-commit"
@@ -1241,8 +1216,6 @@ _git_clean ()
 {
 	__git_has_doubledash && return
=20
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--dry-run --quiet"
@@ -1254,8 +1227,6 @@ _git_clean ()
=20
 _git_clone ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1282,8 +1253,6 @@ _git_commit ()
 {
 	__git_has_doubledash && return
=20
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--cleanup=3D*)
 		__gitcomp "default strip verbatim whitespace
@@ -1318,8 +1287,6 @@ _git_commit ()
=20
 _git_describe ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1351,8 +1318,6 @@ _git_diff ()
 {
 	__git_has_doubledash && return
=20
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
@@ -1373,8 +1338,6 @@ _git_difftool ()
 {
 	__git_has_doubledash && return
=20
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--tool=3D*)
 		__gitcomp "$__git_mergetools_common kompare" "" "${cur##--tool=3D}"
@@ -1399,8 +1362,6 @@ __git_fetch_options=3D"
=20
 _git_fetch ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "$__git_fetch_options"
@@ -1412,8 +1373,6 @@ _git_fetch ()
=20
 _git_format_patch ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--thread=3D*)
 		__gitcomp "
@@ -1445,8 +1404,6 @@ _git_format_patch ()
=20
 _git_fsck ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1461,8 +1418,6 @@ _git_fsck ()
=20
 _git_gc ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--prune --aggressive"
@@ -1481,8 +1436,6 @@ _git_grep ()
 {
 	__git_has_doubledash && return
=20
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1505,8 +1458,6 @@ _git_grep ()
=20
 _git_help ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--all --info --man --web"
@@ -1524,8 +1475,6 @@ _git_help ()
=20
 _git_init ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--shared=3D*)
 		__gitcomp "
@@ -1545,8 +1494,6 @@ _git_ls_files ()
 {
 	__git_has_doubledash && return
=20
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --deleted --modified --others --ignored
@@ -1607,8 +1554,6 @@ _git_log ()
 	if [ -f "$g/MERGE_HEAD" ]; then
 		merge=3D"--merge"
 	fi
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--pretty=3D*)
 		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
@@ -1662,8 +1607,6 @@ _git_merge ()
 {
 	__git_complete_strategy && return
=20
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "$__git_merge_options"
@@ -1674,8 +1617,6 @@ _git_merge ()
=20
 _git_mergetool ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--tool=3D*)
 		__gitcomp "$__git_mergetools_common tortoisemerge" "" "${cur##--tool=
=3D}"
@@ -1696,8 +1637,6 @@ _git_merge_base ()
=20
 _git_mv ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--dry-run"
@@ -1716,8 +1655,6 @@ _git_notes ()
 {
 	local subcommands=3D'add append copy edit list prune remove show'
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
-	local cur words cword
-	_get_comp_words_by_ref -n =3D: cur words cword
=20
 	case "$subcommand,$cur" in
 	,--*)
@@ -1767,8 +1704,6 @@ _git_pull ()
 {
 	__git_complete_strategy && return
=20
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1784,8 +1719,6 @@ _git_pull ()
=20
 _git_push ()
 {
-	local cur prev
-	_get_comp_words_by_ref -n =3D: cur prev
 	case "$prev" in
 	--repo)
 		__gitcomp "$(__git_remotes)"
@@ -1810,8 +1743,6 @@ _git_push ()
 _git_rebase ()
 {
 	local dir=3D"$(__gitdir)"
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
 		__gitcomp "--continue --skip --abort"
 		return
@@ -1853,8 +1784,6 @@ __git_send_email_suppresscc_options=3D"author sel=
f cc bodycc sob cccmd body all"
=20
 _git_send_email ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--confirm=3D*)
 		__gitcomp "
@@ -1896,8 +1825,6 @@ _git_stage ()
=20
 __git_config_get_set_variables ()
 {
-	local words cword
-	_get_comp_words_by_ref -n =3D: words cword
 	local prevword word config_file=3D c=3D$cword
 	while [ $c -gt 1 ]; do
 		word=3D"${words[c]}"
@@ -1928,8 +1855,6 @@ __git_config_get_set_variables ()
=20
 _git_config ()
 {
-	local cur prev
-	_get_comp_words_by_ref -n =3D: cur prev
 	case "$prev" in
 	branch.*.remote)
 		__gitcomp "$(__git_remotes)"
@@ -2389,8 +2314,6 @@ _git_reset ()
 {
 	__git_has_doubledash && return
=20
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--merge --mixed --hard --soft --patch"
@@ -2402,8 +2325,6 @@ _git_reset ()
=20
 _git_revert ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--edit --mainline --no-edit --no-commit --signoff"
@@ -2417,8 +2338,6 @@ _git_rm ()
 {
 	__git_has_doubledash && return
=20
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
@@ -2432,8 +2351,6 @@ _git_shortlog ()
 {
 	__git_has_doubledash && return
=20
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -2451,8 +2368,6 @@ _git_show ()
 {
 	__git_has_doubledash && return
=20
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--pretty=3D*)
 		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
@@ -2476,8 +2391,6 @@ _git_show ()
=20
 _git_show_branch ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -2494,8 +2407,6 @@ _git_show_branch ()
=20
 _git_stash ()
 {
-	local cur
-	_get_comp_words_by_ref -n =3D: cur
 	local save_opts=3D'--keep-index --no-keep-index --quiet --patch'
 	local subcommands=3D'save list show apply clear drop pop create branc=
h'
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
@@ -2540,8 +2451,6 @@ _git_submodule ()
=20
 	local subcommands=3D"add status init update summary foreach sync"
 	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
-		local cur
-		_get_comp_words_by_ref -n =3D: cur
 		case "$cur" in
 		--*)
 			__gitcomp "--quiet --cached"
@@ -2585,8 +2494,6 @@ _git_svn ()
 			--edit --rmdir --find-copies-harder --copy-similarity=3D
 			"
=20
-		local cur
-		_get_comp_words_by_ref -n =3D: cur
 		case "$subcommand,$cur" in
 		fetch,--*)
 			__gitcomp "--revision=3D --fetch-all $fc_opts"
@@ -2658,8 +2565,6 @@ _git_svn ()
 _git_tag ()
 {
 	local i c=3D1 f=3D0
-	local words cword prev
-	_get_comp_words_by_ref -n =3D: words cword prev
 	while [ $c -lt $cword ]; do
 		i=3D"${words[c]}"
 		case "$i" in
@@ -2705,8 +2610,8 @@ _git ()
 		setopt KSH_TYPESET
 	fi
=20
-	local cur words cword
-	_get_comp_words_by_ref -n =3D: cur words cword
+	local cur words cword prev
+	_get_comp_words_by_ref -n =3D: cur words cword prev
 	while [ $c -lt $cword ]; do
 		i=3D"${words[c]}"
 		case "$i" in
@@ -2756,15 +2661,16 @@ _gitk ()
 		setopt KSH_TYPESET
 	fi
=20
+	local cur words cword prev
+	_get_comp_words_by_ref -n =3D: cur words cword prev
+
 	__git_has_doubledash && return
=20
-	local cur
 	local g=3D"$(__gitdir)"
 	local merge=3D""
 	if [ -f "$g/MERGE_HEAD" ]; then
 		merge=3D"--merge"
 	fi
-	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
 	--*)
 		__gitcomp "
--=20
1.7.5.86.g799a6
