From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] Move sideband client side support into reusable form.
Date: Sun, 10 Sep 2006 03:36:07 -0700
Message-ID: <7vd5a4t3e0.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
	<7vk64ctctv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Sep 10 12:35:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMMey-0003tS-5w
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 12:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWIJKf3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 06:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWIJKf3
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 06:35:29 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:60368 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750739AbWIJKf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 06:35:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060910103527.PCFM18458.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Sep 2006 06:35:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LabU1V00K1kojtg0000000
	Sun, 10 Sep 2006 06:35:29 -0400
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <7vk64ctctv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 10 Sep 2006 00:12:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26791>

This moves the receiver side of the sideband support from
fetch-clone.c to sideband.c and its header file, so that
archiver protocol can use it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * The next one refactors the upload side.

 Makefile      |    4 ++--
 fetch-clone.c |   32 +++++---------------------------
 sideband.c    |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 sideband.h    |   11 +++++++++++
 4 files changed, 66 insertions(+), 29 deletions(-)

diff --git a/Makefile b/Makefile
index 4ac85fd..c724b48 100644
--- a/Makefile
+++ b/Makefile
@@ -233,7 +233,7 @@ XDIFF_LIB=xdiff/lib.a
 
 LIB_H = \
 	archive.h blob.h cache.h commit.h csum-file.h delta.h \
-	diff.h object.h pack.h pkt-line.h quote.h refs.h \
+	diff.h object.h pack.h pkt-line.h quote.h refs.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h
 
@@ -245,7 +245,7 @@ DIFF_OBJS = \
 LIB_OBJS = \
 	blob.o commit.o connect.o csum-file.o cache-tree.o base85.o \
 	date.o diff-delta.o entry.o exec_cmd.o ident.o lockfile.o \
-	object.o pack-check.o patch-delta.o path.o pkt-line.o \
+	object.o pack-check.o patch-delta.o path.o pkt-line.o sideband.o \
 	quote.o read-cache.o refs.o run-command.o dir.o object-refs.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
diff --git a/fetch-clone.c b/fetch-clone.c
index c5cf477..b62feac 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "pkt-line.h"
+#include "sideband.h"
 #include <sys/wait.h>
 #include <sys/time.h>
 
@@ -114,36 +115,13 @@ static pid_t setup_sideband(int sideband
 		die("%s: unable to fork off sideband demultiplexer", me);
 	if (!side_pid) {
 		/* subprocess */
+		char buf[DEFAULT_PACKET_MAX];
+
 		close(fd[0]);
 		if (xd[0] != xd[1])
 			close(xd[1]);
-		while (1) {
-			char buf[1024];
-			int len = packet_read_line(xd[0], buf, sizeof(buf));
-			if (len == 0)
-				break;
-			if (len < 1)
-				die("%s: protocol error: no band designator",
-				    me);
-			len--;
-			switch (buf[0] & 0xFF) {
-			case 3:
-				safe_write(2, "remote: ", 8);
-				safe_write(2, buf+1, len);
-				safe_write(2, "\n", 1);
-				exit(1);
-			case 2:
-				safe_write(2, "remote: ", 8);
-				safe_write(2, buf+1, len);
-				continue;
-			case 1:
-				safe_write(fd[1], buf+1, len);
-				continue;
-			default:
-				die("%s: protocol error: bad band #%d",
-				    me, (buf[0] & 0xFF));
-			}
-		}
+		if (recv_sideband(me, xd[0], fd[1], 2, buf, sizeof(buf)))
+			exit(1);
 		exit(0);
 	}
 	close(xd[0]);
diff --git a/sideband.c b/sideband.c
new file mode 100644
index 0000000..861f621
--- /dev/null
+++ b/sideband.c
@@ -0,0 +1,48 @@
+#include "pkt-line.h"
+#include "sideband.h"
+
+/*
+ * Receive multiplexed output stream over git native protocol.
+ * in_stream is the input stream from the remote, which carries data
+ * in pkt_line format with band designator.  Demultiplex it into out
+ * and err and return error appropriately.  Band #1 carries the
+ * primary payload.  Things coming over band #2 is not necessarily
+ * error; they are usually informative message on the standard error
+ * stream, aka "verbose").  A message over band #3 is a signal that
+ * the remote died unexpectedly.  A flush() concludes the stream.
+ */
+int recv_sideband(const char *me, int in_stream, int out, int err, char *buf, int bufsz)
+{
+	while (1) {
+		int len = packet_read_line(in_stream, buf, bufsz);
+		if (len == 0)
+			break;
+		if (len < 1) {
+			len = sprintf(buf, "%s: protocol error: no band designator\n", me);
+			safe_write(err, buf, len);
+			return SIDEBAND_PROTOCOL_ERROR;
+		}
+		len--;
+		switch (buf[0] & 0xFF) {
+		case 3:
+			safe_write(err, "remote: ", 8);
+			safe_write(err, buf+1, len);
+			safe_write(err, "\n", 1);
+			return SIDEBAND_REMOTE_ERROR;
+		case 2:
+			safe_write(err, "remote: ", 8);
+			safe_write(err, buf+1, len);
+			continue;
+		case 1:
+			safe_write(out, buf+1, len);
+			continue;
+		default:
+			len = sprintf(buf + 1,
+				      "%s: protocol error: bad band #%d\n",
+				      me, buf[0] & 0xFF);
+			safe_write(err, buf+1, len);
+			return SIDEBAND_PROTOCOL_ERROR;
+		}
+	}
+	return 0;
+}
diff --git a/sideband.h b/sideband.h
new file mode 100644
index 0000000..90b3855
--- /dev/null
+++ b/sideband.h
@@ -0,0 +1,11 @@
+#ifndef SIDEBAND_H
+#define SIDEBAND_H
+
+#define SIDEBAND_PROTOCOL_ERROR -2
+#define SIDEBAND_REMOTE_ERROR -1
+
+#define DEFAULT_PACKET_MAX 1000
+
+int recv_sideband(const char *me, int in_stream, int out, int err, char *, int);
+
+#endif
-- 
1.4.2.gc52f
