From: Jeff King <peff@peff.net>
Subject: [PATCHv3 11/13] strbuf: add strbuf_add*_urlencode
Date: Sat, 10 Dec 2011 05:34:20 -0500
Message-ID: <20111210103420.GK16529@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 11:34:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZKGG-0006sy-Pc
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 11:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab1LJKeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 05:34:22 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47031
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189Ab1LJKeW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 05:34:22 -0500
Received: (qmail 14105 invoked by uid 107); 10 Dec 2011 10:41:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 05:41:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 05:34:20 -0500
Content-Disposition: inline
In-Reply-To: <20111210102827.GA16460@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186743>

This just follows the rfc3986 rules for percent-encoding
url data into a strbuf.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.c |   37 +++++++++++++++++++++++++++++++++++++
 strbuf.h |    5 +++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index a849705..ff0b96b 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -411,3 +411,40 @@ void strbuf_add_lines(struct strbuf *out, const char *prefix,
 	}
 	strbuf_complete_line(out);
 }
+
+static int is_rfc3986_reserved(char ch)
+{
+	switch (ch) {
+		case '!': case '*': case '\'': case '(': case ')': case ';':
+		case ':': case '@': case '&': case '=': case '+': case '$':
+		case ',': case '/': case '?': case '#': case '[': case ']':
+			return 1;
+	}
+	return 0;
+}
+
+static int is_rfc3986_unreserved(char ch)
+{
+	return isalnum(ch) ||
+		ch == '-' || ch == '_' || ch == '.' || ch == '~';
+}
+
+void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t len,
+			  int reserved)
+{
+	strbuf_grow(sb, len);
+	while (len--) {
+		char ch = *s++;
+		if (is_rfc3986_unreserved(ch) ||
+		    (!reserved && is_rfc3986_reserved(ch)))
+			strbuf_addch(sb, ch);
+		else
+			strbuf_addf(sb, "%%%02x", ch);
+	}
+}
+
+void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
+			     int reserved)
+{
+	strbuf_add_urlencode(sb, s, strlen(s), reserved);
+}
diff --git a/strbuf.h b/strbuf.h
index 08fc13d..fbf059f 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -123,4 +123,9 @@ static inline void strbuf_complete_line(struct strbuf *sb)
 extern int strbuf_branchname(struct strbuf *sb, const char *name);
 extern int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
+extern void strbuf_add_urlencode(struct strbuf *, const char *, size_t,
+				 int reserved);
+extern void strbuf_addstr_urlencode(struct strbuf *, const char *,
+				    int reserved);
+
 #endif /* STRBUF_H */
-- 
1.7.8.rc2.40.gaf387
