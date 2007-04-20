From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/3] provide a facility for "delayed" progress reporting
Date: Fri, 20 Apr 2007 15:05:27 -0400
Message-ID: <S1767212AbXDTTaU/20070420193020Z+531@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Apr 20 21:30:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeyoK-0007Kn-6M
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 21:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767206AbXDTTaU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 15:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767212AbXDTTaU
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 15:30:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23025 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767206AbXDTTaR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 15:30:17 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGT005MFA6F8SH0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 20 Apr 2007 15:30:16 -0400 (EDT)
Apparently-To: <nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45126>

This allows for progress to be displayed only if the progress has not
reached a specified percentage treshold within a given delay in seconds.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 progress.c |   34 ++++++++++++++++++++++++++++++++++
 progress.h |    6 ++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/progress.c b/progress.c
index 478134b..05f7890 100644
--- a/progress.c
+++ b/progress.c
@@ -13,6 +13,8 @@ static void set_progress_signal(void)
 	struct sigaction sa;
 	struct itimerval v;
 
+	progress_update = 0;
+
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_handler = progress_interval;
 	sigemptyset(&sa.sa_mask);
@@ -35,6 +37,24 @@ static void clear_progress_signal(void)
 
 int display_progress(struct progress *progress, unsigned n)
 {
+	if (progress->delay) {
+		char buf[80];
+		if (!progress_update || --progress->delay)
+			return 0;
+		if (progress->total) {
+			unsigned percent = n * 100 / progress->total;
+			if (percent > progress->delayed_percent_treshold) {
+				/* inhibit this progress report entirely */
+				clear_progress_signal();
+				progress->delay = -1;
+				progress->total = 0;
+				return 0;
+			}
+		}
+		if (snprintf(buf, sizeof(buf),
+			     progress->delayed_title, progress->total))
+			fprintf(stderr, "%s\n", buf);
+	}
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
 		if (percent != progress->last_percent || progress_update) {
@@ -59,11 +79,25 @@ void start_progress(struct progress *progress, const char *title,
 	progress->prefix = prefix;
 	progress->total = total;
 	progress->last_percent = -1;
+	progress->delay = 0;
 	if (snprintf(buf, sizeof(buf), title, total))
 		fprintf(stderr, "%s\n", buf);
 	set_progress_signal();
 }
 
+void start_progress_delay(struct progress *progress, const char *title,
+			  const char *prefix, unsigned total,
+			  unsigned percent_treshold, unsigned delay)
+{
+	progress->prefix = prefix;
+	progress->total = total;
+	progress->last_percent = -1;
+	progress->delayed_percent_treshold = percent_treshold;
+	progress->delayed_title = title;
+	progress->delay = delay;
+	set_progress_signal();
+}
+
 void stop_progress(struct progress *progress)
 {
 	clear_progress_signal();
diff --git a/progress.h b/progress.h
index 1f2661e..4ee851a 100644
--- a/progress.h
+++ b/progress.h
@@ -5,11 +5,17 @@ struct progress {
 	const char *prefix;
 	unsigned total;
 	unsigned last_percent;
+	unsigned delay;
+	unsigned delayed_percent_treshold;
+	const char *delayed_title;
 };
 
 int display_progress(struct progress *progress, unsigned n);
 void start_progress(struct progress *progress, const char *title,
 		    const char *prefix, unsigned total);
+void start_progress_delay(struct progress *progress, const char *title,
+			  const char *prefix, unsigned total,
+			  unsigned percent_treshold, unsigned delay);
 void stop_progress(struct progress *progress);
 
 #endif
-- 
1.5.1.1.874.g4f52f-dirty
