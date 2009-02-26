From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] diffcore-pickaxe: further refactor count_match()
Date: Wed, 25 Feb 2009 22:52:05 -0800
Message-ID: <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com>
References: <cover.1235629933.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 07:54:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lca84-0006C2-KO
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 07:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbZBZGwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 01:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbZBZGwX
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 01:52:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55571 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbZBZGwW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 01:52:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2EB7C9D5BB
	for <git@vger.kernel.org>; Thu, 26 Feb 2009 01:52:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 40E6E9D5BA for
 <git@vger.kernel.org>; Thu, 26 Feb 2009 01:52:17 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2.91.gf9a36
In-Reply-To: <cover.1235629933.git.gitster@pobox.com>
X-Pobox-Relay-ID: 02BD6A5C-03D2-11DE-81BA-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111532>

We separate out the part that prepares the blob data to be inspected and
the part that does the actual counting in the data.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-pickaxe.c |   46 +++++++++++++++++++++++++---------------------
 1 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 007b39c..4a0dca1 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -5,22 +5,13 @@
 #include "diff.h"
 #include "diffcore.h"
 
-static unsigned int count_match(int one_or_more,
-				struct diff_filespec *one,
-				const char *needle, unsigned long len,
-				regex_t *regexp)
+static unsigned int count_match_internal(int one_or_more,
+					 const char *data, unsigned long sz,
+					 const char *needle, unsigned long len,
+					 regex_t *regexp)
 {
-	unsigned int cnt;
-	unsigned long offset, sz;
-	const char *data;
-	if (diff_populate_filespec(one, 0))
-		return 0;
-	if (!len)
-		return 0;
-
-	sz = one->size;
-	data = one->data;
-	cnt = 0;
+	unsigned int cnt = 0;
+	unsigned long offset;
 
 	if (regexp) {
 		regmatch_t regmatch;
@@ -29,16 +20,14 @@ static unsigned int count_match(int one_or_more,
 		while (*data && !regexec(regexp, data, 1, &regmatch, flags)) {
 			flags |= REG_NOTBOL;
 			data += regmatch.rm_so;
-			if (*data) data++;
+			if (*data)
+				data++;
 			cnt++;
 			if (one_or_more)
 				break;
 		}
-
-	} else { /* Classic exact string match */
-		/* Yes, I've heard of strstr(), but the thing is *data may
-		 * not be NUL terminated.  Sue me.
-		 */
+	} else {
+		/* data many not be NUL terminated; we cannot use strstr() */
 		for (offset = 0; offset + len <= sz; offset++) {
 			/* we count non-overlapping occurrences of needle */
 			if (!memcmp(needle, data + offset, len)) {
@@ -49,6 +38,21 @@ static unsigned int count_match(int one_or_more,
 			}
 		}
 	}
+	return cnt;
+}
+
+static unsigned int count_match(int one_or_more,
+				struct diff_filespec *one,
+				const char *needle, unsigned long len,
+				regex_t *regexp)
+{
+	unsigned int cnt;
+	if (diff_populate_filespec(one, 0))
+		return 0;
+	if (!len)
+		return 0;
+	cnt = count_match_internal(one_or_more, one->data, one->size,
+				   needle, len, regexp);
 	diff_free_filespec_data(one);
 	return cnt;
 }
-- 
1.6.2.rc2.91.gf9a36
