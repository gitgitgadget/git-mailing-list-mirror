From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 14/22] read-cache: make in-memory format aware of stat_crc
Date: Sun,  7 Jul 2013 10:11:52 +0200
Message-ID: <1373184720-29767-15-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:13:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk67-0006Q3-RN
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103Ab3GGINZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:13:25 -0400
Received: from mail-ea0-f179.google.com ([209.85.215.179]:57451 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052Ab3GGINT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:13:19 -0400
Received: by mail-ea0-f179.google.com with SMTP id b15so2267098eae.24
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VNkSmVayZAffGpggu0JbzBzn1qlks2VVQKsnMk8KKX4=;
        b=ASvFJ4gapuIVRbGHqhAXRL7eeVrXXk1RyFv/LiqoOLruIZJI1p/LN5lKdkL6zEsO+U
         goX8scZR2WKc7/ENTjqmpxSxgLQBBGqV4Llc/qwxKlvkCnZStbLKIFPQlC1kqd7ZnI8N
         DaXmic084ZVHh5A5NEJos474KqQYcRNbgO4H3jz7/pwH86ZGzO1Klyoo1XjKjXFdBNNz
         8mPDayLNgk1BGfOZaRBj2+vdrAmBY4qhqDG0IzFlp9q3hybv8IiiHT5xaOJL+A+xO+2H
         9idUMa4wUyIyLe4G/bAkjKVt5ciQcyjqNiUgpjJuZCtxyd8a8RmzdIo520NnwqvJeEgk
         f/rg==
X-Received: by 10.14.215.5 with SMTP id d5mr19479391eep.143.1373184797799;
        Sun, 07 Jul 2013 01:13:17 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id y1sm30797699eew.3.2013.07.07.01.13.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:13:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229745>

Make the in-memory format aware of the stat_crc used by index-v5.
It is simply ignored by index version prior to v5.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h      |  1 +
 read-cache.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/cache.h b/cache.h
index f6c3407..d77af5e 100644
--- a/cache.h
+++ b/cache.h
@@ -127,6 +127,7 @@ struct cache_entry {
 	unsigned int ce_flags;
 	unsigned int ce_namelen;
 	unsigned char sha1[20];
+	uint32_t ce_stat_crc;
 	struct cache_entry *next; /* used by name_hash */
 	struct cache_entry *next_ce; /* used to keep a list of cache entries */
 	char name[FLEX_ARRAY]; /* more */
diff --git a/read-cache.c b/read-cache.c
index c81e643..5ec0222 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -108,6 +108,29 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
 	return changed;
 }
 
+static uint32_t calculate_stat_crc(struct cache_entry *ce)
+{
+	unsigned int ctimens = 0;
+	uint32_t stat, stat_crc;
+
+	stat = htonl(ce->ce_stat_data.sd_ctime.sec);
+	stat_crc = crc32(0, (Bytef*)&stat, 4);
+#ifdef USE_NSEC
+	ctimens = ce->ce_stat_data.sd_ctime.nsec;
+#endif
+	stat = htonl(ctimens);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	stat = htonl(ce->ce_stat_data.sd_ino);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	stat = htonl(ce->ce_stat_data.sd_dev);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	stat = htonl(ce->ce_stat_data.sd_uid);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	stat = htonl(ce->ce_stat_data.sd_gid);
+	stat_crc = crc32(stat_crc, (Bytef*)&stat, 4);
+	return stat_crc;
+}
+
 /*
  * This only updates the "non-critical" parts of the directory
  * cache, ie the parts that aren't tracked by GIT, and only used
@@ -122,6 +145,8 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 
 	if (S_ISREG(st->st_mode))
 		ce_mark_uptodate(ce);
+
+	ce->ce_stat_crc = calculate_stat_crc(ce);
 }
 
 static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
-- 
1.8.3.453.g1dfc63d
