From: Jeff King <peff@peff.net>
Subject: [PATCH 11/14] progress: allow pure-throughput progress meters
Date: Thu, 10 Nov 2011 02:53:00 -0500
Message-ID: <20111110075300.GK27950@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:53:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPRd-0004cB-Ba
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441Ab1KJHxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:53:04 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38929
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478Ab1KJHxD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:53:03 -0500
Received: (qmail 22550 invoked by uid 107); 10 Nov 2011 07:53:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:53:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:53:00 -0500
Content-Disposition: inline
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185209>

The progress code assumes we are counting something (usually
objects), even if we are measuring throughput. This works
for fetching packfiles, since they show us the object count
alongside the throughput, like:

  Receiving objects:   2% (301/11968), 22.00 MiB | 10.97 MiB/s

You can also tell the progress code you don't know how many
items you have (by specifying a total of 0), and it looks
like:

  Counting objects: 34957

However, if you're fetching a single large item, you want
throughput but you might not have a meaningful count. You
can say you are getting item 0 or 1 out of 1 total, but then
the percent meter is misleading:

  Downloading:   0% (0/1), 22.00 MiB | 10.97 MiB/s

or

  Downloading: 100% (0/1), 22.00 MiB | 10.97 MiB/s

Neither of those is accurate. You are probably somewhere
between zero and 100 percent through the operation, but you
don't know how far.

Telling it you don't know how many items is even uglier:

  Downloading: 1, 22.00 MiB | 10.97 MiB/s

Instead, this patch will omit the count entirely if you are
on the zero-th item of an unknown number of items. It looks
like:

  Downloading: 22.00 MiB | 10.97 MiB/s

Signed-off-by: Jeff King <peff@peff.net>
---
This was the last amount of work to massage the progress code into doing
what I wanted. It might be nicer if it could show a percentage (if we
know the total size), but there's even more surgery required for that.

 progress.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/progress.c b/progress.c
index 3971f49..92fc3c5 100644
--- a/progress.c
+++ b/progress.c
@@ -103,7 +103,10 @@ static int display(struct progress *progress, unsigned n, const char *done)
 			return 1;
 		}
 	} else if (progress_update) {
-		fprintf(stderr, "%s: %u%s%s", progress->title, n, tp, eol);
+		fprintf(stderr, "%s: ", progress->title);
+		if (n)
+			fprintf(stderr, "%u", n);
+		fprintf(stderr, "%s%s", tp, eol);
 		fflush(stderr);
 		progress_update = 0;
 		return 1;
@@ -113,23 +116,24 @@ static int display(struct progress *progress, unsigned n, const char *done)
 }
 
 static void throughput_string(struct throughput *tp, off_t total,
-			      unsigned int rate)
+			      unsigned int rate, struct progress *p)
 {
+	const char *delim = p->total || p->last_value > 0 ? ", " : "";
 	int l = sizeof(tp->display);
 	if (total > 1 << 30) {
-		l -= snprintf(tp->display, l, ", %u.%2.2u GiB",
+		l -= snprintf(tp->display, l, "%s%u.%2.2u GiB", delim,
 			      (int)(total >> 30),
 			      (int)(total & ((1 << 30) - 1)) / 10737419);
 	} else if (total > 1 << 20) {
 		int x = total + 5243;  /* for rounding */
-		l -= snprintf(tp->display, l, ", %u.%2.2u MiB",
+		l -= snprintf(tp->display, l, "%s%u.%2.2u MiB", delim,
 			      x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
 	} else if (total > 1 << 10) {
 		int x = total + 5;  /* for rounding */
-		l -= snprintf(tp->display, l, ", %u.%2.2u KiB",
+		l -= snprintf(tp->display, l, "%s%u.%2.2u KiB", delim,
 			      x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
 	} else {
-		l -= snprintf(tp->display, l, ", %u bytes", (int)total);
+		l -= snprintf(tp->display, l, "%s%u bytes", delim, (int)total);
 	}
 
 	if (rate > 1 << 10) {
@@ -197,7 +201,7 @@ void display_throughput(struct progress *progress, off_t total)
 		tp->last_misecs[tp->idx] = misecs;
 		tp->idx = (tp->idx + 1) % TP_IDX_MAX;
 
-		throughput_string(tp, total, rate);
+		throughput_string(tp, total, rate, progress);
 		if (progress->last_value != -1 && progress_update)
 			display(progress, progress->last_value, NULL);
 	}
@@ -255,7 +259,7 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 		if (tp) {
 			unsigned int rate = !tp->avg_misecs ? 0 :
 					tp->avg_bytes / tp->avg_misecs;
-			throughput_string(tp, tp->curr_total, rate);
+			throughput_string(tp, tp->curr_total, rate, progress);
 		}
 		progress_update = 1;
 		sprintf(bufp, ", %s.\n", msg);
-- 
1.7.7.2.7.g9f96f
