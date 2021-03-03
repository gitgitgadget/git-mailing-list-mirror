Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB68EC4361B
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF2064EC0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355388AbhCDAXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55130 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242420AbhCCTjr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 14:39:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F601BD34E;
        Wed,  3 Mar 2021 14:38:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xuBMqE0oCtjJ4fUCLvpiJIgqDBI=; b=tS8NXz
        ZqPli/kcEgyb6VQ2OPvFjfKzVP/xD3EFgJNkCApSkhqyCR9RIN0o3nXzQhUAaAYo
        aIYU0ctauZO+awD4pBqJ5lmxTe+E9xHi4J8JZOiKV86ggWakE2eJVUWczwMqCkBI
        HGENvMkLEMFCwNTN4FcJ1za2Y3vE1cwLGwfgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bLHj/SgI9M32zzK313wOBSRHmQubtkfA
        560kGRhWhbNnwuB7sEQ3bzb9AsuC2x1zWzQisfHlozTcJWP8vluJFFjU9hATXIk3
        GNkZA5eP0t1wYWlkZDgJ2Rh/eInsCgpsrXSF3CgoXIpId81saXgc2RAsIQewZWDI
        MW0eJ7xFKr8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76579BD34D;
        Wed,  3 Mar 2021 14:38:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EF091BD34C;
        Wed,  3 Mar 2021 14:38:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff King <peff@peff.net>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1?= =?utf-8?Q?bor?= 
        <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 01/12] pkt-line: eliminate the need for static buffer
 in packet_write_gently()
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <2d6858b1625aa3c96688c6c6a9157c2d2b16f43e.1613598529.git.gitgitgadget@gmail.com>
        <YDihb2Kspbh4FIlW@coredump.intra.peff.net>
        <9304ac66-f493-2150-95e3-15303c914ee3@jeffhostetler.com>
Date:   Wed, 03 Mar 2021 11:38:56 -0800
In-Reply-To: <9304ac66-f493-2150-95e3-15303c914ee3@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 26 Feb 2021 14:52:22 -0500")
Message-ID: <xmqq1rcwjacv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 183425A4-7C58-11EB-9EC8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> Right, I think it would be fine to malloc it here, but I didn't
> want to assume that everyone would think that.
>
> I'll change it.

I agree with both of you that the code is unnice in its stack usage
and we want fix with malloc(), or something like that, but sorry, I
think I merged this round by mistake to 'next'.

As we won't be merging the topic to the upcoming release anyway, I
am willing to revert the merge to 'next' and requeue an updated one,
when it appears (I am also OK to see an incremental update, "oops,
no, we realize we don't want to have it on the stack" fix-up, if
this is the only glitch in the series that need to be fixed).

Thanks.
