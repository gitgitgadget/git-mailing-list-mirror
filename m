From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Simple update to bash completions to prevent unbound
 variable errors.
Date: Mon, 12 Jan 2009 19:14:40 -0800
Message-ID: <7vy6xfew2n.fsf@gitster.siamese.dyndns.org>
References: <496C0003.7040909@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 04:16:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMZlD-0006Xr-Vo
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 04:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbZAMDOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 22:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752698AbZAMDOt
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 22:14:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbZAMDOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 22:14:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 812121C5B4;
	Mon, 12 Jan 2009 22:14:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DA1DD1C5AA; Mon,
 12 Jan 2009 22:14:42 -0500 (EST)
In-Reply-To: <496C0003.7040909@tedpavlic.com> (Ted Pavlic's message of "Mon,
 12 Jan 2009 21:44:19 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 552C8180-E120-11DD-9E96-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105447>

Ted Pavlic <ted@tedpavlic.com> writes:

> A vim modeline has also been added for consistency.

Yuck.

> Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
> ---
>  contrib/completion/git-completion.bash |   70
> +++++++++++++++++++++++++-------
>  1 files changed, 55 insertions(+), 15 deletions(-)

Double yuck.

> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index 7b074d7..619e886 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -50,9 +50,11 @@ case "$COMP_WORDBREAKS" in
>  *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
>  esac
>
> +# __gitdir accepts 0 or 1 arguments (i.e., location)
> +# returns location of .git repo
>  __gitdir ()
>  {
> -	if [ -z "$1" ]; then
> +	if [ $# -eq 0 ] || [ -z "$1" ]; then
>  		if [ -n "$__git_dir" ]; then
>  			echo "$__git_dir"
>  		elif [ -d .git ]; then
> @@ -67,6 +69,8 @@ __gitdir ()
>  	fi
>  }
>
> +# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
> +# returns text to add to bash PS1 prompt (includes branch name)

Good.  Would be better if you described what $1 and $2 mean.

> @@ -111,7 +115,7 @@ __git_ps1 ()
>  			fi
>  		fi
>
> -		if [ -n "$1" ]; then
> +		if [ $# -gt 0 ] && [ -n "$1" ]; then

I found the previous round's [ -n "${1-}" ] much easier to read, if we were to
do this.  If -n "${1-}", then "$1" is definitely set so nothing need to
change in the then ... else part.

> +# __gitcomp_1 requires 2 arguments

... and $1 and $2 mean?

>  __gitcomp_1 ()
>  {
>  	local c IFS=' '$'\t'$'\n'
> @@ -131,11 +136,22 @@ __gitcomp_1 ()
>  	done
>  }
>
> +# __gitcomp accepts 1, 2, 3, or 4 arguments
> +# generates completion reply with compgen
>  __gitcomp ()
>  {
> -	local cur="${COMP_WORDS[COMP_CWORD]}"
> -	if [ $# -gt 2 ]; then
> -		cur="$3"
> +	local one two cur="${COMP_WORDS[COMP_CWORD]}" four
> +	if [ $# -gt 0 ]; then
> +		one="$1"
> +		if [ $# -gt 1 ]; then
> +			two="$2"
> +			if [ $# -gt 2 ]; then
> +				cur="$3"
> +				if [ $# -gt 3 ]; then
> +					four="$4"
> +				fi
> +			fi
> +		fi
>  	fi

Yuck.  If you are taking advantage of the fact that "local one"
will bind one to emptiness anyway, can't you do something like:

	local one=${1-} two=${2-} cur=${3-} four=${4-}

to avoid this ugliness?
