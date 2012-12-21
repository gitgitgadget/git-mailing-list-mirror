From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-completion.bash: add support for path completion
Date: Fri, 21 Dec 2012 09:59:17 -0800
Message-ID: <7vmwx71e2y.fsf@alter.siamese.dyndns.org>
References: <1356108872-5881-1-git-send-email-manlio.perillo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, szeder@ira.uka.de, felipe.contreras@gmail.com
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 18:59:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm6t2-00029Q-0z
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 18:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab2LUR7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 12:59:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60761 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201Ab2LUR7V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 12:59:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C3929B3D;
	Fri, 21 Dec 2012 12:59:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wIXyAWO0FNy4PIQGe13AqGivonY=; b=J9a8VR
	v9dd0BWbJygQr5cXkY12O02hHuBW8X1G+5f66hC+tNeHRG/HuC9XQBl8QAw2+3kH
	BQQyb3dLgqsEJdd4ybXjrVQ4KDPRFGjHSbTnZS7DicVApC+EsuXVa3jG0HifQt/b
	r0dhFymNQ/b58Hr7P9HyufWKY4kE556UGJrsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HdbrV9IEBO2I3nKauCtMHCNJhQnDHP66
	fPwKHyjgO35nXTU1rmlDEYYChHIfCAIjFnN7H7XYeRVdhbZi07vNd9xcC8fc6E9b
	KBLoba2zYq+pMNg4yhZORDvgj3RAkVydMHiK4V7y7QgPAKL55NeOjp48XRrwGzXt
	yLogBGzlGsQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49A6C9B3C;
	Fri, 21 Dec 2012 12:59:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 628709B3B; Fri, 21 Dec 2012
 12:59:19 -0500 (EST)
In-Reply-To: <1356108872-5881-1-git-send-email-manlio.perillo@gmail.com>
 (Manlio Perillo's message of "Fri, 21 Dec 2012 17:54:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 24818E04-4B98-11E2-867A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211992>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> +		case "$path" in
> +		?*/*) echo "${path%%/*}/" ;;
> +		*) echo $path ;;

$path unquoted???

> +# __git_index_files accepts 1 or 2 arguments:
> +# 1: Options to pass to ls-files (required).
> +#    Supported options are --cached, --modified, --deleted, --others,
> +#    and --directory.
> +# 2: A directory path (optional).
> +#    If provided, only files within the specified directory are listed.
> +#    Sub directories are never recursed.  Path must have a trailing
> +#    slash.
> +__git_index_files ()
> +{
> +	local dir="$(__gitdir)"
> +
> +	if [ -d "$dir" ]; then
> +		# NOTE: $1 is not quoted in order to support multiple options

Good thinking to document this.  Thanks.

I take it that $1 never comes from the end user and it is known that
it is correct to split them at $IFS?  That is the way I read callers
of this function in this patch, but I am just double-checking.

> @@ -998,7 +1093,13 @@ _git_commit ()
>  			"
>  		return
>  	esac
> -	COMPREPLY=()
> +
> +	if git rev-parse --verify --quiet HEAD 1>/dev/null; then

s/1>/>/;

> +		__git_complete_diff_index_file "HEAD"

As this runs "git diff-index" without --cached, 

The completion will give only for paths that have difference between
the working tree and the HEAD.  If the user has a bogus contents
that was "git add"ed earlier, (i.e. the index is different from
HEAD), then realizes the mistake and fixes it in the working tree
with his editor to match "HEAD" (i.e. the working tree is the same
as HEAD):

	git commit the-prefix-to-that-file<TAB>

to complete the filename will not give that file.  I do not think it
is a show-stopper, but it may puzzle the users when they encounter
the situation.

I am wondering if reading from "git status --porcelain" might be a
better alternative, or if it is too much trouble and slow things
down to cover such a corner case.

> @@ -1362,7 +1464,14 @@ _git_mv ()
>  		return
>  		;;
>  	esac
> -	COMPREPLY=()
> +
> +	if [ $cword -gt 2 ]; then
> +		# We need to show both cached and untracked files (including
> +		# empty directories) since this may not be the last argument.
> +		__git_complete_index_file "--cached --others --directory"
> +	else
> +		__git_complete_index_file "--cached"
> +	fi

Is $cword affected by the presense of "-f" in "git mv [-f] foo bar"?
Just being curious.

Other than that, I do not see anything majorly wrong from the coding
and semantics point of view in the patch.  As to the interaction
with the rest of the completion machinery, I'll leave the review to
the area experts CC'ed and wait for their comments.

Thanks.
