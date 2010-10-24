From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [completion] Request: Include remote heads as push targets
Date: Sun, 24 Oct 2010 13:23:26 +0200
Message-ID: <20101024112325.GB29386@neumann>
References: <4CC05E4B.1010106@xiplink.com> <4CC06439.8040003@xiplink.com>
	<20101021191045.GC11759@burratino>
	<20101021210842.6545a661@montecarlo.grandprix.int>
	<20101023130434.GA29386@neumann>
	<20101023200739.28b6eb1e@montecarlo.grandprix.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Sun Oct 24 13:23:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9yfv-0005nC-MU
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 13:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504Ab0JXLXg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Oct 2010 07:23:36 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:53698 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932497Ab0JXLXe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 07:23:34 -0400
Received: from localhost6.localdomain6 (p5B1306E9.dip0.t-ipconnect.de [91.19.6.233])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MN728-1PGZJX17X6-006ubw; Sun, 24 Oct 2010 13:23:28 +0200
Content-Disposition: inline
In-Reply-To: <20101023200739.28b6eb1e@montecarlo.grandprix.int>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:2LZ7b3d352E5d3A7204D0nawpHuw8Fb3YbeyrvlAo+7
 Wo7o2iYDCYfl4FXTRtZfOGu38PaQVtPWoKHhOVCldfTJr46Mpp
 tcYAsrFepcInuSVzPzTX1qxjOTp3M0L1Fz+qjCt3hW09t123ij
 dKb7mIePamlW4G/kaqEjim0xh+GQUnKKTDj3DCQQ7iaxsVLYJc
 1HPoioNuOOHifcTGUvRKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159854>

On Sat, Oct 23, 2010 at 08:07:39PM -0400, Peter van der Does wrote:
> On Sat, 23 Oct 2010 15:04:34 +0200
> SZEDER G=E1bor <szeder@ira.uka.de> wrote:
>
> > This patch assumes that you use fairly recent bash-completion, beca=
use
> > _get_comp_words_by_ref() was first included in bash-completion v1.2=
,
> > which was released just this summer.
> >=20
> > However, git completion is currently a standalone completion script=
,
> > i.e. to use it you need only bash, git-completion.bash, and nothing
> > else.  If we start to use _get_comp_words_by_ref() directly, as in =
the
> > PoC patch above, then git completion will inherently depend on
> > bash-completion, too.  This could be considered as a regression.
> >=20
> > Alternatively, we could just copy the necessary functions from
> > bash-completion to git-completion.bash (with the name changed, of
> > course, e.g. to __git_get_comp_words_by_ref()), keeping git complet=
ion
> > standalone but still getting the benefits of this function, and
> > getting these bash 4 vs. 3 issues fixed.
> >=20
> > Thoughts?
> >=20
>=20
> Instead of using [code]_get_comp_words_by_ref -n '=3D' cur[/code] you=
 can
> use [code]local cur=3D`_get_cword "=3D"`[/code].
>=20
> To keep git completion standalone we need to, like G=E1bor mentioned,=
 add
> the necessary functions, but we don't have to rename them. There is
> an option to check if a function exists. I've changed the entire git
> completion script and hopefully covered all options. From my tests it
> works on bash 4.

Checking for the function first, and declaring it if it doesn't exists
could be a viewable alternative, but not with _get_cword().  The
_get_cword() implementation you are adding below is outdated.  It is
from bash-completion 1.1, changed quite a bit after that, and in the
end became deprecated in 1.2 in favor of _get_comp_words_by_ref().


