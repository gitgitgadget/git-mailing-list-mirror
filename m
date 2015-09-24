From: Jeff King <peff@peff.net>
Subject: [PATCH 11/68] trace: use strbuf for quote_crnl output
Date: Thu, 24 Sep 2015 17:05:54 -0400
Message-ID: <20150924210553.GH30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:06:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDiV-0000bI-CJ
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbbIXVF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:05:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:35920 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752523AbbIXVF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:05:56 -0400
Received: (qmail 11832 invoked by uid 102); 24 Sep 2015 21:05:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:05:56 -0500
Received: (qmail 28954 invoked by uid 107); 24 Sep 2015 21:06:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:06:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:05:54 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278570>

When we output GIT_TRACE_SETUP paths, we quote any
meta-characters. But our buffer to hold the result is only
PATH_MAX bytes, and we could double the size of the input
path (if every character needs quoting). We could use a
2*PATH_MAX buffer, if we assume the input will never be more
than PATH_MAX. But it's easier still to just switch to a
strbuf and not worry about whether the input can exceed
PATH_MAX or not.

The original copied the "p2" pointer to "p1", advancing
both. Since this gets rid of "p1", let's also drop "p2",
whose name is now confusing. We can just advance the
original "path" pointer.

Signed-off-by: Jeff King <peff@peff.net>
---
 trace.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/trace.c b/trace.c
index 7393926..4aeea60 100644
--- a/trace.c
+++ b/trace.c
@@ -277,25 +277,24 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
 
 static const char *quote_crnl(const char *path)
 {
-	static char new_path[PATH_MAX];
-	const char *p2 = path;
-	char *p1 = new_path;
+	static struct strbuf new_path = STRBUF_INIT;
 
 	if (!path)
 		return NULL;
 
-	while (*p2) {
-		switch (*p2) {
-		case '\\': *p1++ = '\\'; *p1++ = '\\'; break;
-		case '\n': *p1++ = '\\'; *p1++ = 'n'; break;
-		case '\r': *p1++ = '\\'; *p1++ = 'r'; break;
+	strbuf_reset(&new_path);
+
+	while (*path) {
+		switch (*path) {
+		case '\\': strbuf_addstr(&new_path, "\\\\"); break;
+		case '\n': strbuf_addstr(&new_path, "\\n"); break;
+		case '\r': strbuf_addstr(&new_path, "\\r"); break;
 		default:
-			*p1++ = *p2;
+			strbuf_addch(&new_path, *path);
 		}
-		p2++;
+		path++;
 	}
-	*p1 = '\0';
-	return new_path;
+	return new_path.buf;
 }
 
 /* FIXME: move prefix to startup_info struct and get rid of this arg */
-- 
2.6.0.rc3.454.g204ad51
