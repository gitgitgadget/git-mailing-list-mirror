From: Jeff King <peff@peff.net>
Subject: [PATCH] upload-archive: use argv_array for sent parameters
Date: Tue, 15 Nov 2011 14:49:58 -0500
Message-ID: <20111115194958.GB19305@sigill.intra.peff.net>
References: <1319472131-3968-1-git-send-email-kusmabite@gmail.com>
 <201111151122.48378.trast@student.ethz.ch>
 <20111115102807.GA18649@sigill.intra.peff.net>
 <201111151311.46832.trast@student.ethz.ch>
 <20111115173715.GA4478@sigill.intra.peff.net>
 <7vobwdus7w.fsf@alter.siamese.dyndns.org>
 <20111115191832.GA16030@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	j6t@kdbg.org, rene.scharfe@lsrfire.ath.cx
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 20:50:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQP1C-0000Y2-M5
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 20:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384Ab1KOTuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 14:50:01 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42779
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757327Ab1KOTuA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 14:50:00 -0500
Received: (qmail 9792 invoked by uid 107); 15 Nov 2011 19:50:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Nov 2011 14:50:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Nov 2011 14:49:58 -0500
Content-Disposition: inline
In-Reply-To: <20111115191832.GA16030@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185485>

The existing prepare_argv uses a fixed-size static buffer to
hold all of the arguments, and then puts pointers into the
buffer into a fixed-size array. Using argv_array gets rid of
all of the manual bookkeeping and makes the code more
readable.

It also lifts the static limits on the size of the array.
This is convenient, but is perhaps a security regression, as
a malicious client can now ask us to create arbitrary-length
argv arrays in memory.

Signed-off-by: Jeff King <peff@peff.net>
---
I think the code is way more readable and obvious.  Do we care about the
potential DoS?  If so, we can still cap the number of arguments we'll
accept. In practice, we never send more than a few.

 builtin/upload-archive.c |   45 +++++++++++++++++----------------------------
 1 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 80575b9..3830310 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -7,6 +7,7 @@
 #include "pkt-line.h"
 #include "sideband.h"
 #include "run-command.h"
+#include "argv-array.h"
 
 static const char upload_archive_usage[] =
 	"git upload-archive <repo>";
@@ -17,42 +18,28 @@
 static const char lostchild[] =
 "git upload-archive: archiver process was lost";
 
-#define MAX_ARGS (64)
-
-static void prepare_argv(const char **sent_argv)
+static void prepare_argv(struct argv_array *out)
 {
 	const char *arg_cmd = "argument ";
-	char *p;
-	static char buf[4096];
-	int sent_argc;
-	int len;
 
-	/* put received options in sent_argv[] */
-	sent_argc = 2;
-	sent_argv[0] = "archive";
-	sent_argv[1] = "--remote-request";
-	for (p = buf;;) {
+	argv_array_push(out, "archive");
+	argv_array_push(out, "--remote-request");
+	while (1) {
+		char buf[4096];
+		int len;
 		/* This will die if not enough free space in buf */
-		len = packet_read_line(0, p, (buf + sizeof buf) - p);
+		len = packet_read_line(0, buf, sizeof(buf));
 		if (len == 0)
 			break;	/* got a flush */
-		if (sent_argc > MAX_ARGS - 2)
-			die("Too many options (>%d)", MAX_ARGS - 2);
 
-		if (p[len-1] == '\n') {
-			p[--len] = 0;
-		}
+		if (buf[len-1] == '\n')
+			buf[--len] = 0;
 		if (len < strlen(arg_cmd) ||
-		    strncmp(arg_cmd, p, strlen(arg_cmd)))
+		    strncmp(arg_cmd, buf, strlen(arg_cmd)))
 			die("'argument' token or flush expected");
 
-		len -= strlen(arg_cmd);
-		memmove(p, p + strlen(arg_cmd), len);
-		sent_argv[sent_argc++] = p;
-		p += len;
-		*p++ = 0;
+		argv_array_push(out, buf + strlen(arg_cmd));
 	}
-	sent_argv[sent_argc] = NULL;
 }
 
 __attribute__((format (printf, 1, 2)))
@@ -84,8 +71,8 @@ static ssize_t process_input(int child_fd, int band)
 
 int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 {
-	const char *sent_argv[MAX_ARGS];
-	struct child_process cld = { sent_argv };
+	struct argv_array sent_argv = ARGV_ARRAY_INIT;
+	struct child_process cld = {0};
 	cld.out = cld.err = -1;
 	cld.git_cmd = 1;
 
@@ -95,7 +82,8 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 	if (!enter_repo(argv[1], 0))
 		die("'%s' does not appear to be a git repository", argv[1]);
 
-	prepare_argv(sent_argv);
+	prepare_argv(&sent_argv);
+	cld.argv = sent_argv.argv;
 	if (start_command(&cld)) {
 		int err = errno;
 		packet_write(1, "NACK fork failed on the remote side\n");
@@ -138,5 +126,6 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 		packet_flush(1);
 		break;
 	}
+	argv_array_clear(&sent_argv);
 	return 0;
 }
-- 
1.7.7.3.8.g38efa
