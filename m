Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA1CC55179
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 19:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A80C20756
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 19:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EnFAuXez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829497AbgJ0TNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 15:13:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57460 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829496AbgJ0TNI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 15:13:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD39D99F16;
        Tue, 27 Oct 2020 15:13:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ajOCEhfL2FKVhCauiRD2hP8bJps=; b=EnFAuX
        ez76t+kCV4NCUbSd4Ju9D6X6j+qZhpIznFJYRq3LtD4XkoADif4we1nQZjRGI3kj
        QlLAUvkxpFioMaeVrvPGanvzRDR/HUfZcLD2X+smCJP0em96TyjNUtydBQtEKENb
        mtx/82bKg/CzptgJjjLF8BkYaYG2SvRpQBnVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Go8AhjhEG6arbgDKcDPVHEjeQfs4yoY+
        Z8dA7M33kQOPwxE0kMKae0BlqG9fJgzJ1Ntfg8mHDiKOf+Srd4c4hYiD1RZWVTQp
        zRSPdNtRw+N50eiMABmKc4zVbaTypFspUMXzV0ua0+zQnXXePP7sIUq2xeQUcw28
        e4ndBtKJMi0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1C2199F14;
        Tue, 27 Oct 2020 15:13:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D664B99F13;
        Tue, 27 Oct 2020 15:13:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] fix error handling in checkout-index
References: <20201027073000.GA3651896@coredump.intra.peff.net>
Date:   Tue, 27 Oct 2020 12:13:03 -0700
In-Reply-To: <20201027073000.GA3651896@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 27 Oct 2020 03:30:00 -0400")
Message-ID: <xmqq1rhjcwjk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 709E3E5C-1888-11EB-99F6-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> While working on another topic, I noticed that "git checkout-index --
> path" does not propagate errors through its exit code. It has been that
> way for so long that I almost wondered if it is intentional, but I'm
> pretty sure it's not. A bit scary, though. :)

Quite honestly, at this point, I do not think the intention matters
any more.  If somebody depends on the behaviour and wrote

    do some thing &&
    git checkout-index -- $path_that_is_possibly_missing &&
    do another thing &&

then this change _will_ be a regression, whether it was originally
done this way on purpose or not.

I do not think it is the kind of regression that we should avoid,
though.  I'd say that we should bite the bullet and fix it, as it
should also be easy to fix/adjust such a collateral damage.  That
would make the world a better place in the end.

Thanks.

>   [1/2]: checkout-index: drop error message from empty --stage=all
>   [2/2]: checkout-index: propagate errors to exit code
>
>  builtin/checkout-index.c        | 16 ++++++++++++++--
>  t/t2004-checkout-cache-temp.sh  | 10 +++++++++-
>  t/t2006-checkout-index-basic.sh | 11 +++++++++++
>  3 files changed, 34 insertions(+), 3 deletions(-)
>
> -Peff
