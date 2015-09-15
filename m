From: Jeff King <peff@peff.net>
Subject: [PATCH 36/67] remote-ext: simplify git pkt-line generation
Date: Tue, 15 Sep 2015 11:52:10 -0400
Message-ID: <20150915155210.GJ29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:52:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsWp-0006TO-2q
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbbIOPwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:52:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:59376 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752234AbbIOPwM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:52:12 -0400
Received: (qmail 12768 invoked by uid 102); 15 Sep 2015 15:52:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:52:12 -0500
Received: (qmail 7426 invoked by uid 107); 15 Sep 2015 15:52:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:52:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:52:10 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277937>

We format a pkt-line into a heap buffer, which requires
manual computation of the required size. We can just use a
strbuf instead, which handles this for us, and lets us drop
some bare sprintf calls.

Note that we _could_ also use a fixed-size buffer here, as
we are limited by 16-bit pkt-line limit. But we'd still have
to worry about the length computation in that case, and the
allocation overhead is not important here.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/remote-ext.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 3b8c22c..1d991d9 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -142,36 +142,22 @@ static const char **parse_argv(const char *arg, const char *service)
 static void send_git_request(int stdin_fd, const char *serv, const char *repo,
 	const char *vhost)
 {
-	size_t bufferspace;
-	size_t wpos = 0;
-	char *buffer;
+	struct strbuf buffer = STRBUF_INIT;
 
-	/*
-	 * Request needs 12 bytes extra if there is vhost (xxxx \0host=\0) and
-	 * 6 bytes extra (xxxx \0) if there is no vhost.
-	 */
+	/* Generate packet with a dummy size header */
+	strbuf_addf(&buffer, "0000%s %s%c", serv, repo, 0);
 	if (vhost)
-		bufferspace = strlen(serv) + strlen(repo) + strlen(vhost) + 12;
-	else
-		bufferspace = strlen(serv) + strlen(repo) + 6;
+		strbuf_addf(&buffer, "host=%s%c", vhost, 0);
 
-	if (bufferspace > 0xFFFF)
+	/* Now go back and fill in the size */
+	if (buffer.len > 0xFFFF)
 		die("Request too large to send");
-	buffer = xmalloc(bufferspace);
-
-	/* Make the packet. */
-	wpos = sprintf(buffer, "%04x%s %s%c", (unsigned)bufferspace,
-		serv, repo, 0);
-
-	/* Add vhost if any. */
-	if (vhost)
-		sprintf(buffer + wpos, "host=%s%c", vhost, 0);
+	xsnprintf(buffer.buf, buffer.alloc, "%04x", (unsigned)buffer.len);
 
-	/* Send the request */
-	if (write_in_full(stdin_fd, buffer, bufferspace) < 0)
+	if (write_in_full(stdin_fd, buffer.buf, buffer.len) < 0)
 		die_errno("Failed to send request");
 
-	free(buffer);
+	strbuf_release(&buffer);
 }
 
 static int run_child(const char *arg, const char *service)
-- 
2.6.0.rc2.408.ga2926b9
