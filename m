Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673DDC433E5
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 502B820702
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgHUR6D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:58:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:37302 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgHUR6C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 13:58:02 -0400
Received: (qmail 19024 invoked by uid 109); 21 Aug 2020 17:58:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 17:58:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30240 invoked by uid 111); 21 Aug 2020 17:58:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 13:58:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 13:58:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] index-pack: adjust default threading cap
Message-ID: <20200821175800.GC3263141@coredump.intra.peff.net>
References: <20200821175153.GA3263018@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200821175153.GA3263018@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit b8a2486f15 (index-pack: support multithreaded delta resolving,
2012-05-06) describes an experiment that shows that setting the number
of threads for index-pack higher than 3 does not help.

I repeated that experiment using a more modern version of Git and a more
modern CPU and got different results.

Here are timings for p5302 against linux.git run on my laptop, a Core
i9-9880H with 8 cores plus hyperthreading (so online-cpus returns 16):

  5302.3: index-pack 0 threads                   256.28(253.41+2.79)
  5302.4: index-pack 1 threads                   257.03(254.03+2.91)
  5302.5: index-pack 2 threads                   149.39(268.34+3.06)
  5302.6: index-pack 4 threads                   94.96(294.10+3.23)
  5302.7: index-pack 8 threads                   68.12(339.26+3.89)
  5302.8: index-pack 16 threads                  70.90(655.03+7.21)
  5302.9: index-pack default number of threads   116.91(290.05+3.21)

You can see that wall-clock times continue to improve dramatically up to
the number of cores, but bumping beyond that (into hyperthreading
territory) does not help (and in fact hurts a little).

Here's the same experiment on a machine with dual Xeon 6230's, totaling
40 cores (80 with hyperthreading):

  5302.3: index-pack 0 threads                    310.04(302.73+6.90)
  5302.4: index-pack 1 threads                    310.55(302.68+7.40)
  5302.5: index-pack 2 threads                    178.17(304.89+8.20)
  5302.6: index-pack 5 threads                    99.53(315.54+9.56)
  5302.7: index-pack 10 threads                   72.80(327.37+12.79)
  5302.8: index-pack 20 threads                   60.68(357.74+21.66)
  5302.9: index-pack 40 threads                   58.07(454.44+67.96)
  5302.10: index-pack 80 threads                  59.81(720.45+334.52)
  5302.11: index-pack default number of threads   134.18(309.32+7.98)

The results are similar; things stop improving at 40 threads. Curiously,
going from 20 to 40 really doesn't help much, either (and increases CPU
time considerably). So that may represent an actual barrier to
parallelism, where we lose out due to context-switching and loss of
cache locality, but don't reap the wall-clock benefits due to contention
of our coarse-grained locks.

So what's a good default value? It's clear that the current cap of 3 is
too low; our default values are 42% and 57% slower than the best times
on each machine. The results on the 40-core machine imply that 20
threads is an actual barrier regardless of the number of cores, so we'll
take that as a maximum. We get the best results on these machines at
half of the online-cpus value. That's presumably a result of the
hyperthreading. That's common on multi-core Intel processors, but not
necessarily elsewhere. But if we take it as an assumption, we can
perform optimally on hyperthreaded machines and still do much better
than the status quo on other machines, as long as we never half below
the current value of 3.

So that's what this patch does.

Signed-off-by: Jeff King <peff@peff.net>
---
Somebody with an AMD machine with a bunch of cores may want to revisit
this. I don't think it makes anything worse, but they may want to not do
the halving. I don't know if there's an easy way for us to determine the
difference via online_cpus(), though.

 builtin/index-pack.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f865666db9..9721bf1ffe 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1798,9 +1798,22 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 
 	if (HAVE_THREADS && !nr_threads) {
 		nr_threads = online_cpus();
-		/* An experiment showed that more threads does not mean faster */
-		if (nr_threads > 3)
-			nr_threads = 3;
+		/*
+		 * Experiments show that going above 20 threads doesn't help,
+		 * no matter how many cores you have. Below that, we tend to
+		 * max at half the number of online_cpus(), presumably because
+		 * half of those are hyperthreads rather than full cores. We'll
+		 * never reduce the level below "3", though, to match a
+		 * historical value that nobody complained about.
+		 */
+		if (nr_threads < 4)
+			; /* too few cores to consider capping */
+		else if (nr_threads < 6)
+			nr_threads = 3; /* historic cap */
+		else if (nr_threads < 40)
+			nr_threads /= 2;
+		else
+			nr_threads = 20; /* hard cap */
 	}
 
 	curr_pack = open_pack_file(pack_name);
-- 
2.28.0.694.g07780f7063
