From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] make display of total transferred fully accurate
Date: Tue, 06 Nov 2007 16:30:28 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711061608031.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 22:30:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpW0T-0001wB-4t
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 22:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874AbXKFVaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 16:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754741AbXKFVaa
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 16:30:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39220 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791AbXKFVa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 16:30:29 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JR300326T2SYSF0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Nov 2007 16:30:29 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63731>

The minimum delay of 1/2 sec between successive throughput updates might 
not have been elapsed when display_throughput() is called for the last 
time, potentially making the display of total transferred bytes not 
right when progress is said to be done.

Let's force an update of the throughput display as well when the 
progress is complete.  As a side effect, the total transferred will 
always be displayed even if the actual transfer rate doesn't have time 
to kickin.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

It was seriously bugging me that the total still didn't match the size 
of received packs exactly, even after my previous attempt at fixing it.

diff --git a/progress.c b/progress.c
index a963bd8..2a5a2da 100644
--- a/progress.c
+++ b/progress.c
@@ -14,11 +14,12 @@
 #define TP_IDX_MAX      8
 
 struct throughput {
+	off_t curr_total;
 	off_t prev_total;
 	struct timeval prev_tv;
 	unsigned int avg_bytes;
-	unsigned int last_bytes[TP_IDX_MAX];
 	unsigned int avg_misecs;
+	unsigned int last_bytes[TP_IDX_MAX];
 	unsigned int last_misecs[TP_IDX_MAX];
 	unsigned int idx;
 	char display[32];
@@ -109,6 +110,30 @@ static int display(struct progress *progress, unsigned n, int done)
 	return 0;
 }
 
+static void throughput_string(struct throughput *tp, off_t total,
+			      unsigned int rate)
+{	
+	int l = sizeof(tp->display);
+	if (total > 1 << 30) {
+		l -= snprintf(tp->display, l, ", %u.%2.2u GiB",
+			      (int)(total >> 30),
+			      (int)(total & ((1 << 30) - 1)) / 10737419);
+	} else if (total > 1 << 20) {
+		l -= snprintf(tp->display, l, ", %u.%2.2u MiB",
+			      (int)(total >> 20),
+			      ((int)(total & ((1 << 20) - 1)) * 100) >> 20);
+	} else if (total > 1 << 10) {
+		l -= snprintf(tp->display, l, ", %u.%2.2u KiB",
+			      (int)(total >> 10),
+			      ((int)(total & ((1 << 10) - 1)) * 100) >> 10);
+	} else {
+		l -= snprintf(tp->display, l, ", %u bytes", (int)total);
+	}
+	if (rate)
+		snprintf(tp->display + sizeof(tp->display) - l, l,
+			 " | %u KiB/s", rate);
+}
+
 void display_throughput(struct progress *progress, off_t total)
 {
 	struct throughput *tp;
@@ -124,11 +149,12 @@ void display_throughput(struct progress *progress, off_t total)
 	if (!tp) {
 		progress->throughput = tp = calloc(1, sizeof(*tp));
 		if (tp) {
-			tp->prev_total = total;
+			tp->prev_total = tp->curr_total = total;
 			tp->prev_tv = tv;
 		}
 		return;
 	}
+	tp->curr_total = total;
 
 	/*
 	 * We have x = bytes and y = microsecs.  We want z = KiB/s:
@@ -149,39 +175,21 @@ void display_throughput(struct progress *progress, off_t total)
 	misecs += (int)(tv.tv_usec - tp->prev_tv.tv_usec) / 977;
 
 	if (misecs > 512) {
-		int l = sizeof(tp->display);
-		unsigned int count = total - tp->prev_total;
+		unsigned int count, rate;
+	       
+		count = total - tp->prev_total;
 		tp->prev_total = total;
 		tp->prev_tv = tv;
 		tp->avg_bytes += count;
 		tp->avg_misecs += misecs;
-
-		if (total > 1 << 30) {
-			l -= snprintf(tp->display, l, ", %u.%2.2u GiB",
-				      (int)(total >> 30),
-				      (int)(total & ((1 << 30) - 1)) / 10737419);
-		} else if (total > 1 << 20) {
-			l -= snprintf(tp->display, l, ", %u.%2.2u MiB",
-				      (int)(total >> 20),
-				      ((int)(total & ((1 << 20) - 1))
-				       * 100) >> 20);
-		} else if (total > 1 << 10) {
-			l -= snprintf(tp->display, l, ", %u.%2.2u KiB",
-				      (int)(total >> 10),
-				      ((int)(total & ((1 << 10) - 1))
-				       * 100) >> 10);
-		} else {
-			l -= snprintf(tp->display, l, ", %u bytes", (int)total);
-		}
-		snprintf(tp->display + sizeof(tp->display) - l, l,
-			 " | %u KiB/s", tp->avg_bytes / tp->avg_misecs);
-
+		rate = tp->avg_bytes / tp->avg_misecs;
 		tp->avg_bytes -= tp->last_bytes[tp->idx];
 		tp->avg_misecs -= tp->last_misecs[tp->idx];
 		tp->last_bytes[tp->idx] = count;
 		tp->last_misecs[tp->idx] = misecs;
 		tp->idx = (tp->idx + 1) % TP_IDX_MAX;
 
+		throughput_string(tp, total, rate);
 		if (progress->last_value != -1 && progress_update)
 			display(progress, progress->last_value, 0);
 	}
@@ -225,6 +233,12 @@ void stop_progress(struct progress **p_progress)
 	*p_progress = NULL;
 	if (progress->last_value != -1) {
 		/* Force the last update */
+		struct throughput *tp = progress->throughput;
+		if (tp) {
+			unsigned int rate = !tp->avg_misecs ? 0 :
+					tp->avg_bytes / tp->avg_misecs;
+			throughput_string(tp, tp->curr_total, rate);
+		}
 		progress_update = 1;
 		display(progress, progress->last_value, 1);
 	}
