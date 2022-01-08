Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2881BC433FE
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 01:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiAHBvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 20:51:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54849 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiAHBvK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 20:51:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E854111B26;
        Fri,  7 Jan 2022 20:51:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=i8HGouXEBVfq0nBxaSVkb74xLGTppmHRfwTbbMKYf6k=; b=LrUF
        5ug2NrkN/tR6CxPH5BrDfHvihB3dzNiKT3rCXNDStvskUlmsnC40TVG0cn22Z3Yy
        31czl2mF2p67d8KbWO6WeMFTJTzFzH+Jo3lCmk2Gr10dCDtPkH6CvmvxZI4qnJoS
        vie9RhzYAiUDXN+eR1ZFjkMYgoIqH5QuXEbRqJ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46038111B24;
        Fri,  7 Jan 2022 20:51:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 932A2111B23;
        Fri,  7 Jan 2022 20:51:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: Re: [PATCH v2 2/6] refs: allow passing flags when beginning
 transactions
References: <cover.1638874287.git.ps@pks.im> <cover.1641556319.git.ps@pks.im>
        <629be01d50be53c51273286febb9d4a890c968a5.1641556319.git.ps@pks.im>
Date:   Fri, 07 Jan 2022 17:51:07 -0800
Message-ID: <xmqq7dbb3shg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72F25FA8-7025-11EC-9563-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> We do not currently have any flags when creating reference transactions,
> but we'll add one to disable execution of the reference transaction hook
> in some cases.
>
> Allow passing flags to `ref_store_transaction_begin()` to prepare for
> this change.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c                |  8 +++++---
>  refs.h                |  3 ++-
>  refs/files-backend.c  | 10 +++++-----
>  refs/packed-backend.c |  2 +-
>  refs/refs-internal.h  |  1 +
>  sequencer.c           |  2 +-
>  6 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 4da4996c4d..7415864b62 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -800,7 +800,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
>  	struct ref_transaction *transaction;
>  	struct strbuf err = STRBUF_INIT;
>  
> -	transaction = ref_store_transaction_begin(refs, &err);
> +	transaction = ref_store_transaction_begin(refs, 0, &err);

Ah, OK, the "later" came soon enough.  It wasn't that we wanted to
cram multiple calls for "delete" in a single transaction.  It was
that we wanted to tweak how each transaction works by passing a
flag word.

>  struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
> +						    unsigned int flags,
>  						    struct strbuf *err)

OK.  And in this step, everybody passes 0 (i.e. no bit set) to the
function.

