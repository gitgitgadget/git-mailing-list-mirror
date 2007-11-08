From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] nicer display of thin pack completion
Date: Thu, 08 Nov 2007 15:45:41 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711081536540.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 21:46:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqEGf-000624-Qe
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 21:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761487AbXKHUpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 15:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761447AbXKHUpn
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 15:45:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:50821 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760798AbXKHUpm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 15:45:42 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JR700CJMGC5W4U0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 08 Nov 2007 15:45:42 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64070>

In the same spirit of prettifying Git's output display for mere mortals,
here's a simple extension to the progress API allowing for a final 
message to be provided when terminating a progress line, and use it for
the display of the number of objects needed to complete a thin pack,
saving yet one more line of screen display.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/index-pack.c b/index-pack.c
index 581a7f5..469a330 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -792,6 +792,7 @@ int main(int argc, char **argv)
 		flush();
 	} else {
 		if (fix_thin_pack) {
+			char msg[48];
 			int nr_unresolved = nr_deltas - nr_resolved_deltas;
 			int nr_objects_initial = nr_objects;
 			if (nr_unresolved <= 0)
@@ -800,12 +801,11 @@ int main(int argc, char **argv)
 					   (nr_objects + nr_unresolved + 1)
 					   * sizeof(*objects));
 			fix_unresolved_deltas(nr_unresolved);
-			stop_progress(&progress);
-			if (verbose)
-				fprintf(stderr, "%d objects were added to complete this thin pack.\n",
-					nr_objects - nr_objects_initial);
+			sprintf(msg, "completed with %d local objects",
+				nr_objects - nr_objects_initial);
+			stop_progress_msg(&progress, msg);
 			fixup_pack_header_footer(output_fd, sha1,
-				curr_pack, nr_objects);
+						 curr_pack, nr_objects);
 		}
 		if (nr_deltas != nr_resolved_deltas)
 			die("pack has %d unresolved deltas",
diff --git a/progress.c b/progress.c
index 0700dcf..4bd650f 100644
--- a/progress.c
+++ b/progress.c
@@ -69,9 +69,9 @@ static void clear_progress_signal(void)
 	progress_update = 0;
 }
 
-static int display(struct progress *progress, unsigned n, int done)
+static int display(struct progress *progress, unsigned n, const char *done)
 {
-	char *eol, *tp;
+	const char *eol, *tp;
 
 	if (progress->delay) {
 		if (!progress_update || --progress->delay)
@@ -90,7 +90,7 @@ static int display(struct progress *progress, unsigned n, int done)
 
 	progress->last_value = n;
 	tp = (progress->throughput) ? progress->throughput->display : "";
-	eol = done ? ", done.   \n" : "   \r";
+	eol = done ? done : "   \r";
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
 		if (percent != progress->last_percent || progress_update) {
@@ -191,13 +191,13 @@ void display_throughput(struct progress *progress, off_t total)
 
 		throughput_string(tp, total, rate);
 		if (progress->last_value != -1 && progress_update)
-			display(progress, progress->last_value, 0);
+			display(progress, progress->last_value, NULL);
 	}
 }
 
 int display_progress(struct progress *progress, unsigned n)
 {
-	return progress ? display(progress, n, 0) : 0;
+	return progress ? display(progress, n, NULL) : 0;
 }
 
 struct progress *start_progress_delay(const char *title, unsigned total,
@@ -227,12 +227,18 @@ struct progress *start_progress(const char *title, unsigned total)
 
 void stop_progress(struct progress **p_progress)
 {
+	stop_progress_msg(p_progress, "done");
+}
+
+void stop_progress_msg(struct progress **p_progress, const char *msg)
+{
 	struct progress *progress = *p_progress;
 	if (!progress)
 		return;
 	*p_progress = NULL;
 	if (progress->last_value != -1) {
 		/* Force the last update */
+		char buf[strlen(msg) + 5];
 		struct throughput *tp = progress->throughput;
 		if (tp) {
 			unsigned int rate = !tp->avg_misecs ? 0 :
@@ -240,7 +246,8 @@ void stop_progress(struct progress **p_progress)
 			throughput_string(tp, tp->curr_total, rate);
 		}
 		progress_update = 1;
-		display(progress, progress->last_value, 1);
+		sprintf(buf, ", %s.\n", msg);
+		display(progress, progress->last_value, buf);
 	}
 	clear_progress_signal();
 	free(progress->throughput);
diff --git a/progress.h b/progress.h
index 3912969..611e4c4 100644
--- a/progress.h
+++ b/progress.h
@@ -9,5 +9,6 @@ struct progress *start_progress(const char *title, unsigned total);
 struct progress *start_progress_delay(const char *title, unsigned total,
 				       unsigned percent_treshold, unsigned delay);
 void stop_progress(struct progress **progress);
+void stop_progress_msg(struct progress **progress, const char *msg);
 
 #endif
