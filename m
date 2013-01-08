From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] contrib/subtree: Better Error Handling for add
Date: Tue, 08 Jan 2013 10:45:49 -0800
Message-ID: <7v7gnneco2.fsf@alter.siamese.dyndns.org>
References: <1357646997-28675-1-git-send-email-greened@obbligato.org>
 <1357646997-28675-5-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 19:46:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TseBh-0000hk-Iq
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 19:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757108Ab3AHSpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 13:45:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61904 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756998Ab3AHSpw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 13:45:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D46A5AA55;
	Tue,  8 Jan 2013 13:45:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=12EP+irzkt7P2hlsMT+q2cur9ds=; b=U6VDSoB7ts0XtkquJRZ9
	7+SljsWYDfOSfkM/lZ9b5k72e1GXeuIMMd6Sjxs1DXhuehPH8EljOC1JSHaKM9ev
	3sqD3XkE3LVv6fFmqU2H+zGxvSvP9EHDCQLpuabxNut0Bsc2pCe2JDfhKARuZZne
	PO609GmTyj7TZosWIsPIK6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=PP8Q6AiaTbgBsGQ+mJvbT1cyccn1LrX5fpxOrPqPxPQO3T
	mhiEyBtY9H01jLf1m46/U69LpPDj0w5EgXCJ9EKzjTs8akgUP/2oXrFO7AHV4UM2
	oYyDAQDh+OnJIOmiD3skjWtfLBc/sk+QfjrrwX5I9rje/o0HqvSx/j7yQMpDw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9B3CAA54;
	Tue,  8 Jan 2013 13:45:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25FAEAA50; Tue,  8 Jan 2013
 13:45:51 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FF46758-59C3-11E2-B8DF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212995>

"David A. Greene" <greened@obbligato.org> writes:

> From: "David A. Greene" <greened@obbligato.org>
>
> Check refspecs for validity before passing them on to other commands.
> This lets us generate more helpful error messages.
>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>  contrib/subtree/git-subtree.sh |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index cac0680..d53eaee 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -508,12 +508,18 @@ cmd_add()
>  	ensure_clean
>  	
>  	if [ $# -eq 1 ]; then
> -		"cmd_add_commit" "$@"
> +	    git rev-parse -q --verify "$1^{commit}" >/dev/null ||
> +            die "'$1' does not refer to a commit"

Where do these uneven indentation come from?  Is it mimicking
existing breakage in the script?

> +
> +	    "cmd_add_commit" "$@"
>  	elif [ $# -eq 2 ]; then
> -		"cmd_add_repository" "$@"
> +	    git rev-parse -q --verify "$2^{commit}" >/dev/null ||
> +            die "'$2' does not refer to a commit"
> +
> +	    "cmd_add_repository" "$@"
>  	else
>  	    say "error: parameters were '$@'"
> -	    die "Provide either a refspec or a repository and refspec."
> +	    die "Provide either a commit or a repository and commit."
>  	fi
>  }
