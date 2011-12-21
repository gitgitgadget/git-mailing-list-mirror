From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash completion: use read -r everywhere
Date: Wed, 21 Dec 2011 10:59:35 -0800
Message-ID: <7vipl9hht4.fsf@alter.siamese.dyndns.org>
References: <4502a0248bb843018335e9b5cdf70736c096ebe3.1324482693.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Kevin Ballard <kevin@sb.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 21 19:59:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdROC-0007Nu-7l
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 19:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab1LUS7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 13:59:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65384 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013Ab1LUS7i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 13:59:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11D325B45;
	Wed, 21 Dec 2011 13:59:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZPL68cheWFJWrJfiViPq9iSGBWM=; b=VQeJjv
	nNwvK0Y+0sXGDE1Ygzmyolmj21QjlugWbnJblJxLzVJ9RDa+CzyG17MARDZaZWyB
	RC2DNPhrbIJfRmHGTQn0LzCqLBpkN5/+iv7j+1ZEFmeo7AwXVEpoJs21qbJRNUAm
	xVO4Zjk9O/Mb60pmwTbkHTju9V1Gdcbn5laE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K8bsYtKBKhjURcWIn88V+O36Pn5IRd5A
	lX61y0MR6tOymbDGBwjObWlf9TWZD0Dw4E2s8uoI8Rt/DGanYGcJfyXu7u3pEnDP
	jI/tAoV9idZDqcWx3QWYg3aJ4cgNoZwpkrLwnDdeDQFFhnhnk8p+T1GtvMPWSxIr
	Ph5qqj6WP/Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 098D25B3E;
	Wed, 21 Dec 2011 13:59:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DC085B3B; Wed, 21 Dec 2011
 13:59:37 -0500 (EST)
In-Reply-To: <4502a0248bb843018335e9b5cdf70736c096ebe3.1324482693.git.trast@student.ethz.ch> (Thomas Rast's message of "Wed, 21 Dec 2011 16:54:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDC3766E-2C05-11E1-9804-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187578>

Thomas Rast <trast@student.ethz.ch> writes:

> POSIX specifies
>
>   The read utility shall read a single line from standard input.
>   By default, unless the -r option is specified, backslash ('\')
>   shall act as an escape character...
>
> Our omission of -r breaks the loop reading refnames from
> git-for-each-ref in __git_refs() if there are refnames such as
> "foo'bar", in which case for-each-ref helpfully quotes them as in
>
>   $ git update-ref "refs/remotes/test/foo'bar" HEAD
>   $ git for-each-ref --shell --format="ref=%(refname:short)" "refs/remotes"
>   ref='test/foo'\''bar'
>
> Interpolating the \' here will read "ref='test/foo'''bar'" instead,
> and eval then chokes on the unbalanced quotes.
>
> However, since none of the read loops _want_ to have backslashes
> interpolated, it's much safer to use read -r everywhere.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Thanks.

As this script is specific to bash, it is secondary importance what POSIX
says. The "-r" option is important only because "bash" happens to follow
POSIX in this case. I'd like to see the early part of the message reworded
perhaps like this:

	At various points in the script, we use "read" utility without
	giving it the "-r" option that prevents a backslash ('\')
	character to act as an escape character. This breaks e.g. reading
	refnames from ...

Does this regress for zsh users in some ways, by the way?

> ---
>  contrib/completion/git-completion.bash |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 78257ae..e7a39ef 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -111,7 +111,7 @@ __git_ps1_show_upstream ()
>  
>  	# get some config options from git-config
>  	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
> -	while read key value; do
> +	while read -r key value; do
>  		case "$key" in
>  		bash.showupstream)
>  			GIT_PS1_SHOWUPSTREAM="$value"
> @@ -589,7 +589,7 @@ __git_refs ()
>  			local ref entry
>  			git --git-dir="$dir" for-each-ref --shell --format="ref=%(refname:short)" \
>  				"refs/remotes/" | \
> -			while read entry; do
> +			while read -r entry; do
>  				eval "$entry"
>  				ref="${ref#*/}"
>  				if [[ "$ref" == "$cur"* ]]; then
> @@ -602,7 +602,7 @@ __git_refs ()
>  	case "$cur" in
>  	refs|refs/*)
>  		git ls-remote "$dir" "$cur*" 2>/dev/null | \
> -		while read hash i; do
> +		while read -r hash i; do
>  			case "$i" in
>  			*^{}) ;;
>  			*) echo "$i" ;;
> @@ -611,7 +611,7 @@ __git_refs ()
>  		;;
>  	*)
>  		git ls-remote "$dir" HEAD ORIG_HEAD 'refs/tags/*' 'refs/heads/*' 'refs/remotes/*' 2>/dev/null | \
> -		while read hash i; do
> +		while read -r hash i; do
>  			case "$i" in
>  			*^{}) ;;
>  			refs/*) echo "${i#refs/*/}" ;;
> @@ -636,7 +636,7 @@ __git_refs_remotes ()
>  {
>  	local i hash
>  	git ls-remote "$1" 'refs/heads/*' 2>/dev/null | \
> -	while read hash i; do
> +	while read -r hash i; do
>  		echo "$i:refs/remotes/$1/${i#refs/heads/}"
>  	done
>  }
> @@ -1863,7 +1863,7 @@ __git_config_get_set_variables ()
>  	done
>  
>  	git --git-dir="$(__gitdir)" config $config_file --list 2>/dev/null |
> -	while read line
> +	while read -r line
>  	do
>  		case "$line" in
>  		*.*=*)
