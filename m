From: Jeff King <peff@peff.net>
Subject: [PATCH v2 6/8] strbuf: add strbuf_reencode helper
Date: Thu, 22 May 2014 05:30:14 -0400
Message-ID: <20140522093014.GF15032@sigill.intra.peff.net>
References: <20140522092824.GA14530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 11:30:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnPKT-0004AY-PP
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 11:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316AbaEVJaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 05:30:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:57252 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754202AbaEVJaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 05:30:16 -0400
Received: (qmail 11633 invoked by uid 102); 22 May 2014 09:30:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 04:30:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 05:30:14 -0400
Content-Disposition: inline
In-Reply-To: <20140522092824.GA14530@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249891>

This is a convenience wrapper around `reencode_string_len`
and `strbuf_attach`.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-strbuf.txt |  5 +++++
 strbuf.c                               | 17 +++++++++++++++++
 strbuf.h                               |  1 +
 3 files changed, 23 insertions(+)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index 3350d97..9d28b03 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -125,6 +125,11 @@ Functions
 
 	Strip whitespace from the end of a string.
 
+`strbuf_reencode`::
+
+	Replace the contents of the strbuf with a reencoded form.  Returns -1
+	on error, 0 on success.
+
 `strbuf_cmp`::
 
 	Compare two buffers. Returns an integer less than, equal to, or greater
diff --git a/strbuf.c b/strbuf.c
index ee96dcf..fc7290f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "refs.h"
+#include "utf8.h"
 
 int starts_with(const char *str, const char *prefix)
 {
@@ -106,6 +107,22 @@ void strbuf_ltrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
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
index 39c14cf..4e9a2f8 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -45,6 +45,7 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 extern void strbuf_trim(struct strbuf *);
 extern void strbuf_rtrim(struct strbuf *);
 extern void strbuf_ltrim(struct strbuf *);
+extern int strbuf_reencode(struct strbuf *sb, const char *from, const char *to);
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 
 /*
-- 
2.0.0.rc1.436.g03cb729
