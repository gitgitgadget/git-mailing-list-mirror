Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293A2C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 094A760234
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbhINONE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:13:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:46952 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233654AbhINOND (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 10:13:03 -0400
Received: (qmail 24188 invoked by uid 109); 14 Sep 2021 14:11:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 14:11:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23321 invoked by uid 111); 14 Sep 2021 14:11:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 10:11:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 10:11:45 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] merge-recursive: use fspathcmp() in path_hashmap_cmp()
Message-ID: <YUCtoa4Wv1GWT1LE@coredump.intra.peff.net>
References: <512abaef-d71c-9308-6a62-f37b4de69e60@web.de>
 <YSvsQcGNpCMZwS8o@nand.local>
 <xmqqeeaa6fey.fsf@gitster.g>
 <8d2e0876-9441-9665-ebb1-8cb28902014b@web.de>
 <YS1EVq2Gz+sPhw3c@coredump.intra.peff.net>
 <8bd13e99-208b-4c22-90e6-28227593e9c4@web.de>
 <nycvar.QRO.7.76.6.2109131335260.55@tvgsbejvaqbjf.bet>
 <YT+FzPT0RCP2PdNL@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2109141215140.55@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2109141215140.55@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 12:18:35PM +0200, Johannes Schindelin wrote:

> Seeing as there seems to be some appetite for refactoring Git's code on
> this list, I am thinking that the `struct repository *r` direction might
> be the one to go for. And I mean like "move the globals into that struct"
> as opposed to introducing that stack you talked about. It would even be a
> refactoring where I would understand the motivation, and agree with it,
> too.

Oh, definitely. Regardless of whether step 2 is "pass around the
repository struct" or "treat the global repository struct as a stack",
step 1 must be putting repository-related globals into the struct. I
don't think there can be any solution that doesn't start with that. :)

And I think it can even be done incrementally with very little impact.
Just s/ignore_case/the_repository->ignore_case/ in the use-sites is an
improvement over the status quo. Even though it doesn't _fix_ anything,
now we can easily see where the dependencies on repo-variables are. And
of course follow-on steps to make sure we are passing around and
accessing the right repository struct are then welcome.

-Peff
