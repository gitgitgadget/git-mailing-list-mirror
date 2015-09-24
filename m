From: Jeff King <peff@peff.net>
Subject: [PATCH 07/68] strbuf: make strbuf_complete_line more generic
Date: Thu, 24 Sep 2015 17:05:43 -0400
Message-ID: <20150924210542.GD30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:05:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDiA-0000OS-SZ
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbbIXVFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:05:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:35909 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754134AbbIXVFp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:05:45 -0400
Received: (qmail 11811 invoked by uid 102); 24 Sep 2015 21:05:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:05:45 -0500
Received: (qmail 28892 invoked by uid 107); 24 Sep 2015 21:05:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:05:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:05:43 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278567>

The strbuf_complete_line function makes sure that a buffer
ends in a newline. But we may want to do this for any
character (e.g., "/" on the end of a path). Let's factor out
a generic version, and keep strbuf_complete_line as a thin
wrapper.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index aef2794..43f27c3 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -491,10 +491,21 @@ extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *
  */
 extern void strbuf_addstr_xml_quoted(struct strbuf *sb, const char *s);
 
+/**
+ * "Complete" the contents of `sb` by ensuring that either it ends with the
+ * character `term`, or it is empty.  This can be used, for example,
+ * to ensure that text ends with a newline, but without creating an empty
+ * blank line if there is no content in the first place.
+ */
+static inline void strbuf_complete(struct strbuf *sb, char term)
+{
+	if (sb->len && sb->buf[sb->len - 1] != term)
+		strbuf_addch(sb, term);
+}
+
 static inline void strbuf_complete_line(struct strbuf *sb)
 {
-	if (sb->len && sb->buf[sb->len - 1] != '\n')
-		strbuf_addch(sb, '\n');
+	strbuf_complete(sb, '\n');
 }
 
 extern int strbuf_branchname(struct strbuf *sb, const char *name);
-- 
2.6.0.rc3.454.g204ad51
