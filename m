From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Move sideband server side support into reusable form.
Date: Sun, 10 Sep 2006 03:37:44 -0700
Message-ID: <7v8xkst3bb.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
	<7vk64ctctv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Sep 10 12:37:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMMgZ-0004Bc-Kt
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 12:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWIJKhH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 06:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWIJKhH
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 06:37:07 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:64680 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750739AbWIJKhF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 06:37:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060910103704.UAIX21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Sep 2006 06:37:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Lad51V00e1kojtg0000000
	Sun, 10 Sep 2006 06:37:06 -0400
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <7vk64ctctv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 10 Sep 2006 00:12:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26792>

The server side support; this is just the very low level, and the
caller needs to know which band it wants to send things out.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * With the previous downloader-side support, this should make
   it easier to add the status notification from git-archive
   --remote over git native transport (aka git-daemon).

 sideband.c    |   26 ++++++++++++++++++++++++++
 sideband.h    |    1 +
 upload-pack.c |   50 +++++++++++++-------------------------------------
 3 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/sideband.c b/sideband.c
index 861f621..1b14ff8 100644
--- a/sideband.c
+++ b/sideband.c
@@ -46,3 +46,29 @@ int recv_sideband(const char *me, int in
 	}
 	return 0;
 }
+
+/*
+ * fd is connected to the remote side; send the sideband data
+ * over multiplexed packet stream.
+ */
+ssize_t send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max)
+{
+	ssize_t ssz = sz;
+	const char *p = data;
+
+	while (sz) {
+		unsigned n;
+		char hdr[5];
+
+		n = sz;
+		if (packet_max - 5 < n)
+			n = packet_max - 5;
+		sprintf(hdr, "%04x", n + 5);
+		hdr[4] = band;
+		safe_write(fd, hdr, 5);
+		safe_write(fd, p, n);
+		p += n;
+		sz -= n;
+	}
+	return ssz;
+}
diff --git a/sideband.h b/sideband.h
index 90b3855..c645cf2 100644
--- a/sideband.h
+++ b/sideband.h
@@ -7,5 +7,6 @@ #define SIDEBAND_REMOTE_ERROR -1
 #define DEFAULT_PACKET_MAX 1000
 
 int recv_sideband(const char *me, int in_stream, int out, int err, char *, int);
+ssize_t send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
 
 #endif
diff --git a/upload-pack.c b/upload-pack.c
index 51ce936..1f2f7f7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -4,6 +4,7 @@ #include <sys/poll.h>
 #include "cache.h"
 #include "refs.h"
 #include "pkt-line.h"
+#include "sideband.h"
 #include "tag.h"
 #include "object.h"
 #include "commit.h"
@@ -33,45 +34,19 @@ static int strip(char *line, int len)
 	return len;
 }
 
-#define PACKET_MAX 1000
 static ssize_t send_client_data(int fd, const char *data, ssize_t sz)
 {
-	ssize_t ssz;
-	const char *p;
-
-	if (!data) {
-		if (!use_sideband)
-			return 0;
-		packet_flush(1);
-	}
-
-	if (!use_sideband) {
-		if (fd == 3)
-			/* emergency quit */
-			fd = 2;
-		if (fd == 2) {
-			xwrite(fd, data, sz);
-			return sz;
-		}
-		return safe_write(fd, data, sz);
-	}
-	p = data;
-	ssz = sz;
-	while (sz) {
-		unsigned n;
-		char hdr[5];
-
-		n = sz;
-		if (PACKET_MAX - 5 < n)
-			n = PACKET_MAX - 5;
-		sprintf(hdr, "%04x", n + 5);
-		hdr[4] = fd;
-		safe_write(1, hdr, 5);
-		safe_write(1, p, n);
-		p += n;
-		sz -= n;
+	if (use_sideband)
+		return send_sideband(1, fd, data, sz, DEFAULT_PACKET_MAX);
+
+	if (fd == 3)
+		/* emergency quit */
+		fd = 2;
+	if (fd == 2) {
+		xwrite(fd, data, sz);
+		return sz;
 	}
-	return ssz;
+	return safe_write(fd, data, sz);
 }
 
 static void create_pack_file(void)
@@ -308,7 +283,8 @@ static void create_pack_file(void)
 				goto fail;
 			fprintf(stderr, "flushed.\n");
 		}
-		send_client_data(1, NULL, 0);
+		if (use_sideband)
+			packet_flush(1);
 		return;
 	}
  fail:
-- 
1.4.2.gc52f
