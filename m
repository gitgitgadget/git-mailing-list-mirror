From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 17/51] do_for_each_ref(): correctly terminate while
 processesing extra_refs
Date: Mon, 12 Dec 2011 14:41:33 -0800
Message-ID: <7vpqftxq4p.fsf@alter.siamese.dyndns.org>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
 <1323668338-1764-18-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Dec 13 01:38:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaGO1-00016R-GY
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 01:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab1LMAiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 19:38:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592Ab1LMAiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 19:38:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 263B77997;
	Mon, 12 Dec 2011 19:38:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=jMnnCQyBVvK/xbBNN1VYm9SRJbI=; b=YV0NZsQFXkPGbr8KifJM
	J2coj3UCtaQOJ7BL8/BsvsYfibSEKx5kbOzDeHUfTMiYWPQZv0wTS34RDlBTfRkJ
	ZB3E0ZhoVQhBlQwQ4sTEsWB1sQl6dKXZITff2JAatrJ+SPxO+9vgCvQHeDbzO+Nv
	9v1jKhbKyu6B2edAJQ3gvaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=nU70lAn+kpE83zpjmYSl1ABLNAcRmyewmzjA7M3Yw3I2lT
	lFeiv2Dgx6mHZwF19Anp6tpJ+GPQ3ttkhkmw9cqFFPw5gdr8wpXN51pGgdQsfszD
	6pAdqvS+anpsILLerN5ig+kLvfYf/P/1qQVRWwJH0hZicXsOK4GUYM7qLuqPg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CC9A7996;
	Mon, 12 Dec 2011 19:38:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9295D7995; Mon, 12 Dec 2011
 19:38:15 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BEB4F09E-2522-11E1-9365-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186986>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> If the user-supplied function returns a nonzero value while processing
> extra_refs, terminate without processing the rest of the list.
>
> This probably has no practical importance, but makes the handling of
> extra_refs a little bit more consistent with the handling of other
> refs.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 579e4c3..fb6fe84 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -711,8 +711,11 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
>  
>  	struct ref_array *extra = &extra_refs;
>  
> -	for (i = 0; i < extra->nr; i++)
> +	for (i = 0; i < extra->nr; i++) {
>  		retval = do_one_ref(base, fn, trim, flags, cb_data, extra->refs[i]);
> +		if (retval)
> +			goto end_each;
> +	}

Makes sense and everything up to this point looks sane.

Thanks.
