From: Jeff King <peff@peff.net>
Subject: [PATCH 8/9] strbuf: add strbuf_reencode helper
Date: Wed, 21 May 2014 06:33:24 -0400
Message-ID: <20140521103324.GH30464@sigill.intra.peff.net>
References: <20140521102524.GA30301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 12:33:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn3py-0006nx-LP
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 12:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbaEUKd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 06:33:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:56426 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750980AbaEUKd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 06:33:26 -0400
Received: (qmail 383 invoked by uid 102); 21 May 2014 10:33:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 05:33:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 06:33:24 -0400
Content-Disposition: inline
In-Reply-To: <20140521102524.GA30301@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249789>

This is a convenience wrapper around `reencode_string_len`
and `strbuf_attach`.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-strbuf.txt |  5 +++++
 strbuf.c                               | 17 +++++++++++++++++
 strbuf.h                               |  1 +
 3 files changed, 23 insertions(+)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index 8480f89..a468816 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -129,6 +129,11 @@ Functions
 
 	Lowercase each character in the buffer using `tolower`.
 
+`strbuf_reencode`::
+
+	Replace the contents of the strbuf with a reencoded form.  Returns -1
+	on error, 0 on success.
+
 `strbuf_cmp`::
 
 	Compare two buffers. Returns an integer less than, equal to, or greater
diff --git a/strbuf.c b/strbuf.c
index d289d1a..a717d9b 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "refs.h"
+#include "utf8.h"
 
 int starts_with(const char *str, const char *prefix)
 {
@@ -113,6 +114,22 @@ void strbuf_tolower(struct strbuf *sb)
 		sb->buf[i] = tolower(sb->buf[i]);
 }
 
+int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
+{
+	char *out;
+	int len;
+
+	if (same_encoding(from, to))
+		return 0;
+
+	out = reencode_string_len(sb->buf, sb->len, to, from, &len);
+	if (!out)
+		return -1;
+
+	strbuf_attach(sb, out, len, len);
+	return 0;
+}
+
 struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 				 int terminator, int max)
 {
diff --git a/strbuf.h b/strbuf.h
index 25328b9..a068dd6 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -46,6 +46,7 @@ extern void strbuf_trim(struct strbuf *);
 extern void strbuf_rtrim(struct strbuf *);
 extern void strbuf_ltrim(struct strbuf *);
 extern void strbuf_tolower(struct strbuf *sb);
+extern int strbuf_reencode(struct strbuf *sb, const char *from, const char *to);
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 
 /*
-- 
2.0.0.rc1.436.g03cb729
