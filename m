From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC/PATCH v4 1/6] completion: add new __git_complete helper
Date: Mon, 7 May 2012 11:51:45 +0200
Message-ID: <20120507095145.GP2164@goldbirke>
References: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
	<1336353800-17323-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 11:52:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRKcO-0006NG-8E
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 11:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021Ab2EGJwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 05:52:32 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:50780 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668Ab2EGJwb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 05:52:31 -0400
Received: from localhost6.localdomain6 (p5B13051B.dip0.t-ipconnect.de [91.19.5.27])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0M3MGG-1S9fGM2mTA-00rQUz; Mon, 07 May 2012 11:51:47 +0200
Content-Disposition: inline
In-Reply-To: <1336353800-17323-2-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:4OJAmZ1OUjhsEUOM9oBlX2DW5EiJ2Uji21rY8gGiytx
 iNrB74dgMrf49YkLETQvsIQvxk1ODy9o0oekDc6fYyIv1lX3NJ
 v6KJZv+BhKd+tsUJlPj1yCrcXfF/6WLV+b0lCmK8EXEWcOeKtF
 lgaPfI3Bq9Sj9QOoXoFeYbsDRhCYrIQF76cVzampL5woLqhjr5
 La+Zu+aejXxrLUMMbDsy0HixQUfcaxpfAWyzUX8Bxix37Lkhfm
 IcxLom5t++xVOZQRbTTb2oFJrb0V2QyWtPu1nV4ODEZh9sfCuW
 F9B5404z0cou78BQiYDJwXfoAtaNhhYMS6xyAlZa0HWCRK+/uC
 MgnTM2p4nJJkyIviPnWw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197252>

Hi,

On Mon, May 07, 2012 at 03:23:15AM +0200, Felipe Contreras wrote:
> +__git_func_wrap ()
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
> +	_$1
> +}
> +
> +# this is NOT a public function; use at your own risk
> +__git_complete ()
> +{
> +	local name="${2-$1}"

Please add the underscore prefix here right away, so we don't need
that "_$1" above in __git_func_wrap().

There is still no documentation about the parameters of
__git_complete(), so...

It seems to set up completion for the command given as first argument
to invoke the completion function given as second argument, right?
But the completion function argument is optional, and if it's not
specified, its name is derived from the command name by adding an
underscore prefix (in __git_func_wrap()).  So, in case of 'git', $name
becomes 'git', hence the completion function to be invoked is _git().
So far so good.

> +	local wrapper="_${name}_wrap"

But then the wrapper function becomes _git_wrap().  Uh, oh.

> +	eval "$wrapper () { __git_func_wrap $name ; }"

... because this would then define the function _git_wrap(), which is
not good, because that's supposed to be the completion function for
the 'git wrap' command.

That's exactly why I wrote

  local wrapper="__git_wrap_$1"

in my earlier post, and it was not an unnecessary change that could be
simplified away.


> +	complete -o bashdefault -o default -o nospace -F $wrapper $1 2>/dev/null \
> +		|| complete -o default -o nospace -F $wrapper $1
> +}
> +
> +__git_complete git
> +__git_complete gitk
>  
>  # The following are necessary only for Cygwin, and only are needed
>  # when the user has tab-completed the executable name and consequently
>  # included the '.exe' suffix.
>  #
>  if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
> -complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/null \
> -	|| complete -o default -o nospace -F _git git.exe
> +__git_complete git.exe git
>  fi
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 5bda6b6..331a5b9 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -63,7 +63,7 @@ run_completion ()
>  	local _cword
>  	_words=( $1 )
>  	(( _cword = ${#_words[@]} - 1 ))
> -	_git && print_comp
> +	_git_wrap && print_comp
>  }
>  
>  test_completion ()
> -- 
> 1.7.10
> 
