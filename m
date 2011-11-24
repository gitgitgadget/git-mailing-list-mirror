From: Jeff King <peff@peff.net>
Subject: [PATCH 11/13] strbuf: add strbuf_add*_urlencode
Date: Thu, 24 Nov 2011 06:07:28 -0500
Message-ID: <20111124110728.GI8417@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 12:07:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTX9R-0006mM-Ue
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 12:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987Ab1KXLHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 06:07:32 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49653
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832Ab1KXLHb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 06:07:31 -0500
Received: (qmail 10357 invoked by uid 107); 24 Nov 2011 11:07:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Nov 2011 06:07:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Nov 2011 06:07:28 -0500
Content-Disposition: inline
In-Reply-To: <20111124105801.GA6168@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185906>

This just follows the rfc3986 rules for percent-encoding
url data into a strbuf.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.c |   37 +++++++++++++++++++++++++++++++++++++
 strbuf.h |    5 +++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 3ad2cc0..60e5e59 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -397,3 +397,40 @@ int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 
 	return len;
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
index 46a33f8..cecd48c 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -115,4 +115,9 @@ struct strbuf_expand_dict_entry {
 extern int strbuf_branchname(struct strbuf *sb, const char *name);
 extern int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
+extern void strbuf_add_urlencode(struct strbuf *, const char *, size_t,
+				 int reserved);
+extern void strbuf_addstr_urlencode(struct strbuf *, const char *,
+				    int reserved);
+
 #endif /* STRBUF_H */
-- 
1.7.7.4.5.gb32a5
