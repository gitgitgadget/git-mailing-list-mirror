Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 097F21F45F
	for <e@80x24.org>; Mon,  6 May 2019 05:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfEFFLw (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 01:11:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:48896 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725813AbfEFFLv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 01:11:51 -0400
Received: (qmail 27657 invoked by uid 109); 6 May 2019 05:11:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 May 2019 05:11:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30183 invoked by uid 111); 6 May 2019 05:12:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 May 2019 01:12:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2019 01:11:49 -0400
Date:   Mon, 6 May 2019 01:11:49 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] coccicheck: optionally process every source file at once
Message-ID: <20190506051148.GB30003@sigill.intra.peff.net>
References: <cover.1555487380.git.liu.denton@gmail.com>
 <20190422214901.GA14528@sigill.intra.peff.net>
 <20190425120758.GD8695@szeder.dev>
 <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
 <20190501100108.GA8954@archbookpro.localdomain>
 <20190502000422.GF14763@szeder.dev>
 <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
 <20190503144211.GH14763@szeder.dev>
 <20190503174503.GA8242@sigill.intra.peff.net>
 <CA+P7+xoRGVAP4nHE=neUZGkn9RX_hxN9xVzfWexR79ZWT0ejSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xoRGVAP4nHE=neUZGkn9RX_hxN9xVzfWexR79ZWT0ejSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 05, 2019 at 11:08:35AM -0700, Jacob Keller wrote:

> > Jacob Keller's patches to collapse this to a single invocation do fix it
> > (and I've used them selectively in the past rather than cleaning up the
> > resulting patch manually ;) ).
> >
> > Sort of tangential to your point, I guess, but it might be a topic to
> > revisit.
> 
> Yea, my patches are much faster. However, they trade off a huge
> increase in memory consumption, and from what I remember, the failure
> if you don't have enough RAM was not a good experience.

I think there was a suggestion to make it conditional. So maybe
something like this?

-- >8 --
From: Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] coccicheck: optionally process every source file at once

make coccicheck is used in order to apply coccinelle semantic patches,
and see if any of the transformations found within contrib/coccinelle/
can be applied to the current code base.

Provide an option to pass every file to a single invocation of spatch,
instead of running spatch once per source file.

This reduces the time required to run make coccicheck by a significant
amount of time:

Prior timing of make coccicheck
  real    6m14.090s
  user    25m2.606s
  sys     1m22.919s

New timing of make coccicheck
  real    1m36.580s
  user    7m55.933s
  sys     0m18.219s

This is nearly a 4x decrease in the time required to run make
coccicheck. This is due to the overhead of restarting spatch for every
file. By processing all files at once, we can amortize this startup cost
across the total number of files, rather than paying it once per file.

However, it comes at a cost. The RSS of each spatch process goes from
~50MB to ~1500MB (and peak memory usage may be even higher if make runs
multiple rule files in parallel due to "-j"). That's enough to make some
systems (like our Travis build!) fail the whole process, or could make
things slower due to swapping. So let's make the new behavior optional,
and people with a lot of memory can choose to use it.

[peff: modified Jacob's patch to make the behavior optional, since
 people reported complications due to the memory use]

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
The conditional here is implemented as shell. I couldn't find a way to
do it readably with a make ifdef, since we're in the middle of a
backslash-connected shell command in the recipe. And trying to use $(if)
just turned into a mess.

But maybe some gnu make hotshot wants to show me how it's done. ;)

 Makefile | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 9f1b6e8926..5870ea200e 100644
--- a/Makefile
+++ b/Makefile
@@ -1174,8 +1174,11 @@ PTHREAD_CFLAGS =
 SPARSE_FLAGS ?=
 SP_EXTRA_FLAGS =
 
-# For the 'coccicheck' target
+# For the 'coccicheck' target; set USE_SINGLE_SPATCH to invoke a single spatch
+# for all sources, rather than one per source file. That generally runs faster,
+# at the cost of using much more peak memory (on the order of 1-2GB).
 SPATCH_FLAGS = --all-includes --patch .
+USE_SINGLE_SPATCH =
 
 include config.mak.uname
 -include config.mak.autogen
@@ -2790,11 +2793,16 @@ endif
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	@echo '    ' SPATCH $<; \
-	ret=0; \
-	for f in $(COCCI_SOURCES); do \
-		$(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
-			{ ret=$$?; break; }; \
-	done >$@+ 2>$@.log; \
+	if test -z "$(USE_SINGLE_SPATCH)"; then \
+		ret=0; \
+		for f in $(COCCI_SOURCES); do \
+			$(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
+				{ ret=$$?; break; }; \
+		done >$@+ 2>$@.log; \
+	else \
+		$(SPATCH) --sp-file $< $(COCCI_SOURCES) $(SPATCH_FLAGS) >$@+ 2>$@.log; \
+		ret=$$?; \
+	fi; \
 	if test $$ret != 0; \
 	then \
 		cat $@.log; \
-- 
2.21.0.1314.g224b191707

