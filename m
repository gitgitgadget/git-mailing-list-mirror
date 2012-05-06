From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v3] completion: add new _GIT_complete helper
Date: Sun, 6 May 2012 13:14:25 +0200
Message-ID: <20120506111425.GJ2164@goldbirke>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 13:14:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQzQD-0007v1-0X
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 13:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320Ab2EFLOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 07:14:32 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:54497 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301Ab2EFLOb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 07:14:31 -0400
Received: from localhost6.localdomain6 (p5B130CE2.dip0.t-ipconnect.de [91.19.12.226])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0Lpyfn-1RuvzB3uS7-00f0JY; Sun, 06 May 2012 13:14:27 +0200
Content-Disposition: inline
In-Reply-To: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:b2WMiWuIA/9rh8l8NlLGsbPR5U8Snk/3yigQjyvnrHV
 WcKSI6cLLvgdaHsXgZqxf6akAmOMYRM6eCSVN+GNOdgHiEgPXH
 6Z62ek9CGG3nKpWZx88kcoovV/U/55OQTSODudUbGJ7XLLQinm
 hxHCMNFJH4DCCIZ0GTKKWolQLR3uK2y+l7eXo+ToRKE2JAXHVY
 8ptEu3gwpAnB/vtVpBJ0FfJxwPHwzTyPr1lc7NQpC3/NW6mPAQ
 zSSPbVNKN76VKwll3SggD0MXuvTMpcmxYZewOV9QL3rVsY7G+O
 tJLaMBb/Yw8n/qbwu9nb5A/8CJpJBEGMStUJt2wpF/qOTvcRDG
 ojduhxs/vyOGrijPSlxE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197168>

Hi,


On Sat, May 05, 2012 at 05:23:20PM +0200, Felipe Contreras wrote:
> This simplifies the completions, and makes it easier to define aliases:
> 
>  _GIT_complete gf git_fetch

So, 'gf' is an alias for 'git fetch', for which the user would like to
use the completion for 'git fetch', right?  But that completion
function is caled _git_fetch(), so the underscore prefix is missing
here.

Besides, this example won't work, because the completion for 'git
fetch' uses __git_complete_remote_or_refspec(), which in turn relies
on finding out the name of the git command from the word on the
command line, and it won't be able to do that from 'gf'.

I remember we discussed this in an earlier round, and you even
suggested a possible fix (passing the command name as argument to
__git_complete_remote_or_refspec()).  I think that's the right thing
to do here.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> 
> Since v3:

_This_ is v3 ;)

>  * Rename to _GIT_complete to follow bash completion "guidelines"
>  * Get rid of foo_wrap name
> 
> Since v2:
> 
>  * Remove stuff related to aliases fixes; should work on top of master
> 
>  contrib/completion/git-completion.bash |   67 ++++++++++++++------------------
>  t/t9902-completion.sh                  |    2 +-
>  2 files changed, 31 insertions(+), 38 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 9f56ec7..f300b87 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash


> +__git_func_wrap ()

Good.

> +{
> +	if [[ -n ${ZSH_VERSION-} ]]; then
> +		emulate -L bash
> +		setopt KSH_TYPESET
> +
> +		# workaround zsh's bug that leaves 'words' as a special
> +		# variable in versions < 4.3.12
> +		typeset -h words
> +
> +		# workaround zsh's bug that quotes spaces in the COMPREPLY
> +		# array if IFS doesn't contain spaces.
> +		typeset -h IFS
> +	fi
> +	local cur words cword prev
> +	_get_comp_words_by_ref -n =: cur words cword prev
> +	__git_func "$@"

What is this "$@" for and why?  None of the _git_<cmd>() functions
take any arguments, nor does _git() and _gitk(), and AFAICT Bash won't
pass any either.

> +}
> +
> +_GIT_complete ()
> +{
> +	local name="${2-$1}"
> +	eval "$(typeset -f __git_func_wrap | sed -e "s/__git_func/_$name/")"

Still don't like the subshell and sed here ...

> +	complete -o bashdefault -o default -o nospace -F _${name}_wrap $1 2>/dev/null \
> +		|| complete -o default -o nospace -F _${name}_wrap $1
> +}
> +
> +_GIT_complete git
> +_GIT_complete gitk

... because it adds delay when the completion script is loaded.  But I
still don't have ideas how to avoid them.
