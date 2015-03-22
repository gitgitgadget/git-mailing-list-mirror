From: Jeff King <peff@peff.net>
Subject: [PATCH 6/7] trailer: use strbuf_read_cmd
Date: Sun, 22 Mar 2015 06:09:25 -0400
Message-ID: <20150322100925.GF11615@peff.net>
References: <20150322095924.GA24651@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 11:09:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZcp5-0005PV-78
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 11:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbbCVKJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 06:09:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:36717 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751962AbbCVKJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 06:09:27 -0400
Received: (qmail 32673 invoked by uid 102); 22 Mar 2015 10:09:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 05:09:28 -0500
Received: (qmail 7021 invoked by uid 107); 22 Mar 2015 10:09:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 06:09:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2015 06:09:25 -0400
Content-Disposition: inline
In-Reply-To: <20150322095924.GA24651@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266063>

When we read from a trailer.*.command sub-program, the
current code uses run_command followed by a pipe read, which
can result in deadlock (though in practice you would have to
have a large trailer for this to be a problem). The current
code also leaks the file descriptor for the pipe to the
sub-command.

Instead, let's use strbuf_read_cmd, which makes this simpler
(and we can get rid of our custom helper).

Signed-off-by: Jeff King <peff@peff.net>
---
 trailer.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/trailer.c b/trailer.c
index 05b3859..b47bc0e 100644
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
+	if (strbuf_read_cmd(&buf, &cp, 1024)) {
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
