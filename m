Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C065C64E7A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 02:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFBAC206E3
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 02:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgLBCsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 21:48:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:48288 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbgLBCsj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 21:48:39 -0500
Received: (qmail 29987 invoked by uid 109); 2 Dec 2020 02:47:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Dec 2020 02:47:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3219 invoked by uid 111); 2 Dec 2020 02:47:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 21:47:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 21:47:56 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: [PATCH] t7900: speed up expensive test
Message-ID: <X8cAXHJRm+Xz9PFM@coredump.intra.peff.net>
References: <20201113050631.GA744608@coredump.intra.peff.net>
 <323fd904-a7ee-061d-d846-5da5afbc88b2@virtuell-zuhause.de>
 <20201116041051.GA883199@coredump.intra.peff.net>
 <1403797985.37893.1606777048311@ox.hosteurope.de>
 <X8YnsGsUl53OKFno@coredump.intra.peff.net>
 <X8YrbDpC9/EjRr95@coredump.intra.peff.net>
 <373f3dfe-828b-430d-b88e-5e23302090cb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <373f3dfe-828b-430d-b88e-5e23302090cb@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 03:55:00PM -0500, Derrick Stolee wrote:

> > Since Stolee is on the cc and has already seen me complaining about his
> > test, I guess I should expand a bit. ;)
> 
> Ha. I apologize for causing pain here. My thought was that GIT_TEST_LONG=1
> was only used by someone really willing to wait, or someone specifically
> trying to investigate a problem that only triggers on very large cases.
> 
> In that sense, it's not so much intended as a frequently-run regression
> test, but a "run this if you are messing with this area" kind of thing.
> Perhaps there is a different pattern to use here?

No, I think your interpretation is pretty reasonable. I definitely do
not run with GIT_TEST_LONG normally, but was only poking at it because
of the other discussion.

> > Though speaking of which, another easy win might be setting
> > core.compression to "0". We know the random data won't compress anyway,
> > so there's no point in spending cycles on zlib.
> 
> The intention is mostly to expand the data beyond two gigabytes, so
> dropping compression to get there seems like a good idea. If we are
> not compressing at all, then perhaps we can reliably cut ourselves
> closer to the 2GB limit instead of overshooting as a precaution.

Probably, though I think at best we could save 20% of the test cost. I
didn't play much with it.

> Cutting out 70% out seems like a great idea. I don't think it was super
> intentional to slow down those tests.

Here it is as a patch (the numbers are slightly different this time
because I used my usual ramdisk, but the overall improvement is roughly
the same).

I didn't look into whether it should be cleaning up (test 16 takes
longer, too, because of the extra on-disk bytes). I also noticed while
running with "-v" that it complains of corrupted refs. I assume this is
leftover cruft from earlier tests, and I didn't dig into it. But it may
be something worth cleaning up for somebody more familiar with these
tests.

-- >8 --
Subject: [PATCH] t7900: speed up expensive test

A test marked with EXPENSIVE creates two 2.5GB files and adds them to
the repository. This takes 194s to run on my machine, versus 2s when the
EXPENSIVE prereq isn't set. We can trim this down a bit by doing two
things:

  - use "git commit --quiet" to avoid spending time generating a diff
    summary (this actually only helps for the second commit, but I've
    added it here to both for consistency). This shaves off 8s.

  - set core.compression to 0. We know these files are full of random
    bytes, and so won't compress (that's the point of the test!).
    Spending cycles on zlib is pointless. This shaves off 122s.

After this, my total time to run the script is 64s. That won't help
normal runs without GIT_TEST_LONG set, of course, but it's easy enough
to do.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7900-maintenance.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index d9e68bb2bf..d9a02df686 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -239,13 +239,15 @@ test_expect_success 'incremental-repack task' '
 '
 
 test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
+	test_config core.compression 0 &&
+
 	for i in $(test_seq 1 5)
 	do
 		test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
 		return 1
 	done &&
 	git add big &&
-	git commit -m "Add big file (1)" &&
+	git commit -qm "Add big file (1)" &&
 
 	# ensure any possible loose objects are in a pack-file
 	git maintenance run --task=loose-objects &&
@@ -257,7 +259,7 @@ test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
 		return 1
 	done &&
 	git add big &&
-	git commit -m "Add big file (2)" &&
+	git commit -qm "Add big file (2)" &&
 
 	# ensure any possible loose objects are in a pack-file
 	git maintenance run --task=loose-objects &&
-- 
2.29.2.894.g2dadb8c6b8

