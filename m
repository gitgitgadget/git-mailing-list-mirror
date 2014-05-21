From: Jeff King <peff@peff.net>
Subject: [PATCH 2/9] strbuf: add strbuf_tolower function
Date: Wed, 21 May 2014 06:27:42 -0400
Message-ID: <20140521102742.GB30464@sigill.intra.peff.net>
References: <20140521102524.GA30301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 12:27:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn3kS-0005jz-Cu
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 12:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbaEUK1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 06:27:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:56404 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750980AbaEUK1o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 06:27:44 -0400
Received: (qmail 32401 invoked by uid 102); 21 May 2014 10:27:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 05:27:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 06:27:42 -0400
Content-Disposition: inline
In-Reply-To: <20140521102524.GA30301@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249782>

This makes config's lowercase() function public.

Note that we could continue to offer a pure-string
lowercase, but there would be no callers (in most
pure-string cases, we actually duplicate and lowercase the
duplicate).

Signed-off-by: Jeff King <peff@peff.net>
---
This ones gets used later on...

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
index ee96dcf..a1b8a47 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -106,6 +106,13 @@ void strbuf_ltrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
+void strbuf_tolower(struct strbuf *sb)
+{
+	size_t i;
+	for (i = 0; i < sb->len; i++)
+		sb->buf[i] = tolower(sb->buf[i]);
+}
+
 struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 				 int terminator, int max)
 {
diff --git a/strbuf.h b/strbuf.h
index 39c14cf..6b6f745 100644
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
