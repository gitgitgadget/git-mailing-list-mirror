From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v2 08/16] Make in-memory format aware of stat_crc
Date: Sun,  5 Aug 2012 23:49:05 +0200
Message-ID: <1344203353-2819-9-git-send-email-t.gummerer@gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pcouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 23:51:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy8jD-00025m-H6
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 23:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237Ab2HEVus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 17:50:48 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48918 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755175Ab2HEVt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 17:49:59 -0400
Received: by mail-ee0-f46.google.com with SMTP id l10so649089eei.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 14:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/jsOu2p8aTqLn213mqWg0ZpHsNqEJu5kSAeArOlubjY=;
        b=e74gg2py3WeTsqM8WOTZf+x/drbcRkEhDLnO32Zy2Ksnj7O7Bog5PXGHXV0D0OoOnj
         rAnuARdMuEFbBXoFzkMQC1p/zSamNgAY2Z+UFgaWqzNoCH2kz1Thfn9LkbOZBxxeJtj5
         dCRE32cUbwwlA4SJ3eI7DBZmS2psy/iwPTDo5RMJu1ctgvHJerkH67Ji7IwF+7rQ2kRE
         z8UwH8LuO5jO6EGwp7JZVXtw11TIhN+p4tWGLiYVLkqpBlGBTjG8AKK3OQf3s7cq/UP8
         ROByM+BUquz+2TNoLVg6Ou+CHuv3WylK9K6OQB7HX1rlQbSywEz9TMa8rH3Zz6GlMhoH
         YMoA==
Received: by 10.14.215.197 with SMTP id e45mr10334235eep.36.1344203399270;
        Sun, 05 Aug 2012 14:49:59 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id e7sm6165561eep.2.2012.08.05.14.49.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 14:49:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202930>

Make the in-memory format aware of the stat_crc used by index-v5.
It is simply ignored by index version prior to v5.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h      |    1 +
 read-cache.c |   27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/cache.h b/cache.h
index 9bfc9f3..076d6af 100644
--- a/cache.h
+++ b/cache.h
@@ -122,6 +122,7 @@ struct cache_entry {
 	unsigned int ce_flags;
 	unsigned int ce_namelen;
 	unsigned char sha1[20];
+	uint32_t ce_stat_crc;
 	struct cache_entry *next;
 	struct cache_entry *dir_next;
 	char name[FLEX_ARRAY]; /* more */
diff --git a/read-cache.c b/read-cache.c
index dceaa5c..4243606 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -67,6 +67,31 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
 	add_index_entry(istate, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 }
 
+static uint32_t calculate_stat_crc(struct cache_entry *ce)
+{
+	unsigned int ctimens = 0;
+	uint32_t stat, stat_crc;
+
+	stat = htonl(ce->ce_ctime.sec);
+	stat_crc = crc32(0, (Bytef*)&stat, 4);
+#ifdef USE_NSEC
+	ctimens = ce->ce_ctime.nsec;
+#endif
+	stat = htonl(ctimens);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	stat = htonl(ce->ce_ino);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	stat = htonl(ce->ce_size);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	stat = htonl(ce->ce_dev);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	stat = htonl(ce->ce_uid);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	stat = htonl(ce->ce_gid);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	return stat_crc;
+}
+
 /*
  * This only updates the "non-critical" parts of the directory
  * cache, ie the parts that aren't tracked by GIT, and only used
@@ -89,6 +114,8 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 
 	if (S_ISREG(st->st_mode))
 		ce_mark_uptodate(ce);
+
+	ce->ce_stat_crc = calculate_stat_crc(ce);
 }
 
 static int ce_compare_data(struct cache_entry *ce, struct stat *st)
-- 
1.7.10.GIT
