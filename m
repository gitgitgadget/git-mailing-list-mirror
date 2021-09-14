Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9500C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 05:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FAC760F92
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 05:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbhINFYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 01:24:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:46774 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239411AbhINFYi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 01:24:38 -0400
Received: (qmail 22791 invoked by uid 109); 14 Sep 2021 05:23:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 05:23:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19078 invoked by uid 111); 14 Sep 2021 05:23:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 01:23:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 01:23:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] t5326: test propagating hashcache values
Message-ID: <YUAxxPcd7RHC2AH+@coredump.intra.peff.net>
References: <cover.1631049462.git.me@ttaylorr.com>
 <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
 <xmqqa6khi9ph.fsf@gitster.g>
 <YT/3BuDa7KfUN/38@nand.local>
 <xmqqpmtbc3o3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpmtbc3o3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 07:05:32PM -0700, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > Alas, there they are. They are basically no different than having the
> > name-hash for single pack bitmaps, it's just now we don't throw them
> > away when generating a MIDX bitmap from a state where the repository
> > already has a single-pack bitmap.
> 
> I actually wasn't expecting any CPU/time difference.

I was, for the same reason we saw an improvement there in ae4f07fbcc
(pack-bitmap: implement optional name_hash cache, 2013-12-21): without a
name-hash, we try a bunch of fruitless deltas before we find a decent
one.

> I hope that we are talking about the same name-hash, which is used
> to sort the blobs so that when pack-objects try to find a good delta
> base, the blobs from the same path will sit close to each other and
> hopefully fit in the pack window.

Yes, exactly. We spend less time finding the good ones if the likely
candidates are close together. We may _also_ find better ones overall,
depending on the number of candidates and the window size.

The bitmap perf tests (neither p5310 nor its new midx cousin p5326)
don't check the output size.

> The effect I was hoping to see by not discarding the information was
> that we find better delta base hence smaller deltas in the resulting
> packfiles.

If we add a size check like so[1]:

diff --git a/t/perf/lib-bitmap.sh b/t/perf/lib-bitmap.sh
index 63d3bc7cec..648cd5b13d 100644
--- a/t/perf/lib-bitmap.sh
+++ b/t/perf/lib-bitmap.sh
@@ -10,7 +10,11 @@ test_full_bitmap () {
 		{
 			echo HEAD &&
 			echo ^$have
-		} | git pack-objects --revs --stdout >/dev/null
+		} | git pack-objects --revs --stdout >tmp.pack
+	'
+
+	test_size 'fetch size' '
+		wc -c <tmp.pack
 	'
 
 	test_perf 'pack to file (bitmap)' '

then the results I get using linux.git are:

Test                       origin/tb/multi-pack-bitmaps   origin/tb/midx-write-propagate-namehash
-------------------------------------------------------------------------------------------------
5326.4: simulated fetch    2.32(7.16+0.21)                2.00(3.79+0.18) -13.8%
5326.5: fetch size         16.7M                          15.5M -7.1%

so you can see that we spent about half as much CPU (ignore the
wall-clock percentage; the interesting thing is the userspace time,
because my machine has 8 cores). But we also shaved off a bit from the
pack, so we really did manage to find better deltas, too.

I see that Taylor just posted a very similar response, and independently
did the exact same experiment I did. ;) I'll send this anyway, though,
as my particular run showed slightly different results.

-Peff

[1] The other thing you'd want (and I presume Taylor was using for his
    earlier timings) is:

diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-bitmaps.sh
index 5845109ac7..a4ac7746a7 100755
--- a/t/perf/p5326-multi-pack-bitmaps.sh
+++ b/t/perf/p5326-multi-pack-bitmaps.sh
@@ -11,7 +11,7 @@ test_expect_success 'enable multi-pack index' '
 '
 
 test_perf 'setup multi-pack index' '
-	git repack -ad &&
+	git repack -adb &&
 	git multi-pack-index write --bitmap
 '
 

since otherwise there is no pack bitmap for the midx to pull the
name-hashes from.
