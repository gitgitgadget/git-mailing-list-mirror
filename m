From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2/RFC] Make git-completion Bash 4 compatible.
Date: Thu, 28 Oct 2010 00:39:18 +0200
Message-ID: <20101027223918.GA1877@neumann>
References: <20101027131506.4da06c6d@MonteCarlo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 00:39:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBEeV-0006k3-V9
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 00:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171Ab0J0WjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 18:39:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:61470 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763Ab0J0WjW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 18:39:22 -0400
Received: from localhost6.localdomain6 (p5B130C1E.dip0.t-ipconnect.de [91.19.12.30])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0LsMbE-1OQvZH0h56-0122eP; Thu, 28 Oct 2010 00:39:19 +0200
Content-Disposition: inline
In-Reply-To: <20101027131506.4da06c6d@MonteCarlo>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:+k6KtM7CoU3LhjI+GNzfjLQPQrCardNkf/RxoLCmrk4
 GxwsPltJxhdRtFNT0ykIbmhRkQRqP1XFoR8f3XjXw9TzgpqnkD
 NaDPgkrX/u4gwq1DFgwfVttIRoCqmZlin5f5mGfYEdVMYSzzWj
 v8FQfjOPS4lP8tTGY0rCfs398Q211CQLNDUvBmg0ZBLeOdcJn9
 BvACJ0DnwS3+8SBJ7IAgg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160134>

Hi,

On Wed, Oct 27, 2010 at 01:15:06PM -0400, Peter van der Does wrote:
> The completion script does not work as expected under Bash 4.

Thank you.  I applied your patch to play around a bit, and it seems to
work (but, of course, I have not tried all the affected commands).

I agree with the comments and suggestiong of Brian and Jonathan.  The
current commit message covers only the symptoms of a bug this patch
attempts to fix, but it should also explain its cause and how the
patch is supposed to fix it.  Unfortunately, I can only comment on the
latter: if these new functions are good enough for the folks over at
bash-completion project, then they should be good enough for us (;

I'm still puzzled that the only relevant entry I could find in the
bash NEWS file is:

i.  The programmable completion code now uses the same set of characters as
    readline when breaking the command line into a list of words.

Yet, as I mentioned in one of the previous threads, I have two
machines with different bash versions (3.2 and 4.1) but with the exact
same set of characters in COMP_WORDBREAKS, and they show different
behavior.

> Bash: 3
> output:
> $ git log --pretty=<tab><tab>
> email     full      medium    raw
> format:   fuller    oneline   short
> 
> Bash: 4
> output:
> $ git log --pretty=<tab><tab>
> .bash_logout         .local/
> .bash_profile        Music/
> --More--
> 
> Signed-off-by: Peter van der Does <peter@avirtualhome.com>


> @@ -556,11 +799,14 @@ __git_complete_revlist ()
>  
>  __git_complete_remote_or_refspec ()
>  {
> -	local cmd="${COMP_WORDS[1]}"
> -	local cur="${COMP_WORDS[COMP_CWORD]}"
> +	local git_comp_words git_comp_cword
> +	__reassemble_comp_words_by_ref : git_comp_words git_comp_cword

I suggest using '_get_comp_words_by_ref -n ":" words cword' here.
First, for consistency's sake, because you use
_get_comp_words_by_ref() everywhere else, too (almost).  Second, I'm
worried about the double underscore prefix in the function name,
because it usually indicates something that is not supposed to be used
directly from outside.  Even the bash-completion project's scripts
prefer _get_comp_words_by_ref() to __reassemble_comp_words_by_ref().
And third, ...

> +	local cmd="${git_comp_words[1]}"
> +	local cur
>  	local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0
> -	while [ $c -lt $COMP_CWORD ]; do
> -		i="${COMP_WORDS[c]}"
> +	_get_comp_words_by_ref -n ":" cur

... you could then join this _get_comp_words_by_ref() invocation with
the one above.

> +	while [ $c -lt $git_comp_cword ]; do
> +		i="${git_comp_words[c]}"
>  		case "$i" in
>  		--mirror) [ "$cmd" = "push" ] && no_complete_refspec=1 ;;
>  		--all)


> @@ -824,7 +1072,10 @@ __git_whitespacelist="nowarn warn error error-all fix"
>  
>  _git_am ()
>  {
> -	local cur="${COMP_WORDS[COMP_CWORD]}" dir="$(__gitdir)"
> +	local cur
> +	local dir="$(__gitdir)"

You could keep the two declarations in a single line.

> +
> +	_get_comp_words_by_ref -n "=" cur
>  	if [ -d "$dir"/rebase-apply ]; then
>  		__gitcomp "--skip --continue --resolved --abort"
>  		return


> @@ -929,7 +1183,8 @@ _git_bisect ()
>  
>  _git_branch ()
>  {
> -	local i c=1 only_local_ref="n" has_r="n"
> +	local i c=1 only_local_ref="n" has_r="n", cur

The comma before "cur" shouldn't be there.

> +	_get_comp_words_by_ref cur
>  
>  	while [ $c -lt $COMP_CWORD ]; do
>  		i="${COMP_WORDS[c]}"

Hmph.

I don't think there is anything that could go wrong here with respect
to word breaking, but at least for consistency's sake you could query
for words and cword, too, and use ${words[cword]} here.


> @@ -1006,7 +1262,8 @@ _git_cherry ()
>  
>  _git_cherry_pick ()
>  {
> -	local cur="${COMP_WORDS[COMP_CWORD]}"
> +	local cur
> +_get_comp_words_by_ref cur

Missing indentation.

>  	case "$cur" in
>  	--*)
>  		__gitcomp "--edit --no-commit"


> @@ -1606,9 +1886,11 @@ _git_stage ()
>  
>  __git_config_get_set_variables ()
>  {
> -	local prevword word config_file= c=$COMP_CWORD
> +	local prevword word config_file= c
> +	local git_comp_words
> +	__reassemble_comp_words_by_ref = git_comp_words c

Use _get_comp_words_by_ref() instead.

>  	while [ $c -gt 1 ]; do
> -		word="${COMP_WORDS[c]}"
> +		word="${git_comp_words[c]}"
>  		case "$word" in
>  		--global|--system|--file=*)
>  			config_file="$word"


> @@ -2045,7 +2327,8 @@ _git_reset ()
>  {
>  	__git_has_doubledash && return
>  
> -	local cur="${COMP_WORDS[COMP_CWORD]}"
> +	local cur
> +_get_comp_words_by_ref cur

Missing indentation.

>  	case "$cur" in
>  	--*)
>  		__gitcomp "--merge --mixed --hard --soft --patch"


> @@ -2343,15 +2634,16 @@ _git_whatchanged ()
>  
>  _git ()
>  {
> -	local i c=1 command __git_dir
> +	local i c=1 command __git_dir git_comp_words git_comp_cword
>  
>  	if [[ -n $ZSH_VERSION ]]; then
>  		emulate -L bash
>  		setopt KSH_TYPESET
>  	fi
>  
> -	while [ $c -lt $COMP_CWORD ]; do
> -		i="${COMP_WORDS[c]}"
> +	__reassemble_comp_words_by_ref = git_comp_words git_comp_cword

Use _get_comp_words_by_ref() instead.

> +	while [ $c -lt $git_comp_cword ]; do
> +		i="${git_comp_words[c]}"
>  		case "$i" in
>  		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
>  		--bare)      __git_dir="." ;;
