From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] make display of total transferred more accurate
Date: Sun, 04 Nov 2007 22:15:41 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711042144290.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 04:16:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IosS0-0002wr-4l
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 04:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbXKEDPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 22:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbXKEDPo
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 22:15:44 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30477 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbXKEDPn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 22:15:43 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JR000GGSJQ5Y740@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 04 Nov 2007 22:15:42 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63478>

The throughput display needs a delay period before accounting and 
displaying anything.  Yet it might be called after some amount of data 
has already been transferred.  The display of total data is therefore 
accounted late and therefore smaller than the reality.

Let's call display_throughput() with an absolute amount of transferred 
data instead of a relative number, and let the throughput code find the 
relative amount of data by itself as needed.  This way the displayed 
total is always exact.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/csum-file.c b/csum-file.c
index 3729e73..b445e6a 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -18,7 +18,8 @@ static void sha1flush(struct sha1file *f, unsigned int count)
 	for (;;) {
 		int ret = xwrite(f->fd, buf, count);
 		if (ret > 0) {
-			display_throughput(f->tp, ret);
+			f->total += ret;
+			display_throughput(f->tp, f->total);
 			buf = (char *) buf + ret;
 			count -= ret;
 			if (count)
@@ -101,6 +102,7 @@ struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp
 	f->fd = fd;
 	f->error = 0;
 	f->offset = 0;
+	f->total = 0;
 	f->tp = tp;
 	f->do_crc = 0;
 	SHA1_Init(&f->ctx);
diff --git a/csum-file.h b/csum-file.h
index 4d1b231..a38cc3a 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -8,6 +8,7 @@ struct sha1file {
 	int fd, error;
 	unsigned int offset, namelen;
 	SHA_CTX ctx;
+	off_t total;
 	struct progress *tp;
 	char name[PATH_MAX];
 	int do_crc;
diff --git a/index-pack.c b/index-pack.c
index 715a5bb..581a7f5 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -87,9 +87,9 @@ static void *fill(int min)
 				die("early EOF");
 			die("read error on input: %s", strerror(errno));
 		}
-		if (from_stdin)
-			display_throughput(progress, ret);
 		input_len += ret;
+		if (from_stdin)
+			display_throughput(progress, consumed_bytes + input_len);
 	} while (input_len < min);
 	return input_buffer;
 }
diff --git a/progress.c b/progress.c
index 3f6a602..a963bd8 100644
--- a/progress.c
+++ b/progress.c
@@ -14,11 +14,10 @@
 #define TP_IDX_MAX      8
 
 struct throughput {
+	off_t prev_total;
 	struct timeval prev_tv;
-	off_t total;
-	unsigned long count;
-	unsigned long avg_bytes;
-	unsigned long last_bytes[TP_IDX_MAX];
+	unsigned int avg_bytes;
+	unsigned int last_bytes[TP_IDX_MAX];
 	unsigned int avg_misecs;
 	unsigned int last_misecs[TP_IDX_MAX];
 	unsigned int idx;
@@ -110,7 +109,7 @@ static int display(struct progress *progress, unsigned n, int done)
 	return 0;
 }
 
-void display_throughput(struct progress *progress, unsigned long n)
+void display_throughput(struct progress *progress, off_t total)
 {
 	struct throughput *tp;
 	struct timeval tv;
@@ -124,14 +123,13 @@ void display_throughput(struct progress *progress, unsigned long n)
 
 	if (!tp) {
 		progress->throughput = tp = calloc(1, sizeof(*tp));
-		if (tp)
+		if (tp) {
+			tp->prev_total = total;
 			tp->prev_tv = tv;
+		}
 		return;
 	}
 
-	tp->total += n;
-	tp->count += n;
-
 	/*
 	 * We have x = bytes and y = microsecs.  We want z = KiB/s:
 	 *
@@ -152,37 +150,37 @@ void display_throughput(struct progress *progress, unsigned long n)
 
 	if (misecs > 512) {
 		int l = sizeof(tp->display);
+		unsigned int count = total - tp->prev_total;
+		tp->prev_total = total;
 		tp->prev_tv = tv;
-		tp->avg_bytes += tp->count;
+		tp->avg_bytes += count;
 		tp->avg_misecs += misecs;
 
-		if (tp->total > 1 << 30) {
+		if (total > 1 << 30) {
 			l -= snprintf(tp->display, l, ", %u.%2.2u GiB",
-				      (int)(tp->total >> 30),
-				      (int)(tp->total & ((1 << 30) - 1)) / 10737419);
-		} else if (tp->total > 1 << 20) {
+				      (int)(total >> 30),
+				      (int)(total & ((1 << 30) - 1)) / 10737419);
+		} else if (total > 1 << 20) {
 			l -= snprintf(tp->display, l, ", %u.%2.2u MiB",
-				      (int)(tp->total >> 20),
-				      ((int)(tp->total & ((1 << 20) - 1))
+				      (int)(total >> 20),
+				      ((int)(total & ((1 << 20) - 1))
 				       * 100) >> 20);
-		} else if (tp->total > 1 << 10) {
+		} else if (total > 1 << 10) {
 			l -= snprintf(tp->display, l, ", %u.%2.2u KiB",
-				      (int)(tp->total >> 10),
-				      ((int)(tp->total & ((1 << 10) - 1))
+				      (int)(total >> 10),
+				      ((int)(total & ((1 << 10) - 1))
 				       * 100) >> 10);
 		} else {
-			l -= snprintf(tp->display, l, ", %u bytes",
-				      (int)tp->total);
+			l -= snprintf(tp->display, l, ", %u bytes", (int)total);
 		}
 		snprintf(tp->display + sizeof(tp->display) - l, l,
-			 " | %lu KiB/s", tp->avg_bytes / tp->avg_misecs);
+			 " | %u KiB/s", tp->avg_bytes / tp->avg_misecs);
 
 		tp->avg_bytes -= tp->last_bytes[tp->idx];
 		tp->avg_misecs -= tp->last_misecs[tp->idx];
-		tp->last_bytes[tp->idx] = tp->count;
+		tp->last_bytes[tp->idx] = count;
 		tp->last_misecs[tp->idx] = misecs;
 		tp->idx = (tp->idx + 1) % TP_IDX_MAX;
-		tp->count = 0;
 
 		if (progress->last_value != -1 && progress_update)
 			display(progress, progress->last_value, 0);
diff --git a/progress.h b/progress.h
index 61cb68d..3912969 100644
--- a/progress.h
+++ b/progress.h
@@ -3,7 +3,7 @@
 
 struct progress;
 
-void display_throughput(struct progress *progress, unsigned long n);
+void display_throughput(struct progress *progress, off_t total);
 int display_progress(struct progress *progress, unsigned n);
 struct progress *start_progress(const char *title, unsigned total);
 struct progress *start_progress_delay(const char *title, unsigned total,
