Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8609BC64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC2D2084C
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgLALkG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:40:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:47066 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730753AbgLALkF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 06:40:05 -0500
Received: (qmail 26013 invoked by uid 109); 1 Dec 2020 11:39:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Dec 2020 11:39:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25717 invoked by uid 111); 1 Dec 2020 11:39:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 06:39:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 06:39:24 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: t7900's new expensive test
Message-ID: <X8YrbDpC9/EjRr95@coredump.intra.peff.net>
References: <20201113050631.GA744608@coredump.intra.peff.net>
 <323fd904-a7ee-061d-d846-5da5afbc88b2@virtuell-zuhause.de>
 <20201116041051.GA883199@coredump.intra.peff.net>
 <1403797985.37893.1606777048311@ox.hosteurope.de>
 <X8YnsGsUl53OKFno@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8YnsGsUl53OKFno@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 06:23:28AM -0500, Jeff King wrote:

> I'm not sure if EXPENSIVE is the right ballpark, or if we'd want a
> VERY_EXPENSIVE. On my machine, the whole test suite for v2.29.0 takes 64
> seconds to run, and setting GIT_TEST_LONG=1 bumps that to 103s. It got a
> bit worse since then, as t7900 adds an EXPENSIVE test that takes ~200s
> (it's not strictly additive, since we can work in parallel on other
> tests for the first bit, but still, yuck).

Since Stolee is on the cc and has already seen me complaining about his
test, I guess I should expand a bit. ;)

There are some small wins possible (e.g., using "commit --quiet" seems
to shave off ~8s when we don't even think about writing a diff), but
fundamentally the issue is that it just takes a long time to "git add"
the 5.2GB worth of random data. I almost wonder if it would be worth it
to hard-coded the known sha1 and sha256 names of the blobs, and write
them straight into the appropriate loose object file. I guess that is
tricky, though, because it actually needs to be a zlib stream, not just
the output of "test-tool genrandom".

Though speaking of which, another easy win might be setting
core.compression to "0". We know the random data won't compress anyway,
so there's no point in spending cycles on zlib.

Doing this:

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index d9e68bb2bf..849c6d1361 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -239,6 +239,8 @@ test_expect_success 'incremental-repack task' '
 '
 
 test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
+	test_config core.compression 0 &&
+
 	for i in $(test_seq 1 5)
 	do
 		test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
@@ -257,7 +259,7 @@ test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
 		return 1
 	done &&
 	git add big &&
-	git commit -m "Add big file (2)" &&
+	git commit -qm "Add big file (2)" &&
 
 	# ensure any possible loose objects are in a pack-file
 	git maintenance run --task=loose-objects &&

seems to shave off ~140s from the test. I think we could get a little
more by cleaning up the enormous objects, too (they end up causing the
subsequent test to run slower, too, though perhaps it was intentional to
impact downstream tests).

-Peff
