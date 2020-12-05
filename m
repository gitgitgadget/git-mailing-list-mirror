Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A31C1B0D8
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 18:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A716230FD
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 18:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgLESTW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 5 Dec 2020 13:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgLESSt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 13:18:49 -0500
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B056C061A4F
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 10:18:20 -0800 (PST)
Received: from ip6-localhost ([::1] helo=moveme2)
        by 0x63.nu with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <anders@0x63.nu>)
        id 1klc8J-007Hfp-GS; Sat, 05 Dec 2020 19:18:11 +0100
References: <20201025212652.3003036-1-anders@0x63.nu> <20201205013918.18981-1-avarab@gmail.com>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        christian.couder@gmail.com, peff@peff.net, jonathantanmy@google.com
Subject: Re: [PATCH 0/5] pretty format %(trailers): improve machine readability
In-reply-to: <20201205013918.18981-1-avarab@gmail.com>
Date:   Sat, 05 Dec 2020 19:18:11 +0100
Message-ID: <87wnxwp15o.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Ævar Arnfjörð Bjarmason writes:

> I started writing this on top of "master", but then saw the
> outstanding series of other miscellaneous fixes to this
> facility[1]. This is on top of that topic & rebased on master.
>
> Anders, any plans to re-roll yours? Otherwise the conflicts I'd have
> on mine are easy to fix, so I can also submit it as a stand-alone.

Yes, I have plans to do that. But have yet to carve out the required
time from my copious spare time to actually do it.

So please don't hold your breath waiting for me to do that.

> This series comes out of a discussion at work today (well, yesterday
> at this point) where someone wanted to parse %(trailers) output. As
> noted in 3/5 doing this is rather tedious now if you're trying to
> unambiguously grap trailers as a stream of key-value pairs.
>
> So this series adds a "key_value_separator" and "keyonly" parameters,
> and fixes a few bugs I saw along the way.

Interesting. When adding "valueonly" I never consider it being used
without "key". The trick you are doing with separate keyonly and
valueonly is quite clever.

I've only been doing machine parsing for explicit keys, things like:
"%cn%x00%x00%an%x00%x00%(trailers:key=Reviewed-By,valueonly,unfold,separator=%x00)%x00%x00%(trailers:key=Backport-Reviewed-By,valueonly,unfold,separator=%x00)"
(double-NUL to separate field, single-NUL to separate values within field).

But I can't help wonder that if the goal just is to have a nice machine
parsable format maybe it would be easier (both for user and
implementation) to have a separate placeholder for "machine readable
trailers" which by default emits in a format suitable for machine
parsing. Something like a new "%(ztrailers)" (but with a better name)
which simply emits a sequence of "<KEY> NUL <VAL> NUL" for each trailer.
