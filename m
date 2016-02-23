From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] xdiff: drop XDL_EMIT_COMMON
Date: Tue, 23 Feb 2016 01:07:25 -0500
Message-ID: <20160223060725.GC3205@sigill.intra.peff.net>
References: <20160223060338.GA2912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?Q?Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 07:07:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY68C-0001Jn-5e
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 07:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbcBWGH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 01:07:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:47319 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750704AbcBWGH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 01:07:27 -0500
Received: (qmail 8997 invoked by uid 102); 23 Feb 2016 06:07:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 01:07:27 -0500
Received: (qmail 25892 invoked by uid 107); 23 Feb 2016 06:07:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 01:07:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2016 01:07:25 -0500
Content-Disposition: inline
In-Reply-To: <20160223060338.GA2912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287020>

There are no more callers that use this mode, and none
likely to be added (as our xdl_merge() eliminates the common
use of it for generating 3-way merge bases).

This is effectively a revert of a9ed376 (xdiff: generate
"anti-diffs" aka what is common to two files, 2006-06-28),
though of course trying to revert that ancient commit
directly produces many textual conflicts.

Signed-off-by: Jeff King <peff@peff.net>
---
 xdiff/xdiff.h |  1 -
 xdiff/xemit.c | 18 ------------------
 2 files changed, 19 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index c033991..4fb7e79 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -42,7 +42,6 @@ extern "C" {
 #define XDF_IGNORE_BLANK_LINES (1 << 7)
 
 #define XDL_EMIT_FUNCNAMES (1 << 0)
-#define XDL_EMIT_COMMON (1 << 1)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
 
 #define XDL_MMB_READONLY (1 << 0)
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 4266ada..993724b 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -120,21 +120,6 @@ static long def_ff(const char *rec, long len, char *buf, long sz, void *priv)
 	return -1;
 }
 
-static int xdl_emit_common(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
-                           xdemitconf_t const *xecfg) {
-	xdfile_t *xdf = &xe->xdf2;
-	const char *rchg = xdf->rchg;
-	long ix;
-
-	for (ix = 0; ix < xdf->nrec; ix++) {
-		if (rchg[ix])
-			continue;
-		if (xdl_emit_record(xdf, ix, "", ecb))
-			return -1;
-	}
-	return 0;
-}
-
 struct func_line {
 	long len;
 	char buf[80];
@@ -170,9 +155,6 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 	long funclineprev = -1;
 	struct func_line func_line = { 0 };
 
-	if (xecfg->flags & XDL_EMIT_COMMON)
-		return xdl_emit_common(xe, xscr, ecb, xecfg);
-
 	for (xch = xscr; xch; xch = xche->next) {
 		xche = xdl_get_hunk(&xch, xecfg);
 		if (!xch)
-- 
2.7.2.645.g4e1306c
