Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA6B1F45F
	for <e@80x24.org>; Wed,  8 May 2019 07:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfEHHH5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 03:07:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:51312 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725884AbfEHHH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 03:07:57 -0400
Received: (qmail 545 invoked by uid 109); 8 May 2019 07:07:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 May 2019 07:07:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20882 invoked by uid 111); 8 May 2019 07:08:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 08 May 2019 03:08:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 May 2019 03:07:54 -0400
Date:   Wed, 8 May 2019 03:07:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] coccicheck: optionally batch spatch invocations
Message-ID: <20190508070754.GA9195@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
 <20190503144211.GH14763@szeder.dev>
 <20190503174503.GA8242@sigill.intra.peff.net>
 <CA+P7+xoRGVAP4nHE=neUZGkn9RX_hxN9xVzfWexR79ZWT0ejSQ@mail.gmail.com>
 <20190506051148.GB30003@sigill.intra.peff.net>
 <CACsJy8CLjUdHCro8QJfTozMB0xVWppHuFRSLCvFSaeKO_PxAog@mail.gmail.com>
 <20190506234334.GA13296@sigill.intra.peff.net>
 <xmqq7eb3nfxn.fsf@gitster-ct.c.googlers.com>
 <20190507025501.GA3417@sigill.intra.peff.net>
 <xmqqh8a6n9wv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8a6n9wv.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 07, 2019 at 01:52:32PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yes, 2^31-1 is probably a better number, but it's harder to write out. :)
> >
> > Here's what a patch might look like to implement "0". By still using
> > xargs in the unlimited code path, it's not too bad. I dunno.
> 
> As somebody who is too used to run "diff -U999" and be happy, I
> cannot claim that I care enough, but the result does not look
> too bad.

OK. With two "not too bad" comments (plus my own similar feeling), let's
just do it. Here it is as a patch on top. It can also be squashed into
the tip of jk/cocci-batch, but then we should probably s/999/0/ in the
commit message. :)

-- >8 --
Subject: [PATCH] coccicheck: make batch size of 0 mean "unlimited"

If you have the memory to handle it, the ideal case is to run a single
spatch invocation with all of the source files. But the only way to do
so now is to pick an arbitrarily large batch size. Let's make "0" do
this, which is a little friendlier (and doesn't otherwise have a useful
meaning).

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index daba958b8f..9cea614523 100644
--- a/Makefile
+++ b/Makefile
@@ -1176,6 +1176,7 @@ SP_EXTRA_FLAGS =
 
 # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
+# Setting it to 0 will feed all files in a single spatch invocation.
 SPATCH_FLAGS = --all-includes --patch .
 SPATCH_BATCH_SIZE = 1
 
@@ -2792,7 +2793,12 @@ endif
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	@echo '    ' SPATCH $<; \
-	if ! echo $(COCCI_SOURCES) | xargs -n $(SPATCH_BATCH_SIZE) \
+	if test $(SPATCH_BATCH_SIZE) = 0; then \
+		limit=; \
+	else \
+		limit='-n $(SPATCH_BATCH_SIZE)'; \
+	fi; \
+	if ! echo $(COCCI_SOURCES) | xargs $$limit \
 		$(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
 		>$@+ 2>$@.log; \
 	then \
-- 
2.21.0.1314.g224b191707

