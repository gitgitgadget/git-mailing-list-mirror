Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4434C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 05:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhLCFP0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 00:15:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:42702 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhLCFPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 00:15:25 -0500
Received: (qmail 21998 invoked by uid 109); 3 Dec 2021 05:12:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Dec 2021 05:12:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28797 invoked by uid 111); 3 Dec 2021 05:12:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Dec 2021 00:12:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Dec 2021 00:12:01 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH 3/3] xdiff: drop unused flags parameter from recs_match
Message-ID: <YamnIeXz+EscCTZC@coredump.intra.peff.net>
References: <Yammtm+pIkMu43zZ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yammtm+pIkMu43zZ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 6b13bc3232 (xdiff: simplify comparison, 2021-11-17), we do not
call xdl_recmatch() from xdiffi.c's recs_match(), so we no longer need
the "flags" parameter. That in turn lets us drop the flags parameters
from the group-slide functions which call it.

There's no functional change here; it's just making these functions a
little simpler.

Signed-off-by: Jeff King <peff@peff.net>
---
 xdiff/xdiffi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 6a3b9280be..69689fab24 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -390,7 +390,7 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 }
 
 
-static int recs_match(xrecord_t *rec1, xrecord_t *rec2, long flags)
+static int recs_match(xrecord_t *rec1, xrecord_t *rec2)
 {
 	return (rec1->ha == rec2->ha);
 }
@@ -756,10 +756,10 @@ static inline int group_previous(xdfile_t *xdf, struct xdlgroup *g)
  * following group, expand this group to include it. Return 0 on success or -1
  * if g cannot be slid down.
  */
-static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g, long flags)
+static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->end < xdf->nrec &&
-	    recs_match(xdf->recs[g->start], xdf->recs[g->end], flags)) {
+	    recs_match(xdf->recs[g->start], xdf->recs[g->end])) {
 		xdf->rchg[g->start++] = 0;
 		xdf->rchg[g->end++] = 1;
 
@@ -777,10 +777,10 @@ static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g, long flags)
  * into a previous group, expand this group to include it. Return 0 on success
  * or -1 if g cannot be slid up.
  */
-static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g, long flags)
+static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->start > 0 &&
-	    recs_match(xdf->recs[g->start - 1], xdf->recs[g->end - 1], flags)) {
+	    recs_match(xdf->recs[g->start - 1], xdf->recs[g->end - 1])) {
 		xdf->rchg[--g->start] = 1;
 		xdf->rchg[--g->end] = 0;
 
@@ -830,7 +830,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			end_matching_other = -1;
 
 			/* Shift the group backward as much as possible: */
-			while (!group_slide_up(xdf, &g, flags))
+			while (!group_slide_up(xdf, &g))
 				if (group_previous(xdfo, &go))
 					BUG("group sync broken sliding up");
 
@@ -845,7 +845,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 			/* Now shift the group forward as far as possible: */
 			while (1) {
-				if (group_slide_down(xdf, &g, flags))
+				if (group_slide_down(xdf, &g))
 					break;
 				if (group_next(xdfo, &go))
 					BUG("group sync broken sliding down");
@@ -872,7 +872,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * other file that it can align with.
 			 */
 			while (go.end == go.start) {
-				if (group_slide_up(xdf, &g, flags))
+				if (group_slide_up(xdf, &g))
 					BUG("match disappeared");
 				if (group_previous(xdfo, &go))
 					BUG("group sync broken sliding to match");
@@ -915,7 +915,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			}
 
 			while (g.end > best_shift) {
-				if (group_slide_up(xdf, &g, flags))
+				if (group_slide_up(xdf, &g))
 					BUG("best shift unreached");
 				if (group_previous(xdfo, &go))
 					BUG("group sync broken sliding to blank line");
-- 
2.34.1.436.g8c445b282e
