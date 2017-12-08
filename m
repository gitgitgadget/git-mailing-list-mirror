Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8DD620C32
	for <e@80x24.org>; Fri,  8 Dec 2017 11:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbdLHLW1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 06:22:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:52012 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753284AbdLHLWY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 06:22:24 -0500
Received: (qmail 3294 invoked by uid 109); 8 Dec 2017 11:22:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 11:22:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31090 invoked by uid 111); 8 Dec 2017 11:22:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 06:22:45 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 06:22:22 -0500
Date:   Fri, 8 Dec 2017 06:22:22 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] refs: drop "clear packed-refs while locked" assertion
Message-ID: <20171208112222.GA6094@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch fixes a regression in v2.14.0. It's actually fixed already in
v2.15.0 because all of the packed-ref code there was rewritten. So
there's no point in applying this on "master" or even "maint". But I
figured it was worth sharing here in case somebody else runs across it,
and in case we ever do a v2.14.4 release.

-- >8 --
In clear_packed_ref_cache(), we assert that we're not
currently holding the packed-refs lock. But in each of the
three code paths that can hit this, the assertion is either
a noop or actively does the wrong thing:

 1. in rollback_packed_refs(), we will have just released
    the lock before calling the function, and so the
    assertion can never trigger.

 2. get_packed_ref_cache() can reach this assertion via
    validate_packed_ref_cache(). But it calls the validate
    function only when it knows that we're not holding the
    lock, so again, the assertion can never trigger.

 3. lock_packed_refs() also calls validate_packed_ref_cache().
    In this case we're _always_ holding the lock, which
    means any time the validate function has to clear the
    cache, we'll trigger this assertion and die.

    This doesn't happen often in practice because the
    validate function clears the cache only if we find that
    somebody else has racily rewritten the packed-refs file
    between the time we read it and the time we took the lock.

    So most of the time we don't reach the assertion at all
    (nobody has racily written the file so there's no need
    to clear the cache). And when we do, it is not actually
    indicative of a bug; clearing the cache while holding
    the lock is the right thing to do here.

This final case is relatively new, being triggerd by the
extra validation added in fed6ebebf1 (lock_packed_refs():
fix cache validity check, 2017-06-12).

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f21a954ce7..dd41e1d382 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -99,8 +99,6 @@ static void clear_packed_ref_cache(struct files_ref_store *refs)
 	if (refs->packed) {
 		struct packed_ref_cache *packed_refs = refs->packed;
 
-		if (is_lock_file_locked(&refs->packed_refs_lock))
-			die("BUG: packed-ref cache cleared while locked");
 		refs->packed = NULL;
 		release_packed_ref_cache(packed_refs);
 	}
-- 
2.15.1.659.g8bd2eae3ea
