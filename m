From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 4/5] add throughput to progress display
Date: Tue, 30 Oct 2007 14:57:34 -0400
Message-ID: <1193770655-20492-5-git-send-email-nico@cam.org>
References: <1193770655-20492-1-git-send-email-nico@cam.org>
 <1193770655-20492-2-git-send-email-nico@cam.org>
 <1193770655-20492-3-git-send-email-nico@cam.org>
 <1193770655-20492-4-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:59:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImwIn-0001oE-Rr
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 19:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbXJ3S6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 14:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753591AbXJ3S6Q
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 14:58:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37695 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbXJ3S6I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 14:58:08 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQQ0021VNC05WB0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Oct 2007 14:57:39 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.1463.gf79ad2
In-reply-to: <1193770655-20492-4-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62735>

This adds the ability for the progress code to also display transfer
throughput when that makes sense.

The math was inspired by commit c548cf4ee0737a321ffe94f6a97c65baf87281be
from Linus.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 progress.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 progress.h |    1 +
 2 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/progress.c b/progress.c
index 7f9b00e..23ee9f3 100644
--- a/progress.c
+++ b/progress.c
@@ -1,6 +1,19 @@
 #include "git-compat-util.h"
 #include "progress.h"
 
+#define TP_IDX_MAX      8
+
+struct throughput {
+	struct timeval prev_tv;
+	unsigned long count;
+	unsigned long avg_bytes;
+	unsigned long last_bytes[TP_IDX_MAX];
+	unsigned int avg_misecs;
+	unsigned int last_misecs[TP_IDX_MAX];
+	unsigned int idx;
+	char display[20];
+};
+
 struct progress {
 	const char *title;
 	int last_value;
@@ -8,6 +21,7 @@ struct progress {
 	unsigned last_percent;
 	unsigned delay;
 	unsigned delayed_percent_treshold;
+	struct throughput *throughput;
 };
 
 static volatile sig_atomic_t progress_update;
@@ -46,7 +60,7 @@ static void clear_progress_signal(void)
 
 static int display(struct progress *progress, unsigned n, int done)
 {
-	char *eol;
+	char *eol, *tp;
 
 	if (progress->delay) {
 		if (!progress_update || --progress->delay)
@@ -64,18 +78,20 @@ static int display(struct progress *progress, unsigned n, int done)
 	}
 
 	progress->last_value = n;
+	tp = (progress->throughput) ? progress->throughput->display : "";
 	eol = done ? ", done.   \n" : "   \r";
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
 		if (percent != progress->last_percent || progress_update) {
 			progress->last_percent = percent;
-			fprintf(stderr, "%s: %3u%% (%u/%u)%s", progress->title,
-				percent, n, progress->total, eol);
+			fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
+				progress->title, percent, n,
+				progress->total, tp, eol);
 			progress_update = 0;
 			return 1;
 		}
 	} else if (progress_update) {
-		fprintf(stderr, "%s: %u%s", progress->title, n, eol);
+		fprintf(stderr, "%s: %u%s%s", progress->title, n, tp, eol);
 		progress_update = 0;
 		return 1;
 	}
@@ -83,6 +99,60 @@ static int display(struct progress *progress, unsigned n, int done)
 	return 0;
 }
 
+void display_throughput(struct progress *progress, unsigned long n)
+{
+	struct throughput *tp;
+	struct timeval tv;
+	unsigned int misecs;
+
+	if (!progress)
+		return;
+	tp = progress->throughput;
+
+	gettimeofday(&tv, NULL);
+
+	if (!tp) {
+		progress->throughput = tp = calloc(1, sizeof(*tp));
+		if (tp)
+			tp->prev_tv = tv;
+		return;
+	}
+
+	tp->count += n;
+
+	/*
+	 * We have x = bytes and y = microsecs.  We want z = KiB/s:
+	 *
+	 *	z = (x / 1024) / (y / 1000000)
+	 *	z = x / y * 1000000 / 1024
+	 *	z = x / (y * 1024 / 1000000)
+	 *	z = x / y'
+	 *
+	 * To simplify things we'll keep track of misecs, or 1024th of a sec
+	 * obtained with:
+	 *
+	 *	y' = y * 1024 / 1000000
+	 *	y' = y / (1000000 / 1024)
+	 *	y' = y / 977
+	 */
+	misecs = (tv.tv_sec - tp->prev_tv.tv_sec) * 1024;
+	misecs += (int)(tv.tv_usec - tp->prev_tv.tv_usec) / 977;
+
+	if (misecs > 512) {
+		tp->prev_tv = tv;
+		tp->avg_bytes += tp->count;
+		tp->avg_misecs += misecs;
+		snprintf(tp->display, sizeof(tp->display),
+			 ", %lu KiB/s", tp->avg_bytes / tp->avg_misecs);
+		tp->avg_bytes -= tp->last_bytes[tp->idx];
+		tp->avg_misecs -= tp->last_misecs[tp->idx];
+		tp->last_bytes[tp->idx] = tp->count;
+		tp->last_misecs[tp->idx] = misecs;
+		tp->idx = (tp->idx + 1) % TP_IDX_MAX;
+		tp->count = 0;
+	}
+}
+
 int display_progress(struct progress *progress, unsigned n)
 {
 	return progress ? display(progress, n, 0) : 0;
@@ -103,6 +173,7 @@ struct progress * start_progress_delay(const char *title, unsigned total,
 	progress->last_percent = -1;
 	progress->delayed_percent_treshold = percent_treshold;
 	progress->delay = delay;
+	progress->throughput = NULL;
 	set_progress_signal();
 	return progress;
 }
@@ -124,5 +195,6 @@ void stop_progress(struct progress **p_progress)
 		display(progress, progress->last_value, 1);
 	}
 	clear_progress_signal();
+	free(progress->throughput);
 	free(progress);
 }
diff --git a/progress.h b/progress.h
index 29780ce..7902ca5 100644
--- a/progress.h
+++ b/progress.h
@@ -3,6 +3,7 @@
 
 struct progress;
 
+void display_throughput(struct progress *progress, unsigned long n);
 int display_progress(struct progress *progress, unsigned n);
 struct progress * start_progress(const char *title, unsigned total);
 struct progress * start_progress_delay(const char *title, unsigned total,
-- 
1.5.3.4.1463.gf79ad2
