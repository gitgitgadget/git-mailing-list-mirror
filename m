Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1621F858
	for <e@80x24.org>; Fri, 29 Jul 2016 04:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbcG2ELf (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 00:11:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:50819 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750822AbcG2ELe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 00:11:34 -0400
Received: (qmail 24570 invoked by uid 102); 29 Jul 2016 04:11:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 00:11:35 -0400
Received: (qmail 31408 invoked by uid 107); 29 Jul 2016 04:12:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 00:12:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 00:11:31 -0400
Date:	Fri, 29 Jul 2016 00:11:31 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/7] pack-objects: compute local/ignore_pack_keep early
Message-ID: <20160729041130.GF22408@sigill.intra.peff.net>
References: <20160729040422.GA19678@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160729040422.GA19678@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In want_object_in_pack(), we can exit early from our loop if
neither "local" nor "ignore_pack_keep" are set. If they are,
however, we must examine each pack to see if it has the
object and is non-local or has a ".keep".

It's quite common for there to be no non-local or .keep
packs at all, in which case we know ahead of time that
looking further will be pointless. We can pre-compute this
by simply iterating over the list of packs ahead of time,
and dropping the flags if there are no packs that could
match.

Another similar strategy would be to modify the loop in
want_object_in_pack() to notice that we have already found
the object once, and that we are looping only to check for
"local" and "keep" attributes. If a pack has neither of
those, we can skip the call to find_pack_entry_one(), which
is the expensive part of the loop.

This has two advantages:

  - it isn't all-or-nothing; we still get some improvement
    when there's a small number of kept or non-local packs,
    and a large number of non-kept local packs

  - it eliminates any possible race where we add new
    non-local or kept packs after our initial scan. In
    practice, I don't think this race matters; we already
    cache the packed_git information, so somebody who adds a
    new pack or .keep file after we've started will not be
    noticed at all, unless we happen to need to call
    reprepare_packed_git() because a lookup fails.

    In other words, we're already racy, and the race is not
    a big deal (losing the race means we might include an
    object in the pack that would not otherwise be, which is
    an acceptable outcome).

However, it also has a disadvantage: we still loop over the
rest of the packs for each object to check their flags. This
is much less expensive than doing the object lookup, but
still not free. So if we wanted to implement that strategy
to cover the non-all-or-nothing cases, we could do so in
addition to this one (so you get the most speedup in the
all-or-nothing case, and the best we can do in the other
cases). But given that the all-or-nothing case is likely the
most common, it is probably not worth the trouble, and we
can revisit this later if evidence points otherwise.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8ad11f2..c4c2a3c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -46,6 +46,7 @@ static int keep_unreachable, unpack_unreachable, include_tag;
 static unsigned long unpack_unreachable_expiration;
 static int pack_loose_unreachable;
 static int local;
+static int have_non_local_packs;
 static int incremental;
 static int ignore_packed_keep;
 static int allow_ofs_delta;
@@ -990,7 +991,8 @@ static int want_object_in_pack(const unsigned char *sha1,
 			 * we just found is going to be packed, so break
 			 * out of the loop to return 1 now.
 			 */
-			if (!ignore_packed_keep && !local)
+			if (!ignore_packed_keep &&
+			    (!local || !have_non_local_packs))
 				break;
 
 			if (local && !p->pack_local)
@@ -2799,6 +2801,28 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		progress = 2;
 
 	prepare_packed_git();
+	if (ignore_packed_keep) {
+		struct packed_git *p;
+		for (p = packed_git; p; p = p->next)
+			if (p->pack_local && p->pack_keep)
+				break;
+		if (!p) /* no keep-able packs found */
+			ignore_packed_keep = 0;
+	}
+	if (local) {
+		/*
+		 * unlike ignore_packed_keep above, we do not want to
+		 * unset "local" based on looking at packs, as it
+		 * also covers non-local objects
+		 */
+		struct packed_git *p;
+		for (p = packed_git; p; p = p->next) {
+			if (!p->pack_local) {
+				have_non_local_packs = 1;
+				break;
+			}
+		}
+	}
 
 	if (progress)
 		progress_state = start_progress(_("Counting objects"), 0);
-- 
2.9.2.607.g98dce7b