> To give an idea of what the change is, here's part of the entire diff=
=2E
>=20
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash index f83f019..a2c0589 10075=
5
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -71,12 +71,159 @@
>  #
>  #       git@vger.kernel.org
>  #
> +# Updated for Bash 4.0
> =20
>  case "$COMP_WORDBREAKS" in
>  *:*) : great ;;
>  *)   COMP_WORDBREAKS=3D"$COMP_WORDBREAKS:"
>  esac
> =20
> +# If the function _get_cword does not exists, we can assume the
> +# bash_completion script isn't loaded and therefor we're defining th=
e
> +# necessary functions ourselves.
> +if ! type _get_cword &> /dev/null ; then
> +	# features supported by bash 4.0 and higher
> +	if [ ${BASH_VERSINFO[0]} -gt 3 ]; then
> +	    declare -r git_bash4=3D$BASH_VERSION 2>/dev/null || :
> +	fi
> +
> +	# Get the word to complete.
> +	# This is nicer than ${COMP_WORDS[$COMP_CWORD]}, since it
> handles cases
> +	# where the user is completing in the middle of a word.
> +	# (For example, if the line is "ls foobar",
> +	# and the cursor is here -------->   ^
> +	# it will complete just "foo", not "foobar", which is what the
> user wants.)
> +	# @param $1 string  (optional) Characters out of
> $COMP_WORDBREAKS which should
> +	#     NOT be considered word breaks. This is useful for things
> like scp where
> +	#     we want to return host:path and not only path.
> +	#     NOTE: This parameter only applies to bash-4.
> +	_get_cword()
> +	{
> +    	if [ -n "$git_bash4" ] ; then
> +        	__get_cword4 "$@"
> +    	else
> +        	__get_cword3
> +    	fi
> +	} # _get_cword()
> +
> +
> +	# Get the word to complete on bash-3, where words are not
> broken by
> +	# COMP_WORDBREAKS characters and the COMP_CWORD variables look
> like this, for
> +	# example:
> +	#
> +	#     $ a b:c<TAB>
> +	#     COMP_CWORD: 1
> +	#     COMP_CWORDS:
> +	#     0: a
> +	#     1: b:c
> +	#
> +	# See also:
> +	# _get_cword, main routine
> +	# __get_cword4, bash-4 variant
> +	#
> +	__get_cword3()
> +	{
> +	    if [[ "${#COMP_WORDS[COMP_CWORD]}" -eq 0 ]] ||
> [[ "$COMP_POINT" =3D=3D "${#COMP_LINE}" ]]; then
> +        	printf "%s" "${COMP_WORDS[COMP_CWORD]}"
> +    	else
> +	        local i
> +        	local cur=3D"$COMP_LINE"
> +        	local index=3D"$COMP_POINT"
> +        	for (( i =3D 0; i <=3D COMP_CWORD; ++i )); do
> +	            while [[
> +                	# Current COMP_WORD fits in $cur?
> +                	"${#cur}" -ge ${#COMP_WORDS[i]} &&
> +                	# $cur doesn't match COMP_WORD?
> +                	"${cur:0:${#COMP_WORDS[i]}}" !=3D
> "${COMP_WORDS[i]}"
> +                	]]; do
> +                	# Strip first character
> +                	cur=3D"${cur:1}"
> +                	# Decrease cursor position
> +                	index=3D"$(( index - 1 ))"
> +            	done
> +=09
> +            	# Does found COMP_WORD matches COMP_CWORD?
> +            	if [[ "$i" -lt "$COMP_CWORD" ]]; then
> +	                # No, COMP_CWORD lies further;
> +                	local old_size=3D"${#cur}"
> +                	cur=3D"${cur#${COMP_WORDS[i]}}"
> +                	local new_size=3D"${#cur}"
> +                	index=3D"$(( index - old_size + new_size ))"
> +            	fi
> +        	done
> +
> +	        if [[ "${COMP_WORDS[COMP_CWORD]:0:${#cur}}" !=3D
> "$cur" ]]; then
> +            	# We messed up! At least return the whole word so
> things
> +            	# keep working
> +            	printf "%s" "${COMP_WORDS[COMP_CWORD]}"
> +        	else
> +	            printf "%s" "${cur:0:$index}"
> +        	fi
> +    	fi
> +	} # __get_cword3()
> +
> +
> +	# Get the word to complete on bash-4, where words are splitted
> by
> +	# COMP_WORDBREAKS characters (default is " \t\n\"'><=3D;|&(:")
> and the COMP_CWORD
> +	# variables look like this, for example:
> +	#
> +	#     $ a b:c<TAB>
> +	#     COMP_CWORD: 3
> +	#     COMP_CWORDS:
> +	#     0: a
> +	#     1: b
> +	#     2: :
> +	#     3: c
> +	#
> +	# @oaram $1 string
> +	# $1 string  (optional) Characters out of $COMP_WORDBREAKS
> which should
> +	#     NOT be considered word breaks. This is useful for things
> like scp where
> +	#     we want to return host:path and not only path.
> +	# See also:
> +	# _get_cword, main routine
> +	# __get_cword3, bash-3 variant
> +	#
> +	__get_cword4()
> +	{
> +	    local i
> +	    local LC_CTYPE=3DC
> +	    local WORDBREAKS=3D$COMP_WORDBREAKS
> +	    # Strip single quote (') and double quote (") from
> WORDBREAKS to
> +	    # workaround a bug in bash-4.0, where quoted words are
> split
> +	    # unintended, see:
> +	    #
> http://www.mail-archive.com/bug-bash@gnu.org/msg06095.html
> +	    # This fixes simple quoting (e.g. $ a "b<TAB> returns "b
> instead of b)
> +	    # but still fails quoted spaces (e.g. $ a "b c<TAB>
> returns c instead
> +	    # of "b c).
> +	    WORDBREAKS=3D${WORDBREAKS//\"/}
> +	    WORDBREAKS=3D${WORDBREAKS//\'/}
> +	    if [ -n "$1" ]; then
> +        	for (( i=3D0; i<${#1}; ++i )); do
> +	            local char=3D${1:$i:1}
> +            	WORDBREAKS=3D${WORDBREAKS//$char/}
> +        	done
> +    	fi
> +    	local cur=3D${COMP_LINE:0:$COMP_POINT}
> +    	local tmp=3D$cur
> +    	local word_start=3D`expr "$tmp" : '.*['"$WORDBREAKS"']'`
> +    	while [ "$word_start" -ge 2 ]; do
> +	        # Get character before $word_start
> +        	local char=3D${cur:$(( $word_start - 2 )):1}
> +        	# If the WORDBREAK character isn't escaped, exit loop
> +        	if [ "$char" !=3D "\\" ]; then
> +	            break
> +        	fi
> +        	# The WORDBREAK character is escaped;
> +        	# Recalculate $word_start
> +        	tmp=3D${COMP_LINE:0:$(( $word_start - 2 ))}
> +        	word_start=3D`expr "$tmp" : '.*['"$WORDBREAKS"']'`
> +    	done
> +
> +	    cur=3D${cur:$word_start}
> +	    printf "%s" "$cur"
> +	} # __get_cword4()
> +fi
> +
> @@ -551,7 +698,7 @@ __git_complete_revlist ()
>  __git_complete_remote_or_refspec ()
>  {
>  	local cmd=3D"${COMP_WORDS[1]}"
> -	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
> +	local cur=3D`_get_cword ":"`
>  	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
>  	while [ $c -lt $COMP_CWORD ]; do
>  		i=3D"${COMP_WORDS[c]}"
> @@ -1360,7 +1508,7 @@ _git_log ()
>  {
>  	__git_has_doubledash && return
> =20
> -	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
> +	local cur=3D`_get_cword "=3D"`
>  	local g=3D"$(git rev-parse --git-dir 2>/dev/null)"
>  	local merge=3D""
>  	if [ -f "$g/MERGE_HEAD" ]; then
> @@ -1419,7 +1567,7 @@ _git_merge ()
>  {
>  	__git_complete_strategy && return
> =20
> -	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
> +	local cur=3D`_get_cword`
>  	case "$cur" in
>  	--*)
>  		__gitcomp "$__git_merge_options"
>=20
>=20
> I just need someone to test the new script on Bash 3. If somebody is
> willing to test, drop me an private email and I can send the new scri=
pt.
>=20
