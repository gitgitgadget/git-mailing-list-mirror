From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 4/4] inexact rename detection eye candy
Date: Sat, 19 Feb 2011 05:25:33 -0500
Message-ID: <20110219102533.GD22508@sigill.intra.peff.net>
References: <20110219101936.GB20577@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 19 11:25:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqk0S-0005R8-7h
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 11:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620Ab1BSKZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 05:25:36 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48651 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858Ab1BSKZf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 05:25:35 -0500
Received: (qmail 8695 invoked by uid 111); 19 Feb 2011 10:25:34 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 19 Feb 2011 10:25:34 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Feb 2011 05:25:33 -0500
Content-Disposition: inline
In-Reply-To: <20110219101936.GB20577@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167268>

During a merge, we might spend many seconds doing inexact
rename detection. It's nice to let the user know that
something is actually happening.

Signed-off-by: Jeff King <peff@peff.net>
---
This feels wrong because it's in such a deep library function. At the
very least we probably need some way to turn it off, so callers can pass
along any --quiet or --no-progress indicators. Though I think it should
perhaps be off entirely for any revision traversals (since the progress
will be per-commit, so it will be in the middle of log output). And then
on for diff (unless --quiet is given), and on for merge.

I made it update progress for each of the rename_src * rename_dst
similarity estimates. We could just as easily count rename_dst items we
look at, but hey, it's eye candy, and obviously bigger numbers are
better.

 diffcore-rename.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1d3d5cd..136a86f 100644
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
+	struct progress *progress;
 
 	if (!minimum_score)
 		minimum_score = DEFAULT_RENAME_SCORE;
@@ -528,6 +530,10 @@ void diffcore_rename(struct diff_options *options)
 		goto cleanup;
 	}
 
+	progress = start_progress_delay(
+			"Performing inexact rename detection",
+			rename_dst_nr * rename_src_nr, 50, 1);
+
 	mx = xcalloc(num_create * NUM_CANDIDATE_PER_DST, sizeof(*mx));
 	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
 		struct diff_filespec *two = rename_dst[i].two;
@@ -555,9 +561,11 @@ void diffcore_rename(struct diff_options *options)
 			 */
 			diff_free_filespec_blob(one);
 			diff_free_filespec_blob(two);
+			display_progress(progress, i*rename_src_nr + j);
 		}
 		dst_cnt++;
 	}
+	stop_progress(&progress);
 
 	/* cost matrix sorted by most to least similar pair */
 	qsort(mx, dst_cnt * NUM_CANDIDATE_PER_DST, sizeof(*mx), score_compare);
-- 
1.7.4.1.26.g5e991
