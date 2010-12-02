From: Peter van der Does <peter@avirtualhome.com>
Subject: [PATCH v5 1/2] Introduce functions from bash-completion project.
Date: Wed,  1 Dec 2010 19:40:43 -0500
Message-ID: <1291250444-1832-2-git-send-email-peter@avirtualhome.com>
References: <1291250444-1832-1-git-send-email-peter@avirtualhome.com>
Cc: Peter van der Does <peter@avirtualhome.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 02 01:41:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNxEf-0003Bi-MO
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 01:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743Ab0LBAlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 19:41:05 -0500
Received: from morn.lunarbreeze.com ([216.227.218.220]:43370 "EHLO
	morn.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab0LBAlD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 19:41:03 -0500
Received: from c-69-248-93-14.hsd1.nj.comcast.net ([69.248.93.14] helo=monza.grandprix.int)
	by morn.lunarbreeze.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@avirtualhome.com>)
	id 1PNxEL-0006kG-CS; Wed, 01 Dec 2010 16:41:01 -0800
Received: from MonteCarlo.grandprix.int. (montecarlo.grandprix.int [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id 1F14BD79EF;
	Wed,  1 Dec 2010 19:40:59 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1291250444-1832-1-git-send-email-peter@avirtualhome.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162656>

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

With Bash 4 the way word breaking is done in the programmable completion
code has changed. The documentation at the bash project is not very
clear what was changed, the only reference found is in the NEWS section:

i.  The programmable completion code now uses the same set of characters
as readline when breaking the command line into a list of words.

The word breaking problem occurs with certain characters, like colon and
equal sign.

The bash-completion project (http://bash-completion.alioth.debian.org/)
has written several functions to overcome this problem. By using these
functions within the git-completion.bash script the word breaking
problem is solved.

Signed-off-by: Peter van der Does <peter@avirtualhome.com>
---
 contrib/completion/git-completion.bash |  223 ++++++++++++++++++++++++++++++++
 1 files changed, 223 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f710469..0036e8b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -82,6 +82,229 @@ case "$COMP_WORDBREAKS" in
 *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
 esac
 
+# If the function _get_comp_words_by_ref does not exists, we can assume the
+# bash_completion 1.2 script isn't loaded and therefor we're defining the
+# necessary functions ourselves.
+# The functions come from the bash_completion 1.2 script.
+# See: http://bash-completion.alioth.debian.org/
+if ! type _get_comp_words_by_ref &> /dev/null ; then
+	# The bash_completion 1.2 library wasn't loaded,
+	# we have to define some functions from it ourselves.
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
-- 
1.7.3.2
