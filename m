From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Show total transferred as part of throughput progress display
Date: Wed, 31 Oct 2007 23:57:04 -0400
Message-ID: <20071101035704.GA4518@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 04:57:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InRBa-0004J6-Oh
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 04:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbXKAD5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 23:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753069AbXKAD5W
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 23:57:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45822 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbXKAD5W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 23:57:22 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1InRAs-0005Hv-FA; Wed, 31 Oct 2007 23:56:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 49F1120FBAE; Wed, 31 Oct 2007 23:57:05 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62910>

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

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This follows on top of Nico's 5 patch series to add the thoughput
 meter.  I think its a useful addition.

 progress.c |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/progress.c b/progress.c
index 23ee9f3..5c95091 100644
--- a/progress.c
+++ b/progress.c
@@ -11,7 +11,11 @@ struct throughput {
 	unsigned int avg_misecs;
 	unsigned int last_misecs[TP_IDX_MAX];
 	unsigned int idx;
-	char display[20];
+	unsigned int unit_size;
+	unsigned int unit_index;
+	unsigned int total_units;
+	unsigned int curr_bytes;
+	char display[40];
 };
 
 struct progress {
@@ -24,6 +28,7 @@ struct progress {
 	struct throughput *throughput;
 };
 
+static const char *units[] = {"bytes", "KiB", "MiB", "GiB"};
 static volatile sig_atomic_t progress_update;
 
 static void progress_interval(int signum)
@@ -113,12 +118,27 @@ void display_throughput(struct progress *progress, unsigned long n)
 
 	if (!tp) {
 		progress->throughput = tp = calloc(1, sizeof(*tp));
-		if (tp)
+		if (tp) {
 			tp->prev_tv = tv;
+			tp->unit_size = 1;
+		}
 		return;
 	}
 
 	tp->count += n;
+	tp->curr_bytes += n;
+	if (tp->curr_bytes > tp->unit_size) {
+		tp->total_units += tp->curr_bytes / tp->unit_size;
+		tp->curr_bytes = tp->curr_bytes % tp->unit_size;
+
+		while (tp->total_units >= 1024
+			&& tp->unit_index < ARRAY_SIZE(units)) {
+			tp->curr_bytes += (tp->total_units % 1024) * tp->unit_size;
+			tp->total_units = tp->total_units / 1024;
+			tp->unit_size *= 1024;
+			tp->unit_index++;
+		}
+	}
 
 	/*
 	 * We have x = bytes and y = microsecs.  We want z = KiB/s:
@@ -143,7 +163,13 @@ void display_throughput(struct progress *progress, unsigned long n)
 		tp->avg_bytes += tp->count;
 		tp->avg_misecs += misecs;
 		snprintf(tp->display, sizeof(tp->display),
-			 ", %lu KiB/s", tp->avg_bytes / tp->avg_misecs);
+			 ", %3u.%2.2u %s     %lu KiB/s",
+			 tp->total_units,
+			 tp->unit_size > 1
+				? tp->curr_bytes / (tp->unit_size / 100)
+				: 0,
+			 units[tp->unit_index],
+			 tp->avg_bytes / tp->avg_misecs);
 		tp->avg_bytes -= tp->last_bytes[tp->idx];
 		tp->avg_misecs -= tp->last_misecs[tp->idx];
 		tp->last_bytes[tp->idx] = tp->count;
-- 
1.5.3.4.1481.g854da
