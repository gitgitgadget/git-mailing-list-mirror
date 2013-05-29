From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 25/25] refs: document the lifetime of the args passed to each_ref_fn
Date: Wed, 29 May 2013 09:54:10 -0700
Message-ID: <7vd2s9via5.fsf@alter.siamese.dyndns.org>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
	<1369472904-12875-26-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 29 18:54:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhjdk-0005lI-IR
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 18:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759512Ab3E2QyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 12:54:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49581 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759039Ab3E2QyO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 12:54:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAC192306F;
	Wed, 29 May 2013 16:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=LoetCO+Jl7c+e5dcdZC7kU78F6s=; b=dfDM0Os1QqwIi7lU+3pT
	rBoAXdT+x1mydyrB8s1qmICwDgvqBYpkbmErH3VJFJ+IyToYjAttH7qwdTrzDLXI
	twe9ViYMSw8YN1pGYO8p8Gmo0k/LxZhV2aGsROtwsmreQlucMKPK0CvlwvD11Njo
	3KIVqfmtTokXgNyZuYVoPZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hAK1z7X/OBMWydZjWnosUawDKBQ8vhf3DWvxXBTsV4/jR0
	InHUXUwRKiIESlzvgs+JY87LIQ2leA9WFZbqpRhjenSiHozq7WtJSaY0BYjhqs6z
	G9a4B64IdDWcv+9YqpDLTM3tFh81MxZmt3YJSwEORyItiybjycQMoWvfpBR4k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0CD82306E;
	Wed, 29 May 2013 16:54:12 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 551482306B;
	Wed, 29 May 2013 16:54:12 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6366ECF8-C880-11E2-8183-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225843>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The commits leading up to this have (hopefully) fixed all of the
> callers of the for_each_ref()-like functions.  This commit does the
> last step: documents what each_ref_fn callbacks can assume about
> object lifetimes.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

I looked at all the patches in the series and they all looked
sensible.

I have a few comments (sent as individual review) but all of the
suggestions in them are "by the way I noticed this issue that is not
new to this series while I was reading the code, and we may want to
fix it elsewhere", not "this is broken in the patch, we need to fix
it before queuing".

Thanks for a pleasant read.

> ---
>  refs.h | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/refs.h b/refs.h
> index a35eafc..122ec03 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -15,13 +15,23 @@ struct ref_lock {
>  #define REF_ISBROKEN 0x04
>  
>  /*
> - * Calls the specified function for each ref file until it returns
> - * nonzero, and returns the value.  Please note that it is not safe to
> - * modify references while an iteration is in progress, unless the
> - * same callback function invocation that modifies the reference also
> - * returns a nonzero value to immediately stop the iteration.
> + * The signature for the callback function for the for_each_*()
> + * functions below.  The memory pointed to by the refname and sha1
> + * arguments is only guaranteed to be valid for the duration of a
> + * single callback invocation.
> + */
> +typedef int each_ref_fn(const char *refname,
> +			const unsigned char *sha1, int flags, void *cb_data);
> +
> +/*
> + * The following functions invoke the specified callback function for
> + * each reference indicated.  If the function ever returns a nonzero
> + * value, stop the iteration and return that value.  Please note that
> + * it is not safe to modify references while an iteration is in
> + * progress, unless the same callback function invocation that
> + * modifies the reference also returns a nonzero value to immediately
> + * stop the iteration.
>   */
> -typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
>  extern int head_ref(each_ref_fn, void *);
>  extern int for_each_ref(each_ref_fn, void *);
>  extern int for_each_ref_in(const char *, each_ref_fn, void *);
