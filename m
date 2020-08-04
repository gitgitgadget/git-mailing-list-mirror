Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23B2C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 07:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F3D22B40
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 07:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgHDHqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:46:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:47374 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727887AbgHDHqx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 03:46:53 -0400
Received: (qmail 598 invoked by uid 109); 4 Aug 2020 07:46:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Aug 2020 07:46:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9689 invoked by uid 111); 4 Aug 2020 07:46:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Aug 2020 03:46:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Aug 2020 03:46:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 2/3] revision: avoid out-of-bounds read/write on empty
 pathspec
Message-ID: <20200804074652.GB284046@coredump.intra.peff.net>
References: <20200804074146.GA190027@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200804074146.GA190027@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running t4216 with ASan results in it complaining of an out-of-bounds
read in prepare_to_use_bloom_filter(). The issue is this code to strip a
trailing slash:

  last_index = pi->len - 1;
  if (pi->match[last_index] == '/') {

because we have no guarantee that pi->len isn't zero. This can happen if
the pathspec is ".", as we translate that to an empty string. And if
that read of random memory does trigger the conditional, we'd then do an
out-of-bounds write:

  path_alloc = xstrdup(pi->match);
  path_alloc[last_index] = '\0';

Let's make sure to check the length before subtracting. Note that for an
empty pathspec, we'd end up bailing from the function a few lines later,
which makes it tempting to just:

  if (!pi->len)
          return;

early here. But our code here is stripping a trailing slash, and we need
to check for emptiness after stripping that slash, too. So we'd have two
blocks, which would require repeating some cleanup code.

Instead, just skip the trailing-slash for an empty string. Setting
last_index at all in the case is awkward since it will have a nonsense
value (and it uses an "int", which is a too-small type for a string
anyway). So while we're here, let's:

  - drop last_index entirely; it's only used in two spots right next to
    each other and writing out "pi->len - 1" in both is actually easier
    to follow

  - use xmemdupz() to duplicate the string. This is slightly more
    efficient, but more importantly makes the intent more clear by
    allocating the correct-sized substring in the first place. It also
    eliminates any question of whether path_alloc is as long as
    pi->match (which it would not be if pi->match has any embedded NULs,
    though in practice this is probably impossible).

Signed-off-by: Jeff King <peff@peff.net>
---
Another variant is to actually stop assigning revs->bloom_filter_settings
so early, so that we don't have to clean it up. And then once we're sure
we're going to use it and have passed all of our early-return checks,
then assign it. But that conflicts with the get_bloom_filter_settings()
patch in:

  https://lore.kernel.org/git/08479793c1274d5ee0f063578bb0f4d93c910fa9.1596480582.git.me@ttaylorr.com/

so I didn't go that way.

 revision.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index 6de29cdf7a..5ed86e4524 100644
--- a/revision.c
+++ b/revision.c
@@ -669,7 +669,6 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	struct pathspec_item *pi;
 	char *path_alloc = NULL;
 	const char *path, *p;
-	int last_index;
 	size_t len;
 	int path_component_nr = 1;
 
@@ -692,12 +691,10 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 		return;
 
 	pi = &revs->pruning.pathspec.items[0];
-	last_index = pi->len - 1;
 
 	/* remove single trailing slash from path, if needed */
-	if (pi->match[last_index] == '/') {
-		path_alloc = xstrdup(pi->match);
-		path_alloc[last_index] = '\0';
+	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
+		path_alloc = xmemdupz(pi->match, pi->len - 1);
 		path = path_alloc;
 	} else
 		path = pi->match;
-- 
2.28.0.536.ga4d8134877

