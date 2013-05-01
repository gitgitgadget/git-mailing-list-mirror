From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/subtree: don't delete remote branches if split fails
Date: Wed, 01 May 2013 10:13:49 -0700
Message-ID: <7vd2ta8vxu.fsf@alter.siamese.dyndns.org>
References: <397ab75eeb9d1c60f418b1ded23d8de04cf16251.1367396752.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "David A. Greene" <greened@obbligato.org>,
	Steffen Jaeckel <steffen.jaeckel@stzedn.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed May 01 19:13:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXabM-00063G-Nh
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 19:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600Ab3EARNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 13:13:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053Ab3EARNv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 13:13:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D2DB1BA9D;
	Wed,  1 May 2013 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HbcUaH+B8xq8Bm6nYDGeubSP8Y8=; b=d43sz2
	MOYoF7wcVD2gIS7Cm+7kzQAXTRzB6MC48nLpfd8Q2WaZVb3PNIPd/Bi5y+sOAW8P
	XbBALP1lnMNgrGCMHDI/d9B/1OvcUVgJEZPPZdVut4Ea142oVyOz+tsUM8QZQ8Uq
	sghyGdoVE+ZTQti6tigQh9jrmM25kktLzDk+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s6MGM6PredEXoGuiN8YRBpHEoLDN3z2m
	4zRoIl/veZ4F3fryEJHJbfbQHW6M9oIwzonRHMV9dmh7j+j+1i+gvS6+bvpwJhk4
	WS6vGFzU7b/WkkpMl5dkHuVbsFiRbI0G2kmAC4jUXMN04AsMffZABt6qT15+8SWs
	VU30rRqP1pM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6194A1BA9C;
	Wed,  1 May 2013 17:13:51 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFBFD1BA9B;
	Wed,  1 May 2013 17:13:50 +0000 (UTC)
In-Reply-To: <397ab75eeb9d1c60f418b1ded23d8de04cf16251.1367396752.git.john@keeping.me.uk>
	(John Keeping's message of "Wed, 1 May 2013 09:25:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E3D148A-B282-11E2-88DB-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223102>

John Keeping <john@keeping.me.uk> writes:

> When using "git subtree push" to split out a subtree and push it to a
> remote repository, we do not detect if the split command fails which
> causes the LHS of the refspec to be empty, deleting the remote branch.
>
> Fix this by pulling the result of the split command into a variable so
> that we can die if the command fails.
>
> Reported-by: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  contrib/subtree/git-subtree.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 8a23f58..10daa8b 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -715,7 +715,8 @@ cmd_push()
>  	    repository=$1
>  	    refspec=$2
>  	    echo "git push using: " $repository $refspec
> -	    git push $repository $(git subtree split --prefix=$prefix):refs/heads/$refspec
> +	    localrev=$(git subtree split --prefix="$prefix") || die
> +	    git push $repository $localrev:refs/heads/$refspec
>  	else
>  	    die "'$dir' must already exist. Try 'git subtree add'."
>  	fi

Looks trivially correct to me.
