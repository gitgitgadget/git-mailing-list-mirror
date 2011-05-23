From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] combine-diff: calculate mode_differs earlier
Date: Mon, 23 May 2011 16:16:59 -0400
Message-ID: <20110523201659.GB6298@sigill.intra.peff.net>
References: <20110523201529.GA6281@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 22:17:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QObZJ-0006kC-KG
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 22:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934056Ab1EWURG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 16:17:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37652
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933322Ab1EWURB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 16:17:01 -0400
Received: (qmail 23018 invoked by uid 107); 23 May 2011 20:19:05 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 16:19:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 16:16:59 -0400
Content-Disposition: inline
In-Reply-To: <20110523201529.GA6281@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174268>

One loop combined both the patch generation and checking
whether there was any mode change to report. Let's factor
that into two separate loops, as we may care about the mode
change even if we are not generating patches (e.g., because
we are showing a binary diff, which will come in a future
patch).

Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 309dc6c..2183184 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -845,6 +845,13 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			close(fd);
 	}
 
+	for (i = 0; i < num_parent; i++) {
+		if (elem->parent[i].mode != elem->mode) {
+			mode_differs = 1;
+			break;
+		}
+	}
+
 	for (cnt = 0, cp = result; cp < result + result_size; cp++) {
 		if (*cp == '\n')
 			cnt++;
@@ -893,8 +900,6 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 				     elem->parent[i].mode,
 				     &result_file, sline,
 				     cnt, i, num_parent, result_deleted);
-		if (elem->parent[i].mode != elem->mode)
-			mode_differs = 1;
 	}
 
 	show_hunks = make_hunks(sline, cnt, num_parent, dense);
-- 
1.7.5.2.4.g43415
