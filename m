Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF33C388F9
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 01:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E9EF22254
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 01:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xm24+4r4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgKTBck (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 20:32:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54839 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgKTBcj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 20:32:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 774BA9AD0C;
        Thu, 19 Nov 2020 20:32:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3EzyvQWW4Ofo
        Bd+xLsLrohgYQuI=; b=xm24+4r4wfFGH/xREsDoY/2GLArNE0BLTqB4a0700RMc
        pJmFOEpmCjjy8wNBtDulRoVNGbQrKji9mAdarqt0s4joqm+XGQH9ANoIOuD/hiRK
        d85VjarbJK3sfN/OuBC6Uq+O/o9w/wc8C7onPtPMHmu8MyIuGUM2YqQMbMhGxVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jzo1rm
        zvIG5XAo5eYPlnqhImhJV5WXoKDFkf0/J+oyIue0bgtsicohGkJmjTKEOoOB8KZQ
        If5bh+69BInPIPkHCJ6NjvE4JhAPvWIXxxAco8uMf0KiRX9fSiPmlzrcXHRGIH2R
        Z5+MX7/VlU+PPBh8X8mJVuj+HNa5cX5eu54SU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E48D9AD0B;
        Thu, 19 Nov 2020 20:32:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE3E59AD0A;
        Thu, 19 Nov 2020 20:32:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] tests: make sure nested lazy prereqs work reliably
References: <20201118190414.32616-1-szeder.dev@gmail.com>
        <20201119155824.GB25426@coredump.intra.peff.net>
        <20201119175608.GA132922@coredump.intra.peff.net>
        <xmqqd009xh19.fsf@gitster.c.googlers.com>
        <20201120001458.GA274082@coredump.intra.peff.net>
Date:   Thu, 19 Nov 2020 17:32:36 -0800
In-Reply-To: <20201120001458.GA274082@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 19 Nov 2020 19:14:58 -0500")
Message-ID: <xmqqlfewvmmj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 454E96D4-2AD0-11EB-A0C8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> OK, then here's the whole thing. I ended up with a few more cleanups,
> too. This is all on top of G=C3=A1bor's patches. It's conceptually
> independent, but the textual wrangling was annoying enough it didn't
> make any sense to require you to do it again during merging. ;) Plus I
> do not think either topic is high-risk nor urgent enough to worry too
> much about one blocking the other.

I'll ask you to do the last step maybe in a few weeks; the range
notation tests seem to have changed since where I queued G=C3=A1bor's
patches and where [4/4] is based on (yours is based on newer
codebase).

> The diffstat is scary, but it's mostly the final patch, which is pretty
> mechanical.

Yup, and the result is much easier to read.

Thanks.

>   [1/4]: t0000: keep clean-up tests together
>   [2/4]: t0000: run prereq tests inside sub-test
>   [3/4]: t0000: run cleaning test inside sub-test
>   [4/4]: t0000: consistently use single quotes for outer tests
>
>  t/t0000-basic.sh | 570 +++++++++++++++++++++++------------------------
>  1 file changed, 284 insertions(+), 286 deletions(-)
>
> -Peff
