From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] progress: use pager's original_stderr if available
Date: Thu, 24 Mar 2011 13:47:32 -0400
Message-ID: <20110324174732.GB30685@sigill.intra.peff.net>
References: <20110324174556.GA30661@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 18:47:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2odW-00083v-H7
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 18:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932885Ab1CXRrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 13:47:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37283
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932840Ab1CXRrh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 13:47:37 -0400
Received: (qmail 4158 invoked by uid 107); 24 Mar 2011 17:48:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Mar 2011 13:48:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Mar 2011 13:47:32 -0400
Content-Disposition: inline
In-Reply-To: <20110324174556.GA30661@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169931>

If we are outputting to a pager, stderr is redirected to the
pager. However, progress messages should not be part of that
stream, as they are time-sensitive and would end up being
hidden once we actually have output.

Signed-off-by: Jeff King <peff@peff.net>
---
Same as the last iteration.

 progress.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/progress.c b/progress.c
index 3971f49..bc7d3a3 100644
--- a/progress.c
+++ b/progress.c
@@ -10,6 +10,7 @@
 
 #include "git-compat-util.h"
 #include "progress.h"
+#include "cache.h"
 
 #define TP_IDX_MAX      8
 
@@ -71,6 +72,7 @@ static void clear_progress_signal(void)
 
 static int display(struct progress *progress, unsigned n, const char *done)
 {
+	FILE *out = original_stderr ? original_stderr : stderr;
 	const char *eol, *tp;
 
 	if (progress->delay) {
@@ -95,16 +97,16 @@ static int display(struct progress *progress, unsigned n, const char *done)
 		unsigned percent = n * 100 / progress->total;
 		if (percent != progress->last_percent || progress_update) {
 			progress->last_percent = percent;
-			fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
+			fprintf(out, "%s: %3u%% (%u/%u)%s%s",
 				progress->title, percent, n,
 				progress->total, tp, eol);
-			fflush(stderr);
+			fflush(out);
 			progress_update = 0;
 			return 1;
 		}
 	} else if (progress_update) {
-		fprintf(stderr, "%s: %u%s%s", progress->title, n, tp, eol);
-		fflush(stderr);
+		fprintf(out, "%s: %u%s%s", progress->title, n, tp, eol);
+		fflush(out);
 		progress_update = 0;
 		return 1;
 	}
@@ -211,11 +213,12 @@ int display_progress(struct progress *progress, unsigned n)
 struct progress *start_progress_delay(const char *title, unsigned total,
 				       unsigned percent_treshold, unsigned delay)
 {
+	FILE *out = original_stderr ? original_stderr : stderr;
 	struct progress *progress = malloc(sizeof(*progress));
 	if (!progress) {
 		/* unlikely, but here's a good fallback */
-		fprintf(stderr, "%s...\n", title);
-		fflush(stderr);
+		fprintf(out, "%s...\n", title);
+		fflush(out);
 		return NULL;
 	}
 	progress->title = title;
-- 
1.7.4.41.g423da
