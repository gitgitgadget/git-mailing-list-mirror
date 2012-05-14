From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] completion: add new __git_complete helper
Date: Mon, 14 May 2012 10:43:00 -0700
Message-ID: <7vvcjyhd5n.fsf@alter.siamese.dyndns.org>
References: <1337009718-1164-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 19:43:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STzIh-0008Nn-8E
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 19:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757065Ab2ENRnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 13:43:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60188 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755197Ab2ENRnI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 13:43:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E242A828C;
	Mon, 14 May 2012 13:43:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L6DJrF0/Msvg4dWhZSO+XqymDGA=; b=k6qvx/
	Dl4tFMqX3Xkty6jSHva3AZafW0M0Uc55cv1nd2i+L3Wd5wpNMnXC5DA0N2ni3xYX
	uJTdxZRAJUwHYnT8B8152e4Qg+h7fFow+Y8bUV9ynrRd4u+pvbZl5ou5gwhf4LHU
	jG2VQqPabUjV4ir3Zx/Lc+xYO788ZxKuqMUFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uxAlM8bteZaanqMVU/eQClr4rx25c9Hw
	yN20be19PlJ7Ohjdco4Myy9ADd+scYDdywADsfhg14C+kFLbUyTXZocKZcmh3kqV
	yeMZA8H+KkGqBk58arHFF1/XewSknTHHZrQPY+vlJ8VdpXQvtUd5efF03LLhL1zd
	Z/frhSwYFYU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D87FC828B;
	Mon, 14 May 2012 13:43:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A98B828A; Mon, 14 May 2012
 13:43:03 -0400 (EDT)
In-Reply-To: <1337009718-1164-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Mon, 14 May 2012 17:35:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4160B220-9DEC-11E1-94B6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197791>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This simplifies the completions, and would make it easier to define
> aliases in the future.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash |   70 +++++++++++++++-----------------
>  t/t9902-completion.sh                  |    2 +-
>  2 files changed, 34 insertions(+), 38 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 9f56ec7..d60bb8a 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2603,21 +2603,6 @@ _git ()
>  {
>  	local i c=1 command __git_dir
>  
> -	if [[ -n ${ZSH_VERSION-} ]]; then
> -		emulate -L bash
> -		setopt KSH_TYPESET
> -
> -		# workaround zsh's bug that leaves 'words' as a special
> -		# variable in versions < 4.3.12
> -		typeset -h words
> -
> -		# workaround zsh's bug that quotes spaces in the COMPREPLY
> -		# array if IFS doesn't contain spaces.
> -		typeset -h IFS
> -	fi
> -
> -	local cur words cword prev
> -	_get_comp_words_by_ref -n =: cur words cword prev
>  	while [ $c -lt $cword ]; do
>  		i="${words[c]}"
>  		case "$i" in
> @@ -2667,22 +2652,6 @@ _git ()
>  
>  _gitk ()
>  {
> -	if [[ -n ${ZSH_VERSION-} ]]; then
> -		emulate -L bash
> -		setopt KSH_TYPESET
> -
> -		# workaround zsh's bug that leaves 'words' as a special
> -		# variable in versions < 4.3.12
> -		typeset -h words
> -
> -		# workaround zsh's bug that quotes spaces in the COMPREPLY
> -		# array if IFS doesn't contain spaces.
> -		typeset -h IFS
> -	fi
> -
> -	local cur words cword prev
> -	_get_comp_words_by_ref -n =: cur words cword prev
> -
> @@ -2703,16 +2672,43 @@ _gitk ()
>  	__git_complete_revlist
>  }
>  
> -complete -o bashdefault -o default -o nospace -F _git git 2>/dev/null \
> -	|| complete -o default -o nospace -F _git git
> -complete -o bashdefault -o default -o nospace -F _gitk gitk 2>/dev/null \
> -	|| complete -o default -o nospace -F _gitk gitk

Nice code reduction by moving the duplicated code into the new helpers ;-)

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
> +	$1
> +}
> +
> +# Setup completion for certain functions defined above by setting common
> +# variables and workarounds.
> +# This is NOT a public function; use at your own risk.
> +__git_complete ()
> +{
> +	local wrapper="__git_wrap${2}"
> +	eval "$wrapper () { __git_func_wrap $2 ; }"
> +	complete -o bashdefault -o default -o nospace -F $wrapper $1 2>/dev/null \
> +		|| complete -o default -o nospace -F $wrapper $1
> +}
> +
> +__git_complete git _git
> +__git_complete gitk _gitk

It makes my stomach queasy whenever I see $var not in double quotes that
forces me to guess (and trace to verify if the codepath is what I really
care about) if any value with $IFS in it could be used there, so even when
they are known to be safe, I'd prefer to see either explicit quotes or
comment that says what are expected in $1 and $2.

The quoting of all the added lines looks correct, though.

>  # The following are necessary only for Cygwin, and only are needed
>  # when the user has tab-completed the executable name and consequently
>  # included the '.exe' suffix.
>  #
>  if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
> -complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/null \
> -	|| complete -o default -o nospace -F _git git.exe
> +__git_complete git.exe _git
>  fi
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 5bda6b6..0f09fd6 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -63,7 +63,7 @@ run_completion ()
>  	local _cword
>  	_words=( $1 )
>  	(( _cword = ${#_words[@]} - 1 ))
> -	_git && print_comp
> +	__git_wrap_git && print_comp
>  }
>  
>  test_completion ()
