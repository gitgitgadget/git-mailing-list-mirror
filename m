From: Linus Torvalds <torvalds@osdl.org>
Subject: Make "git clone" pack-fetching download statistics better
Date: Sat, 11 Feb 2006 10:43:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602111041430.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Feb 11 19:44:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7zj3-00019a-LN
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 19:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWBKSoB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 13:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWBKSoB
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 13:44:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56295 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932350AbWBKSoA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 13:44:00 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1BIhvDZ013783
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 11 Feb 2006 10:43:57 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1BIhuCG008945;
	Sat, 11 Feb 2006 10:43:56 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15957>


Make "git clone" pack-fetching download statistics better

Average it out over a few events to make the numbers stable, and fix the
silly usec->binary-ms conversion.

Yeah, yeah, it's arguably eye-candy to keep the user calm, but let's do 
that right.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This is obviously against my previous diff to do the verbose output in the 
first place. If you want a combined diff, just holler.

This makes the download speed be totally stable for me on an otherwise 
idle DSL connection (146 kB/s, which sounds right, in case anybody cares).

diff --git a/fetch-clone.c b/fetch-clone.c
index d8216cb..da1b3ff 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -130,12 +130,35 @@ int receive_unpack_pack(int fd[2], const
 	die("git-unpack-objects died of unnatural causes %d", status);
 }
 
+/*
+ * We average out the download speed over this many "events", where
+ * an event is a minimum of about half a second. That way, we get
+ * a reasonably stable number.
+ */
+#define NR_AVERAGE (4)
+
+/*
+ * A "binary msec" is a power-of-two-msec, aka 1/1024th of a second.
+ * Keeing the time in that format means that "bytes / msecs" means
+ * is the same as kB/s (modulo rounding).
+ *
+ * 1000512 is a magic number (usecs in a second, rounded up by half
+ * of 1024, to make "rounding" come out right ;)
+ */
+#define usec_to_binarymsec(x) ((int)(x) / (1000512 >> 10))
+
 int receive_keep_pack(int fd[2], const char *me, int quiet)
 {
 	char tmpfile[PATH_MAX];
 	int ofd, ifd;
 	unsigned long total;
 	static struct timeval prev_tv;
+	struct average {
+		unsigned long bytes;
+		unsigned long time;
+	} download[NR_AVERAGE] = { {0, 0}, };
+	unsigned long avg_bytes, avg_time;
+	int idx = 0;
 
 	ifd = fd[0];
 	snprintf(tmpfile, sizeof(tmpfile),
@@ -146,6 +169,8 @@ int receive_keep_pack(int fd[2], const c
 
 	gettimeofday(&prev_tv, NULL);
 	total = 0;
+	avg_bytes = 0;
+	avg_time = 0;
 	while (1) {
 		char buf[8192];
 		ssize_t sz, wsz, pos;
@@ -184,14 +209,27 @@ int receive_keep_pack(int fd[2], const c
 			gettimeofday(&tv, NULL);
 			msecs = tv.tv_sec - prev_tv.tv_sec;
 			msecs <<= 10;
-			msecs += (int)(tv.tv_usec - prev_tv.tv_usec) >> 10;
+			msecs += usec_to_binarymsec(tv.tv_usec - prev_tv.tv_usec);
+
 			if (msecs > 500) {
 				prev_tv = tv;
 				last = total;
-				fprintf(stderr, "%4lu.%03luMB  (%lu kB/s)        \r",
+
+				/* Update averages ..*/
+				avg_bytes += diff;
+				avg_time += msecs;
+				avg_bytes -= download[idx].bytes;
+				avg_time -= download[idx].time;
+				download[idx].bytes = diff;
+				download[idx].time = msecs;
+				idx++;
+				if (idx >= NR_AVERAGE)
+					idx = 0;
+
+				fprintf(stderr, "%4lu.%03luMB  (%lu kB/s)      \r",
 					total >> 20,
 					1000*((total >> 10) & 1023)>>10,
-					diff / msecs );
+					avg_bytes / avg_time );
 			}
 		}
 	}
