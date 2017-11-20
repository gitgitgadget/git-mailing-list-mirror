Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B71A202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 20:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbdKTU3X (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 15:29:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:35050 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751173AbdKTU3X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 15:29:23 -0500
Received: (qmail 4021 invoked by uid 109); 20 Nov 2017 20:29:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 Nov 2017 20:29:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15936 invoked by uid 111); 20 Nov 2017 20:29:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 20 Nov 2017 15:29:38 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Nov 2017 15:29:21 -0500
Date:   Mon, 20 Nov 2017 15:29:21 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/5] everything_local: use "quick" object existence check
Message-ID: <20171120202920.7ppcwmzkxifywtoj@sigill.intra.peff.net>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In b495697b82 (fetch-pack: avoid repeatedly re-scanning pack
directory, 2013-01-26), we noticed that everything_local()
could waste time trying to find and parse objects which we
_expect_ to be missing. The solution was to put
has_sha1_file() in front of parse_object() to skip the
more-expensive parse attempt.

That optimization was negated later when has_sha1_file()
learned to do the same re-scan in 45e8a74873 (has_sha1_file:
re-check pack directory before giving up, 2013-08-30).

We can restore it by using the "quick" flag to tell
has_sha1_file (actually has_object_file these days) that we
prefer speed to thoroughness for this call.  See also the
fixes in 5827a0354 and 0eeb077be7 for prior art and
discussion on using the "quick" flag for these cases.

The recently-added performance regression test in p5551
demonstrates the problem. You can see the original fix:

  Test            b495697b82^       b495697b82
  --------------------------------------------------------
  5551.4: fetch   1.68(1.33+0.35)   0.87(0.69+0.18) -48.2%

and then the regression:

  Test            45e8a74873^       45e8a74873
  ---------------------------------------------------------
  5551.4: fetch   0.96(0.77+0.19)   2.55(2.04+0.50) +165.6%

and now our fix:

  Test            HEAD^             HEAD
  --------------------------------------------------------
  5551.4: fetch   7.21(6.58+0.63)   5.47(5.04+0.43) -24.1%

You can also see that other things have gotten a lot slower
since 2013. We'll deal with those in separate patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 fetch-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 008b25d3db..9f6b07ad91 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -716,7 +716,8 @@ static int everything_local(struct fetch_pack_args *args,
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
 
-		if (!has_object_file(&ref->old_oid))
+		if (!has_object_file_with_flags(&ref->old_oid,
+						OBJECT_INFO_QUICK))
 			continue;
 
 		o = parse_object(&ref->old_oid);
-- 
2.15.0.494.g79a8547723

