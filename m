From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] run_column_filter: use argv_array
Date: Thu, 15 May 2014 04:33:40 -0400
Message-ID: <20140515083340.GB26866@sigill.intra.peff.net>
References: <20140515082943.GA26473@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 10:33:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkr6p-000248-JT
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 10:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbaEOIdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 04:33:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:52057 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751640AbaEOIdm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 04:33:42 -0400
Received: (qmail 20247 invoked by uid 102); 15 May 2014 08:33:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 May 2014 03:33:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2014 04:33:40 -0400
Content-Disposition: inline
In-Reply-To: <20140515082943.GA26473@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249069>

We currently set up the argv array by hand in a fixed-size
stack-local array. Using an argv array is more readable, as
it handles buffer allocation us (not to mention makes it
obvious we do not overflow the array).

However, there's a more subtle benefit, too. We leave the
function having run start_command (with the child_process
in a static global), and then later run finish_command from
another function. That means when we run finish_command,
neither column_process.argv nor the memory it points to is
valid any longer.

Most of the time finish_command does not bother looking at
argv, but it may if it encounters an error (e.g., waitpid
failure or signal death). This is unusual, which is why
nobody has noticed. But by using run-command's built-in
argv_array, the memory ownership is handled for us
automatically.

Signed-off-by: Jeff King <peff@peff.net>
---
 column.c | 43 +++++++++++++------------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/column.c b/column.c
index 8d1ce88..1a468de 100644
--- a/column.c
+++ b/column.c
@@ -370,46 +370,29 @@ static struct child_process column_process;
 
 int run_column_filter(int colopts, const struct column_options *opts)
 {
-	const char *av[10];
-	int ret, ac = 0;
-	struct strbuf sb_colopt  = STRBUF_INIT;
-	struct strbuf sb_width   = STRBUF_INIT;
-	struct strbuf sb_padding = STRBUF_INIT;
+	struct argv_array *argv;
 
 	if (fd_out != -1)
 		return -1;
 
-	av[ac++] = "column";
-	strbuf_addf(&sb_colopt, "--raw-mode=%d", colopts);
-	av[ac++] = sb_colopt.buf;
-	if (opts && opts->width) {
-		strbuf_addf(&sb_width, "--width=%d", opts->width);
-		av[ac++] = sb_width.buf;
-	}
-	if (opts && opts->indent) {
-		av[ac++] = "--indent";
-		av[ac++] = opts->indent;
-	}
-	if (opts && opts->padding) {
-		strbuf_addf(&sb_padding, "--padding=%d", opts->padding);
-		av[ac++] = sb_padding.buf;
-	}
-	av[ac] = NULL;
+	memset(&column_process, 0, sizeof(column_process));
+	argv = &column_process.args;
+
+	argv_array_push(argv, "column");
+	argv_array_pushf(argv, "--raw-mode=%d", colopts);
+	if (opts && opts->width)
+		argv_array_pushf(argv, "--width=%d", opts->width);
+	if (opts && opts->indent)
+		argv_array_pushf(argv, "--indent=%s", opts->indent);
+	if (opts && opts->padding)
+		argv_array_pushf(argv, "--padding=%d", opts->padding);
 
 	fflush(stdout);
-	memset(&column_process, 0, sizeof(column_process));
 	column_process.in = -1;
 	column_process.out = dup(1);
 	column_process.git_cmd = 1;
-	column_process.argv = av;
-
-	ret = start_command(&column_process);
-
-	strbuf_release(&sb_colopt);
-	strbuf_release(&sb_width);
-	strbuf_release(&sb_padding);
 
-	if (ret)
+	if (start_command(&column_process))
 		return -2;
 
 	fd_out = dup(1);
-- 
2.0.0.rc1.436.g03cb729
