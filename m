From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Refactor replace_encoding_header.
Date: Sat, 15 Sep 2007 23:50:12 +0200
Message-ID: <20070916172233.A12D04CA60@madism.org>
References: <20070916172134.GA26457@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 19:22:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWxpQ-0007yF-Iv
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 19:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbXIPRWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 13:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbXIPRWg
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 13:22:36 -0400
Received: from pan.madism.org ([88.191.52.104]:35173 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752192AbXIPRWe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 13:22:34 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 05D5D202B0;
	Sun, 16 Sep 2007 19:22:34 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A12D04CA60; Sun, 16 Sep 2007 19:22:33 +0200 (CEST)
In-Reply-To: <20070916172134.GA26457@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58327>

* Be more clever in how we search for "encoding ...\n": parse for real
  instead of the sloppy strstr's.
* use strbuf_splice to do the substring replacements.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 commit.c |   59 +++++++++++++++++++++++------------------------------------
 1 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/commit.c b/commit.c
index 6602e2c..13af933 100644
--- a/commit.c
+++ b/commit.c
@@ -648,47 +648,34 @@ static char *get_header(const struct commit *commit, const char *key)
 
 static char *replace_encoding_header(char *buf, const char *encoding)
 {
-	char *encoding_header = strstr(buf, "\nencoding ");
-	char *header_end = strstr(buf, "\n\n");
-	char *end_of_encoding_header;
-	int encoding_header_pos;
-	int encoding_header_len;
-	int new_len;
-	int need_len;
-	int buflen = strlen(buf) + 1;
-
-	if (!header_end)
-		header_end = buf + buflen;
-	if (!encoding_header || encoding_header >= header_end)
-		return buf;
-	encoding_header++;
-	end_of_encoding_header = strchr(encoding_header, '\n');
-	if (!end_of_encoding_header)
+	struct strbuf tmp;
+	size_t start, len;
+	char *cp = buf;
+
+	/* guess if there is an encoding header before a \n\n */
+	while (strncmp(cp, "encoding ", strlen("encoding "))) {
+		cp = strchr(cp, '\n');
+		if (!cp || *++cp == '\n')
+			return buf;
+	}
+	start = cp - buf;
+	cp = strchr(cp, '\n');
+	if (!cp)
 		return buf; /* should not happen but be defensive */
-	end_of_encoding_header++;
-
-	encoding_header_len = end_of_encoding_header - encoding_header;
-	encoding_header_pos = encoding_header - buf;
+	len = cp + 1 - (buf + start);
 
+	strbuf_init(&tmp, 0);
+	strbuf_attach(&tmp, buf, strlen(buf), strlen(buf) + 1);
 	if (is_encoding_utf8(encoding)) {
 		/* we have re-coded to UTF-8; drop the header */
-		memmove(encoding_header, end_of_encoding_header,
-			buflen - (encoding_header_pos + encoding_header_len));
-		return buf;
-	}
-	new_len = strlen(encoding);
-	need_len = new_len + strlen("encoding \n");
-	if (encoding_header_len < need_len) {
-		buf = xrealloc(buf, buflen + (need_len - encoding_header_len));
-		encoding_header = buf + encoding_header_pos;
-		end_of_encoding_header = encoding_header + encoding_header_len;
+		strbuf_splice(&tmp, start, len, NULL, 0);
+	} else {
+		/* just replaces XXXX in 'encoding XXXX\n' */
+		strbuf_splice(&tmp, start + strlen("encoding "),
+					  len - strlen("encoding \n"),
+					  encoding, strlen(encoding));
 	}
-	memmove(end_of_encoding_header + (need_len - encoding_header_len),
-		end_of_encoding_header,
-		buflen - (encoding_header_pos + encoding_header_len));
-	memcpy(encoding_header + 9, encoding, strlen(encoding));
-	encoding_header[9 + new_len] = '\n';
-	return buf;
+	return tmp.buf;
 }
 
 static char *logmsg_reencode(const struct commit *commit,
-- 
1.5.3.1
