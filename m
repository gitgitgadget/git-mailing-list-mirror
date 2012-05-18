From: Jeff King <peff@peff.net>
Subject: [PATCH 12/13] ident: use a dynamic strbuf in fmt_ident
Date: Fri, 18 May 2012 19:23:39 -0400
Message-ID: <20120518232338.GL30031@sigill.intra.peff.net>
References: <20120518230528.GA30510@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 01:23:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVWWY-0003x5-7Z
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 01:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946515Ab2ERXXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 19:23:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48803
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946489Ab2ERXXm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 19:23:42 -0400
Received: (qmail 7974 invoked by uid 107); 18 May 2012 23:24:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 19:24:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 19:23:39 -0400
Content-Disposition: inline
In-Reply-To: <20120518230528.GA30510@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197993>

Now that we accept arbitrary-sized names and email
addresses, the only remaining limit is in the actual
formatting of the names into a buffer. The current limit is
1000 characters, which is not likely to be reached, but
using a strbuf is one less error condition we have to worry
about.

Signed-off-by: Jeff King <peff@peff.net>
---
 ident.c | 43 +++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/ident.c b/ident.c
index b111e34..cefb829 100644
--- a/ident.c
+++ b/ident.c
@@ -121,15 +121,6 @@ const char *ident_default_date(void)
 	return git_default_date;
 }
 
-static int add_raw(char *buf, size_t size, int offset, const char *str)
-{
-	size_t len = strlen(str);
-	if (offset + len > size)
-		return size;
-	memcpy(buf + offset, str, len);
-	return offset + len;
-}
-
 static int crud(unsigned char c)
 {
 	return  c <= 32  ||
@@ -148,7 +139,7 @@ static int crud(unsigned char c)
  * Copy over a string to the destination, but avoid special
  * characters ('\n', '<' and '>') and remove crud at the end
  */
-static int copy(char *buf, size_t size, int offset, const char *src)
+static void strbuf_addstr_without_crud(struct strbuf *sb, const char *src)
 {
 	size_t i, len;
 	unsigned char c;
@@ -172,19 +163,19 @@ static int copy(char *buf, size_t size, int offset, const char *src)
 	/*
 	 * Copy the rest to the buffer, but avoid the special
 	 * characters '\n' '<' and '>' that act as delimiters on
-	 * an identification line
+	 * an identification line. We can only remove crud, never add it,
+	 * so 'len' is our maximum.
 	 */
+	strbuf_grow(sb, len);
 	for (i = 0; i < len; i++) {
 		c = *src++;
 		switch (c) {
 		case '\n': case '<': case '>':
 			continue;
 		}
-		if (offset >= size)
-			return size;
-		buf[offset++] = c;
+		sb->buf[sb->len++] = c;
 	}
-	return offset;
+	sb->buf[sb->len] = '\0';
 }
 
 /*
@@ -271,9 +262,8 @@ static const char *env_hint =
 const char *fmt_ident(const char *name, const char *email,
 		      const char *date_str, int flag)
 {
-	static char buffer[1000];
+	static struct strbuf ident = STRBUF_INIT;
 	char date[50];
-	int i;
 	int error_on_no_name = (flag & IDENT_ERROR_ON_NO_NAME);
 	int name_addr_only = (flag & IDENT_NO_DATE);
 
@@ -300,19 +290,16 @@ const char *fmt_ident(const char *name, const char *email,
 			die("invalid date format: %s", date_str);
 	}
 
-	i = copy(buffer, sizeof(buffer), 0, name);
-	i = add_raw(buffer, sizeof(buffer), i, " <");
-	i = copy(buffer, sizeof(buffer), i, email);
+	strbuf_reset(&ident);
+	strbuf_addstr_without_crud(&ident, name);
+	strbuf_addstr(&ident, " <");
+	strbuf_addstr_without_crud(&ident, email);
+	strbuf_addch(&ident, '>');
 	if (!name_addr_only) {
-		i = add_raw(buffer, sizeof(buffer), i,  "> ");
-		i = copy(buffer, sizeof(buffer), i, date);
-	} else {
-		i = add_raw(buffer, sizeof(buffer), i, ">");
+		strbuf_addch(&ident, ' ');
+		strbuf_addstr_without_crud(&ident, date);
 	}
-	if (i >= sizeof(buffer))
-		die("Impossibly long personal identifier");
-	buffer[i] = 0;
-	return buffer;
+	return ident.buf;
 }
 
 const char *fmt_name(const char *name, const char *email)
-- 
1.7.10.1.16.g53a707b
