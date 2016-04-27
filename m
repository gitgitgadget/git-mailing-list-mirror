From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/29] ref_transaction_create(): disallow recursive pruning
Date: Wed, 27 Apr 2016 11:47:11 -0700
Message-ID: <xmqq60v2anyo.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<615204c877610855b02b21ce14efa5b7342182bc.1461768689.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 27 20:47:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avUUZ-0005Ep-Vg
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 20:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbcD0SrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 14:47:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751884AbcD0SrO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 14:47:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CECC16F55;
	Wed, 27 Apr 2016 14:47:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lqZIYUDMP9AnY5vcKfx0XYQJ21c=; b=w8c5DV
	s2z5WDNLRGZIeta+paBPIa458/P5b5gdsPBjTFoInGlRRkqdxKRfePEeJn8QWoQd
	ts9UeVMC5p+tns+IQYUa0ZE512lHbtya+6quUNQo0Ca0XhIjEiLcaDOgQapXbOlm
	O9mxfn5E6L6zRjHWr+w6JANaP1J7gqIAbqlco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XmgzeQwrFAphbeqLUMihAs8jMXVsVEt0
	3D6ELLaQf3OkpTCPAnOsMgU12J0P6M82Z9uUR5ky3H9oW1IRvSnqJQ+0WEeWOqWz
	rNlKzTdbh88STrVs0+nnIp7ZiuSGkiPXeWZK5qbuyX7XrXjPHWPS1JqAe9ERF67n
	HV/nBPIMWUE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 642FC16F54;
	Wed, 27 Apr 2016 14:47:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B991F16F51;
	Wed, 27 Apr 2016 14:47:12 -0400 (EDT)
In-Reply-To: <615204c877610855b02b21ce14efa5b7342182bc.1461768689.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Wed, 27 Apr 2016 18:57:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 74679B3C-0CA8-11E6-94FF-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292785>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It is nonsensical (and a little bit dangerous) to use REF_ISPRUNING
> without REF_NODEREF. Forbid it explicitly. Change the one REF_ISPRUNING
> caller to pass REF_NODEREF too.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> This also makes later patches a bit clearer.

I wonder if it is more future-proof to solve this by doing

    -#define REF_ISPRUNING	0x04
    +#define REF_ISPRUNING	(0x04 | REF_NODEREF)

instead.  It makes the intention clear that pruning is always about
the single level (i.e. no-deref).


>  refs.c               | 3 +++
>  refs/files-backend.c | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index ba14105..5dc2473 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -790,6 +790,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  	if (transaction->state != REF_TRANSACTION_OPEN)
>  		die("BUG: update called for transaction that is not open");
>  
> +	if ((flags & REF_ISPRUNING) && !(flags & REF_NODEREF))
> +		die("BUG: REF_ISPRUNING set without REF_NODEREF");
> +
>  	if (new_sha1 && !is_null_sha1(new_sha1) &&
>  	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
>  		strbuf_addf(err, "refusing to update ref with bad name '%s'",
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 9faf17c..8fcbd7d 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2116,7 +2116,7 @@ static void prune_ref(struct ref_to_prune *r)
>  	transaction = ref_transaction_begin(&err);
>  	if (!transaction ||
>  	    ref_transaction_delete(transaction, r->name, r->sha1,
> -				   REF_ISPRUNING, NULL, &err) ||
> +				   REF_ISPRUNING | REF_NODEREF, NULL, &err) ||
>  	    ref_transaction_commit(transaction, &err)) {
>  		ref_transaction_free(transaction);
>  		error("%s", err.buf);
