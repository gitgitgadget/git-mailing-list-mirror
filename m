From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 11/19] read-cache: make in-memory format aware of stat_crc
Date: Fri, 12 Jul 2013 19:26:56 +0200
Message-ID: <1373650024-3001-12-git-send-email-t.gummerer@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:30:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxhAq-0004k2-AS
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173Ab3GLRaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:30:22 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36237 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964904Ab3GLRaV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:30:21 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so9096583pab.39
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hsqVIyuGkFlSlwiKWZ+rPPxonVOvrcKLJBwRU9ta3fs=;
        b=uojudd9InQoIbdSY0nkJFIb9EU6gzKcIEfbIT9rWGEH5DiJ/VMlgOtESrnUGK8pqM/
         kODIMcZ+CmyPjVD5Di/kEZaxv1wXNiiIs00m6LT2bAuhlw4Egpdzu8wRDqvGGVbht8hS
         dAdL87mDStbSI6JCA0Ht+U0+gIf5wvnvC+8dNKiq6i7drR66hBuK7pYN5VMloGCMHZtA
         vfLMq/gYb5RIUDhrBUZ3OXGD/doLtkXnGTNhg+mnbSKgzl1RNCdUpf0row/Ugzr7L0xT
         l8KLrL6k3zfvMPYhtBCarWkU2Y8A/SCsUjEzvFVFc/SpbjdPueb+umuiH6d4VyjBJqa/
         kPww==
X-Received: by 10.68.12.165 with SMTP id z5mr42296217pbb.172.1373650220708;
        Fri, 12 Jul 2013 10:30:20 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id zf3sm14547947pac.9.2013.07.12.10.30.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:30:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230223>

Make the in-memory format aware of the stat_crc used by index-v5.
It is simply ignored by index version prior to v5.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h      |  1 +
 read-cache.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/cache.h b/cache.h
index 455b772..2097105 100644
--- a/cache.h
+++ b/cache.h
@@ -127,6 +127,7 @@ struct cache_entry {
 	unsigned int ce_flags;
 	unsigned int ce_namelen;
 	unsigned char sha1[20];
+	uint32_t ce_stat_crc;
 	struct cache_entry *next; /* used by name_hash */
 	char name[FLEX_ARRAY]; /* more */
 };
diff --git a/read-cache.c b/read-cache.c
index ab716ed..9bfbb4f 100644
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
