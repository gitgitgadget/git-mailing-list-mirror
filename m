From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-bisect working only from toplevel dir
Date: Wed, 23 Nov 2011 11:09:29 -0800
Message-ID: <7vd3cibqqe.fsf@alter.siamese.dyndns.org>
References: <20111123145034.GB17927@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Borowski <kilobyte@angband.pl>
X-From: git-owner@vger.kernel.org Wed Nov 23 20:09:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTICO-0001cQ-VN
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 20:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008Ab1KWTJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 14:09:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42674 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754343Ab1KWTJb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 14:09:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F577515D;
	Wed, 23 Nov 2011 14:09:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bicVzOBZ2lcyhIovv8i3pFXr6YI=; b=ciL//Y
	SHcSr12OEuPBn9xzQxzi4DlvhBhf5uStg6t3v16TD46V/tVmITSTmJ+yHn5Y5R+5
	mq4RrwjOBnHWL76UNs7/isqXsi6Y+7G8GxRvF7g8rSX5XeJwH4Xv4KtGtG9XI+g3
	fwj2YitBoJoD8HV5OUeFFyt3DPuUHfvzCVS1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QjB252JecB+FQkVG2NKub5qzrqDPWZ/w
	/g+YlLErrOu8y2O+wwv4YrLX2GbdH7Z6U9gIpOhhrz7tXCQAfB8Kl5UkW2oEZdxt
	mMwoGxuDE9corsUbz3Kku+LL7/4jFoePtHU1W7sCIqrBBiUjmYN3e2AsU/OjYhoA
	ztQfklbd4ko=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8636A515C;
	Wed, 23 Nov 2011 14:09:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05558515B; Wed, 23 Nov 2011
 14:09:30 -0500 (EST)
In-Reply-To: <20111123145034.GB17927@angband.pl> (Adam Borowski's message of
 "Wed, 23 Nov 2011 15:50:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC124854-1606-11E1-9B57-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185865>

Adam Borowski <kilobyte@angband.pl> writes:

> The requirement to be in the toplevel directory when calling git-bisect is
> pretty infuriating.  I tried to find an explanation for this, and the only
> reference I found was:
>
> http://thread.gmane.org/gmane.comp.version-control.git/27524/focus=27596

Interesting. It used to be that people were thankful when a command
happened to work from a subdirectory, and it was a minor irritation when
some command didn't; in the early days, everything in Git was to be used
from the top-legvel.

> However, since then, git-reset has been changed (in a81c311f).  What about
> changing git-bisect as well?
>
> A trivial patch seems to work for me, but I might have missed some corner
> case.

Thanks; read and follow Documentation/SubmittingPatches the next time
perhaps?

As to the approach, I suspect that it would be far better if it made
workable with cd_to_toplevel at the beginning, instead of saying
SUBDIRECTORY_OK.

After all, the current directory may disappear during the course of
bisection, upon checking out a revision that did not have the directory
you started your bisection from.

>
> -- 
> 1KB		// Yo momma uses IPv4!
>
> From 1dd5dda6a9db3d987e15784c4de24e593cc596e0 Mon Sep 17 00:00:00 2001
> From: Adam Borowski <kilobyte@angband.pl>
> Date: Wed, 23 Nov 2011 15:08:42 +0100
> Subject: [PATCH] git-bisect: allow using it from a subdirectory.
>
> Just like git-reset, restricting it to toplevel is an annoyance, and the
> latter has been changed in a81c311f.
> ---
>  git-bisect.sh |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 99efbe8..fd6ccdd 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -27,6 +27,7 @@ git bisect run <cmd>...
>  Please use "git help bisect" to get the full man page.'
>  
>  OPTIONS_SPEC=
> +SUBDIRECTORY_OK=Yes
>  . git-sh-setup
>  . git-sh-i18n
