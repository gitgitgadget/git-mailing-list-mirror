From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 1/3] read-cache.c: Handle long filenames correctly
Date: Wed, 11 Jul 2012 11:22:36 +0200
Message-ID: <1341998558-8502-2-git-send-email-t.gummerer@gmail.com>
References: <7vy5mtlebz.fsf@alter.siamese.dyndns.org>
 <1341998558-8502-1-git-send-email-t.gummerer@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 11:23:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sot8o-0001jJ-En
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 11:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414Ab2GKJXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 05:23:22 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59528 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232Ab2GKJXU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 05:23:20 -0400
Received: by eaak11 with SMTP id k11so287450eaa.19
        for <git@vger.kernel.org>; Wed, 11 Jul 2012 02:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4hkgE4auGD7ij/T2ZLE5zDXkeKAflFbYa6SDjytsrYM=;
        b=Hrze6boFPP2S4Ay1KyaQzcHIITWotHrGS+FmIt+LE2XSowKERvLms4u6xYsxgASOUI
         JBha5BI94sWj5s3pRR5i+6JzLqmKGkhH7fK6Hc8rbrXUXANp2Ib6o5wMA206JCdDTy1C
         kOa0onYWZtrcJM2y1oRt5O8bLiV3imnpMtYMdBD7QVX37DvT7/PJfbrQFCbQ7CS7hhmF
         MABwvUKwCeFg+LamboxpqQwiKE3pgmea93dMUPsYle8BFVr/VjaxMxytOToPZNzzZmM+
         C8LkmSy+dC/NEWz7vN8IWHOXo85LyE1RYL/yQRgH6jQNBc7Aju9EiWUnkgRlRphCPR7j
         WxaQ==
Received: by 10.14.95.65 with SMTP id o41mr11135246eef.41.1341998599226;
        Wed, 11 Jul 2012 02:23:19 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id x52sm3819065eea.11.2012.07.11.02.23.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Jul 2012 02:23:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1341998558-8502-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201290>

Make git handle long file/path names (> 4096 characters) correctly.

There is a bug in the current version, which causes very long
file/pathnames to be handled incorrectly, or not even added to
the index, if they share the first 4096 characters.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c              |    9 +++++--
 t/t0007-long-filenames.sh |   62 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100755 t/t0007-long-filenames.sh

diff --git a/read-cache.c b/read-cache.c
index ef355cc..4c6bf5f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -399,8 +399,13 @@ int cache_name_compare(const char *name1, int flags1, const char *name2, int fla
 {
 	int len1 = flags1 & CE_NAMEMASK;
 	int len2 = flags2 & CE_NAMEMASK;
-	int len = len1 < len2 ? len1 : len2;
-	int cmp;
+	int len, cmp;
+
+	if (len1 >= CE_NAMEMASK)
+		len1 = strlen(name1 + CE_NAMEMASK) + CE_NAMEMASK;
+	if (len2 >= CE_NAMEMASK)
+		len2 = strlen(name2 + CE_NAMEMASK) + CE_NAMEMASK;
+	len = len1 < len2 ? len1 : len2;
 
 	cmp = memcmp(name1, name2, len);
 	if (cmp)
diff --git a/t/t0007-long-filenames.sh b/t/t0007-long-filenames.sh
new file mode 100755
index 0000000..2cf6035
--- /dev/null
+++ b/t/t0007-long-filenames.sh
@@ -0,0 +1,62 @@
+
+#!/bin/sh
+
+test_description='very long file names in the index handled correctly'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git init &&
+
+	a=a && # 1
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 16
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 256
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 4096
+	a=${a}q &&
+
+	>path1 &&
+	git update-index --add path1 &&
+	(
+		git ls-files -s path1 |
+		sed -e "s/	.*/	/" |
+		tr -d "\012"
+		echo "$a"
+	) | git update-index --index-info &&
+
+	a=a && # 1
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 16
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 256
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 4096
+	a=${a}e &&
+
+	>path2 &&
+	git update-index --add path2 &&
+	(
+		git ls-files -s path2 |
+		sed -e "s/	.*/	/" |
+		tr -d "\012"
+		echo "$a"
+	) | git update-index --index-info &&
+	len=$(git ls-files "a*" | wc -c) &&
+	test $len = 8196
+'
+
+test_expect_success 'validate git ls-files output for a known tree' '
+	git ls-files "a*" >current &&
+	a=a && # 1
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 16
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 256
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 4096
+	a=${a}e &&
+	echo $a >expected &&
+
+	a=a && # 1
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 16
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 256
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 4096
+	a=${a}q &&
+	echo $a >>expected &&
+
+	test_cmp expected current
+'
+
+test_done
-- 
1.7.10.GIT
