From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 4/5] tree-walk: unroll get_mode since loop boundaries are well-known
Date: Wed, 30 Mar 2011 20:38:00 -0500
Message-ID: <1301535481-1085-4-git-send-email-dpmcgee@gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 03:38:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q56qP-0003Um-SC
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 03:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933839Ab1CaBiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 21:38:15 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37679 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933810Ab1CaBiN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 21:38:13 -0400
Received: by iyb14 with SMTP id 14so1845353iyb.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 18:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=JaANWbIAztQPzlApXv7ZyCa7uX9zhNuKAm+jL5C0KaA=;
        b=JUAEJgfgeAcOq2OZKtAe/H25IYXLQr78satXaIUCBILFfVexMM9h8RLyWPJTkGr6RC
         3RH8YNt+vQbPKwDOTOiAPJfZFHjdBjEkks4ZDB4Ob3HCLoIZeBngO2f+s187f+/JSJ2c
         I1gbdu3LGzIYKezaFDivjqFdFfD/n5QBGpq2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dblZpkUmwJaKVWVwUM/zKZ8luevdzIurHijl/O6CBNBwP7khjzaF+82TMY084pf4E/
         LVHKzRRrJos78X+wrVa+49i6SGM/6n+zzzhZajAcvzdh/m0gCFQh4mPx2cG0sllqmwUf
         wSIBU/Z0j0omyo4vICiMKBMlza9Pe4YGDzvlA=
Received: by 10.43.46.69 with SMTP id un5mr2132584icb.44.1301535492273;
        Wed, 30 Mar 2011 18:38:12 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id xi12sm284214icb.6.2011.03.30.18.38.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 18:38:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170443>

We know our mode entry in our tree objects should be 5 or 6 characters
long. This change both enforces this fact and also unrolls the parsing
of the information giving the compiler more room for optimization of the
operations.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 tree-walk.c |   41 ++++++++++++++++++++++++++++++++++-------
 1 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index f386151..41383b0 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -9,16 +9,43 @@ static const char *get_mode(const char *str, unsigned int *modep)
 	unsigned char c;
 	unsigned int mode = 0;
 
-	if (*str == ' ')
-		return NULL;
-
-	while ((c = *str++) != ' ') {
-		if (c < '0' || c > '7')
-			return NULL;
+	/*
+	 * Unroll what looks like a loop since the bounds are
+	 * well-known. There should be at least 5 and at most 6
+	 * characters available in any valid mode, as '40000' is the
+	 * shortest while '160000' (S_IFGITLINK) is the longest.
+	 */
+	/* char 1 */
+	c = *str++;
+	if (c < '0' || c > '7') return NULL;
+	mode = (mode << 3) + (c - '0');
+	/* char 2 */
+	c = *str++;
+	if (c < '0' || c > '7') return NULL;
+	mode = (mode << 3) + (c - '0');
+	/* char 3 */
+	c = *str++;
+	if (c < '0' || c > '7') return NULL;
+	mode = (mode << 3) + (c - '0');
+	/* char 4 */
+	c = *str++;
+	if (c < '0' || c > '7') return NULL;
+	mode = (mode << 3) + (c - '0');
+	/* char 5 */
+	c = *str++;
+	if (c < '0' || c > '7') return NULL;
+	mode = (mode << 3) + (c - '0');
+	/* char 6, optional */
+	if (*str != ' ') {
+		c = *str++;
+		if (c < '0' || c > '7') return NULL;
 		mode = (mode << 3) + (c - '0');
 	}
+
+	if (*str != ' ') return NULL;
+
 	*modep = mode;
-	return str;
+	return str + 1;
 }
 
 static void decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size)
-- 
1.7.4.2
