Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6392B1F45F
	for <e@80x24.org>; Wed,  8 May 2019 22:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfEHWjh (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 18:39:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:52542 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727572AbfEHWjg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 18:39:36 -0400
Received: (qmail 4512 invoked by uid 109); 8 May 2019 22:39:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 May 2019 22:39:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28814 invoked by uid 111); 8 May 2019 22:40:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 08 May 2019 18:40:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 May 2019 18:39:34 -0400
Date:   Wed, 8 May 2019 18:39:34 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] coccicheck: optionally batch spatch invocations
Message-ID: <20190508223934.GB19990@sigill.intra.peff.net>
References: <20190503174503.GA8242@sigill.intra.peff.net>
 <CA+P7+xoRGVAP4nHE=neUZGkn9RX_hxN9xVzfWexR79ZWT0ejSQ@mail.gmail.com>
 <20190506051148.GB30003@sigill.intra.peff.net>
 <CACsJy8CLjUdHCro8QJfTozMB0xVWppHuFRSLCvFSaeKO_PxAog@mail.gmail.com>
 <20190506234334.GA13296@sigill.intra.peff.net>
 <xmqq7eb3nfxn.fsf@gitster-ct.c.googlers.com>
 <20190507025501.GA3417@sigill.intra.peff.net>
 <xmqqh8a6n9wv.fsf@gitster-ct.c.googlers.com>
 <20190508070754.GA9195@sigill.intra.peff.net>
 <20190508123610.GA19502@archbookpro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190508123610.GA19502@archbookpro.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 08, 2019 at 08:36:10AM -0400, Denton Liu wrote:

> >  %.cocci.patch: %.cocci $(COCCI_SOURCES)
> >  	@echo '    ' SPATCH $<; \
> > -	if ! echo $(COCCI_SOURCES) | xargs -n $(SPATCH_BATCH_SIZE) \
> > +	if test $(SPATCH_BATCH_SIZE) = 0; then \
> > +		limit=; \
> > +	else \
> > +		limit='-n $(SPATCH_BATCH_SIZE)'; \
> > +	fi; \
> 
> Could we pull `limit` out of the recipe and into a make variable? You
> mentioned earlier that you wanted to do this but it was too complicated
> but now that it's written like this, it seem like it'd be pretty easy to
> do.

Yes, we could, because this part of it is a straight text substitution
in the recipe, and not a conditional. I don't know that it's any more
readable, though. Either that same conditional gets split out like:

  ifeq ($(SPATCH_BATCH_SIZE),0)
  SPATCH_LIMIT =
  else
  SPATCH_LIMIT = -n $(SPATCH_BATCH_SIZE)
  endif

or we do it inline, but IMHO it's still pretty cluttered:

diff --git a/Makefile b/Makefile
index 9cea614523..aedc7b80a8 100644
--- a/Makefile
+++ b/Makefile
@@ -2793,12 +2793,8 @@ endif
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	@echo '    ' SPATCH $<; \
-	if test $(SPATCH_BATCH_SIZE) = 0; then \
-		limit=; \
-	else \
-		limit='-n $(SPATCH_BATCH_SIZE)'; \
-	fi; \
-	if ! echo $(COCCI_SOURCES) | xargs $$limit \
+	if ! echo $(COCCI_SOURCES) | \
+	     xargs $(if $(filter 0,$(SPATCH_BATCH_SIZE)),,-n $(SPATCH_BATCH_SIZE)) \
 		$(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
 		>$@+ 2>$@.log; \
 	then \

It gets a little better if we make the sentinel value the empty string
instead of "0" (you can drop the filter).

-Peff
