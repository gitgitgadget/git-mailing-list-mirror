From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: fix segfault when HEAD points nowhere
Date: Thu, 31 Jan 2013 08:06:19 -0800
Message-ID: <7vlib9ibgk.fsf@alter.siamese.dyndns.org>
References: <1359634971-79036-1-git-send-email-frase@frase.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fraser Tweedale <frase@frase.id.au>
X-From: git-owner@vger.kernel.org Thu Jan 31 17:06:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0wez-0004Nd-Db
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 17:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941Ab3AaQGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 11:06:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48000 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360Ab3AaQGW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 11:06:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CED5B236;
	Thu, 31 Jan 2013 11:06:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a7eoM9PwRtHoxf+lRR0OXul2h8s=; b=gPyCKa
	JWNVC4ikzh9iH8pdhN8gIHQ5nsaUu0AQJY4oF+hNzcFvfYRRUsusP7U+BA1u7V33
	caA9oakhg7pUkV0v4xSoPzkXPcKOsPFR+Au1IGhpXCQEmIg2hikxS9Mpfof7pKtA
	L1kn5pGZcpEO+RQepAHtcR8zfkj0WPYfDakLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fIWNiEgPDsHNeB8IejpptRB2F4XzbdCK
	GfMrqBdoyJ/R1btZDPcDu7eWrT/kS10J4R5hgRbIBLktDTNWUt9ADZK4ivDX81u1
	o4AJb3/xaDl6or6tXRqkMnfyoVKrp+Lm/qnutogLJqRU6Xt0j+ft3J20CH3Z3Yhq
	7886CdUkdO4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 010F3B235;
	Thu, 31 Jan 2013 11:06:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62E56B232; Thu, 31 Jan 2013
 11:06:21 -0500 (EST)
In-Reply-To: <1359634971-79036-1-git-send-email-frase@frase.id.au> (Fraser
 Tweedale's message of "Thu, 31 Jan 2013 22:22:51 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2770BC78-6BC0-11E2-BD48-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215121>

Fraser Tweedale <frase@frase.id.au> writes:

> When reporting the outcome of a push, a segfault occurs if HEAD does
> not point somewhere.  Check that HEAD points somewhere before trying
> to strcmp it.
>
> Signed-off-by: Fraser Tweedale <frase@frase.id.au>
> ---
>  transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/transport.c b/transport.c
> index 9932f40..b9306ef 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -741,7 +741,7 @@ void transport_print_push_status(const char *dest, struct ref *refs,
>  			n += print_one_push_status(ref, dest, n, porcelain);
>  		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD &&
>  		    *nonfastforward != NON_FF_HEAD) {
> -			if (!strcmp(head, ref->name))
> +			if (head != NULL && !strcmp(head, ref->name))
>  				*nonfastforward = NON_FF_HEAD;
>  			else
>  				*nonfastforward = NON_FF_OTHER;

Wow.

This is a bug that is hard to trigger by just using the software
(you have to be doubly insane to be on an unborn branch and pushing
out a branch that is not the one you are currently on) and one has
to look at the code to hunt for it.

The fix looks correct.  Thank you very much for spotting.
