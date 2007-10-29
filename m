From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/2] add throughput to progress display
Date: Mon, 29 Oct 2007 19:22:20 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710291904190.22100@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 00:22:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImdwM-0004OW-8K
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 00:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbXJ2XWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 19:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755865AbXJ2XWX
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 19:22:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25943 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbXJ2XWW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 19:22:22 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQP00DS94X8S110@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 29 Oct 2007 19:22:21 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62631>

This adds the ability for the progress code to also display throughput
when that makes sense.

The math was inspired by commit c548cf4ee0737a321ffe94f6a97c65baf87281be
from Linus.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/progress.c b/progress.c
index 7629e05..275579b 100644
--- a/progress.c
+++ b/progress.c
@@ -37,7 +37,7 @@ static void clear_progress_signal(void)
 
 static int display(struct progress *progress, unsigned n, int done)
 {
-	char *eol;
+	char *eol, *tp;
 
 	if (progress->delay) {
 		if (!progress_update || --progress->delay)
@@ -55,18 +55,20 @@ static int display(struct progress *progress, unsigned n, int done)
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
@@ -74,6 +76,59 @@ static int display(struct progress *progress, unsigned n, int done)
 	return 0;
 }
 
+void display_throughput(struct progress *progress, unsigned long n)
+{
+	struct throughput *tp = progress->throughput;
+	struct timeval tv;
+	unsigned int misecs;
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
+	 *
+	 * Taking care not to overflow y' we get:
+	 *
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
 	return display(progress, n, 0);
@@ -104,4 +159,6 @@ void stop_progress(struct progress *progress)
 		display(progress, progress->last_value, 1);
 	}
 	clear_progress_signal();
+	free(progress->throughput);
+	progress->throughput = NULL;
 }
diff --git a/progress.h b/progress.h
index 07b56bd..eba457f 100644
--- a/progress.h
+++ b/progress.h
@@ -1,6 +1,21 @@
 #ifndef PROGRESS_H
 #define PROGRESS_H
 
+#include <sys/time.h>
+
+#define TP_IDX_MAX	8
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
@@ -8,8 +23,10 @@ struct progress {
 	unsigned last_percent;
 	unsigned delay;
 	unsigned delayed_percent_treshold;
+	struct throughput *throughput;
 };
 
+void display_throughput(struct progress *progress, unsigned long n);
 int display_progress(struct progress *progress, unsigned n);
 void start_progress(struct progress *progress, const char *title,
 		    unsigned total);
