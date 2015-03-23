From: Jeff King <peff@peff.net>
Subject: [PATCH v2 6/7] trailer: use capture_command
Date: Sun, 22 Mar 2015 23:54:00 -0400
Message-ID: <20150323035400.GF30337@peff.net>
References: <20150323035302.GA30279@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 04:54:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZtRJ-0005BN-BQ
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 04:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbbCWDyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 23:54:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:37031 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752124AbbCWDyD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 23:54:03 -0400
Received: (qmail 14626 invoked by uid 102); 23 Mar 2015 03:54:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 22:54:02 -0500
Received: (qmail 12265 invoked by uid 107); 23 Mar 2015 03:54:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 23:54:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2015 23:54:00 -0400
Content-Disposition: inline
In-Reply-To: <20150323035302.GA30279@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266120>

When we read from a trailer.*.command sub-program, the
current code uses run_command followed by a pipe read, which
can result in deadlock (though in practice you would have to
have a large trailer for this to be a problem). The current
code also leaks the file descriptor for the pipe to the
sub-command.

Instead, let's use capture_command, which makes this simpler
(and we can get rid of our custom helper).

Signed-off-by: Jeff King <peff@peff.net>
---
 trailer.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/trailer.c b/trailer.c
index 05b3859..4b14a56 100644
--- a/trailer.c
+++ b/trailer.c
@@ -214,16 +214,6 @@ static struct trailer_item *remove_first(struct trailer_item **first)
 	return item;
 }
 
-static int read_from_command(struct child_process *cp, struct strbuf *buf)
-{
-	if (run_command(cp))
-		return error("running trailer command '%s' failed", cp->argv[0]);
-	if (strbuf_read(buf, cp->out, 1024) < 1)
-		return error("reading from trailer command '%s' failed", cp->argv[0]);
-	strbuf_trim(buf);
-	return 0;
-}
-
 static const char *apply_command(const char *command, const char *arg)
 {
 	struct strbuf cmd = STRBUF_INIT;
@@ -240,14 +230,16 @@ static const char *apply_command(const char *command, const char *arg)
 	cp.argv = argv;
 	cp.env = local_repo_env;
 	cp.no_stdin = 1;
-	cp.out = -1;
 	cp.use_shell = 1;
 
-	if (read_from_command(&cp, &buf)) {
+	if (capture_command(&cp, &buf, 1024)) {
+		error("running trailer command '%s' failed", cmd.buf);
 		strbuf_release(&buf);
 		result = xstrdup("");
-	} else
+	} else {
+		strbuf_trim(&buf);
 		result = strbuf_detach(&buf, NULL);
+	}
 
 	strbuf_release(&cmd);
 	return result;
-- 
2.3.3.618.ga041503
