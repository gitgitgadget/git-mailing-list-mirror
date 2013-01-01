From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] Better Error Handling for add
Date: Tue, 01 Jan 2013 13:39:03 -0800
Message-ID: <7v1ue4a8i0.fsf@alter.siamese.dyndns.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
 <1357012655-24974-4-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Jan 01 22:39:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq9YV-0007tj-7q
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 22:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483Ab3AAVjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 16:39:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49047 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467Ab3AAVjF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 16:39:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4820A9A04;
	Tue,  1 Jan 2013 16:39:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4P8a71OlkqQnhnPCC2UpUSOY2NA=; b=oWHCj6
	QVhmZzqNU3mnpeqr8QAVNvJHWfYyVlVtGOrlkO01pGNgWYS45hLhj4J7dlHUXC0X
	nb3X6oKia/XwaqT4eN3BMl6wvhNSaDI9vyCjzaLAmKH1Ld/k4R1tprdKTeoIgAf5
	aPomZq2/sPDZKGR8egW4v4uAnbRc6YuDbnmgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uI5wXmAHhEwI9QidYkQG3p+2yQwKv6BT
	SzRujf7lSWtWWvwci9tcWoPU9ZyP0zkRJWnkbXCm+7oU14ZtmzX0MI9OdtNoPY1K
	PeLD4iLPL3ruZ1QTh+h2m9FVj/cFCT28mwB9WXKFyv8CiPNQoX1rCInbfjU7Tp84
	m7yekXYphrg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A35F9A03;
	Tue,  1 Jan 2013 16:39:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFC109A00; Tue,  1 Jan 2013
 16:39:04 -0500 (EST)
In-Reply-To: <1357012655-24974-4-git-send-email-greened@obbligato.org> (David
 A. Greene's message of "Mon, 31 Dec 2012 21:57:30 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA2638EA-545B-11E2-AD61-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212445>

"David A. Greene" <greened@obbligato.org> writes:

> From: "David A. Greene" <greened@obbligato.org>
>
> Check refspecs for validity before passing them on to other commands.
> This lets us generate more helpful error messages.
>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>  contrib/subtree/git-subtree.sh |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 7ceb413..b8a807a 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -509,8 +509,20 @@ cmd_add()
>  	ensure_clean
>  	
>  	if [ $# -eq 1 ]; then
> +	        ref=$(git check-ref-format --normalize "refs/heads/$1") ||
> +                die "'$1' is not a valid refspec.  Are you missing a branch?"

Is a user forbidden from passing a commit that is not at the tip of
an existing branch?  In other words, is

	$ subtree add origin/next~4^2

forbidden?

> +	        rev=$(git rev-parse --verify $1) ||
> +                die "'$1' is not a valid refspec.  Are you missing a branch?"
> +
>  		"cmd_add_commit" "$@"

If you want to make sure you give a comit to add_commit, you can
probably say something like this:

	git rev-parse -q --verify "$1^{commit}" >/dev/null ||
        die "'$1' does not refer to a commit"

>  	elif [ $# -eq 2 ]; then
> +	        ref=$(git check-ref-format --normalize "refs/heads/$2") ||
> +                die "'$2' is not a valid refspec."
> +
> +	        rev=$(git rev-parse --verify $2) ||
> +                die "'$2' is not a valid refspec."
> +

Likewise.

>  		"cmd_add_repository" "$@"
>  	else
>  	    say "error: parameters were '$@'"
