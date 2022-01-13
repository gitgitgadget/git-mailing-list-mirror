Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1BEC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 00:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiAMAYs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 19:24:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60179 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiAMAYk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 19:24:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81DB3117820;
        Wed, 12 Jan 2022 19:24:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z3SzXbkUYGbM44CnN9WRDMRwA7Kst/xP1LOa0B
        rI+yY=; b=A4ex1s74WsXtJde5IzQkFrRYnj8oTpxu7Svv1LVA3acq5axaOWiWsI
        bGwW9t7kKHGHdDJQrbyTH24OfuCJnXJLW9l35a9UrHF91whOdyMKFrECLXQcIuZ1
        lUEqloHVK8DyGlK6SsNISBtGdAcpaJwUA87YLr0GI5xw/eYpqSTyo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78A0D11781F;
        Wed, 12 Jan 2022 19:24:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D031411781C;
        Wed, 12 Jan 2022 19:24:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: Re: [PATCH v2 1/6] refs: open-code deletion of packed refs
References: <cover.1638874287.git.ps@pks.im> <cover.1641556319.git.ps@pks.im>
        <0739f085b266e65b423ccc14f70cc00c88744459.1641556319.git.ps@pks.im>
Date:   Wed, 12 Jan 2022 16:24:36 -0800
In-Reply-To: <0739f085b266e65b423ccc14f70cc00c88744459.1641556319.git.ps@pks.im>
        (Patrick Steinhardt's message of "Fri, 7 Jan 2022 12:55:13 +0100")
Message-ID: <xmqqy23kjxdn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31151766-7407-11EC-8F05-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

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

This breaks "make hdr-check" (which is part of CI -- static-analysis).

----- >8 --------- >8 --------- >8 --------- >8 -----
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 12 Jan 2022 16:24:13 -0800
Subject: [PATCH] fixup! refs: open-code deletion of packed refs

---
 refs/packed-backend.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 5e0dd7d08e..a2cca5d9a3 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -3,6 +3,7 @@
 
 struct repository;
 struct ref_transaction;
+struct string_list;
 
 /*
  * Support for storing references in a `packed-refs` file.
-- 
2.35.0-rc0-185-gedd802a149



