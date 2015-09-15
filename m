From: Jeff King <peff@peff.net>
Subject: [PATCH 07/67] strbuf: make strbuf_complete_line more generic
Date: Tue, 15 Sep 2015 11:25:29 -0400
Message-ID: <20150915152528.GG29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:25:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbs6y-0008UQ-9P
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbbIOPZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:25:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:59285 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752233AbbIOPZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:25:31 -0400
Received: (qmail 11186 invoked by uid 102); 15 Sep 2015 15:25:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:25:31 -0500
Received: (qmail 6838 invoked by uid 107); 15 Sep 2015 15:25:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:25:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:25:29 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277908>

The strbuf_complete_line function make sure that a buffer
ends in a newline. But we may want to do this for any
character (e.g., "/" on the end of a path). Let's factor out
a generic version, and keep strbuf_complete_line as a thin
wrapper.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index aef2794..ba099cd 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -491,10 +491,22 @@ extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *
  */
 extern void strbuf_addstr_xml_quoted(struct strbuf *sb, const char *s);
 
+/**
+ * Ensure that `sb` ends with the character `term`, if it does not
+ * already.
+ */
+static inline void strbuf_complete(struct strbuf *sb, char term)
+{
+	if (sb->len && sb->buf[sb->len - 1] != term)
+		strbuf_addch(sb, term);
+}
+
+/**
+ * Ensure that `sb` ends with a newline.
+ */
 static inline void strbuf_complete_line(struct strbuf *sb)
 {
-	if (sb->len && sb->buf[sb->len - 1] != '\n')
-		strbuf_addch(sb, '\n');
+	strbuf_complete(sb, '\n');
 }
 
 extern int strbuf_branchname(struct strbuf *sb, const char *name);
-- 
2.6.0.rc2.408.ga2926b9
