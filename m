Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EA4C433F5
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 01:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiAHBvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 20:51:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53233 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiAHBvI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 20:51:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6BD1916FFD4;
        Fri,  7 Jan 2022 20:51:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=yHI9XnwuC/GarIR1kLQH/TF6hjioj4xW5k5VksabLLQ=; b=f3+B
        mxxVDJVia66/plLC4vhns6OaNtIrgFXEWgMq0yI1DZmeDWsU2sb4ZX2PwjhdUWtZ
        pokulK74PTTZ30xJnwWsRNj0T+4NUF8a+9t+GyWQYoGmQqtLmdmr+Zozsv3TUZfc
        OZC70dZjWV1ZTxiRsq+TuqLSSLdJWaUXi+wCxOg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55D2C16FFD3;
        Fri,  7 Jan 2022 20:51:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C799716FFD1;
        Fri,  7 Jan 2022 20:51:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: Re: [PATCH v2 1/6] refs: open-code deletion of packed refs
References: <cover.1638874287.git.ps@pks.im> <cover.1641556319.git.ps@pks.im>
        <0739f085b266e65b423ccc14f70cc00c88744459.1641556319.git.ps@pks.im>
Date:   Fri, 07 Jan 2022 17:51:04 -0800
Message-ID: <xmqqczl33shj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7148A450-7025-11EC-A4C9-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> When deleting loose refs, then we also have to delete the refs in the
> packed backend. This is done by calling `refs_delete_refs()`, which
> then uses the packed-backend's logic to delete refs. This doesn't allow
> us to exercise any control over the reference transaction which is being
> created in the packed backend, which is required in a subsequent commit.
>
> Extract a new function `packed_refs_delete_refs()`, which hosts most of
> the logic to delete refs except for creating the transaction itself.
> Like this, we can easily create the transactionion in the files backend

ionion?

> and thus exert more control over it.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

The title might be technically correct, but I think the primary
point, the benefit this step brings to the system, is now we have a
helper function we can call in a transaction we create ourselves.

    refs: extract packed_refs_delete_refs() to be used in our own transaction

or something along that line, perhaps?  I dunno.

>  refs/files-backend.c  | 12 +++++++++---
>  refs/packed-backend.c | 28 +++++++++++++++++++++-------
>  refs/packed-backend.h |  6 ++++++
>  3 files changed, 36 insertions(+), 10 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 90b671025a..5795e54020 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1249,6 +1249,7 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
>  {
>  	struct files_ref_store *refs =
>  		files_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
> +	struct ref_transaction *transaction = NULL;
>  	struct strbuf err = STRBUF_INIT;
>  	int i, result = 0;
>  
> @@ -1258,10 +1259,14 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
>  	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
>  		goto error;
>  
> -	if (refs_delete_refs(refs->packed_ref_store, msg, refnames, flags)) {
> -		packed_refs_unlock(refs->packed_ref_store);
> +	transaction = ref_store_transaction_begin(refs->packed_ref_store, &err);
> +	if (!transaction)
> +		goto error;
> +
> +	result = packed_refs_delete_refs(refs->packed_ref_store,
> +					 transaction, msg, refnames, flags);
> +	if (result)
>  		goto error;
> -	}

Without looking at the later patches, my guess is that we'd create a
single transaction for packed-refs backend and then issue multiple
delete requests in that single transaction?

Ah, no.  We are already deleting multiple refs in one go, so that is
not what is happening here.  Makes readers a bit curious.  Hopefully
we will find it out in a later patch.

> diff --git a/refs/packed-backend.h b/refs/packed-backend.h
> index f61a73ec25..5e0dd7d08e 100644
> --- a/refs/packed-backend.h
> +++ b/refs/packed-backend.h
> @@ -27,6 +27,12 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
>  void packed_refs_unlock(struct ref_store *ref_store);
>  int packed_refs_is_locked(struct ref_store *ref_store);
>  
> +int packed_refs_delete_refs(struct ref_store *ref_store,
> +			    struct ref_transaction *transaction,
> +			    const char *msg,
> +			    struct string_list *refnames,
> +			    unsigned int flags);
> +
>  /*
>   * Return true if `transaction` really needs to be carried out against
>   * the specified packed_ref_store, or false if it can be skipped
