Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E028C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53787610CA
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhKSRGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 12:06:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52118 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhKSRGq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 12:06:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A183DF0712;
        Fri, 19 Nov 2021 12:03:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xS0rYfnHEUrr
        UIGAw7aUi2tEhMO5UXpSQpGjhK6X5GI=; b=C612r1dFXE708MV4Yz0YonIXsZyP
        RUZClhqxBpVfHPdRlm6OSjcTbHJMFTtB9FFfFj/BXuYfR15Y+X+dmDAgD3mEYmo+
        khO9og5RPzkn0OldpX5WxW+zqel08fPPIEPJl64V286AQtMR+Ts60doRavn0QoWc
        L+IA6AXQQtiOPUs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 969A4F0710;
        Fri, 19 Nov 2021 12:03:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F31E2F070F;
        Fri, 19 Nov 2021 12:03:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [Question] Unicode weirdness breaking tests on ZFS?
References: <9393e572-0666-6485-df29-abad5e0d32a1@gmail.com>
        <20211117161226.xcat77ewhf5inaif@tb-raspi4>
        <20211117170613.kyoe6ov2m5wi2i56@tb-raspi4>
        <20211117173924.maporsti5cz2ixsu@tb-raspi4>
        <8a3d0d0e-cc82-b696-00f4-b71e6452e1bd@gmail.com>
        <5d1b5ce6-d9ff-1b2a-2ff2-19813c957a24@gmail.com>
        <20211119154405.xhoqfh3vmljxbh5c@tb-raspi4>
Date:   Fri, 19 Nov 2021 09:03:42 -0800
In-Reply-To: <20211119154405.xhoqfh3vmljxbh5c@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Fri, 19 Nov 2021 16:44:05
 +0100")
Message-ID: <xmqqmtm0qdqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A70CF7C2-495A-11EC-BA69-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Should we conclude that the underlying os/zfs is not stable ?
> Things don't seem to be reproducable
>
> What Git needs here in t0050 is that stat("=C3=A4") behaves the same as=
 stat("a=C2=A8"),
> when either "=C3=A4" or "a=C2=A8" exist on disk.
> The same for open() and all other file system functions.

We either need to see these two are treated as the same thing, or
these two are treated as two distict filesystem entities, just like
stat("a") and stat("b") are.  What we absolutely need is the
unification either always happens or never happens consistently.

I wonder what readdir() is returning.  After creat("=C3=A4") in an empty
directory, does readdir() in there return "=C3=A4" or "a=C2=A8?  And vice
versa?  Is this also inconsistent?

> ("=C3=A4" is the precomposed form "a=C2=A8" is the decomposed form,
>  typically both render to the same glyph on the screen,
>  and a hex dump or xxd will show what we had.
>  I just use this notation here for illustration)
>
> Should we contact the zfs developers ?
