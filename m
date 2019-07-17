Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DEE61F461
	for <e@80x24.org>; Wed, 17 Jul 2019 19:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfGQTVY (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 15:21:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:38740 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727235AbfGQTVX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 15:21:23 -0400
Received: (qmail 20503 invoked by uid 109); 17 Jul 2019 19:21:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Jul 2019 19:21:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11896 invoked by uid 111); 17 Jul 2019 19:22:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Jul 2019 15:22:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jul 2019 15:21:21 -0400
Date:   Wed, 17 Jul 2019 15:21:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Carlo Arenas <carenas@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
Message-ID: <20190717192121.GA5447@sigill.intra.peff.net>
References: <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
 <CAPUEspgD8E02FcNvBx96neGEejdqMDWoH8NgpsHyGPo_KM09FA@mail.gmail.com>
 <20190714005129.GA4525@sigill.intra.peff.net>
 <54c2ee44-ee99-ea4a-3154-f642e0060877@kdbg.org>
 <20190715144602.GA26636@sigill.intra.peff.net>
 <4be7a0a1-0256-40c3-4abc-d3d9302f527b@kdbg.org>
 <20190715181527.GA30747@sigill.intra.peff.net>
 <xmqqo91t3itl.fsf@gitster-ct.c.googlers.com>
 <20190716200101.GA6558@sigill.intra.peff.net>
 <xmqq1ryo1qdr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1ryo1qdr.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 17, 2019 at 11:13:04AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... My big question is if we use "{}" for gcc (and
> > compatible friends), does that squelch all of the complaints from other
> > compilers and tools that might see the "{0}" version? In particular,
> > does it work for sparse?
> 
> Yeah, I agree that it is the most important question.  The best
> solution is not to do the macro, use "= { 0 };" everywhere *and*
> somehow arrange sparse not to complain about it.  I am not sure if
> the last part is doable, though.

I did just check "make range-diff.sp" with this diff:

diff --git a/range-diff.c b/range-diff.c
index ba1e9a4265..481cefff3e 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -102,7 +102,7 @@ static int read_patches(const char *range, struct string_list *list)
 		}
 
 		if (starts_with(line, "diff --git")) {
-			struct patch patch = { 0 };
+			struct patch patch = { };
 			struct strbuf root = STRBUF_INIT;
 			int linenr = 0;
 

and it seems OK. So presumably we could just lump sparse into the list
of gcc-compatible platforms, and it would work. But it does require the
macro still for other hosts.

Other than that, our options seem to be:

  1. Live with it. IIRC we're already not sparse-clean, and Ramsay
     mostly looks at the diff to find new problems.

  2. Pass -Wno-non-pointer-null to sparse. Unfortunately that also
     disables more useful warnings (like passing "0" instead of NULL to
     a function).

  3. Switch to NULL here, and adhere to that going forward.

-Peff
