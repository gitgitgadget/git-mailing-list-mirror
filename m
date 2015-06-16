From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] trace: implement %p placeholder for filenames
Date: Tue, 16 Jun 2015 15:35:32 -0400
Message-ID: <20150616193531.GA15931@peff.net>
References: <20150616193102.GA15856@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Augie Fackler <augie@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 21:35:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4we3-00022K-Rw
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 21:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbbFPTfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 15:35:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:46997 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753104AbbFPTfe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 15:35:34 -0400
Received: (qmail 20309 invoked by uid 102); 16 Jun 2015 19:35:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 14:35:34 -0500
Received: (qmail 18244 invoked by uid 107); 16 Jun 2015 19:35:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 15:35:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2015 15:35:32 -0400
Content-Disposition: inline
In-Reply-To: <20150616193102.GA15856@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271789>

This lets you trace output on a per-process basis by naming
the trace file after the PID. This is probably not all that
useful for GIT_TRACE itself (which is about a global view of
the process hierarchy anyway), but will be useful for traces
which produce large amounts of data (e.g., whole packfiles).

Signed-off-by: Jeff King <peff@peff.net>
---
This is the bare minimum to let you distinguish between the stdin of
different processes. If we are going to use the trace subsystem to
collect more long-term debugging logs, it would probably make sense to
add placeholders for the program name and a timestamp. Then you could,
for example, leave more verbose debugging enabled on your servers all
the time.

 Documentation/git.txt |  3 ++-
 trace.c               | 19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3453669..80f6392 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -984,7 +984,8 @@ trace messages into this file descriptor.
 Alternatively, if the variable is set to an absolute path
 (starting with a '/' character), Git will interpret this
 as a file path and will try to write the trace messages
-into it.
+into it. If the filename contains the string `%p`, that string
+will be replaced with the PID of the traced process.
 +
 Unsetting the variable, or setting it to empty, "0" or
 "false" (case insensitive) disables trace messages.
diff --git a/trace.c b/trace.c
index 7393926..e1d1360 100644
--- a/trace.c
+++ b/trace.c
@@ -25,6 +25,16 @@
 #include "cache.h"
 #include "quote.h"
 
+static size_t expand_trace_name(struct strbuf *out, const char *fmt,
+				void *data)
+{
+	if (*fmt == 'p') {
+		strbuf_addf(out, "%lu", (unsigned long)getpid());
+		return 1;
+	}
+	return 0;
+}
+
 /* Get a trace file descriptor from "key" env variable. */
 static int get_trace_fd(struct trace_key *key)
 {
@@ -49,17 +59,22 @@ static int get_trace_fd(struct trace_key *key)
 	else if (strlen(trace) == 1 && isdigit(*trace))
 		key->fd = atoi(trace);
 	else if (is_absolute_path(trace)) {
-		int fd = open(trace, O_WRONLY | O_APPEND | O_CREAT, 0666);
+		struct strbuf name = STRBUF_INIT;
+		int fd;
+
+		strbuf_expand(&name, trace, expand_trace_name, NULL);
+		fd = open(name.buf, O_WRONLY | O_APPEND | O_CREAT, 0666);
 		if (fd == -1) {
 			fprintf(stderr,
 				"Could not open '%s' for tracing: %s\n"
 				"Defaulting to tracing on stderr...\n",
-				trace, strerror(errno));
+				name.buf, strerror(errno));
 			key->fd = STDERR_FILENO;
 		} else {
 			key->fd = fd;
 			key->need_close = 1;
 		}
+		strbuf_release(&name);
 	} else {
 		fprintf(stderr, "What does '%s' for %s mean?\n"
 			"If you want to trace into a file, then please set "
-- 
2.4.3.699.g84b4da7
