From: Jeff King <peff@peff.net>
Subject: [PATCH] progress: store throughput display in a strbuf
Date: Wed, 17 Jun 2015 14:54:06 -0400
Message-ID: <20150617185406.GA727@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 20:54:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5ITW-0000ps-Ju
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 20:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693AbbFQSyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 14:54:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:47561 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755636AbbFQSyI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 14:54:08 -0400
Received: (qmail 28354 invoked by uid 102); 17 Jun 2015 18:54:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 13:54:08 -0500
Received: (qmail 28052 invoked by uid 107); 17 Jun 2015 18:54:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 14:54:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jun 2015 14:54:06 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271880>

Coverity noticed that we strncpy() into a fixed-size buffer
without making sure that it actually ended up
NUL-terminated. This is unlikely to be a bug in practice,
since throughput strings rarely hit 32 characters, but it
would be nice to clean it up.

The most obvious way to do so is to add a NUL-terminator.
But instead, this patch switches the fixed-size buffer out
for a strbuf. At first glance this seems much less
efficient, until we realize that filling in the fixed-size
buffer is done by writing into a strbuf and copying the
result!

By writing straight to the buffer, we actually end up more
efficient:

  1. We avoid an extra copy of the bytes.

  2. Rather than malloc/free each time progress is shown, we
     can strbuf_reset and use the same buffer each time.

Signed-off-by: Jeff King <peff@peff.net>
---
 progress.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/progress.c b/progress.c
index 2e31bec..a3efcfd 100644
--- a/progress.c
+++ b/progress.c
@@ -25,7 +25,7 @@ struct throughput {
 	unsigned int last_bytes[TP_IDX_MAX];
 	unsigned int last_misecs[TP_IDX_MAX];
 	unsigned int idx;
-	char display[32];
+	struct strbuf display;
 };
 
 struct progress {
@@ -98,7 +98,7 @@ static int display(struct progress *progress, unsigned n, const char *done)
 	}
 
 	progress->last_value = n;
-	tp = (progress->throughput) ? progress->throughput->display : "";
+	tp = (progress->throughput) ? progress->throughput->display.buf : "";
 	eol = done ? done : "   \r";
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
@@ -129,6 +129,7 @@ static int display(struct progress *progress, unsigned n, const char *done)
 static void throughput_string(struct strbuf *buf, off_t total,
 			      unsigned int rate)
 {
+	strbuf_reset(buf);
 	strbuf_addstr(buf, ", ");
 	strbuf_humanise_bytes(buf, total);
 	strbuf_addstr(buf, " | ");
@@ -141,7 +142,6 @@ void display_throughput(struct progress *progress, off_t total)
 	struct throughput *tp;
 	uint64_t now_ns;
 	unsigned int misecs, count, rate;
-	struct strbuf buf = STRBUF_INIT;
 
 	if (!progress)
 		return;
@@ -154,6 +154,7 @@ void display_throughput(struct progress *progress, off_t total)
 		if (tp) {
 			tp->prev_total = tp->curr_total = total;
 			tp->prev_ns = now_ns;
+			strbuf_init(&tp->display, 0);
 		}
 		return;
 	}
@@ -193,9 +194,7 @@ void display_throughput(struct progress *progress, off_t total)
 	tp->last_misecs[tp->idx] = misecs;
 	tp->idx = (tp->idx + 1) % TP_IDX_MAX;
 
-	throughput_string(&buf, total, rate);
-	strncpy(tp->display, buf.buf, sizeof(tp->display));
-	strbuf_release(&buf);
+	throughput_string(&tp->display, total, rate);
 	if (progress->last_value != -1 && progress_update)
 		display(progress, progress->last_value, NULL);
 }
@@ -250,12 +249,9 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 
 		bufp = (len < sizeof(buf)) ? buf : xmalloc(len + 1);
 		if (tp) {
-			struct strbuf strbuf = STRBUF_INIT;
 			unsigned int rate = !tp->avg_misecs ? 0 :
 					tp->avg_bytes / tp->avg_misecs;
-			throughput_string(&strbuf, tp->curr_total, rate);
-			strncpy(tp->display, strbuf.buf, sizeof(tp->display));
-			strbuf_release(&strbuf);
+			throughput_string(&tp->display, tp->curr_total, rate);
 		}
 		progress_update = 1;
 		sprintf(bufp, ", %s.\n", msg);
@@ -264,6 +260,8 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 			free(bufp);
 	}
 	clear_progress_signal();
+	if (progress->throughput)
+		strbuf_release(&progress->throughput->display);
 	free(progress->throughput);
 	free(progress);
 }
-- 
2.4.4.719.g3984bc6
