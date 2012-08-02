From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 08/16] Make in-memory format aware of stat_crc
Date: Thu,  2 Aug 2012 13:01:58 +0200
Message-ID: <1343905326-23790-9-git-send-email-t.gummerer@gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 13:03:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwtBq-0005Lo-4k
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 13:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615Ab2HBLDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 07:03:09 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44602 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602Ab2HBLDD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 07:03:03 -0400
Received: by mail-ee0-f46.google.com with SMTP id l10so2331146eei.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 04:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=b1SeMJmwgWAAOcIBvEdtlGRudz/ewUBvIK0B0VKcXDo=;
        b=0BHvkZC/uzHHg+GbPKBzmyfW1GZyom0KWt44XOKPqHFfBYjX1UYuXwE7PmtNmwNQda
         8hm+9q/bn2pn5p171tmKnRK6puMsOXNjy1gEhrSv6zXF/6DtRMBFyQkLnXi6snrULJ/A
         Z7ZAIGZIPN2Blu6tPJ1QnNdlOI12S8uCY/GBqQju4nwvCzR71un7PtHIOOnnm18d0dj7
         PlIQXCI8tu58s8SDHSqDut+ywwJfTPrAAyRAJj4sIBcUjaPXPQ7R55VNVKmBWKXfT9+s
         E2lcRS0a1XP1gITIJo7wZTI6vUUNs0dQiLsnTkGMdyt3HMwX6tHQIo83oFho9ApDTmQQ
         uNcg==
Received: by 10.14.216.198 with SMTP id g46mr19016000eep.32.1343905382855;
        Thu, 02 Aug 2012 04:03:02 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id d48sm16418739eeo.10.2012.08.02.04.03.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 04:03:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.886.gdf6792c.dirty
In-Reply-To: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202761>

Make the in-memory format aware of the stat_crc used by index-v5.
It is simply ignored by index version prior to v5.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h      |  1 +
 read-cache.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/cache.h b/cache.h
index 3aa70d8..7247944 100644
--- a/cache.h
+++ b/cache.h
@@ -133,6 +133,7 @@ struct cache_entry {
 	unsigned int ce_flags;
 	unsigned int ce_namelen;
 	unsigned char sha1[20];
+	uint32_t ce_stat_crc;
 	struct cache_entry *next;
 	struct cache_entry *dir_next;
 	char name[FLEX_ARRAY]; /* more */
diff --git a/read-cache.c b/read-cache.c
index 1c804e1..dfe5ee2 100644
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
1.7.10.886.gdf6792c.dirty
