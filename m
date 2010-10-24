From: Peter van der Does <peter@avirtualhome.com>
Subject: Re: [completion] Request: Include remote heads as push targets
Date: Sat, 23 Oct 2010 20:07:39 -0400
Message-ID: <20101023200739.28b6eb1e@montecarlo.grandprix.int>
References: <4CC05E4B.1010106@xiplink.com>
	<4CC06439.8040003@xiplink.com>
	<20101021191045.GC11759@burratino>
	<20101021210842.6545a661@montecarlo.grandprix.int>
	<20101023130434.GA29386@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: SZEDER =?ISO-8859-1?B?R+Fib3I=?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Oct 24 02:08:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9o8G-0006St-6W
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 02:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758457Ab0JXAHv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 20:07:51 -0400
Received: from morn.lunarbreeze.com ([216.227.218.220]:50142 "EHLO
	morn.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758237Ab0JXAHu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Oct 2010 20:07:50 -0400
Received: from c-69-248-103-68.hsd1.nj.comcast.net ([69.248.103.68] helo=monza.grandprix.int)
	by morn.lunarbreeze.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@avirtualhome.com>)
	id 1P9o7i-0002tP-Ha; Sat, 23 Oct 2010 17:07:42 -0700
Received: from montecarlo.grandprix.int (montecarlo.grandprix.int [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id 1D81D101F82;
	Sat, 23 Oct 2010 20:07:40 -0400 (EDT)
In-Reply-To: <20101023130434.GA29386@neumann>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159832>

On Sat, 23 Oct 2010 15:04:34 +0200
SZEDER G=E1bor <szeder@ira.uka.de> wrote:


> Here is a proof of concept patch to use that function instead of
> ${COMP_WORDS[COMP_CWORD]} in two places.  The second hunk fixes the
> completion of pretty aliases for 'git log --pretty=3D'.  The first hu=
nk
> seems to fix Marc's issue with the completion of remotes after 'git
> push origin HEAD:', but I haven't thought this one through (there's a
> lot going on with scanning the previous words on the command line and
> such, so it might actually break something else).  Both fixes seem to
> work under bash 4 and 3.2.
>=20
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash index f83f019..5608e9b 10075=
5
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -551,7 +551,8 @@ __git_complete_revlist ()
>  __git_complete_remote_or_refspec ()
>  {
>  	local cmd=3D"${COMP_WORDS[1]}"
> -	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
> +	local cur
> +	_get_comp_words_by_ref -n ':' cur
>  	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
>  	while [ $c -lt $COMP_CWORD ]; do
>  		i=3D"${COMP_WORDS[c]}"
> @@ -1360,7 +1361,8 @@ _git_log ()
>  {
>  	__git_has_doubledash && return
> =20
> -	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
> +	local cur
> +	_get_comp_words_by_ref -n '=3D' cur
>  	local g=3D"$(git rev-parse --git-dir 2>/dev/null)"
>  	local merge=3D""
>  	if [ -f "$g/MERGE_HEAD" ]; then
>=20
> This patch assumes that you use fairly recent bash-completion, becaus=
e
> _get_comp_words_by_ref() was first included in bash-completion v1.2,
> which was released just this summer.
>=20
> However, git completion is currently a standalone completion script,
> i.e. to use it you need only bash, git-completion.bash, and nothing
> else.  If we start to use _get_comp_words_by_ref() directly, as in th=
e
> PoC patch above, then git completion will inherently depend on
> bash-completion, too.  This could be considered as a regression.
>=20
> Alternatively, we could just copy the necessary functions from
> bash-completion to git-completion.bash (with the name changed, of
> course, e.g. to __git_get_comp_words_by_ref()), keeping git completio=
n
> standalone but still getting the benefits of this function, and
> getting these bash 4 vs. 3 issues fixed.
>=20
> Thoughts?
>=20

Instead of using [code]_get_comp_words_by_ref -n '=3D' cur[/code] you c=
an
use [code]local cur=3D`_get_cword "=3D"`[/code].

To keep git completion standalone we need to, like G=E1bor mentioned, a=
dd
the necessary functions, but we don't have to rename them. There is
an option to check if a function exists. I've changed the entire git
completion script and hopefully covered all options. From my tests it
works on bash 4.

To give an idea of what the change is, here's part of the entire diff.

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash index f83f019..a2c0589 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -71,12 +71,159 @@
 #
 #       git@vger.kernel.org
 #
+# Updated for Bash 4.0
=20
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
 *)   COMP_WORDBREAKS=3D"$COMP_WORDBREAKS:"
 esac
=20
+# If the function _get_cword does not exists, we can assume the
+# bash_completion script isn't loaded and therefor we're defining the
+# necessary functions ourselves.
+if ! type _get_cword &> /dev/null ; then
+	# features supported by bash 4.0 and higher
+	if [ ${BASH_VERSINFO[0]} -gt 3 ]; then
+	    declare -r git_bash4=3D$BASH_VERSION 2>/dev/null || :
+	fi
+
+	# Get the word to complete.
+	# This is nicer than ${COMP_WORDS[$COMP_CWORD]}, since it
handles cases
+	# where the user is completing in the middle of a word.
+	# (For example, if the line is "ls foobar",
+	# and the cursor is here -------->   ^
+	# it will complete just "foo", not "foobar", which is what the
user wants.)
+	# @param $1 string  (optional) Characters out of
$COMP_WORDBREAKS which should
+	#     NOT be considered word breaks. This is useful for things
like scp where
+	#     we want to return host:path and not only path.
+	#     NOTE: This parameter only applies to bash-4.
+	_get_cword()
+	{
+    	if [ -n "$git_bash4" ] ; then
+        	__get_cword4 "$@"
+    	else
+        	__get_cword3
+    	fi
+	} # _get_cword()
+
+
+	# Get the word to complete on bash-3, where words are not
broken by
+	# COMP_WORDBREAKS characters and the COMP_CWORD variables look
like this, for
+	# example:
+	#
+	#     $ a b:c<TAB>
+	#     COMP_CWORD: 1
+	#     COMP_CWORDS:
+	#     0: a
+	#     1: b:c
+	#
+	# See also:
+	# _get_cword, main routine
+	# __get_cword4, bash-4 variant
+	#
+	__get_cword3()
+	{
+	    if [[ "${#COMP_WORDS[COMP_CWORD]}" -eq 0 ]] ||
[[ "$COMP_POINT" =3D=3D "${#COMP_LINE}" ]]; then
+        	printf "%s" "${COMP_WORDS[COMP_CWORD]}"
+    	else
+	        local i
+        	local cur=3D"$COMP_LINE"
+        	local index=3D"$COMP_POINT"
+        	for (( i =3D 0; i <=3D COMP_CWORD; ++i )); do
+	            while [[
+                	# Current COMP_WORD fits in $cur?
+                	"${#cur}" -ge ${#COMP_WORDS[i]} &&
+                	# $cur doesn't match COMP_WORD?
+                	"${cur:0:${#COMP_WORDS[i]}}" !=3D
"${COMP_WORDS[i]}"
+                	]]; do
+                	# Strip first character
+                	cur=3D"${cur:1}"
+                	# Decrease cursor position
+                	index=3D"$(( index - 1 ))"
+            	done
+=09
+            	# Does found COMP_WORD matches COMP_CWORD?
+            	if [[ "$i" -lt "$COMP_CWORD" ]]; then
+	                # No, COMP_CWORD lies further;
+                	local old_size=3D"${#cur}"
+                	cur=3D"${cur#${COMP_WORDS[i]}}"
+                	local new_size=3D"${#cur}"
+                	index=3D"$(( index - old_size + new_size ))"
+            	fi
+        	done
+
+	        if [[ "${COMP_WORDS[COMP_CWORD]:0:${#cur}}" !=3D
"$cur" ]]; then
+            	# We messed up! At least return the whole word so
things
+            	# keep working
+            	printf "%s" "${COMP_WORDS[COMP_CWORD]}"
+        	else
+	            printf "%s" "${cur:0:$index}"
+        	fi
+    	fi
+	} # __get_cword3()
+
+
+	# Get the word to complete on bash-4, where words are splitted
by
+	# COMP_WORDBREAKS characters (default is " \t\n\"'><=3D;|&(:")
and the COMP_CWORD
+	# variables look like this, for example:
+	#
+	#     $ a b:c<TAB>
+	#     COMP_CWORD: 3
+	#     COMP_CWORDS:
+	#     0: a
+	#     1: b
+	#     2: :
+	#     3: c
+	#
+	# @oaram $1 string
+	# $1 string  (optional) Characters out of $COMP_WORDBREAKS
which should
+	#     NOT be considered word breaks. This is useful for things
like scp where
+	#     we want to return host:path and not only path.
+	# See also:
+	# _get_cword, main routine
+	# __get_cword3, bash-3 variant
+	#
+	__get_cword4()
+	{
+	    local i
+	    local LC_CTYPE=3DC
+	    local WORDBREAKS=3D$COMP_WORDBREAKS
+	    # Strip single quote (') and double quote (") from
WORDBREAKS to
+	    # workaround a bug in bash-4.0, where quoted words are
split
+	    # unintended, see:
+	    #
http://www.mail-archive.com/bug-bash@gnu.org/msg06095.html
+	    # This fixes simple quoting (e.g. $ a "b<TAB> returns "b
instead of b)
+	    # but still fails quoted spaces (e.g. $ a "b c<TAB>
returns c instead
+	    # of "b c).
+	    WORDBREAKS=3D${WORDBREAKS//\"/}
+	    WORDBREAKS=3D${WORDBREAKS//\'/}
+	    if [ -n "$1" ]; then
+        	for (( i=3D0; i<${#1}; ++i )); do
+	            local char=3D${1:$i:1}
+            	WORDBREAKS=3D${WORDBREAKS//$char/}
+        	done
+    	fi
+    	local cur=3D${COMP_LINE:0:$COMP_POINT}
+    	local tmp=3D$cur
+    	local word_start=3D`expr "$tmp" : '.*['"$WORDBREAKS"']'`
+    	while [ "$word_start" -ge 2 ]; do
+	        # Get character before $word_start
+        	local char=3D${cur:$(( $word_start - 2 )):1}
+        	# If the WORDBREAK character isn't escaped, exit loop
+        	if [ "$char" !=3D "\\" ]; then
+	            break
+        	fi
+        	# The WORDBREAK character is escaped;
+        	# Recalculate $word_start
+        	tmp=3D${COMP_LINE:0:$(( $word_start - 2 ))}
+        	word_start=3D`expr "$tmp" : '.*['"$WORDBREAKS"']'`
+    	done
+
+	    cur=3D${cur:$word_start}
+	    printf "%s" "$cur"
+	} # __get_cword4()
+fi
+
@@ -551,7 +698,7 @@ __git_complete_revlist ()
 __git_complete_remote_or_refspec ()
 {
 	local cmd=3D"${COMP_WORDS[1]}"
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur=3D`_get_cword ":"`
 	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
 	while [ $c -lt $COMP_CWORD ]; do
 		i=3D"${COMP_WORDS[c]}"
@@ -1360,7 +1508,7 @@ _git_log ()
 {
 	__git_has_doubledash && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur=3D`_get_cword "=3D"`
 	local g=3D"$(git rev-parse --git-dir 2>/dev/null)"
 	local merge=3D""
 	if [ -f "$g/MERGE_HEAD" ]; then
@@ -1419,7 +1567,7 @@ _git_merge ()
 {
 	__git_complete_strategy && return
=20
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	local cur=3D`_get_cword`
 	case "$cur" in
 	--*)
 		__gitcomp "$__git_merge_options"


I just need someone to test the new script on Bash 3. If somebody is
willing to test, drop me an private email and I can send the new script=
=2E

Peter

--=20
GPG key: E77E8E98

IRC: Ganseki on irc.freenode.net
Twitter: @petervanderdoes

WordPress Plugin Developer
Blog: http://blog.avirtualhome.com
=46orums: http://forums.avirtualhome.com
Twitter: @avhsoftware
