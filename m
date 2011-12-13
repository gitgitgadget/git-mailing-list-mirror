From: iheffner@gmail.com
Subject: [PATCH 2/3] switch sideband communication to use constants
Date: Tue, 13 Dec 2011 10:28:50 -0800
Message-ID: <1323800931-37123-3-git-send-email-iheffner@gmail.com>
References: <1323800931-37123-1-git-send-email-iheffner@gmail.com>
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	"Dave Olszewski" <cxreg@pobox.com>,
	Ivan Heffner <iheffner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 19:30:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaX71-0001d3-A3
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 19:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168Ab1LMS3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 13:29:54 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36499 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752330Ab1LMS3x (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2011 13:29:53 -0500
Received: by lagp5 with SMTP id p5so2542095lag.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 10:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=X/PJQhWjskRNQFGNZVpmJbvScgk54M2sbImNzw1TrwE=;
        b=tN8+pDHFmgYHw7XxOu+qMNC/R4BP5Os62kotRzubnXQJzHlSHKhoS9mF3UyLAEccf/
         i19Ukym/uG3boX0sIOrsmiZSggYuLiedgMocO9S0lBHHaXkK9ccqbRdx35nxl3CdPM1n
         MUDR9s2IkG6ZKbjhu+N1jGMWMTZTT8tMiBtoc=
Received: by 10.205.127.70 with SMTP id gz6mr13474154bkc.134.1323800991918;
        Tue, 13 Dec 2011 10:29:51 -0800 (PST)
Received: from localhost.localdomain (sea02-v612-nat.marchex.com. [174.137.113.43])
        by mx.google.com with ESMTPS id 39sm1014563eei.1.2011.12.13.10.29.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 10:29:51 -0800 (PST)
X-Mailer: git-send-email 1.7.6.553.g917d7.dirty
In-Reply-To: <1323800931-37123-1-git-send-email-iheffner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187039>

From: Ivan Heffner <iheffner@gmail.com>

Found all uses of magic numbers for sideband channel indicators and
changed them to use the new SIDEBAND_CHAN_* constants.

Signed-off-by: Ivan Heffner <iheffner@gmail.com>
---
 builtin/receive-pack.c   |    6 +++---
 builtin/upload-archive.c |    6 +++---
 sideband.c               |    6 +++---
 upload-pack.c            |   22 +++++++++++-----------
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7ec68a1..43f7a55 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -179,7 +179,7 @@ static void report_message(const char *prefix, const char *err, va_list params)
 	msg[sz++] = '\n';
 
 	if (use_sideband)
-		send_sideband(1, 2, msg, sz, use_sideband);
+		send_sideband(1, SIDEBAND_CHAN_PROGRESS, msg, sz, use_sideband);
 	else
 		xwrite(2, msg, sz);
 }
@@ -207,7 +207,7 @@ static int copy_to_sideband(int in, int out, void *arg)
 		ssize_t sz = xread(in, data, sizeof(data));
 		if (sz <= 0)
 			break;
-		send_sideband(1, 2, data, sz, use_sideband);
+		send_sideband(1, SIDEBAND_CHAN_PROGRESS, data, sz, use_sideband);
 	}
 	close(in);
 	return 0;
@@ -851,7 +851,7 @@ static void report(struct command *commands, const char *unpack_status)
 	packet_buf_flush(&buf);
 
 	if (use_sideband)
-		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
+		send_sideband(1, SIDEBAND_CHAN_PACK, buf.buf, buf.len, use_sideband);
 	else
 		safe_write(1, buf.buf, buf.len);
 	strbuf_release(&buf);
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 2d0b383..4ac7984 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -77,7 +77,7 @@ static void error_clnt(const char *fmt, ...)
 	va_start(params, fmt);
 	len = vsprintf(buf, fmt, params);
 	va_end(params);
-	send_sideband(1, 3, buf, len, LARGE_PACKET_MAX);
+	send_sideband(1, SIDEBAND_CHAN_ERROR, buf, len, LARGE_PACKET_MAX);
 	die("sent error to the client: %s", buf);
 }
 
@@ -149,11 +149,11 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 		}
 		if (pfd[1].revents & POLLIN)
 			/* Status stream ready */
