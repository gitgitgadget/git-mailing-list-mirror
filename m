From: Jeff King <peff@peff.net>
Subject: [PATCH 40/68] sha1_get_pack_name: use a strbuf
Date: Thu, 24 Sep 2015 17:07:34 -0400
Message-ID: <20150924210733.GK30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:09:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDlp-0003uA-Uw
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807AbbIXVHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:07:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:35992 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753523AbbIXVHg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:36 -0400
Received: (qmail 12061 invoked by uid 102); 24 Sep 2015 21:07:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:36 -0500
Received: (qmail 29345 invoked by uid 107); 24 Sep 2015 21:07:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:34 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278620>

We do some manual memory computation here, and there's no
check that our 60 is not overflowed by the raw sprintf (it
isn't, because the "which" parameter is never longer than
"pack"). We can simplify this greatly with a strbuf.

Technically the end result is not identical, as the original
took care not to rewrite the object directory on each call
for performance reasons.  We could do that here, too (by
saving the baselen and resetting to it), but it's not worth
the complexity; this function is not called a lot (generally
once per packfile that we open).

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 39 ++++++++++-----------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 2be1afd..c26fdcb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -208,44 +208,25 @@ const char *sha1_file_name(const unsigned char *sha1)
  * provided by the caller.  which should be "pack" or "idx".
  */
 static char *sha1_get_pack_name(const unsigned char *sha1,
-				char **name, char **base, const char *which)
+				struct strbuf *buf,
+				const char *which)
 {
-	static const char hex[] = "0123456789abcdef";
-	char *buf;
-	int i;
-
-	if (!*base) {
-		const char *sha1_file_directory = get_object_directory();
-		int len = strlen(sha1_file_directory);
-		*base = xmalloc(len + 60);
-		sprintf(*base, "%s/pack/pack-1234567890123456789012345678901234567890.%s",
-			sha1_file_directory, which);
-		*name = *base + len + 11;
-	}
-
-	buf = *name;
-
-	for (i = 0; i < 20; i++) {
-		unsigned int val = *sha1++;
-		*buf++ = hex[val >> 4];
-		*buf++ = hex[val & 0xf];
-	}
-
-	return *base;
+	strbuf_reset(buf);
+	strbuf_addf(buf, "%s/pack/pack-%s.%s", get_object_directory(),
+		    sha1_to_hex(sha1), which);
+	return buf->buf;
 }
 
 char *sha1_pack_name(const unsigned char *sha1)
 {
-	static char *name, *base;
-
-	return sha1_get_pack_name(sha1, &name, &base, "pack");
+	static struct strbuf buf = STRBUF_INIT;
+	return sha1_get_pack_name(sha1, &buf, "pack");
 }
 
 char *sha1_pack_index_name(const unsigned char *sha1)
 {
-	static char *name, *base;
-
-	return sha1_get_pack_name(sha1, &name, &base, "idx");
+	static struct strbuf buf = STRBUF_INIT;
+	return sha1_get_pack_name(sha1, &buf, "idx");
 }
 
 struct alternate_object_database *alt_odb_list;
-- 
2.6.0.rc3.454.g204ad51
