From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-sh-setup: refactor ident-parsing functions
Date: Mon, 12 Nov 2012 09:44:01 -0800
Message-ID: <7vpq3ik97i.fsf@alter.siamese.dyndns.org>
References: <20121018072207.GA1605@sigill.intra.peff.net>
 <20121018072522.GA9999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:44:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXy3Y-0005jq-Fk
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883Ab2KLRoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:44:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984Ab2KLRoE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:44:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5184E949E;
	Mon, 12 Nov 2012 12:44:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=IPxowZgmDFAUaHvrnsyfqiwYioA=; b=I5srnDKwrdFOX9L+zgxJ
	PmCOMRjLDQSAN2LeYvKV53FT3yEAdYPAarZ0X+ntrBmW2uzow4jbscuK7tmeJevf
	O68rUOnAJwfMLOsK+QR+PqQjBOt1LxLuylxbhdyZPomMHKW0d/uwQIL0HX+INeEQ
	RXKAljO9fO52ogsAlw6xg7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hzvOyDQJLZLS1Pk3yh2lzmvaWfG649fSyxl4rreqqd+Ryg
	Gsnz01Bu2+/Ts2sYaCKvg36sbq9crFxaSyePSJTvp/3GCf9qfiCY1gfioUZya3YH
	TSZ+0dKPPUoQmvh58cccgFmGQyjhnX3n7TAdrllVLQ2cL5suDZqvleJJ1q2Cs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D6D2949D;
	Mon, 12 Nov 2012 12:44:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B0B0949B; Mon, 12 Nov 2012
 12:44:02 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C341C2C-2CF0-11E2-9F31-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209497>

Jeff King <peff@peff.net> writes:

> The only ident-parsing function we currently provide is
> get_author_ident_from_commit. This is not very
> flexible for two reasons:
>
>   1. It takes a commit as an argument, and can't read from
>      commit headers saved on disk.
>
>   2. It will only parse authors, not committers.
>
> This patch provides a more flexible interface which will
> parse multiple idents from a commit provide on stdin. We can
> easily use it as a building block for the current function
> to retain compatibility.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Since we are counting processes in this series, I should note that this
> actually adds a subshell invocation for each call, since it went from:
>
>   script='...'
>   sed $script
>
> to:
>
>   sed "$(make_script)"
>
> For filter-branch, which is really the only high-performance caller we
> have, this is negated by the fact that it will do author and committer
> at the same time, saving us an extra subshell (in addition to an extra
> sed invocation).

Given that pick-ident-script is a const function, a caller that
repeatedly call is could call it once and use it in a variable, no?

>
>  git-sh-setup.sh | 62 +++++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 43 insertions(+), 19 deletions(-)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index ee0e0bc..22f0aed 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -191,28 +191,52 @@ get_author_ident_from_commit () {
>  	fi
>  }
>  
> +# Generate a sed script to parse identities from a commit.
> +#
> +# Reads the commit from stdin, which should be in raw format (e.g., from
> +# cat-file or "--pretty=raw").
> +#
> +# The first argument specifies the ident line to parse (e.g., "author"), and
> +# the second specifies the environment variable to put it in (e.g., "AUTHOR"
> +# for "GIT_AUTHOR_*"). Multiple pairs can be given to parse author and
> +# committer.
> +pick_ident_script () {
> +	while test $# -gt 0
> +	do
> +		lid=$1; shift
> +		uid=$1; shift
> +		printf '%s' "
> +		/^$lid /{
> +			s/'/'\\\\''/g
> +			h
> +			s/^$lid "'\([^<]*\) <[^>]*> .*$/\1/'"
> +			s/.*/GIT_${uid}_NAME='&'/p
> +
> +			g
> +			s/^$lid "'[^<]* <\([^>]*\)> .*$/\1/'"
> +			s/.*/GIT_${uid}_EMAIL='&'/p
> +
> +			g
> +			s/^$lid "'[^<]* <[^>]*> \(.*\)$/@\1/'"
> +			s/.*/GIT_${uid}_DATE='&'/p
> +		}
> +		"
> +	done
> +	echo '/^$/q'
> +}
> +
> +# Create a pick-script as above and feed it to sed. Stdout is suitable for
> +# feeding to eval.
> +parse_ident_from_commit () {
> +	LANG=C LC_ALL=C sed -ne "$(pick_ident_script "$@")"
> +}
> +
> +# Parse the author from a commit given as an argument. Stdout is suitable for
> +# feeding to eval to set the usual GIT_* ident variables.
>  get_author_ident_from_commit () {
> -	pick_author_script='
> -	/^author /{
> -		s/'\''/'\''\\'\'\''/g
> -		h
> -		s/^author \([^<]*\) <[^>]*> .*$/\1/
> -		s/.*/GIT_AUTHOR_NAME='\''&'\''/p
> -
> -		g
> -		s/^author [^<]* <\([^>]*\)> .*$/\1/
> -		s/.*/GIT_AUTHOR_EMAIL='\''&'\''/p
> -
> -		g
> -		s/^author [^<]* <[^>]*> \(.*\)$/@\1/
> -		s/.*/GIT_AUTHOR_DATE='\''&'\''/p
> -
> -		q
> -	}
> -	'
>  	encoding=$(git config i18n.commitencoding || echo UTF-8)
>  	git show -s --pretty=raw --encoding="$encoding" "$1" -- |
> -	LANG=C LC_ALL=C sed -ne "$pick_author_script"
> +	parse_ident_from_commit author AUTHOR
>  }
>  
>  # Clear repo-local GIT_* environment variables. Useful when switching to
