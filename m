From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/6] Change semantics of interpolate to work like snprintf.
Date: Sun,  9 Sep 2007 02:04:32 +0200
Message-ID: <11892962764194-git-send-email-madcoder@debian.org>
References: <11892962763548-git-send-email-madcoder@debian.org>
 <11892962761617-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 10:55:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIOa-00040f-Gd
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:43:56 +0200
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAMo-0006Zs-04
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:09:34 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAMh-0003zs-SG
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300AbXIIAEo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 20:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755287AbXIIAEm
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 20:04:42 -0400
Received: from pan.madism.org ([88.191.52.104]:46629 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755241AbXIIAEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 20:04:38 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 96ED91EB19;
	Sun,  9 Sep 2007 02:04:37 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id EEBA339D7; Sun,  9 Sep 2007 02:04:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <11892962761617-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.1, required=12.0, autolearn=disabled, AWL=0.938,UIO_VGER=-3)
X-UiO-Scanned: 81F3C4A4A7C0F1A4733C985A14CB913EE8E149E5
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -20 maxlevel 200 minaction 2 bait 0 mail/h: 5 total 517791 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58156>

  Also fix many off-by-ones and a useless memset.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 commit.c      |    9 ++++-----
 interpolate.c |   20 ++++++++------------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/commit.c b/commit.c
index 99f65ce..25781cc 100644
--- a/commit.c
+++ b/commit.c
@@ -923,15 +923,14 @@ long format_commit_message(const struct commit *commit, const void *format,
 
 	do {
 		char *buf = *buf_p;
-		unsigned long space = *space_p;
+		unsigned long len;
 
-		space = interpolate(buf, space, format,
+		len = interpolate(buf, *space_p, format,
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
