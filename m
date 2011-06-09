From: Jeff King <peff@peff.net>
Subject: [PATCH 05/10] strbuf: allow strbuf_split to work on non-strbufs
Date: Thu, 9 Jun 2011 11:54:58 -0400
Message-ID: <20110609155458.GE25507@sigill.intra.peff.net>
References: <20110609155001.GA14969@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Claire Fousse <claire.fousse@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:55:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUhZc-0000Lv-25
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 17:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab1FIPzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 11:55:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38418
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392Ab1FIPzC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 11:55:02 -0400
Received: (qmail 14025 invoked by uid 107); 9 Jun 2011 15:55:09 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 11:55:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 11:54:58 -0400
Content-Disposition: inline
In-Reply-To: <20110609155001.GA14969@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175538>

The strbuf_split function takes a strbuf as input, and
outputs a list of strbufs. However, there is no reason that
the input has to be a strbuf, and not an arbitrary buffer.

This patch adds strbuf_split_buf for a length-delimited
buffer, and strbuf_split_str for NUL-terminated strings.

Signed-off-by: Jeff King <peff@peff.net>
---
This makes the naming convention slightly different than "add", which
uses:

  add - add data by pointer and length
  addstr - add data by pointer to NUL-terminated string
  addbuf - add strbuf

but here we have:

  strbuf_split - split a strbuf
  strbuf_split_str - split a NUL-terminated string
  strbuf_split_buf - split pointer and length

It's that way because strbuf_split was introduced first with the current
semantics. I don't know if it is worth fixing the inconsistency.

 strbuf.c |   12 ++++++------
 strbuf.h |   12 +++++++++++-
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 64f6c1e..1a7df12 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -103,19 +103,19 @@ void strbuf_ltrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
-struct strbuf **strbuf_split_max(const struct strbuf *sb, int delim, int max)
+struct strbuf **strbuf_split_buf(const char *str, size_t slen, int delim, int max)
 {
 	int alloc = 2, pos = 0;
-	char *n, *p;
+	const char *n, *p;
 	struct strbuf **ret;
 	struct strbuf *t;
 
 	ret = xcalloc(alloc, sizeof(struct strbuf *));
-	p = n = sb->buf;
-	while (n < sb->buf + sb->len) {
+	p = n = str;
+	while (n < str + slen) {
 		int len;
 		if (max <= 0 || pos + 1 < max)
-			n = memchr(n, delim, sb->len - (n - sb->buf));
+			n = memchr(n, delim, slen - (n - str));
 		else
 			n = NULL;
 		if (pos + 1 >= alloc) {
@@ -123,7 +123,7 @@ struct strbuf **strbuf_split_max(const struct strbuf *sb, int delim, int max)
 			ret = xrealloc(ret, sizeof(struct strbuf *) * alloc);
 		}
 		if (!n)
-			n = sb->buf + sb->len - 1;
+			n = str + slen - 1;
 		len = n - p + 1;
 		t = xmalloc(sizeof(struct strbuf));
 		strbuf_init(t, len);
diff --git a/strbuf.h b/strbuf.h
index 4cf1dcd..46a33f8 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -44,8 +44,18 @@ extern void strbuf_rtrim(struct strbuf *);
 extern void strbuf_ltrim(struct strbuf *);
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 
-extern struct strbuf **strbuf_split_max(const struct strbuf *,
+extern struct strbuf **strbuf_split_buf(const char *, size_t,
 					int delim, int max);
+static inline struct strbuf **strbuf_split_str(const char *str,
+					       int delim, int max)
+{
+	return strbuf_split_buf(str, strlen(str), delim, max);
+}
+static inline struct strbuf **strbuf_split_max(const struct strbuf *sb,
+						int delim, int max)
+{
+	return strbuf_split_buf(sb->buf, sb->len, delim, max);
+}
 static inline struct strbuf **strbuf_split(const struct strbuf *sb, int delim)
 {
 	return strbuf_split_max(sb, delim, 0);
-- 
1.7.6.rc1.36.g91167
