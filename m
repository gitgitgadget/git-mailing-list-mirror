Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 375F91F45F
	for <e@80x24.org>; Tue,  7 May 2019 02:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfEGCzE (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 22:55:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:49734 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726852AbfEGCzE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 22:55:04 -0400
Received: (qmail 10947 invoked by uid 109); 7 May 2019 02:55:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 May 2019 02:55:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6672 invoked by uid 111); 7 May 2019 02:55:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 May 2019 22:55:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2019 22:55:01 -0400
Date:   Mon, 6 May 2019 22:55:01 -0400
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
Message-ID: <20190507025501.GA3417@sigill.intra.peff.net>
References: <20190501100108.GA8954@archbookpro.localdomain>
 <20190502000422.GF14763@szeder.dev>
 <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
 <20190503144211.GH14763@szeder.dev>
 <20190503174503.GA8242@sigill.intra.peff.net>
 <CA+P7+xoRGVAP4nHE=neUZGkn9RX_hxN9xVzfWexR79ZWT0ejSQ@mail.gmail.com>
 <20190506051148.GB30003@sigill.intra.peff.net>
 <CACsJy8CLjUdHCro8QJfTozMB0xVWppHuFRSLCvFSaeKO_PxAog@mail.gmail.com>
 <20190506234334.GA13296@sigill.intra.peff.net>
 <xmqq7eb3nfxn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7eb3nfxn.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 07, 2019 at 11:42:28AM +0900, Junio C Hamano wrote:

> > Making "0" work as "unlimited" might be nice, but xargs doesn't support
> > that and I didn't want to make the recipe any more unreadable than it
> > already is.
> 
> Sounds good.  After reading the log message, I was curious if there
> is a mechanism that makes 999 special (like 0 in your hypothetical
> "0 means unlimited"), but I guess it is just "any number that is
> greater than the number of source files we have will do".

Yes, 2^31-1 is probably a better number, but it's harder to write out. :)

Here's what a patch might look like to implement "0". By still using
xargs in the unlimited code path, it's not too bad. I dunno.

---
diff --git a/Makefile b/Makefile
index daba958b8f..0765a59b7a 100644
--- a/Makefile
+++ b/Makefile
@@ -2792,7 +2792,12 @@ endif
 
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

-Peff
