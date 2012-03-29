From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/4] sha1_name: introduce getn_sha1() to take length
Date: Thu, 29 Mar 2012 19:28:12 +0530
Message-ID: <1333029495-10034-2-git-send-email-artagnon@gmail.com>
References: <1333029495-10034-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 29 15:58:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDFs4-00070Z-Nb
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 15:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759058Ab2C2N6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 09:58:34 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33574 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932713Ab2C2N61 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 09:58:27 -0400
Received: by ghrr11 with SMTP id r11so1476386ghr.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gLG+UZkBG0bK5bf33HefphNSoF/PSfdFdRHcvqpGWc8=;
        b=PfGNw/5n3CruiIKue5P6R/e2QOes13Z164ddOyaGeW2LPlL5lVYqdHcjBeoBivRRJM
         v0xmmUH0Hb9LYanW2NopQakurhcKUYK558ECuhg2JgzHyQ7Qs4LPXchWfKFFuF4IJ5Ug
         lsxkxRtrcJ7GiGfSfSQTifHkiFkY4Sztaoifi0zQbVWleYXJZlopj1j+881pp64zvr8w
         TWJledsem6tbeVAfTGskDuRh+jAHvSios1Hk/11j7xCsixxI2vNAAdaML8FeD2U0x3s/
         XLtko1lZW0W2NgTYkMSqM9kNVf5AhnrR89L5D4y2J5/WA48jS5RW2ZNtYMG7Ch/gjIgc
         HaPQ==
Received: by 10.68.217.97 with SMTP id ox1mr256239pbc.81.1333029506577;
        Thu, 29 Mar 2012 06:58:26 -0700 (PDT)
Received: from localhost.localdomain ([122.174.77.58])
        by mx.google.com with ESMTPS id j3sm5090947pbb.29.2012.03.29.06.58.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 06:58:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1333029495-10034-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194254>

Introduce a variant of get_sha1() that additionally takes the length
of the buffer, so it can parse object names from buffers that don't
necessarily terminate with NUL.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 cache.h     |    1 +
 sha1_name.c |   23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index e5e1aa4..e52c354 100644
--- a/cache.h
+++ b/cache.h
@@ -813,6 +813,7 @@ struct object_context {
 };
 
 extern int get_sha1(const char *str, unsigned char *sha1);
+extern int getn_sha1(const char *name, int namelen, unsigned char *sha1);
 extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, int only_to_die, const char *prefix);
 static inline int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode)
 {
diff --git a/sha1_name.c b/sha1_name.c
index 03ffc2c..31d412e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1019,12 +1019,11 @@ static char *resolve_relative_path(const char *rel)
 			   rel);
 }
 
-int get_sha1_with_context_1(const char *name, unsigned char *sha1,
-			    struct object_context *oc,
-			    int only_to_die, const char *prefix)
+static int getn_sha1_with_context_1(const char *name, int namelen,
+				unsigned char *sha1, struct object_context *oc,
+				int only_to_die, const char *prefix)
 {
 	int ret, bracket_depth;
-	int namelen = strlen(name);
 	const char *cp;
 
 	memset(oc, 0, sizeof(*oc));
@@ -1134,3 +1133,19 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 	}
 	return ret;
 }
+
+int get_sha1_with_context_1(const char *name, unsigned char *sha1,
+			struct object_context *oc,
+			int only_to_die, const char *prefix)
+{
+	int namelen = strlen(name);
+	return getn_sha1_with_context_1(name, namelen, sha1,
+					oc, only_to_die, prefix);
+}
+
+/* A variant of get_sha1 that takes a length. */
+int getn_sha1(const char *name, int namelen, unsigned char *sha1)
+{
+	struct object_context unused;
+	return getn_sha1_with_context_1(name, namelen, sha1, &unused, 0, NULL);
+}
-- 
1.7.8.1.362.g5d6df.dirty
