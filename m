Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0CDC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 19:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiJNToF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 15:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJNToE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 15:44:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3A12FC0A
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 12:44:03 -0700 (PDT)
Received: (qmail 14311 invoked by uid 109); 14 Oct 2022 19:44:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Oct 2022 19:44:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1456 invoked by uid 111); 14 Oct 2022 19:44:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Oct 2022 15:44:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Oct 2022 15:44:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] bisect--helper: plug strvec leak
Message-ID: <Y0m8AU+Yf7PREI2E@coredump.intra.peff.net>
References: <xmqqy1tunjgp.fsf@gitster.g>
 <221006.86a668r5mf.gmgdl@evledraar.gmail.com>
 <xmqqk05cipq8.fsf@gitster.g>
 <1965b54b-122a-c965-f886-1a7dd6afbfb4@web.de>
 <Y0TXTl0gSBOFQa9B@coredump.intra.peff.net>
 <xmqq35buykz1.fsf@gitster.g>
 <Y0VtkmNwjKcXcemP@coredump.intra.peff.net>
 <xmqqpmeyuvxt.fsf@gitster.g>
 <221011.86czayns5x.gmgdl@evledraar.gmail.com>
 <xmqq8rlmujcz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8rlmujcz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2022 at 02:43:24PM -0700, Junio C Hamano wrote:

> > -	if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
> > +	if (run_command_opt_l(RUN_GIT_CMD, "-C", repo, "sparse-checkout",
> > +			      "set", NULL)) {
> 
> And this does give us protection from the "Programmers can give
> unterminated list to run_command_v_opt() by mistake", which is not
> really solved mechanically even if the list is prepared with the
> strvec API (because the compiler has to be smart enough to know that
> argv.v was prepared with proper use of the API), which is nice.

Yeah, I agree this addresses the point I raised (which I am somewhat
regretting raising, as IMHO it was not worth the amount of discussion
that has ensued).

Since nobody asked, my _real_ opinion is that I prefer René's original
that used an actual struct, and its auto-freeing strvec. And I'd be
happy to see all of the run_command_v() variants go away entirely. It
does save a few lines, but with modern niceties, it's not very many, and
it's much less flexible.

I resisted saying so earlier because I do not think it is even worth
anybody's time to think about, let alone implement.

-Peff
