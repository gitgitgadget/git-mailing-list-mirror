From: Jeff King <peff@peff.net>
Subject: [PATCHv2 11/13] strbuf: add strbuf_add*_urlencode
Date: Tue, 6 Dec 2011 01:23:01 -0500
Message-ID: <20111206062301.GK29233@sigill.intra.peff.net>
References: <20111206062127.GA29046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 07:23:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXoQu-0004m6-Ls
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 07:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932997Ab1LFGXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 01:23:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40058
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932992Ab1LFGXE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 01:23:04 -0500
Received: (qmail 1278 invoked by uid 107); 6 Dec 2011 06:29:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 01:29:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 01:23:01 -0500
Content-Disposition: inline
In-Reply-To: <20111206062127.GA29046@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186329>

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
1.7.8.rc4.4.g884ec
