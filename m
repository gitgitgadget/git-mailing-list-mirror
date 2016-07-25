Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63EC203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 18:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbcGYSuf (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 14:50:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:48739 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752973AbcGYSue (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 14:50:34 -0400
Received: (qmail 9858 invoked by uid 102); 25 Jul 2016 18:50:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 14:50:34 -0400
Received: (qmail 27492 invoked by uid 107); 25 Jul 2016 18:50:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 14:50:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jul 2016 14:50:31 -0400
Date:	Mon, 25 Jul 2016 14:50:31 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 2/2] pack-objects: compute local/ignore_pack_keep early
Message-ID: <20160725185031.GB12974@sigill.intra.peff.net>
References: <20160725184938.GA12871@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160725184938.GA12871@sigill.intra.peff.net>
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
 builtin/pack-objects.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 55ef5a8..c5e343c 100644
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
@@ -981,7 +982,7 @@ static int want_object_in_pack(const unsigned char *sha1,
 				return 0;
 			if (ignore_packed_keep && p->pack_local && p->pack_keep)
 				return 0;
-			if (!ignore_packed_keep && !local)
+			if (!ignore_packed_keep && (!local || !have_non_local_packs))
 				break;
 		}
 	}
@@ -2785,6 +2786,28 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
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
2.9.2.512.g8a06708
