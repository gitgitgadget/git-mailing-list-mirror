From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-refs: remove newly empty directories
Date: Mon, 05 Jul 2010 20:02:54 -0700
Message-ID: <7vsk3x5n35.fsf@alter.siamese.dyndns.org>
References: <1278368848-7037-1-git-send-email-price@ksplice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Price <price@ksplice.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 05:03:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVyRA-0007Ms-TZ
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 05:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834Ab0GFDDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 23:03:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab0GFDDB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 23:03:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C310FC2E0D;
	Mon,  5 Jul 2010 23:03:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=0TNQu3hkqmqM4h2prWKXOe3C3vE=; b=jxDZrLJehVDbmOQaKuRSDPx
	5Re3xcp7a7dOBe41O+YGAZq4c3KSw2E9gd1rs4EVAUswsaqVa2wuogqhpcvZCP2D
	aQ4ioBx+ggEdss2qm7WXaM0Q5ZaDfRL/0vI++WWTKSfSlscxcad12h/sECUN8ZpN
	B5bzS72gqpYxf2Lwk7h8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=VW0nU5fjhNpwbRBymsJ4I7+7hs6NbdYxvhxaWMYPqJjGGIsFF
	oAy4+yvU+tsZqRycTxukFcXvOIrssLfQictp/ZVD5TWrTKGDjh0AiHA8p+iq52H4
	7X2b4XO/cwgygNS+0to9r8Om94aKB3v222GSrVXmLuUr2uMAsIgjrOIyC0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A2FCC2E0B;
	Mon,  5 Jul 2010 23:02:58 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF0D0C2E0A; Mon,  5 Jul
 2010 23:02:55 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FB478730-88AA-11DF-A475-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150316>

Greg Price <price@ksplice.com> writes:

> diff --git a/pack-refs.c b/pack-refs.c
> index 7f43f8a..33d7358 100644
> --- a/pack-refs.c
> +++ b/pack-refs.c
> @@ -63,11 +63,19 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
>  /* make sure nobody touched the ref, and unlink */
>  static void prune_ref(struct ref_to_prune *r)
>  {
> +	char *p, *q;
>  	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1);
>  
>  	if (lock) {
>  		unlink_or_warn(git_path("%s", r->name));
>  		unlock_ref(lock);
> +
> +		/* remove the directory if empty */
> +		for (q = p = r->name; *p; p++)
> +			if (*p == '/')
> +				q = p;
> +		*q = '\0';
> +		rmdir(r->name);
>  	}
>  }

Will this keep refs/heads/p/q that is empty after packing p/q/r/s branch
that happens to be the only branch whose name begins with p/?

I do not want a careless loop that will remove refs/heads after packing
"master" that happens to be the only local branch, but still...
