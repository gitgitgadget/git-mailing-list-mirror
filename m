From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] atomic write for sideband remote messages
Date: Wed, 11 Oct 2006 11:49:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610111127360.2435@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 17:54:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXgKe-0004S7-G1
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 17:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWJKPtR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 11:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbWJKPtR
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 11:49:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22304 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1161085AbWJKPtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 11:49:16 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J6Z00G3GAM3AEG0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 11 Oct 2006 11:49:15 -0400 (EDT)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28723>

It has been a few times that I ended up with such a confusing display:

|remote: Generating pack...
|remote: Done counting 17 objects.
|remote: Result has 9 objects.
|remote: Deltifying 9 objects.
|remote:  100% (9/9) done
|remote: Unpacking 9 objects
|Total 9, written 9 (delta 8), reused 0 (delta 0)
| 100% (9/9) done

The confusion can be avoided in most cases by writing the remote message 
in one go to prevent interleacing with local messages.  The buffer 
declaration has been moved inside recv_sideband() to avoid extra string 
copies.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/builtin-archive.c b/builtin-archive.c
index 6dabdee..9177379 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -75,7 +75,7 @@ static int run_remote_archiver(const cha
 		die("git-archive: expected a flush");
 
 	/* Now, start reading from fd[0] and spit it out to stdout */
-	rv = recv_sideband("archive", fd[0], 1, 2, buf, sizeof(buf));
+	rv = recv_sideband("archive", fd[0], 1, 2);
 	close(fd[0]);
 	rv |= finish_connect(pid);
 
diff --git a/fetch-clone.c b/fetch-clone.c
index b632ca0..76b99af 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -115,12 +115,10 @@ static pid_t setup_sideband(int sideband
 		die("%s: unable to fork off sideband demultiplexer", me);
 	if (!side_pid) {
 		/* subprocess */
-		char buf[LARGE_PACKET_MAX];
-
 		close(fd[0]);
 		if (xd[0] != xd[1])
 			close(xd[1]);
-		if (recv_sideband(me, xd[0], fd[1], 2, buf, sizeof(buf)))
+		if (recv_sideband(me, xd[0], fd[1], 2))
 			exit(1);
 		exit(0);
 	}
diff --git a/sideband.c b/sideband.c
index 1b14ff8..277fa3c 100644
--- a/sideband.c
+++ b/sideband.c
@@ -11,10 +11,13 @@ #include "sideband.h"
  * stream, aka "verbose").  A message over band #3 is a signal that
  * the remote died unexpectedly.  A flush() concludes the stream.
  */
-int recv_sideband(const char *me, int in_stream, int out, int err, char *buf, int bufsz)
+int recv_sideband(const char *me, int in_stream, int out, int err)
 {
+	char buf[7 + LARGE_PACKET_MAX + 1];
+	strcpy(buf, "remote:");
 	while (1) {
-		int len = packet_read_line(in_stream, buf, bufsz);
+		int band, len;
+		len	= packet_read_line(in_stream, buf+7, LARGE_PACKET_MAX);
 		if (len == 0)
 			break;
 		if (len < 1) {
@@ -22,25 +25,26 @@ int recv_sideband(const char *me, int in
 			safe_write(err, buf, len);
 			return SIDEBAND_PROTOCOL_ERROR;
 		}
+		band = buf[7] & 0xff;
 		len--;
-		switch (buf[0] & 0xFF) {
+		switch (band) {
 		case 3:
-			safe_write(err, "remote: ", 8);
-			safe_write(err, buf+1, len);
-			safe_write(err, "\n", 1);
+			buf[7] = ' ';
+			buf[8+len] = '\n';
+			safe_write(err, buf, 8+len+1);
 			return SIDEBAND_REMOTE_ERROR;
 		case 2:
-			safe_write(err, "remote: ", 8);
-			safe_write(err, buf+1, len);
+			buf[7] = ' ';
+			safe_write(err, buf, 8+len);
 			continue;
 		case 1:
-			safe_write(out, buf+1, len);
+			safe_write(out, buf+8, len);
 			continue;
 		default:
-			len = sprintf(buf + 1,
+			len = sprintf(buf,
 				      "%s: protocol error: bad band #%d\n",
-				      me, buf[0] & 0xFF);
-			safe_write(err, buf+1, len);
+				      me, band);
+			safe_write(err, buf, len);
 			return SIDEBAND_PROTOCOL_ERROR;
 		}
 	}
diff --git a/sideband.h b/sideband.h
index 4872106..a84b691 100644
--- a/sideband.h
+++ b/sideband.h
@@ -7,7 +7,7 @@ #define SIDEBAND_REMOTE_ERROR -1
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
 
-int recv_sideband(const char *me, int in_stream, int out, int err, char *, int);
+int recv_sideband(const char *me, int in_stream, int out, int err);
 ssize_t send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
 
 #endif
