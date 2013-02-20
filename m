From: Jeff King <peff@peff.net>
Subject: [PATCH v3 07/19] upload-archive: use argv_array to store client
 arguments
Date: Wed, 20 Feb 2013 15:01:26 -0500
Message-ID: <20130220200126.GG25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 21:01:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8FrX-0004Gj-8J
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934926Ab3BTUB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:01:29 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54582 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934553Ab3BTUB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:01:29 -0500
Received: (qmail 17696 invoked by uid 107); 20 Feb 2013 20:03:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 15:03:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 15:01:26 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216721>

The current parsing scheme for upload-archive is to pack
arguments into a fixed-size buffer, separated by NULs, and
put a pointer to each argument in the buffer into a
fixed-size argv array.

This works fine, and the limits are high enough that nobody
reasonable is going to hit them, but it makes the code hard
to follow.  Instead, let's just stuff the arguments into an
argv_array, which is much simpler. That lifts the "all
arguments must fit inside 4K together" limit.

We could also trivially lift the MAX_ARGS limitation (in
fact, we have to keep extra code to enforce it). But that
would mean a client could force us to allocate an arbitrary
amount of memory simply by sending us "argument" lines. By
limiting the MAX_ARGS, we limit an attacker to about 4
megabytes (64 times a maximum 64K packet buffer). That may
sound like a lot compared to the 4K limit, but it's not a
big deal compared to what git-archive will actually allocate
while working (e.g., to load blobs into memory). The
important thing is that it is bounded.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/upload-archive.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index c3d134e..3393cef 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -7,6 +7,7 @@
 #include "pkt-line.h"
 #include "sideband.h"
 #include "run-command.h"
+#include "argv-array.h"
 
 static const char upload_archive_usage[] =
 	"git upload-archive <repo>";
@@ -18,10 +19,9 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 
 int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 {
-	const char *sent_argv[MAX_ARGS];
+	struct argv_array sent_argv = ARGV_ARRAY_INIT;
 	const char *arg_cmd = "argument ";
-	char *p, buf[4096];
-	int sent_argc;
+	char buf[4096];
 	int len;
 
 	if (argc != 2)
@@ -31,33 +31,26 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 		die("'%s' does not appear to be a git repository", argv[1]);
 
 	/* put received options in sent_argv[] */
-	sent_argc = 1;
-	sent_argv[0] = "git-upload-archive";
-	for (p = buf;;) {
+	argv_array_push(&sent_argv, "git-upload-archive");
+	for (;;) {
 		/* This will die if not enough free space in buf */
-		len = packet_read_line(0, p, (buf + sizeof buf) - p);
+		len = packet_read_line(0, buf, sizeof(buf));
 		if (len == 0)
 			break;	/* got a flush */
-		if (sent_argc > MAX_ARGS - 2)
-			die("Too many options (>%d)", MAX_ARGS - 2);
+		if (sent_argv.argc > MAX_ARGS)
+		    die("Too many options (>%d)", MAX_ARGS - 1);
 
-		if (p[len-1] == '\n') {
-			p[--len] = 0;
+		if (buf[len-1] == '\n') {
+			buf[--len] = 0;
 		}
-		if (len < strlen(arg_cmd) ||
-		    strncmp(arg_cmd, p, strlen(arg_cmd)))
-			die("'argument' token or flush expected");
 
-		len -= strlen(arg_cmd);
-		memmove(p, p + strlen(arg_cmd), len);
-		sent_argv[sent_argc++] = p;
-		p += len;
-		*p++ = 0;
+		if (prefixcmp(buf, arg_cmd))
+			die("'argument' token or flush expected");
+		argv_array_push(&sent_argv, buf + strlen(arg_cmd));
 	}
-	sent_argv[sent_argc] = NULL;
 
 	/* parse all options sent by the client */
-	return write_archive(sent_argc, sent_argv, prefix, 0, NULL, 1);
+	return write_archive(sent_argv.argc, sent_argv.argv, prefix, 0, NULL, 1);
 }
 
 __attribute__((format (printf, 1, 2)))
-- 
1.8.2.rc0.9.g352092c
