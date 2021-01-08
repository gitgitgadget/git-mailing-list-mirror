Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D029C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 23:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1BC23877
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 23:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbhAHXur (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 18:50:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50017 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbhAHXuq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 18:50:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05E4F9719F;
        Fri,  8 Jan 2021 18:50:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1rj2IK4UZ3i2ghC5Fg6pEcpXvOs=; b=va/dF8
        kywsXLvz6CH54bk8yZIlXsh9PNCUWL+2Jls6vuoxmTB48GeDo3DMeBAD3doWzGgR
        EtGK1yAGHeeEyd7WCb6+CpGily2LpmiGgBNq7mGON16RgK1jfBz9Fy2kM52MGA9G
        zucuzriy7QB6XSXrKulSkk75Tz+0UxSOJ67Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gwn8iK3t1OMvoGtzLHtpikfHBPP3jgF9
        z/HSLv5aYwlDFa+9UaFIKiJFOuQTh9JANMLGIfHcmTwdw1XX8jqizJWszoTtoqMV
        Co+EuUR+DczThPv7bMFJ9NBow9PaNYb0ejH756ermrQf14zWAx8jtEO81xxyh6bV
        X5W5TMT6rws=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C714B9719B;
        Fri,  8 Jan 2021 18:50:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFFE297199;
        Fri,  8 Jan 2021 18:50:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 2/4] fetch: refactor `s_update_ref` to use common
 exit path
References: <cover.1610027375.git.ps@pks.im> <cover.1610107599.git.ps@pks.im>
        <718a8bf5d7a0ed92c3004991a42419279ff38253.1610107599.git.ps@pks.im>
Date:   Fri, 08 Jan 2021 15:50:00 -0800
In-Reply-To: <718a8bf5d7a0ed92c3004991a42419279ff38253.1610107599.git.ps@pks.im>
        (Patrick Steinhardt's message of "Fri, 8 Jan 2021 13:11:19 +0100")
Message-ID: <xmqqim87gf9z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39570E7A-520C-11EB-A22D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> @@ -598,30 +598,33 @@ static int s_update_ref(const char *action,
>  	msg = xstrfmt("%s: %s", rla, action);
>  
>  	transaction = ref_transaction_begin(&err);
> -	if (!transaction ||
> -	    ref_transaction_update(transaction, ref->name,
> -				   &ref->new_oid,
> -				   check_old ? &ref->old_oid : NULL,
> -				   0, msg, &err))
> -		goto fail;
> +	if (!transaction) {
> +		ret = STORE_REF_ERROR_OTHER;
> +		goto out;
> +	}
> +
> +	ret = ref_transaction_update(transaction, ref->name, &ref->new_oid,
> +				     check_old ? &ref->old_oid : NULL,
> +				     0, msg, &err);
> +	if (ret) {
> +		ret = STORE_REF_ERROR_OTHER;
> +		goto out;
> +	}

The above certainly got cleaner thanks to Christian's suggestion,
but I wonder why

	transaction = ref_transaction_begin(&err);
	if (!transaction ||
	    ref_transaction_update(transaction, ref->name,
				   &ref->new_oid,
				   check_old ? &ref->old_oid : NULL,
				   0, msg, &err)) {
		ret = STORE_REF_ERROR_OTHER;
		goto out;
	}

shouldn't be sufficient.

>  	ret = ref_transaction_commit(transaction, &err);
>  	if (ret) {
> -		df_conflict = (ret == TRANSACTION_NAME_CONFLICT);
> -		goto fail;
> +		ret = (ret == TRANSACTION_NAME_CONFLICT) ? STORE_REF_ERROR_DF_CONFLICT
> +							 : STORE_REF_ERROR_OTHER;
> +		goto out;
>  	}
> 
> +out:
>  	ref_transaction_free(transaction);

It is a bit funny to see a goto that jumps to the label without
having anything else in between, but we know we will be adding more
code just before the "out:" label, so it is a good preliminary
preparation.

I think a variant that is much easier to follow would be to write
like this instead:

	switch (ref_transaction_commit(transaction, &err)) {
        case 0: /* happy */
		break;
	case TRANSACTION_NAME_CONFLICT:
		ret = STORE_REF_ERROR_DF_CONFLICT;
		goto out;
	default:
		ret = STORE_REF_ERROR_OTHER;
		goto out;
	}

> +	if (ret)
> +		error("%s", err.buf);

OK.

>  	strbuf_release(&err);
>  	free(msg);
> -	return 0;
> -fail:
> -	ref_transaction_free(transaction);
> -	error("%s", err.buf);
> -	strbuf_release(&err);
> -	free(msg);
> -	return df_conflict ? STORE_REF_ERROR_DF_CONFLICT
> -			   : STORE_REF_ERROR_OTHER;
> +	return ret;
>  }
>  
>  static int refcol_width = 10;

THanks.
