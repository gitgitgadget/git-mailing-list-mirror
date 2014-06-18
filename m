From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 1/5] cache: rename cache_name_compare() to name_compare()
Date: Wed, 18 Jun 2014 11:45:13 -0700
Message-ID: <1403117117-10384-2-git-send-email-jmmahler@gmail.com>
References: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 20:46:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxKs4-00079o-BH
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 20:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212AbaFRSqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 14:46:02 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:50207 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaFRSqB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 14:46:01 -0400
Received: by mail-pb0-f48.google.com with SMTP id rq2so1022029pbb.35
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XFFva2epq/SxrqBHLTC9N+owVpbs/NfjbW5B9JexHkY=;
        b=A4MrHr0lqrdnheAbGSW1TK1exf0Go7WtmL5yhd6uf6ZYYcytUs78O7xq6kT1dV3Dss
         FbdEoJGxJj/YIUpzR/nDKKrpEHHQCi1UKjBNlQPxloSh2GpdhlS1bPvvbeoXGfJZPDFW
         E7ALEVIAW1B8fkIXAHv+2AFi07wl719Oj18chcc3aKUuTLD9PeQUhPY1iOjR+QYTz96u
         7gw27aeOnTD7t5tcTqnI1xvbw/TdmHd6hp00MMyFLIpLshyz3Shma4YLn8Z9lv5PBJjn
         g8TF8XxJrtCkKhob7tDmQ99kj6MfFQmLEWYZmV2hGhiTRZdCYeWNtWHLjKs+9Cx9DGEc
         wpzg==
X-Received: by 10.68.171.193 with SMTP id aw1mr4365185pbc.117.1403117160312;
        Wed, 18 Jun 2014 11:46:00 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id bu1sm4655008pbb.54.2014.06.18.11.45.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jun 2014 11:45:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.697.g57b47e0
In-Reply-To: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252021>

The cache_name_compare() function is not specific to a cache.
Make its name more general by renaming it to name_compare().

Simplify cache_name_stage_compare() via name_compare().
Where lengths are involved, change int to size_t.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 cache.h      |  2 +-
 read-cache.c | 23 +++++++++++++----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index c498a30..e3205fe 100644
--- a/cache.h
+++ b/cache.h
@@ -1027,7 +1027,7 @@ extern int validate_headref(const char *ref);
 
 extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
 extern int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
-extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
+extern int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 extern int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
 extern void *read_object_with_reference(const unsigned char *sha1,
diff --git a/read-cache.c b/read-cache.c
index 9f56d76..158241d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -434,18 +434,26 @@ int df_name_compare(const char *name1, int len1, int mode1,
 	return c1 - c2;
 }
 
-int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2)
+int name_compare(const char *name1, size_t len1, const char *name2, size_t len2)
 {
-	int len = len1 < len2 ? len1 : len2;
-	int cmp;
-
-	cmp = memcmp(name1, name2, len);
+	size_t min_len = (len1 < len2) ? len1 : len2;
+	int cmp = memcmp(name1, name2, min_len);
 	if (cmp)
 		return cmp;
 	if (len1 < len2)
 		return -1;
 	if (len1 > len2)
 		return 1;
+	return 0;
+}
+
+int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2)
+{
+	int cmp;
+
+	cmp = name_compare(name1, len1, name2, len2);
+	if (cmp)
+		return cmp;
 
 	if (stage1 < stage2)
 		return -1;
@@ -454,11 +462,6 @@ int cache_name_stage_compare(const char *name1, int len1, int stage1, const char
 	return 0;
 }
 
-int cache_name_compare(const char *name1, int len1, const char *name2, int len2)
-{
-	return cache_name_stage_compare(name1, len1, 0, name2, len2, 0);
-}
-
 static int index_name_stage_pos(const struct index_state *istate, const char *name, int namelen, int stage)
 {
 	int first, last;
-- 
2.0.0
