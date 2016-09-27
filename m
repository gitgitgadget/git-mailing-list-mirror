Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 398F0207EC
	for <e@80x24.org>; Tue, 27 Sep 2016 04:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbcI0Ehi (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 00:37:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:48534 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750851AbcI0Ehg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 00:37:36 -0400
Received: (qmail 13644 invoked by uid 109); 27 Sep 2016 04:37:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 04:37:36 +0000
Received: (qmail 11353 invoked by uid 111); 27 Sep 2016 04:37:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 00:37:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 00:37:33 -0400
Date:   Tue, 27 Sep 2016 00:37:33 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org
Subject: [PATCH] xdiff: rename "struct group" to "struct xdlgroup"
Message-ID: <20160927043733.u3emlanbipu2cn5h@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit e8adf23 (xdl_change_compact(): introduce the concept
of a change group, 2016-08-22) added a "struct group" type
to xdiff/xdiffi.c. But the POSIX system header "grp.h"
already defines "struct group" (it is part of the getgrnam
interface). This happens to work because the new type is
local to xdiffi.c, and the xdiff code includes a relatively
small set of system headers. But it will break compilation
if xdiff ever switches to using git-compat-util.h.  It can
also probably cause confusion with tools that look at the
whole code base, like coccinelle or ctags.

Let's resolve by giving the xdiff variant a scoped name,
which is closer to other xdiff types anyway (e.g.,
xdlfile_t, though note that xdiff is fond if typedefs when
Git usually is not).

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't rename the functions, which have no conflict, but that would
also be closer to xdiff's usual style. I don't know how far it is worth
going; maybe this patch is even already too far.

I noticed because I have a patch series which switches xdiff
to git-compat-util, to try to use the st_* macros there.

 xdiff/xdiffi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 67c1ccc..760fbb6 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -708,7 +708,7 @@ static int score_cmp(struct split_score *s1, struct split_score *s2)
  * Note that loops that are testing for changed lines in xdf->rchg do not need
  * index bounding since the array is prepared with a zero at position -1 and N.
  */
-struct group {
+struct xdlgroup {
 	/*
 	 * The index of the first changed line in the group, or the index of
 	 * the unchanged line above which the (empty) group is located.
@@ -725,7 +725,7 @@ struct group {
 /*
  * Initialize g to point at the first group in xdf.
  */
-static void group_init(xdfile_t *xdf, struct group *g)
+static void group_init(xdfile_t *xdf, struct xdlgroup *g)
 {
 	g->start = g->end = 0;
 	while (xdf->rchg[g->end])
@@ -736,7 +736,7 @@ static void group_init(xdfile_t *xdf, struct group *g)
  * Move g to describe the next (possibly empty) group in xdf and return 0. If g
  * is already at the end of the file, do nothing and return -1.
  */
-static inline int group_next(xdfile_t *xdf, struct group *g)
+static inline int group_next(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->end == xdf->nrec)
 		return -1;
@@ -752,7 +752,7 @@ static inline int group_next(xdfile_t *xdf, struct group *g)
  * Move g to describe the previous (possibly empty) group in xdf and return 0.
  * If g is already at the beginning of the file, do nothing and return -1.
  */
-static inline int group_previous(xdfile_t *xdf, struct group *g)
+static inline int group_previous(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->start == 0)
 		return -1;
@@ -769,7 +769,7 @@ static inline int group_previous(xdfile_t *xdf, struct group *g)
  * following group, expand this group to include it. Return 0 on success or -1
  * if g cannot be slid down.
  */
-static int group_slide_down(xdfile_t *xdf, struct group *g, long flags)
+static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g, long flags)
 {
 	if (g->end < xdf->nrec &&
 	    recs_match(xdf->recs[g->start], xdf->recs[g->end], flags)) {
@@ -790,7 +790,7 @@ static int group_slide_down(xdfile_t *xdf, struct group *g, long flags)
  * into a previous group, expand this group to include it. Return 0 on success
  * or -1 if g cannot be slid up.
  */
-static int group_slide_up(xdfile_t *xdf, struct group *g, long flags)
+static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g, long flags)
 {
 	if (g->start > 0 &&
 	    recs_match(xdf->recs[g->start - 1], xdf->recs[g->end - 1], flags)) {
@@ -818,7 +818,7 @@ static void xdl_bug(const char *msg)
  * size.
  */
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
-	struct group g, go;
+	struct xdlgroup g, go;
 	long earliest_end, end_matching_other;
 	long groupsize;
 	unsigned int blank_lines;
-- 
2.10.0.492.g14f803f
