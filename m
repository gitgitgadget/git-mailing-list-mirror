From: Peter van der Does <peter@avirtualhome.com>
Subject: [PATCH v2/RFC] Make git-completion Bash 4 compatible.
Date: Wed, 27 Oct 2010 13:15:06 -0400
Message-ID: <20101027131506.4da06c6d@MonteCarlo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	SZEDER =?ISO-8859-1?B?R+Fib3I=?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 27 19:15:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB9b0-0004pg-7j
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 19:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793Ab0J0RPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 13:15:24 -0400
Received: from morn.lunarbreeze.com ([216.227.218.220]:51949 "EHLO
	morn.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab0J0RPV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 13:15:21 -0400
Received: from c-69-248-103-68.hsd1.nj.comcast.net ([69.248.103.68] helo=monza.grandprix.int)
	by morn.lunarbreeze.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@avirtualhome.com>)
	id 1PB9af-0004ST-Al; Wed, 27 Oct 2010 10:15:09 -0700
Received: from MonteCarlo (montecarlo.grandprix.int [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id B8FA3101F82;
	Wed, 27 Oct 2010 13:15:07 -0400 (EDT)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.22.0; i486-pc-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160103>


The completion script does not work as expected under Bash 4.
Bash: 3
output:
$ git log --pretty=<tab><tab>
email     full      medium    raw
format:   fuller    oneline   short

Bash: 4
output:
$ git log --pretty=<tab><tab>
.bash_logout         .local/
.bash_profile        Music/
--More--

Signed-off-by: Peter van der Does <peter@avirtualhome.com>
---
Updated patch to play along with latest maint branch. It broke after the patch 
ml/completion-zsh was implemented.
Removed some debugging code from the patch.

 contrib/completion/git-completion.bash |  417 +++++++++++++++++++++++++++-----
 1 files changed, 355 insertions(+), 62 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 64341d5..85fb0f1 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -76,12 +76,251 @@
 #
 #       git@vger.kernel.org
 #
+# Updated for Bash 4.0
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
 *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
 esac
 
+# If the function _get_comp_words_by_ref does not exists, we can assume the
+# bash_completion 1.2 script isn't loaded and therefor we're defining the
+# necessary functions ourselves.
+if ! type _get_comp_words_by_ref &> /dev/null ; then
+	# Assign variable one scope above the caller
+	# Usage: local "$1" && _upvar $1 "value(s)"
+	# Param: $1  Variable name to assign value to
+	# Param: $*  Value(s) to assign.  If multiple values, an array is
+	#            assigned, otherwise a single value is assigned.
+	# NOTE: For assigning multiple variables, use '_upvars'.  Do NOT
+	#       use multiple '_upvar' calls, since one '_upvar' call might
+	#       reassign a variable to be used by another '_upvar' call.
+	# See: http://fvue.nl/wiki/Bash:_Passing_variables_by_reference
+	_upvar() {
+		if unset -v "$1"; then           # Unset & validate varname
+	        if (( $# == 2 )); then
+	            eval $1=\"\$2\"          # Return single value
+	        else
+	            eval $1=\(\"\${@:2}\"\)  # Return array
+	        fi
+	    fi
+	}
+
+
+	# Assign variables one scope above the caller
+	# Usage: local varname [varname ...] &&
+	#        _upvars [-v varname value] | [-aN varname [value ...]] ...
+	# Available OPTIONS:
+	#     -aN  Assign next N values to varname as array
+	#     -v   Assign single value to varname
+	# Return: 1 if error occurs
+	# See: http://fvue.nl/wiki/Bash:_Passing_variables_by_reference
+	_upvars() {
+	    if ! (( $# )); then
+	        echo "${FUNCNAME[0]}: usage: ${FUNCNAME[0]} [-v varname"\
+	            "value] | [-aN varname [value ...]] ..." 1>&2
+	        return 2
+	    fi
+	    while (( $# )); do
+	        case $1 in
+	            -a*)
+	                # Error checking
+	                [[ ${1#-a} ]] || { echo "bash: ${FUNCNAME[0]}: \`$1': missing"\
+	                    "number specifier" 1>&2; return 1; }
+	                printf %d "${1#-a}" &> /dev/null || { echo "bash:"\
+	                    "${FUNCNAME[0]}: \`$1': invalid number specifier" 1>&2
+	                    return 1; }
+	                # Assign array of -aN elements
+	                [[ "$2" ]] && unset -v "$2" && eval $2=\(\"\${@:3:${1#-a}}\"\) &&
+	                shift $((${1#-a} + 2)) || { echo "bash: ${FUNCNAME[0]}:"\
+	                    "\`$1${2+ }$2': missing argument(s)" 1>&2; return 1; }
+	                ;;
+	            -v)
+	                # Assign single value
+	                [[ "$2" ]] && unset -v "$2" && eval $2=\"\$3\" &&
+	                shift 3 || { echo "bash: ${FUNCNAME[0]}: $1: missing"\
+	                "argument(s)" 1>&2; return 1; }
+	                ;;
+	            *)
+	                echo "bash: ${FUNCNAME[0]}: $1: invalid option" 1>&2
+	                return 1 ;;
+	        esac
+	    done
+	}
+
+
+	# Reassemble command line words, excluding specified characters from the
+	# list of word completion separators (COMP_WORDBREAKS).
+	# @param $1 chars  Characters out of $COMP_WORDBREAKS which should
+	#     NOT be considered word breaks. This is useful for things like scp where
+	#     we want to return host:path and not only path, so we would pass the
+	#     colon (:) as $1 here.
+	# @param $2 words  Name of variable to return words to
+	# @param $3 cword  Name of variable to return cword to
+	#
+	__reassemble_comp_words_by_ref() {
+	    local exclude i j ref
+	    # Exclude word separator characters?
+	    if [[ $1 ]]; then
+	        # Yes, exclude word separator characters;
+	        # Exclude only those characters, which were really included
+	        exclude="${1//[^$COMP_WORDBREAKS]}"
+	    fi
+
+	    # Default to cword unchanged
+	    eval $3=$COMP_CWORD
+	    # Are characters excluded which were former included?
+	    if [[ $exclude ]]; then
+	        # Yes, list of word completion separators has shrunk;
+	        # Re-assemble words to complete
+	        for (( i=0, j=0; i < ${#COMP_WORDS[@]}; i++, j++)); do
+	            # Is current word not word 0 (the command itself) and is word not
+	            # empty and is word made up of just word separator characters to be
+	            # excluded?
+	            while [[ $i -gt 0 && ${COMP_WORDS[$i]} &&
+	                ${COMP_WORDS[$i]//[^$exclude]} == ${COMP_WORDS[$i]}
+	            ]]; do
+	                [ $j -ge 2 ] && ((j--))
+	                # Append word separator to current word
+	                ref="$2[$j]"
+	                eval $2[$j]=\${!ref}\${COMP_WORDS[i]}
+	                # Indicate new cword
+	                [ $i = $COMP_CWORD ] && eval $3=$j
+	                # Indicate next word if available, else end *both* while and for loop
+	                (( $i < ${#COMP_WORDS[@]} - 1)) && ((i++)) || break 2
+	            done
+	            # Append word to current word
+	            ref="$2[$j]"
+	            eval $2[$j]=\${!ref}\${COMP_WORDS[i]}
+	            # Indicate new cword
+	            [ $i = $COMP_CWORD ] && [[ ${COMP_WORDS[i]} ]] && eval $3=$j
+	        done
+	    else
+	        # No, list of word completions separators hasn't changed;
+	        eval $2=\( \"\${COMP_WORDS[@]}\" \)
+	    fi
+	} # __reassemble_comp_words_by_ref()
+
+	# @param $1 exclude  Characters out of $COMP_WORDBREAKS which should NOT be
+	#     considered word breaks. This is useful for things like scp where
+	#     we want to return host:path and not only path, so we would pass the
+	#     colon (:) as $1 in this case.  Bash-3 doesn't do word splitting, so this
+	#     ensures we get the same word on both bash-3 and bash-4.
+	# @param $2 words  Name of variable to return words to
+	# @param $3 cword  Name of variable to return cword to
+	# @param $4 cur  Name of variable to return current word to complete to
+	# @see ___get_cword_at_cursor_by_ref()
+	__get_cword_at_cursor_by_ref() {
+	    local cword words=()
+	    __reassemble_comp_words_by_ref "$1" words cword
+
+	    local i cur2
+	    local cur="$COMP_LINE"
+	    local index="$COMP_POINT"
+	    for (( i = 0; i <= cword; ++i )); do
+	        while [[
+	            # Current word fits in $cur?
+	            "${#cur}" -ge ${#words[i]} &&
+	            # $cur doesn't match cword?
+	            "${cur:0:${#words[i]}}" != "${words[i]}"
+	        ]]; do
+	            # Strip first character
+	            cur="${cur:1}"
+	            # Decrease cursor position
+	            ((index--))
+	        done
+
+	        # Does found word matches cword?
+	        if [[ "$i" -lt "$cword" ]]; then
+	            # No, cword lies further;
+	            local old_size="${#cur}"
+	            cur="${cur#${words[i]}}"
+	            local new_size="${#cur}"
+	            index=$(( index - old_size + new_size ))
+	        fi
+	    done
+
+	    if [[ "${words[cword]:0:${#cur}}" != "$cur" ]]; then
+	        # We messed up. At least return the whole word so things keep working
+	        cur2=${words[cword]}
+	    else
+	        cur2=${cur:0:$index}
+	    fi
+
+	    local "$2" "$3" "$4" &&
+	        _upvars -a${#words[@]} $2 "${words[@]}" -v $3 "$cword" -v $4 "$cur2"
+	}
+
+
+	# Get the word to complete and optional previous words.
+	# This is nicer than ${COMP_WORDS[$COMP_CWORD]}, since it handles cases
+	# where the user is completing in the middle of a word.
+	# (For example, if the line is "ls foobar",
+	# and the cursor is here -------->   ^
+	# Also one is able to cross over possible wordbreak characters.
+	# Usage: _get_comp_words_by_ref [OPTIONS] [VARNAMES]
+	# Available VARNAMES:
+	#     cur         Return cur via $cur
+	#     prev        Return prev via $prev
+	#     words       Return words via $words
+	#     cword       Return cword via $cword
+	#
+	# Available OPTIONS:
+	#     -n EXCLUDE  Characters out of $COMP_WORDBREAKS which should NOT be
+	#                 considered word breaks. This is useful for things like scp
+	#                 where we want to return host:path and not only path, so we
+	#                 would pass the colon (:) as -n option in this case.  Bash-3
+	#                 doesn't do word splitting, so this ensures we get the same
+	#                 word on both bash-3 and bash-4.
+	#     -c VARNAME  Return cur via $VARNAME
+	#     -p VARNAME  Return prev via $VARNAME
+	#     -w VARNAME  Return words via $VARNAME
+	#     -i VARNAME  Return cword via $VARNAME
+	#
+	# Example usage:
+	#
+	#    $ _get_comp_words_by_ref -n : cur prev
+	#
+	_get_comp_words_by_ref()
+	{
+	    local exclude flag i OPTIND=1
+	    local cur cword words=()
+	    local upargs=() upvars=() vcur vcword vprev vwords
+
+	    while getopts "c:i:n:p:w:" flag "$@"; do
+	        case $flag in
+	            c) vcur=$OPTARG ;;
+	            i) vcword=$OPTARG ;;
+	            n) exclude=$OPTARG ;;
+	            p) vprev=$OPTARG ;;
+	            w) vwords=$OPTARG ;;
+	        esac
+	    done
+	    while [[ $# -ge $OPTIND ]]; do
+	        case ${!OPTIND} in
+	            cur)   vcur=cur ;;
+	            prev)  vprev=prev ;;
+	            cword) vcword=cword ;;
+	            words) vwords=words ;;
+	            *) echo "bash: $FUNCNAME(): \`${!OPTIND}': unknown argument" \
+	                1>&2; return 1
+	        esac
+	        let "OPTIND += 1"
+	    done
+
+	    __get_cword_at_cursor_by_ref "$exclude" words cword cur
+
+	    [[ $vcur   ]] && { upvars+=("$vcur"  ); upargs+=(-v $vcur   "$cur"  ); }
+	    [[ $vcword ]] && { upvars+=("$vcword"); upargs+=(-v $vcword "$cword"); }
+	    [[ $vprev  ]] && { upvars+=("$vprev" ); upargs+=(-v $vprev
+	        "${words[cword - 1]}"); }
+	    [[ $vwords ]] && { upvars+=("$vwords"); upargs+=(-a${#words[@]} $vwords
+	        "${words[@]}"); }
+
+	    (( ${#upvars[@]} )) && local "${upvars[@]}" && _upvars "${upargs[@]}"
+	}
+fi
+
 # __gitdir accepts 0 or 1 arguments (i.e., location)
 # returns location of .git repo
 __gitdir ()
@@ -331,7 +570,8 @@ __gitcomp_1 ()
 # generates completion reply with compgen
 __gitcomp ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	if [ $# -gt 2 ]; then
 		cur="$3"
 	fi
@@ -390,7 +630,8 @@ __git_tags ()
 __git_refs ()
 {
 	local i is_hash=y dir="$(__gitdir "${1-}")"
-	local cur="${COMP_WORDS[COMP_CWORD]}" format refs
+	local cur format refs
+	_get_comp_words_by_ref cur
 	if [ -d "$dir" ]; then
 		case "$cur" in
 		refs|refs/*)
@@ -488,7 +729,8 @@ __git_compute_merge_strategies ()
 
 __git_complete_file ()
 {
-	local pfx ls ref cur="${COMP_WORDS[COMP_CWORD]}"
+	local pfx ls ref cur
+	_get_comp_words_by_ref -n ":" cur
 	case "$cur" in
 	?*:*)
 		ref="${cur%%:*}"
@@ -536,7 +778,8 @@ __git_complete_file ()
 
 __git_complete_revlist ()
 {
-	local pfx cur="${COMP_WORDS[COMP_CWORD]}"
+	local pfx cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	*...*)
 		pfx="${cur%...*}..."
@@ -556,11 +799,14 @@ __git_complete_revlist ()
 
 __git_complete_remote_or_refspec ()
 {
-	local cmd="${COMP_WORDS[1]}"
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local git_comp_words git_comp_cword
+	__reassemble_comp_words_by_ref : git_comp_words git_comp_cword
+	local cmd="${git_comp_words[1]}"
+	local cur
 	local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0
-	while [ $c -lt $COMP_CWORD ]; do
-		i="${COMP_WORDS[c]}"
+	_get_comp_words_by_ref -n ":" cur
+	while [ $c -lt $git_comp_cword ]; do
+		i="${git_comp_words[c]}"
 		case "$i" in
 		--mirror) [ "$cmd" = "push" ] && no_complete_refspec=1 ;;
 		--all)
@@ -628,13 +874,15 @@ __git_complete_remote_or_refspec ()
 
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
@@ -824,7 +1072,10 @@ __git_whitespacelist="nowarn warn error error-all fix"
 
 _git_am ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}" dir="$(__gitdir)"
+	local cur
+	local dir="$(__gitdir)"
+
+	_get_comp_words_by_ref -n "=" cur
 	if [ -d "$dir"/rebase-apply ]; then
 		__gitcomp "--skip --continue --resolved --abort"
 		return
@@ -848,7 +1099,8 @@ _git_am ()
 
 _git_apply ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--whitespace=*)
 		__gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=}"
@@ -871,7 +1123,8 @@ _git_add ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -885,7 +1138,8 @@ _git_add ()
 
 _git_archive ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--format=*)
 		__gitcomp "$(git archive --list)" "" "${cur##--format=}"
@@ -929,7 +1183,8 @@ _git_bisect ()
 
 _git_branch ()
 {
-	local i c=1 only_local_ref="n" has_r="n"
+	local i c=1 only_local_ref="n" has_r="n", cur
+	_get_comp_words_by_ref cur
 
 	while [ $c -lt $COMP_CWORD ]; do
 		i="${COMP_WORDS[c]}"
@@ -940,7 +1195,7 @@ _git_branch ()
 		c=$((++c))
 	done
 
-	case "${COMP_WORDS[COMP_CWORD]}" in
+	case "$cur" in
 	--*)
 		__gitcomp "
 			--color --no-color --verbose --abbrev= --no-abbrev
@@ -982,7 +1237,8 @@ _git_checkout ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--conflict=*)
 		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
@@ -1006,7 +1262,8 @@ _git_cherry ()
 
 _git_cherry_pick ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--edit --no-commit"
@@ -1021,7 +1278,8 @@ _git_clean ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--dry-run --quiet"
@@ -1033,7 +1291,8 @@ _git_clean ()
 
 _git_clone ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1060,7 +1319,8 @@ _git_commit ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--cleanup=*)
 		__gitcomp "default strip verbatim whitespace
@@ -1095,7 +1355,8 @@ _git_commit ()
 
 _git_describe ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1127,7 +1388,8 @@ _git_diff ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
@@ -1148,7 +1410,8 @@ _git_difftool ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--tool=*)
 		__gitcomp "$__git_mergetools_common kompare" "" "${cur##--tool=}"
@@ -1173,7 +1436,8 @@ __git_fetch_options="
 
 _git_fetch ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "$__git_fetch_options"
@@ -1185,7 +1449,8 @@ _git_fetch ()
 
 _git_format_patch ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--thread=*)
 		__gitcomp "
@@ -1217,7 +1482,8 @@ _git_format_patch ()
 
 _git_fsck ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1232,7 +1498,8 @@ _git_fsck ()
 
 _git_gc ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--prune --aggressive"
@@ -1251,7 +1518,8 @@ _git_grep ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1274,7 +1542,8 @@ _git_grep ()
 
 _git_help ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--all --info --man --web"
@@ -1292,7 +1561,8 @@ _git_help ()
 
 _git_init ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--shared=*)
 		__gitcomp "
@@ -1312,7 +1582,8 @@ _git_ls_files ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --deleted --modified --others --ignored
@@ -1366,7 +1637,8 @@ _git_log ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	local g="$(git rev-parse --git-dir 2>/dev/null)"
 	local merge=""
 	if [ -f "$g/MERGE_HEAD" ]; then
@@ -1425,7 +1697,8 @@ _git_merge ()
 {
 	__git_complete_strategy && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "$__git_merge_options"
@@ -1436,7 +1709,8 @@ _git_merge ()
 
 _git_mergetool ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--tool=*)
 		__gitcomp "$__git_mergetools_common tortoisemerge" "" "${cur##--tool=}"
@@ -1457,7 +1731,8 @@ _git_merge_base ()
 
 _git_mv ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--dry-run"
@@ -1494,7 +1769,8 @@ _git_pull ()
 {
 	__git_complete_strategy && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -1510,8 +1786,9 @@ _git_pull ()
 
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
@@ -1534,7 +1811,9 @@ _git_push ()
 
 _git_rebase ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}" dir="$(__gitdir)"
+	local cur
+	local dir="$(__gitdir)"
+	_get_comp_words_by_ref -n "=" cur
 	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
 		__gitcomp "--continue --skip --abort"
 		return
@@ -1564,7 +1843,8 @@ __git_send_email_suppresscc_options="author self cc bodycc sob cccmd body all"
 
 _git_send_email ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--confirm=*)
 		__gitcomp "
@@ -1606,9 +1886,11 @@ _git_stage ()
 
 __git_config_get_set_variables ()
 {
-	local prevword word config_file= c=$COMP_CWORD
+	local prevword word config_file= c
+	local git_comp_words
+	__reassemble_comp_words_by_ref = git_comp_words c
 	while [ $c -gt 1 ]; do
-		word="${COMP_WORDS[c]}"
+		word="${git_comp_words[c]}"
 		case "$word" in
 		--global|--system|--file=*)
 			config_file="$word"
@@ -1636,9 +1918,9 @@ __git_config_get_set_variables ()
 
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
@@ -1648,13 +1930,13 @@ _git_config ()
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
@@ -2045,7 +2327,8 @@ _git_reset ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--merge --mixed --hard --soft --patch"
@@ -2057,7 +2340,8 @@ _git_reset ()
 
 _git_revert ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--edit --mainline --no-edit --no-commit --signoff"
@@ -2071,7 +2355,8 @@ _git_rm ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur=
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
@@ -2085,7 +2370,8 @@ _git_shortlog ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -2103,7 +2389,8 @@ _git_show ()
 {
 	__git_has_doubledash && return
 
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref -n "=" cur
 	case "$cur" in
 	--pretty=*)
 		__gitcomp "$__git_log_pretty_formats
@@ -2127,7 +2414,8 @@ _git_show ()
 
 _git_show_branch ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur
+	_get_comp_words_by_ref cur
 	case "$cur" in
 	--*)
 		__gitcomp "
@@ -2144,10 +2432,11 @@ _git_show_branch ()
 
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
@@ -2189,7 +2478,8 @@ _git_submodule ()
 
 	local subcommands="add status init update summary foreach sync"
 	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
-		local cur="${COMP_WORDS[COMP_CWORD]}"
+		local cur
+		_get_comp_words_by_ref cur
 		case "$cur" in
 		--*)
 			__gitcomp "--quiet --cached"
@@ -2233,7 +2523,8 @@ _git_svn ()
 			--edit --rmdir --find-copies-harder --copy-similarity=
 			"
 
-		local cur="${COMP_WORDS[COMP_CWORD]}"
+		local cur
+		_get_comp_words_by_ref cur
 		case "$subcommand,$cur" in
 		fetch,--*)
 			__gitcomp "--revision= --fetch-all $fc_opts"
@@ -2343,15 +2634,16 @@ _git_whatchanged ()
 
 _git ()
 {
-	local i c=1 command __git_dir
+	local i c=1 command __git_dir git_comp_words git_comp_cword
 
 	if [[ -n $ZSH_VERSION ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
 	fi
 
-	while [ $c -lt $COMP_CWORD ]; do
-		i="${COMP_WORDS[c]}"
+	__reassemble_comp_words_by_ref = git_comp_words git_comp_cword
+	while [ $c -lt $git_comp_cword ]; do
+		i="${git_comp_words[c]}"
 		case "$i" in
 		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
 		--bare)      __git_dir="." ;;
@@ -2363,7 +2655,7 @@ _git ()
 	done
 
 	if [ -z "$command" ]; then
-		case "${COMP_WORDS[COMP_CWORD]}" in
+		case "${git_comp_words[git_comp_cword]}" in
 		--*)   __gitcomp "
 			--paginate
 			--no-pager
@@ -2401,12 +2693,13 @@ _gitk ()
 
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
-- 
1.7.3.2


-- 
Peter van der Does

GPG key: E77E8E98

IRC: Ganseki on irc.freenode.net
Twitter: @petervanderdoes
