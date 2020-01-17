Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039A3C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 17:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAC0206D5
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 17:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ky8xKCbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgAQRh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:37:29 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54237 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgAQRh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 12:37:29 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F195A6BF9;
        Fri, 17 Jan 2020 12:37:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+PbB+8eeU4dPBxoBVIgG1QNQqao=; b=ky8xKC
        bAOblCVu1N0xqQRDXrDpJNGyuo/EbmW4nC20uqQRFF5HR3v9COsQfEpV9FQ6Oa/K
        3qmP/ptaihVzfKro/rBVT3b1vikB/Dah36C2ik95xEFb/TeEPIOmvNcGxSL4i++Y
        NL2qNpcq/hil88uSjrbFXzfKPzTuSkoqh49MA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rVrFzto4BJiSWni39gz20AuK+8hfGMsc
        7g++pL82w++VlVTJG6l5z1craJZ7V2DozuWyq0bmStzcct4VfwXRO1Pl1zY6s3Tx
        jtCEX1NxwCT5jTipFJlG3SWEaX6L4don3eXv7j5xitCivBI16V5gzopHhE77NZkE
        6ps38fjQ65I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 376F8A6BF8;
        Fri, 17 Jan 2020 12:37:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5EA33A6BF7;
        Fri, 17 Jan 2020 12:37:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: use compat regex with SANITIZE=address
References: <20200116175138.GA691238@coredump.intra.peff.net>
Date:   Fri, 17 Jan 2020 09:37:22 -0800
In-Reply-To: <20200116175138.GA691238@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 16 Jan 2020 12:51:38 -0500")
Message-ID: <xmqqr1zydlwt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05B35B6C-3950-11EA-B955-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Recent versions of the gcc and clang Address Sanitizer produce test
> failures related to regexec(). This triggers with gcc-10 and clang-8
> (but not gcc-9 nor clang-7). Running:
>
>   make CC=gcc-10 SANITIZE=address test
>
> results in failures in t4018, t3206, and t4062.
> ...
> We can work around that by having the preprocessor replace regexec with
> git_regexec (both in the callers and in the actual implementation), and
> we truly end up with a call to our custom regex code, even when
> compiling with ASan. That's probably a good thing to do anyway, as it
> means anybody looking at the symbols later (e.g., in a debugger) would
> have a better indication of which function is which. So we'll do the
> same for the other common regex functions (even though just regexec() is
> enough to fix this ASan problem).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Makefile             | 3 +++
>  compat/regex/regex.h | 5 +++++
>  2 files changed, 8 insertions(+)

I guess we should treat this the same way as the recent vcproj "fix"
by Dscho, i.e. fast-track to 'maint' to ensure that all public
integration branches has it soonish?

Thanks.
