From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xdiff: optimise for no whitespace difference when
 ignoring whitespace.
Date: Mon, 05 Jul 2010 19:36:04 -0700
Message-ID: <7vsk3x72wb.fsf@alter.siamese.dyndns.org>
References: <1278310017-24299-1-git-send-email-dgreid@gmail.com>
 <1278334842-9701-1-git-send-email-dgreid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@drmicha.warpmail.net, git@vger.kernel.org
To: Dylan Reid <dgreid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 04:36:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVy1K-0006jT-VQ
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 04:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756951Ab0GFCgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 22:36:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756810Ab0GFCgN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 22:36:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B50E2C2B2F;
	Mon,  5 Jul 2010 22:36:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Kq19Z9+89G/LNU0iDouHjm2dKzw=; b=F0i/Vp7j4nwAGfEgAHfFAGQ
	AEpuI20fPvtvM42Y2bna4IBf+Zh0yKxfxReH+kifxFk7dquO1OUiLjgTakhs/IfJ
	INLo7gVxI7QNfU9xOs7ayB0Qw6VnZDyTs9uWAwE309/+0FFLKEUMFoK89lMANeFZ
	yvrRrEqUH5NC9Awy847w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Wed0wrOxbI+w7YCDHaSrbaZvNPRf7YkJtT7aSn79Tz5UlIQla
	jMwCtvHpw0bCGugzhljj7zi4LTmjuJ2LzWGwm00N4r1aVNGbi30gxPGkS8LTXT6Q
	ooJ5JtCBezLEzAYMEKr15PVBvu/50aQ3EqI4PvMIXcUX8RG49havSOeHXQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E334C2B2C;
	Mon,  5 Jul 2010 22:36:09 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0B2CC2B2A; Mon,  5 Jul
 2010 22:36:05 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3C2BBAFE-88A7-11DF-9CB6-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150311>

Dylan Reid <dgreid@gmail.com> writes:

> In xdl_recmatch, do the memcmp to check if the two lines are equal before
> checking if whitespace flags are set.  If the lines are identicle, then

"identical"?

> there is no need to check if they differ only in whitespace.
> This makes the common case (there is no whitespace difference) faster.
> It costs the case where lines are the same length and contain
> whitespace differences, but the common case is more than 20% faster.

"more than 20% faster" based on what dataset and benchmark?

>
> Signed-off-by: Dylan Reid <dgreid@gmail.com>
> ---
>  xdiff/xutils.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index bc12f29..22f9bd6 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -190,8 +190,10 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
>  {
>  	int i1, i2;
>  
> +	if (s1 == s2 && !memcmp(l1, l2, s1))
> +		return 1;
>  	if (!(flags & XDF_WHITESPACE_FLAGS))
> -		return s1 == s2 && !memcmp(l1, l2, s1);
> +		return 0;
>  
>  	i1 = 0;
>  	i2 = 0;
> -- 
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
