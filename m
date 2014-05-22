From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] strbuf: add strbuf_tolower function
Date: Thu, 22 May 2014 05:44:24 -0400
Message-ID: <20140522094424.GB15255@sigill.intra.peff.net>
References: <20140522094251.GA14994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 11:44:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnPY8-00009e-D8
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 11:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbaEVJo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 05:44:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:57271 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753720AbaEVJo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 05:44:28 -0400
Received: (qmail 13142 invoked by uid 102); 22 May 2014 09:44:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 04:44:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 05:44:24 -0400
Content-Disposition: inline
In-Reply-To: <20140522094251.GA14994@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249896>

This makes config's lowercase() function public.

Note that we could continue to offer a pure-string
lowercase, but there would be no callers (in most
pure-string cases, we actually duplicate and lowercase the
duplicate).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-strbuf.txt | 4 ++++
 config.c                               | 8 +-------
 strbuf.c                               | 7 +++++++
 strbuf.h                               | 1 +
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index 3350d97..8480f89 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -125,6 +125,10 @@ Functions
 
 	Strip whitespace from the end of a string.
 
+`strbuf_tolower`::
+
+	Lowercase each character in the buffer using `tolower`.
+
 `strbuf_cmp`::
 
 	Compare two buffers. Returns an integer less than, equal to, or greater
diff --git a/config.c b/config.c
index a30cb5c..03ce5c6 100644
--- a/config.c
+++ b/config.c
@@ -147,12 +147,6 @@ int git_config_include(const char *var, const char *value, void *data)
 	return ret;
 }
 
-static void lowercase(char *p)
-{
-	for (; *p; p++)
-		*p = tolower(*p);
-}
-
 void git_config_push_parameter(const char *text)
 {
 	struct strbuf env = STRBUF_INIT;
@@ -180,7 +174,7 @@ int git_config_parse_parameter(const char *text,
 		strbuf_list_free(pair);
 		return error("bogus config parameter: %s", text);
 	}
-	lowercase(pair[0]->buf);
+	strbuf_tolower(pair[0]);
 	if (fn(pair[0]->buf, pair[1] ? pair[1]->buf : NULL, data) < 0) {
 		strbuf_list_free(pair);
 		return -1;
diff --git a/strbuf.c b/strbuf.c
index 854c725..3da4f3e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -106,6 +106,13 @@ void strbuf_ltrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
+void strbuf_tolower(struct strbuf *sb)
+{
+	char *p;
+	for (p = sb->buf; *p; p++)
+		*p = tolower(*p);
+}
+
 struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 				 int terminator, int max)
 {
diff --git a/strbuf.h b/strbuf.h
index 4de7531..25328b9 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -45,6 +45,7 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 extern void strbuf_trim(struct strbuf *);
 extern void strbuf_rtrim(struct strbuf *);
 extern void strbuf_ltrim(struct strbuf *);
+extern void strbuf_tolower(struct strbuf *sb);
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 
 /*
-- 
2.0.0.rc1.436.g03cb729
