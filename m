From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: do not corrupt HEAD on empty repo
Date: Tue, 08 May 2012 09:43:03 -0700
Message-ID: <7vsjfawrmw.fsf@alter.siamese.dyndns.org>
References: <1336493114-4984-1-git-send-email-kusmabite@gmail.com>
 <CABPQNSau5snkNLqsnBnsLVBVNKHXnvb8rsE8DbNfpo9__5uijA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, j.sixt@viscovery.net,
	schwab@linux-m68k.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue May 08 18:43:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRnVI-0000gz-Fz
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 18:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457Ab2EHQnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 12:43:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36880 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755041Ab2EHQnF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 12:43:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4078B68FD;
	Tue,  8 May 2012 12:43:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NDeYFzov8lelZO5p6DIbQrFOhlY=; b=hdbH7S
	kttqmMifbHmeSc8mIDp/MZzkKC+s0E2kypL1qjANYXSYGlvzN/s8cKL7NGAjRwgF
	Fm3fIUtlHh+OjJaFXaV21lgAX8x8hMne16b26y8Zp+C+x49Yam4XEYvobihB1LrZ
	MgO7mj4FaNRnQbQ53zpPprZaXKdGbxQN5tNog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wOr+YFjDjU0YnnxZFJgL2b0w6CeEPWfD
	FdYJXwfYECdILYC35J6rwZMX9HDN5B4yaQRuLoXFxBzUeu7jBXyUOmG7+OtX1IH4
	XUTfcsWT01bsX1lD6tJ5/NzvP1Pia270XvnMaB9zh50zisF9LI2GG7YSXg9JeEx6
	DOSAqZ0zHlw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 367BB68FC;
	Tue,  8 May 2012 12:43:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA6AF68F8; Tue,  8 May 2012
 12:43:04 -0400 (EDT)
In-Reply-To: <CABPQNSau5snkNLqsnBnsLVBVNKHXnvb8rsE8DbNfpo9__5uijA@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 8 May 2012 18:25:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E217AC24-992C-11E1-8C93-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197390>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Hmh, this is needlessly cluttery. The following should cover it:
>
> ---
> diff --git a/t/t2015-checkout-unborn.sh b/t/t2015-checkout-unborn.sh
> index 2fa9458..b49fedf 100755
> --- a/t/t2015-checkout-unborn.sh
> +++ b/t/t2015-checkout-unborn.sh
> @@ -50,10 +50,7 @@ test_expect_success 'checking out in a newly created repo' '
>  	test_create_repo empty &&
>  	(
>  		cd empty &&
> -		cat .git/HEAD >expect &&
> -		test_must_fail git checkout &&
> -		cat .git/HEAD >actual &&
> -		test_cmp expect actual
> +		test_must_fail git checkout
>  	)
>  '

Hrm, I am of two minds.  Yes, we may want checkout to fail, but at the
same time, we would want to make sure that a failed checkout does not
corrupt the HEAD.  Perhaps it would make it more palatable if you replaced
"cat .git/HEAD" with "git symbolic-ref HEAD" in the original?
