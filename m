From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v4 05/13] Make in-memory format aware of stat_crc
Date: Thu, 16 Aug 2012 11:58:41 +0200
Message-ID: <1345111129-6925-6-git-send-email-t.gummerer@gmail.com>
References: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, pclouds@gmail.com, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 11:59:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1wrs-0000D2-MH
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 11:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756599Ab2HPJ7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 05:59:49 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:48203 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756209Ab2HPJ7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 05:59:14 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id 5986C4EF70; Thu, 16 Aug 2012 11:59:09 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the in-memory format aware of the stat_crc used by index-v5.
It is simply ignored by index version prior to v5.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h      |  1 +
 read-cache.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/cache.h b/cache.h
index c77cdbe..bfe3099 100644
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
index cdd8480..9d2bd62 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -51,6 +51,29 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
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
@@ -73,6 +96,8 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 
 	if (S_ISREG(st->st_mode))
 		ce_mark_uptodate(ce);
+
+	ce->ce_stat_crc = calculate_stat_crc(ce);
 }
 
 static int ce_compare_data(struct cache_entry *ce, struct stat *st)
-- 
1.7.11.2