-			if (process_input(pfd[1].fd, 2))
+			if (process_input(pfd[1].fd, SIDEBAND_CHAN_PROGRESS))
 				continue;
 		if (pfd[0].revents & POLLIN)
 			/* Data stream ready */
-			if (process_input(pfd[0].fd, 1))
+			if (process_input(pfd[0].fd, SIDEBAND_CHAN_PACK))
 				continue;
 
 		if (waitpid(writer, &status, 0) < 0)
diff --git a/sideband.c b/sideband.c
index d5ffa1c..4b4199a 100644
--- a/sideband.c
+++ b/sideband.c
@@ -47,12 +47,12 @@ int recv_sideband(const char *me, int in_stream, int out)
 		band = buf[pf] & 0xff;
 		len--;
 		switch (band) {
-		case 3:
+		case SIDEBAND_CHAN_ERROR:
 			buf[pf] = ' ';
 			buf[pf+1+len] = '\0';
 			fprintf(stderr, "%s\n", buf);
 			return SIDEBAND_REMOTE_ERROR;
-		case 2:
+		case SIDEBAND_CHAN_PROGRESS:
 			buf[pf] = ' ';
 			do {
 				char *b = buf;
@@ -107,7 +107,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 				memmove(buf + pf+1, b + brk, len);
 			} while (len);
 			continue;
-		case 1:
+		case SIDEBAND_CHAN_PACK:
 			safe_write(out, buf + pf+1, len);
 			continue;
 		default:
diff --git a/upload-pack.c b/upload-pack.c
index 470cffd..98c2542 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -56,19 +56,19 @@ static int strip(char *line, int len)
 	return len;
 }
 
-static ssize_t send_client_data(int fd, const char *data, ssize_t sz)
+static ssize_t send_client_data(int chan, const char *data, ssize_t sz)
 {
 	if (use_sideband)
-		return send_sideband(1, fd, data, sz, use_sideband);
-	if (fd == 3)
+		return send_sideband(1, chan, data, sz, use_sideband);
+	if (chan == SIDEBAND_CHAN_ERROR)
 		/* emergency quit */
-		fd = 2;
-	if (fd == 2) {
+		chan = SIDEBAND_CHAN_PROGRESS;
+	if (chan == SIDEBAND_CHAN_PROGRESS) {
 		/* XXX: are we happy to lose stuff here? */
-		xwrite(fd, data, sz);
+		xwrite(chan, data, sz);
 		return sz;
 	}
-	return safe_write(fd, data, sz);
+	return safe_write(chan, data, sz);
 }
 
 static FILE *pack_pipe = NULL;
@@ -243,7 +243,7 @@ static void create_pack_file(void)
 			sz = xread(pack_objects.err, progress,
 				  sizeof(progress));
 			if (0 < sz)
-				send_client_data(2, progress, sz);
+				send_client_data(SIDEBAND_CHAN_PROGRESS, progress, sz);
 			else if (sz == 0) {
 				close(pack_objects.err);
 				pack_objects.err = -1;
@@ -286,7 +286,7 @@ static void create_pack_file(void)
 			}
 			else
 				buffered = -1;
-			sz = send_client_data(1, data, sz);
+			sz = send_client_data(SIDEBAND_CHAN_PACK, data, sz);
 			if (sz < 0)
 				goto fail;
 		}
@@ -302,7 +302,7 @@ static void create_pack_file(void)
 	/* flush the data */
 	if (0 <= buffered) {
 		data[0] = buffered;
-		sz = send_client_data(1, data, 1);
+		sz = send_client_data(SIDEBAND_CHAN_PACK, data, 1);
 		if (sz < 0)
 			goto fail;
 		fprintf(stderr, "flushed.\n");
@@ -312,7 +312,7 @@ static void create_pack_file(void)
 	return;
 
  fail:
-	send_client_data(3, abort_msg, sizeof(abort_msg));
+	send_client_data(SIDEBAND_CHAN_ERROR, abort_msg, sizeof(abort_msg));
 	die("git upload-pack: %s", abort_msg);
 }
 
-- 
1.7.6.553.g917d7.dirty
