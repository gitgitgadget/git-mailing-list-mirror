Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C6C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 22:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CFA0235FA
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 22:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbhAGW7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 17:59:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64983 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbhAGW7x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 17:59:53 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC8FB11E92D;
        Thu,  7 Jan 2021 17:59:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n61Go8YmLjwC7NqPKeQ56p6giAA=; b=V/oi/N
        Lgh8ula+bgoxgGLv01dtTo2C7BxaSD0jTET1cXmhlFLq5radWMyBVSyvjidVcplO
        /IJpfZcscwxNBJa/1aXxTTac3S0RnKmsr2CQWFI/3m/pfijkaSJQ7yDx0lTMVWtK
        ZVUuX+IdAHX6iQIpIfrf46GPoTusC3qmdLcqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F3dL1ivOUwsf6lWFeh61kvhc5MCx/G8b
        7WbLwLrkl42bVfjmE23KdzUV23hE5y0tiVa8NfvhTcbCbs0i2ySgP/Ku+N6sO9hU
        CV4DZXVpqzNR5D54EfBJEWK15GMSXoSRp60fU42QJ+Wa6yfEkrvoOe+rHBuWFPsx
        ier0Jcyig98=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4FCB11E92C;
        Thu,  7 Jan 2021 17:59:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 203B211E92B;
        Thu,  7 Jan 2021 17:59:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] fetch: allow passing a transaction to `s_update_ref()`
References: <cover.1610027375.git.ps@pks.im>
        <e627e729e5cd14c94dcf819f4f87b1412b9a9e9b.1610027375.git.ps@pks.im>
Date:   Thu, 07 Jan 2021 14:59:05 -0800
In-Reply-To: <e627e729e5cd14c94dcf819f4f87b1412b9a9e9b.1610027375.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 7 Jan 2021 14:51:39 +0100")
Message-ID: <xmqqtursjqva.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2177052-513B-11EB-BF9D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>  static int s_update_ref(const char *action,
>  			struct ref *ref,
> +			struct ref_transaction *transaction,
>  			int check_old)
>  {
>  	char *msg;
>  	char *rla = getenv("GIT_REFLOG_ACTION");
> -	struct ref_transaction *transaction;
> +	struct ref_transaction *transaction_to_free = NULL;
>  	struct strbuf err = STRBUF_INIT;
> -	int ret, df_conflict = 0;
> +	int ret, df_conflict = 0, commit = 0;

> @@ -597,26 +598,38 @@ static int s_update_ref(const char *action,
>  		rla = default_rla.buf;
>  	msg = xstrfmt("%s: %s", rla, action);
>  
> -	transaction = ref_transaction_begin(&err);
> -	if (!transaction ||
> -	    ref_transaction_update(transaction, ref->name,
> +	/*
> +	 * If no transaction was passed to us, we manage the transaction
> +	 * ourselves. Otherwise, we trust the caller to handle the transaction
> +	 * lifecycle.
> +	 */
> +	if (!transaction) {
> +		transaction = transaction_to_free = ref_transaction_begin(&err);
> +		if (!transaction)
> +			goto fail;
> +		commit = 1;
> +	}

The idea is that we still allow the caller to pass NULL in which
case we begin and commit a transaction ourselves, but if the caller
is to pass an already initialized transaction to us, we obviously
do not have to "begin" but also we won't commit.

Which makes sense, but then do we still need the "commit" variable
that reminds us "we are responsible for finishing the transaction we
started"?

If we rename "transaction_to_free" to a name that makes it more
clear that it is a transaction that we created and that we are
responsible for seeing through to its end (after all, "to-free"
captures only one half of that, i.e. before returning, we are
responsible for calling ref_transation_free() on it), then we do not
need such an extra variable that can go out of sync by mistake, no?
The block that protects the call to ref_transaction_commit() can
just check if the transaction_to_free variable (with a better name)
is non-NULL, instead of looking at the commit variable.

Just my attempt to come up with an alternative name for
transaction_to_free:

 - "our_transaction" because it is ours?

 - "auto_transaction" because it is automatically started and
   committed without bothering the caller?

