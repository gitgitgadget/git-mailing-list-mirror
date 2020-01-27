Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8CCC2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 20:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8F22467B
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 20:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ued5BMtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgA0UEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:04:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56237 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0UD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 15:03:59 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 656EA3AED9;
        Mon, 27 Jan 2020 15:03:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pbNZUuL9kOo+xRRZt0YKr4v8IAY=; b=ued5BM
        tJFwXPJXMBb6xNDk57fP3y7/kLDg2VYU0poB44M/BRtQfIa6e0Qe5N8HWo5k91lC
        BAQyavp1Uq/VflOcm21N08ZSVnvTHHB+6uSEiqsc3z9/twUZ5hUwCIYBW9soDOT+
        qrViA81f7+LA6gvJO30u0L7gZ2y6xwohBZeiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n3MgccyM8SAFYkplQVuig0joSD7F/EBl
        JLk4kippdAeUPX80GYIhOd/MUiShIo0kSlvPWZFfn429LYjw9zFqrrsB4T8s5ume
        W43fqwGV7mit17HQkRVPM2GRXHjUu4CZAYCSnBtVwSciw0AjlQDk1RTuV7LAJQgg
        imLmjRaUXqs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D4223AED8;
        Mon, 27 Jan 2020 15:03:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1FD83AED7;
        Mon, 27 Jan 2020 15:03:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] avoid computing zero offsets from NULL pointer
References: <20200125053542.GA744596@coredump.intra.peff.net>
        <20200125053834.GB744673@coredump.intra.peff.net>
Date:   Mon, 27 Jan 2020 12:03:55 -0800
In-Reply-To: <20200125053834.GB744673@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 25 Jan 2020 00:38:34 -0500")
Message-ID: <xmqq7e1cbr9w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26838392-4140-11EA-B760-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> switch to iterating with a numeric index (as we do in sequencer.c here).
> In other cases (like the cache_end one) the use of an end pointer is
> more natural; we can keep that by just explicitly checking for NULL when
> assigning the end pointer.
>
> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index 8509f9ea22..2f1fe48512 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -84,8 +84,8 @@ static void trim_common_tail(mmfile_t *a, mmfile_t *b)
>  {
>  	const int blk = 1024;
>  	long trimmed = 0, recovered = 0;
> -	char *ap = a->ptr + a->size;
> -	char *bp = b->ptr + b->size;
> +	char *ap = a->ptr ? a->ptr + a->size : a->ptr;
> +	char *bp = b->ptr ? b->ptr + b->size : b->ptr;
>  	long smaller = (a->size < b->size) ? a->size : b->size;
>  
>  	while (blk + trimmed <= smaller && !memcmp(ap - blk, bp - blk, blk)) {

Isn't it a bug for a->ptr or b->ptr to be NULL here?  Even if we
manage to assign ap = a->ptr = NULL without complaints, how would
that memcmp work?

Is it that the corresponding .size would always be 0 if .ptr is NULL
that protects us?

A bit puzzled.
