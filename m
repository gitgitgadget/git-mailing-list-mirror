From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/3] Change semantics of interpolate to work like snprintf.
Date: Sat,  8 Sep 2007 13:53:18 +0200
Message-ID: <1189252399316-git-send-email-madcoder@debian.org>
References: <20070902224213.GB431@artemis.corp>
 <11892523992761-git-send-email-madcoder@debian.org>
 <1189252399433-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 13:53:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITysV-0006v1-1o
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 13:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbXIHLxZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 07:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbXIHLxX
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 07:53:23 -0400
Received: from pan.madism.org ([88.191.52.104]:57495 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbXIHLxV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 07:53:21 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 030F91E9CF;
	Sat,  8 Sep 2007 13:53:19 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 391A51427AA; Sat,  8 Sep 2007 13:53:19 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <1189252399433-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58120>

  Also fix many off-by-ones and a useless memset.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 commit.c      |    9 ++++-----
 interpolate.c |   20 ++++++++------------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/commit.c b/commit.c
index dc5a064..30db9f4 100644
--- a/commit.c
+++ b/commit.c
@@ -922,15 +922,14 @@ static long format_commit_message(const struct commit *commit,
 
 	do {
 		char *buf = *buf_p;
-		unsigned long space = *space_p;
+		unsigned long len;
 
-		space = interpolate(buf, space, user_format,
+		len = interpolate(buf, *space_p, user_format,
 				    table, ARRAY_SIZE(table));
-		if (!space)
+		if (len < *space_p)
 			break;
-		buf = xrealloc(buf, space);
+		ALLOC_GROW(buf, len + 1, *space_p);
 		*buf_p = buf;
-		*space_p = space;
 	} while (1);
 	interp_clear_table(table, ARRAY_SIZE(table));
 
diff --git a/interpolate.c b/interpolate.c
index 0082677..ff4fb10 100644
--- a/interpolate.c
+++ b/interpolate.c
@@ -44,9 +44,8 @@ void interp_clear_table(struct interp *table, int ninterps)
  *        { "%%", "%"},
  *    }
  *
- * Returns 0 on a successful substitution pass that fits in result,
- * Returns a number of bytes needed to hold the full substituted
- * string otherwise.
+ * Returns the length of the substituted string (not including the final \0).
+ * Like with snprintf, if the result is >= reslen, then it overflowed.
  */
 
 unsigned long interpolate(char *result, unsigned long reslen,
@@ -61,8 +60,6 @@ unsigned long interpolate(char *result, unsigned long reslen,
 	int i;
 	char c;
 
-        memset(result, 0, reslen);
-
 	while ((c = *src)) {
 		if (c == '%') {
 			/* Try to match an interpolation string. */
@@ -78,9 +75,9 @@ unsigned long interpolate(char *result, unsigned long reslen,
 				value = interps[i].value;
 				valuelen = strlen(value);
 
-				if (newlen + valuelen + 1 < reslen) {
+				if (newlen + valuelen < reslen) {
 					/* Substitute. */
-					strncpy(dest, value, valuelen);
+					memcpy(dest, value, valuelen);
 					dest += valuelen;
 				}
 				newlen += valuelen;
@@ -89,14 +86,13 @@ unsigned long interpolate(char *result, unsigned long reslen,
 			}
 		}
 		/* Straight copy one non-interpolation character. */
-		if (newlen + 1 < reslen)
+		if (newlen < reslen)
 			*dest++ = *src;
 		src++;
 		newlen++;
 	}
 
-	if (newlen + 1 < reslen)
-		return 0;
-	else
-		return newlen + 2;
+	if (reslen > 0)
+		*dest = '\0';
+	return newlen;
 }
-- 
1.5.3.1
