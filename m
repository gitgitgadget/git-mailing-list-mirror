Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A005C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE61D20786
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hiW3wWC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgH0EaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:30:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55058 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgH0EaT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 00:30:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5FC5F0F56;
        Thu, 27 Aug 2020 00:30:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EvJiaQHjstYBGCRsPkJPcPa8hHI=; b=hiW3wW
        C5HAFLbG/o1iBWnPSShaIFdSleyYwFa5jdzRaVrtnkGJICqiTQ9qwxU08bJsFFTu
        Hr6zEci0XHxxgmixrLLFEmlbTgvKIEa3lxVhK/tRqmnP7QMBreDJEe9vOYMF6Y3R
        vFnJeq1Xcgffuns2BjzblpYvfIV8oxUZAzhWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PCj5EQATgnE3MyjTnAEvnS0EeuTs4w88
        7rjbQPPZXTrFnB7ZKgZHLzpziFyA9j4Uz2hwvHbmDeiOf5wFniYjjc9Je2X0lOyb
        6+a9WYiPwaoIz9wzgvEUXtr1Kkbf5MIB4k5Hxg89UwKSQa6EB9Ov9fjTSLm9SE8y
        E64wvshHlBQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0579F0F55;
        Thu, 27 Aug 2020 00:30:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 039CEF0F53;
        Thu, 27 Aug 2020 00:30:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] run_command: teach API users to use embedded 'args' more
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
        <20200826194650.4031087-1-gitster@pobox.com>
        <20200826194650.4031087-3-gitster@pobox.com>
        <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com>
        <xmqqmu2ht58g.fsf_-_@gitster.c.googlers.com>
        <20200827042157.GC3346457@coredump.intra.peff.net>
Date:   Wed, 26 Aug 2020 21:30:13 -0700
In-Reply-To: <20200827042157.GC3346457@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 27 Aug 2020 00:21:57 -0400")
Message-ID: <xmqqlfi0sobu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00EAEDDE-E81E-11EA-86E1-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I've actually considered dropping child_process.argv entirely. Having
> two separate ways to do the same thing gives the potential for
> confusion. But I never dug into whether any existing callers would be
> made worse for it (I kind of doubt it, though; worst case they can use
> strvec_pushv). There are still several left after this patch, it seems.
>
> Likewise for child_process.env_array.

Yup, conversion similar to what I did in this patch may be too
trivial for #microproject, but would nevertheless be a good
#leftoverbits task.  The removal of .argv/.env is not entirely
trivial but a good candidate for #microproject.

Thanks.

