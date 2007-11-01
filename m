From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/3] Show total transferred as part of throughput progress
Date: Thu, 01 Nov 2007 16:59:57 -0400
Message-ID: <1193950797-29631-4-git-send-email-nico@cam.org>
References: <1193950797-29631-1-git-send-email-nico@cam.org>
 <1193950797-29631-2-git-send-email-nico@cam.org>
 <1193950797-29631-3-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:00:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inh9c-0000yZ-8S
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbXKAVAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbXKAVAD
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:00:03 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31466 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbXKAVAA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:00:00 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQU002D3IBX07M0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Nov 2007 16:59:58 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.279.gb2d9d-dirty
In-reply-to: <1193950797-29631-3-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62999>

Right now it is infeasible to offer to the user a reasonable concept
of when a clone will be complete as we aren't able to come up with
the final pack size until after we have actually transferred the
entire thing to the client.  However in many cases users can work
with a rough rule-of-thumb; for example it is somewhat well known
that git.git is about 16 MiB today and that linux-2.6.git is over
120 MiB.

We now show the total amount of data we have transferred over
the network as part of the throughput meter, organizing it in
"human friendly" terms like `ls -h` would do.  Users can glance at
this, see that the total transferred size is about 3 MiB, see the
throughput of X KiB/sec, and determine a reasonable figure of about
when the clone will be complete, assuming they know the rough size
of the source repository or are able to obtain it.

This is also a helpful indicator that there is progress being made
even if we stall on a very large object.  The thoughput meter may
remain relatively constant and the percentage complete and object
count won't be changing, but the total transferred will be increasing
as additional data is received for this object.

[from an initial proposal from Shawn O. Pearce]

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 progress.c |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/progress.c b/progress.c
index 39d5d2c..3f6a602 100644
--- a/progress.c
+++ b/progress.c
@@ -15,13 +15,14 @@
 
 struct throughput {
 	struct timeval prev_tv;
+	off_t total;
 	unsigned long count;
 	unsigned long avg_bytes;
 	unsigned long last_bytes[TP_IDX_MAX];
 	unsigned int avg_misecs;
 	unsigned int last_misecs[TP_IDX_MAX];
 	unsigned int idx;
-	char display[20];
+	char display[32];
 };
 
 struct progress {
@@ -128,6 +129,7 @@ void display_throughput(struct progress *progress, unsigned long n)
 		return;
 	}
 
+	tp->total += n;
 	tp->count += n;
 
 	/*
@@ -149,11 +151,32 @@ void display_throughput(struct progress *progress, unsigned long n)
 	misecs += (int)(tv.tv_usec - tp->prev_tv.tv_usec) / 977;
 
 	if (misecs > 512) {
+		int l = sizeof(tp->display);
 		tp->prev_tv = tv;
 		tp->avg_bytes += tp->count;
 		tp->avg_misecs += misecs;
-		snprintf(tp->display, sizeof(tp->display),
-			 ", %lu KiB/s", tp->avg_bytes / tp->avg_misecs);
+
+		if (tp->total > 1 << 30) {
+			l -= snprintf(tp->display, l, ", %u.%2.2u GiB",
+				      (int)(tp->total >> 30),
+				      (int)(tp->total & ((1 << 30) - 1)) / 10737419);
+		} else if (tp->total > 1 << 20) {
+			l -= snprintf(tp->display, l, ", %u.%2.2u MiB",
+				      (int)(tp->total >> 20),
+				      ((int)(tp->total & ((1 << 20) - 1))
+				       * 100) >> 20);
+		} else if (tp->total > 1 << 10) {
+			l -= snprintf(tp->display, l, ", %u.%2.2u KiB",
+				      (int)(tp->total >> 10),
+				      ((int)(tp->total & ((1 << 10) - 1))
+				       * 100) >> 10);
+		} else {
+			l -= snprintf(tp->display, l, ", %u bytes",
+				      (int)tp->total);
+		}
+		snprintf(tp->display + sizeof(tp->display) - l, l,
+			 " | %lu KiB/s", tp->avg_bytes / tp->avg_misecs);
+
 		tp->avg_bytes -= tp->last_bytes[tp->idx];
 		tp->avg_misecs -= tp->last_misecs[tp->idx];
 		tp->last_bytes[tp->idx] = tp->count;
-- 
1.5.3.4.279.gb2d9d-dirty
