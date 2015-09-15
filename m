From: Jeff King <peff@peff.net>
Subject: [PATCH 11/67] trace: use strbuf for quote_crnl output
Date: Tue, 15 Sep 2015 11:28:43 -0400
Message-ID: <20150915152843.GK29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:29:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsAV-0004ju-99
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbbIOP2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:28:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:59297 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752614AbbIOP2p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:28:45 -0400
Received: (qmail 11325 invoked by uid 102); 15 Sep 2015 15:28:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:28:45 -0500
Received: (qmail 6905 invoked by uid 107); 15 Sep 2015 15:28:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:28:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:28:43 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277912>

When we output GIT_TRACE_SETUP paths, we quote any
meta-characters. But our buffer to hold the result is only
PATH_MAX bytes, and we could double the size of the input
path (if every character needs quoted). We could use a
2*PATH_MAX buffer, if we assume the input will never be more
than PATH_MAX. But it's easier still to just switch to a
strbuf and not worry about whether the input can exceed
PATH_MAX or not.

Signed-off-by: Jeff King <peff@peff.net>
---
 trace.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/trace.c b/trace.c
index 7393926..0c06d71 100644
--- a/trace.c
+++ b/trace.c
@@ -277,25 +277,25 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
 
 static const char *quote_crnl(const char *path)
 {
-	static char new_path[PATH_MAX];
+	static struct strbuf new_path = STRBUF_INIT;
 	const char *p2 = path;
-	char *p1 = new_path;
 
 	if (!path)
 		return NULL;
 
+	strbuf_reset(&new_path);
+
 	while (*p2) {
 		switch (*p2) {
-		case '\\': *p1++ = '\\'; *p1++ = '\\'; break;
-		case '\n': *p1++ = '\\'; *p1++ = 'n'; break;
-		case '\r': *p1++ = '\\'; *p1++ = 'r'; break;
+		case '\\': strbuf_addstr(&new_path, "\\\\"); break;
+		case '\n': strbuf_addstr(&new_path, "\\n"); break;
+		case '\r': strbuf_addstr(&new_path, "\\r"); break;
 		default:
-			*p1++ = *p2;
+			strbuf_addch(&new_path, *p2);
 		}
 		p2++;
 	}
-	*p1 = '\0';
-	return new_path;
+	return new_path.buf;
 }
 
 /* FIXME: move prefix to startup_info struct and get rid of this arg */
-- 
2.6.0.rc2.408.ga2926b9
