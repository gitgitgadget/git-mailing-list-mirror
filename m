Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F21C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 23:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 747F323998
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 23:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbhAHXy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 18:54:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59923 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbhAHXy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 18:54:29 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D021B424F;
        Fri,  8 Jan 2021 18:53:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O6Z531O/c3gk82yAKSZ6atD/Q5Q=; b=mm05dK
        hq/SB2vpgRdbcMPuOHZoBUspfpcAcfzx6+OmuktJqxKF++evTNCf9GCcCy2dicUy
        ftvNyzVrXEk3vPk5bwihn5ozqGcl1r3w7OTlbWCsl5s+XYu+6/oAdSlmSbkYRjiO
        bRJ7nsu5zE1au1ppKwqoK+/XRaaiQp2bbJOE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZPjc3/6YG/SPa35oLU0AfgfeewxmzIi2
        5cB+XFcWhS+n+WLWKRsSNbY6jlMQoU9D9PM2hkWuvRojr3uCrVq+pVZM9QahJnuj
        XaLHMH4zooZnEk+pMs2N/gtlMxm8yJQCEfUs8Ae1nAkoYO/6gOEJ1ou+1lOAL4+d
        N1fZZaTxNY4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 539E4B424E;
        Fri,  8 Jan 2021 18:53:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7121B424D;
        Fri,  8 Jan 2021 18:53:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 3/4] fetch: allow passing a transaction to
 `s_update_ref()`
References: <cover.1610027375.git.ps@pks.im> <cover.1610107599.git.ps@pks.im>
        <4162d10fcbb5729dffaaec0651345dd9522a8e05.1610107599.git.ps@pks.im>
Date:   Fri, 08 Jan 2021 15:53:46 -0800
In-Reply-To: <4162d10fcbb5729dffaaec0651345dd9522a8e05.1610107599.git.ps@pks.im>
        (Patrick Steinhardt's message of "Fri, 8 Jan 2021 13:11:23 +0100")
Message-ID: <xmqqczyfgf3p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF638C0A-520C-11EB-8C3F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> @@ -597,10 +598,17 @@ static int s_update_ref(const char *action,
>  		rla = default_rla.buf;
>  	msg = xstrfmt("%s: %s", rla, action);
>  
> -	transaction = ref_transaction_begin(&err);
> +	/*
> +	 * If no transaction was passed to us, we manage the transaction
> +	 * ourselves. Otherwise, we trust the caller to handle the transaction
> +	 * lifecycle.
> +	 */
>  	if (!transaction) {
> -		ret = STORE_REF_ERROR_OTHER;
> -		goto out;
> +		transaction = our_transaction = ref_transaction_begin(&err);
> +		if (!transaction) {
> +			ret = STORE_REF_ERROR_OTHER;
> +			goto out;
> +		}
>  	}

OK, this answers the question I posed in the review of the previous
step.  We need to separate out "if (!transaction || ...)" into two
anyway with this step, so it is easier to see what changed in this
step if we separated in the previous preparatory clean-up step.

> @@ -611,15 +619,17 @@ static int s_update_ref(const char *action,
>  		goto out;
>  	}
>  
> -	ret = ref_transaction_commit(transaction, &err);
> -	if (ret) {
> -		ret = (ret == TRANSACTION_NAME_CONFLICT) ? STORE_REF_ERROR_DF_CONFLICT
> -							 : STORE_REF_ERROR_OTHER;
> -		goto out;
> +	if (our_transaction) {
> +		ret = ref_transaction_commit(our_transaction, &err);
> +		if (ret) {
> +			ret = (ret == TRANSACTION_NAME_CONFLICT) ? STORE_REF_ERROR_DF_CONFLICT
> +								 : STORE_REF_ERROR_OTHER;
> +			goto out;
> +		}

The switch statement suggested earlier would shine when the
constants involved have such long names.

>  	}
>  
>  out:
> -	ref_transaction_free(transaction);
> +	ref_transaction_free(our_transaction);
>  	if (ret)
>  		error("%s", err.buf);
>  	strbuf_release(&err);

Makes sense.  Thanks.
