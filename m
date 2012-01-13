From: Junio C Hamano <gitster@pobox.com>
Subject: Re: thin packs ending up fat
Date: Thu, 12 Jan 2012 16:14:16 -0800
Message-ID: <7vboq81msn.fsf@alter.siamese.dyndns.org>
References: <20120112221523.GA3663@sigill.intra.peff.net>
 <20120112223234.GA4949@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 13 01:14:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlUmn-0004uA-9a
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 01:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231Ab2AMAOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 19:14:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49586 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756073Ab2AMAOT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 19:14:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1F666959;
	Thu, 12 Jan 2012 19:14:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8lLzCsuEhynos7oOIIdWUDo4VmY=; b=uYIsc5
	/pILc2ujEdHtuEAgbpZNmvv3S6Ab128FVhVsNE3sW/3i9ZOtKR3AkgW6gNQtj5+u
	kdBFkv1DULKVDdwMJsYXm+TgD8qobQHbkX+AKZHSwZzLUIFpFDD7yp50Y8/lSB6X
	PgQbzHQmII7jZt0vh2Utp+nT7I7FPliZdV6z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XVZZcgGifT3NZ5eQStDYdTCaT+XgEXyu
	skYdrGRPo+UXSCfLsCskIdhP00ZQls5bOyByzsvDc2tKX3pw5+9fETXW7ptaVdf7
	FIY5CHQUTPmkaGDVuopI6eLeXNeuIcud/Bty0wofWJhV3gs+Y85zdPIDzJDjzOym
	9cpEY6t6iiI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B87286958;
	Thu, 12 Jan 2012 19:14:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 284496947; Thu, 12 Jan 2012
 19:14:18 -0500 (EST)
In-Reply-To: <20120112223234.GA4949@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 12 Jan 2012 17:32:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88B68A68-3D7B-11E1-BEDA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188489>

Jeff King <peff@peff.net> writes:

> Hmm. It turns out this is really easy, because we have already marked
> such objects as preferred bases.
>
> So with this patch:
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 96c1680..d05e228 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1439,6 +1439,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>  	 */
>  	if (reuse_delta && trg_entry->in_pack &&
>  	    trg_entry->in_pack == src_entry->in_pack &&
> +	    !src_entry->preferred_base &&
>  	    trg_entry->in_pack_type != OBJ_REF_DELTA &&
>  	    trg_entry->in_pack_type != OBJ_OFS_DELTA)
>  		return 0;

Yeah, I was wondering why this one-liner was not in the original message
;-)

> here are the numbers I get:
>
>                   dataset
>             | fetches | tags
> ---------------------------------
>      before | 53358   | 2750977
> size  after | 32398   | 2668479
>      change |   -39%  |      -3%
> ---------------------------------
>      before |  0.18   | 1.12
> CPU   after |  0.18   | 1.15
>      change |    +0%  |      +3%

Looks good.
