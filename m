Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8E5B202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 20:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbdKTUf0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 15:35:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:35056 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752712AbdKTUfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 15:35:25 -0500
Received: (qmail 4235 invoked by uid 109); 20 Nov 2017 20:35:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 Nov 2017 20:35:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15961 invoked by uid 111); 20 Nov 2017 20:35:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 20 Nov 2017 15:35:41 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Nov 2017 15:35:23 -0500
Date:   Mon, 20 Nov 2017 15:35:23 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/5] sha1_file: don't re-scan pack directory for null sha1
Message-ID: <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In theory nobody should ever ask the low-level object code
for a null sha1. It's used as a sentinel for "no such
object" in lots of places, so leaking through to this level
is a sign that the higher-level code is not being careful
about its error-checking.  In practice, though, quite a few
code paths seem to rely on the null sha1 lookup failing as a
way to quietly propagate non-existence (e.g., by feeding it
to lookup_commit_reference_gently(), which then returns
NULL).

When this happens, we do two inefficient things:

  1. We actually search for the null sha1 in packs and in
     the loose object directory.

  2. When we fail to find it, we re-scan the pack directory
     in case a simultaneous repack happened to move it from
     loose to packed.

It's debatable whether (1) is a good idea or not. The
performance drop is at least linear in the number of
lookups, so it's not too bad. And if by some 2^-160th chance
somebody does have such an object, we probably ought to
access it. On the other hand, enough code paths treat the
null sha1 specially that the object probably isn't usable,
anyway.

Problem (2), on the other hand, is a pretty severe
performance issue. If you have a large number of packs,
rescanning the pack directory can be very expensive. And it
only helps in the case that you have an object with the null
sha1 _and_ somebody was simultaneously repacking it. The
tradeoff is certainly a bad one there.

In an ideal world, we'd simply fix all of the callers to
notice the null sha1 and avoid passing it to us. But a
simple experiment to catch this with a BUG() shows that
there are a large number of code paths.

In the meantime, let's address problem (2). That's the
minimal fix we can do to make the performance problems go
away. p5551 shows this off (when a fetched ref is new, the
"old" sha1 is 0{40}, which ends up being passed for
fast-forward checks, the status table abbreviations, etc):

  Test            HEAD^             HEAD
  --------------------------------------------------------
  5551.4: fetch   5.51(5.03+0.48)   0.17(0.10+0.06) -96.9%

We could address (1), too, but there's not much performance
improvement left to make.

Signed-off-by: Jeff King <peff@peff.net>
---
This is the minimal fix that addresses the performance issues.
I'd actually have no problem at all declaring that looking up a null
sha1 is insane, and having the object-lookup routines simply return "no
such object" without even doing the loose/pack lookup first.

I'm also fine with going down the BUG() route and fixing the
higher-level callers, but it's a big enough task (with little enough
real-world impact) that I think it would be worth applying this in the
meantime.

 sha1_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index 8a7c6b7eba..dde0ad101d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1180,6 +1180,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		if (!sha1_loose_object_info(real, oi, flags))
 			return 0;
 
+		if (is_null_sha1(sha1))
+			return -1;
+
 		/* Not a loose object; someone else may have just packed it. */
 		if (flags & OBJECT_INFO_QUICK) {
 			return -1;
-- 
2.15.0.494.g79a8547723
