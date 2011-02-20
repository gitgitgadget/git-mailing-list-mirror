From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] add inexact rename detection progress infrastructure
Date: Sun, 20 Feb 2011 04:51:16 -0500
Message-ID: <20110220095115.GA1082@sigill.intra.peff.net>
References: <20110220094803.GA988@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 20 10:51:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr5wq-0005X5-4P
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 10:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880Ab1BTJvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 04:51:19 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35677 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652Ab1BTJvS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 04:51:18 -0500
Received: (qmail 16508 invoked by uid 111); 20 Feb 2011 09:51:17 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 20 Feb 2011 09:51:17 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Feb 2011 04:51:16 -0500
Content-Disposition: inline
In-Reply-To: <20110220094803.GA988@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167408>

We might spend many seconds doing inexact rename detection
with no output.  It's nice to let the user know that
something is actually happening.

This patch adds the infrastructure, but no callers actually
turn on progress reporting.

Signed-off-by: Jeff King <peff@peff.net>
---
Replaces the old 4/4. Now not on by default, progress reporting is
hoisted to the outer loop, and actually counts all the way to 100%.

 diff.h            |    1 +
 diffcore-rename.c |   10 ++++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/diff.h b/diff.h
index f774c9a..9585e41 100644
--- a/diff.h
+++ b/diff.h
@@ -111,6 +111,7 @@ struct diff_options {
 	int rename_score;
 	int rename_limit;
 	int needed_rename_limit;
+	int show_rename_progress;
 	int dirstat_percent;
 	int setup;
 	int abbrev;
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1d3d5cd..d40e40a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "hash.h"
+#include "progress.h"
 
 /* Table of rename/copy destinations */
 
@@ -449,6 +450,7 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_score *mx;
 	int i, j, rename_count;
 	int num_create, num_src, dst_cnt;
+	struct progress *progress = NULL;
 
 	if (!minimum_score)
 		minimum_score = DEFAULT_RENAME_SCORE;
@@ -528,6 +530,12 @@ void diffcore_rename(struct diff_options *options)
 		goto cleanup;
 	}
 
+	if (options->show_rename_progress) {
+		progress = start_progress_delay(
+				"Performing inexact rename detection",
+				rename_dst_nr * rename_src_nr, 50, 1);
+	}
+
 	mx = xcalloc(num_create * NUM_CANDIDATE_PER_DST, sizeof(*mx));
 	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
 		struct diff_filespec *two = rename_dst[i].two;
@@ -557,7 +565,9 @@ void diffcore_rename(struct diff_options *options)
 			diff_free_filespec_blob(two);
 		}
 		dst_cnt++;
+		display_progress(progress, (i+1)*rename_src_nr);
 	}
+	stop_progress(&progress);
 
 	/* cost matrix sorted by most to least similar pair */
 	qsort(mx, dst_cnt * NUM_CANDIDATE_PER_DST, sizeof(*mx), score_compare);
-- 
1.7.4.1.26.g5e991
