Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8119D208B4
	for <e@80x24.org>; Wed,  9 Aug 2017 10:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbdHIKQs (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 06:16:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:33066 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752679AbdHIKQs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 06:16:48 -0400
Received: (qmail 28329 invoked by uid 109); 9 Aug 2017 10:16:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 10:16:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25747 invoked by uid 111); 9 Aug 2017 10:17:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 06:17:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 06:16:45 -0400
Date:   Wed, 9 Aug 2017 06:16:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 2/2] hashcmp: use memcmp instead of open-coded loop
Message-ID: <20170809101645.7wv4mcsmnejxzhvs@sigill.intra.peff.net>
References: <20170809101106.p45y34uk6wcruqxv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170809101106.p45y34uk6wcruqxv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 1a812f3a70 (hashcmp(): inline memcmp() by hand to
optimize, 2011-04-28), it was reported that an open-coded
loop outperformed memcmp() for comparing sha1s.

Discussion[1] a few years later in 2013 showed that this
depends on your libc's version of memcmp(). In particular,
glibc 2.13 optimized their memcmp around 2011. Here are
current timings with glibc 2.24 (best-of-five, on
linux.git):

  [before this patch, open-coded]
  $ time git rev-list --objects --all
  real	0m35.357s
  user	0m35.016s
  sys	0m0.340s

  [after this patch, memcmp]
  real	0m32.930s
  user	0m32.630s
  sys	0m0.300s

Now that we've had 6 years for that version of glibc to
make its way onto people's machines, it's worth revisiting
our benchmarks and switching to memcmp().

It may be that there are other non-glibc systems where
memcmp() isn't as well optimized. But since our single data
point in favor of open-coding was on a now-ancient glibc, we
should probably assume the system memcmp is good unless
proven otherwise. We may end up with a SLOW_MEMCMP Makefile
knob, but we can hold off on that until we actually find
such a system in practice.

[1] https://public-inbox.org/git/20130318073229.GA5551@sigill.intra.peff.net/

Signed-off-by: Jeff King <peff@peff.net>
---
I also wondered if using memcmp() could be a hint to the compiler to use
an intrinsic or some other trick, especially because the "len" here is a
constant. But in a toy function compiled with "gcc -S", it looks like we
do keep the call to memcmp (so the speedup really is glibc, and not some
compiler magic).

 cache.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 71fe092644..46af4ecddb 100644
--- a/cache.h
+++ b/cache.h
@@ -939,14 +939,7 @@ extern const struct object_id null_oid;
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
-	int i;
-
-	for (i = 0; i < GIT_SHA1_RAWSZ; i++, sha1++, sha2++) {
-		if (*sha1 != *sha2)
-			return *sha1 - *sha2;
-	}
-
-	return 0;
+	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
 }
 
 static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
-- 
2.14.0.609.gd2d1f7ddf
