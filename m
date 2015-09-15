From: Jeff King <peff@peff.net>
Subject: [PATCH 24/67] http-push: replace strcat with xsnprintf
Date: Tue, 15 Sep 2015 11:42:26 -0400
Message-ID: <20150915154226.GX29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:42:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsNY-0003rV-ND
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbbIOPma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:42:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:59340 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753978AbbIOPm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:42:28 -0400
Received: (qmail 11978 invoked by uid 102); 15 Sep 2015 15:42:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:42:28 -0500
Received: (qmail 7204 invoked by uid 107); 15 Sep 2015 15:42:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:42:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:42:26 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277926>

We account for these strcats in our initial allocation, but
the code is confusing to follow and verify. Let's remember
our original allocation length, and then xsnprintf can
verify that we don't exceed it.

Note that we can't just use xstrfmt here (which would be
even cleaner) because the code tries to grow the buffer only
when necessary.

Signed-off-by: Jeff King <peff@peff.net>
---
It would probably be a good match for a strbuf, but it's
hard to over-emphasize how little interest I have in
refactoring the http-push webdav code.

 http-push.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/http-push.c b/http-push.c
index 1f3788f..37baff8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -786,21 +786,21 @@ xml_start_tag(void *userData, const char *name, const char **atts)
 {
 	struct xml_ctx *ctx = (struct xml_ctx *)userData;
 	const char *c = strchr(name, ':');
-	int new_len;
+	int old_namelen, new_len;
 
 	if (c == NULL)
 		c = name;
 	else
 		c++;
 
-	new_len = strlen(ctx->name) + strlen(c) + 2;
+	old_namelen = strlen(ctx->name);
+	new_len = old_namelen + strlen(c) + 2;
 
 	if (new_len > ctx->len) {
 		ctx->name = xrealloc(ctx->name, new_len);
 		ctx->len = new_len;
 	}
-	strcat(ctx->name, ".");
-	strcat(ctx->name, c);
+	xsnprintf(ctx->name + old_namelen, ctx->len - old_namelen, ".%s", c);
 
 	free(ctx->cdata);
 	ctx->cdata = NULL;
-- 
2.6.0.rc2.408.ga2926b9
