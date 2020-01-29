Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93101C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 05:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362EA207FD
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 05:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XT0kSBCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgA2FQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:16:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50232 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgA2FQo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 00:16:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA72B46FAA;
        Wed, 29 Jan 2020 00:16:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tA97Sj+0LL7qnCQsrLBd13s7RRc=; b=XT0kSB
        CUPfiCAohzJVP/TbpftPSPjuYRv5Qp2RIph7v0od+P6yZ6J0XJa3KCEY47BWXQvD
        KcOpL45ieCKdV94xtCD9MzRm2wM58J6uesxMJSVnnh8ZRFdJM5gI4As/YAxEhRoI
        aDO2EBMYk0yZTmY9a1qSMRq/wjbQQyfj/1Qrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tay+9FUVH9iBV8oklKNer+2EXIY1aOPP
        I0DUo5Z2dNhNOQVxBoyRHhB4WD83jx70qM/Ecv5axe2Dyvj3H29U5Sq3QnYVtrCH
        9PTHcmmXYkVail1doYPVvQzWjURUDqk9yJZedhRc4vxT6ZhfrG6PDT9NgYNfJnbb
        hBKbsj5R2ic=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2B4646FA8;
        Wed, 29 Jan 2020 00:16:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F38AD46FA7;
        Wed, 29 Jan 2020 00:16:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] avoid computing zero offsets from NULL pointer
References: <20200125053542.GA744596@coredump.intra.peff.net>
        <20200125053834.GB744673@coredump.intra.peff.net>
        <xmqq7e1cbr9w.fsf@gitster-ct.c.googlers.com>
        <20200127211933.GA3794@coredump.intra.peff.net>
        <xmqqtv4f8nlm.fsf@gitster-ct.c.googlers.com>
        <20200129023146.GA596379@coredump.intra.peff.net>
Date:   Tue, 28 Jan 2020 21:16:39 -0800
In-Reply-To: <20200129023146.GA596379@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Jan 2020 21:31:46 -0500")
Message-ID: <xmqqblqm7sg8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88554102-4256-11EA-A2B6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yep, but it's not much different than the hundreds of other function
> interfaces we have where sometimes you can pass NULL and sometimes not.
>
> So anyway. What do we want to do here? The fix I have? Something more
> elaborate and reusable? Or perhaps just switch it to:

My preference was to take the patch as-is, as it was clear enough,
before seeing this one ...

> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index 3cd2ac2855..4d20069302 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -84,8 +84,8 @@ static void trim_common_tail(mmfile_t *a, mmfile_t *b)
>  {
>  	const int blk = 1024;
>  	long trimmed = 0, recovered = 0;
> -	char *ap = a->ptr ? a->ptr + a->size : a->ptr;
> -	char *bp = b->ptr ? b->ptr + b->size : b->ptr;
> +	char *ap = a->size ? a->ptr + a->size : a->ptr;
> +	char *bp = b->size ? b->ptr + b->size : b->ptr;
>  	long smaller = (a->size < b->size) ? a->size : b->size;
>  
>  	while (blk + trimmed <= smaller && !memcmp(ap - blk, bp - blk, blk)) {
>
> By checking "size" instead of "ptr", then we know that the addition is a
> noop. And we'd continue to catch a NULL pointer mixed with a non-zero
> length (as a segfault). And a non-NULL pointer with a zero length does
> the right thing.

which makes quite a lot of sense.
