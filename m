From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 14/24] read-cache: make in-memory format aware of stat_crc
Date: Sun, 18 Aug 2013 21:42:03 +0200
Message-ID: <1376854933-31241-15-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:48:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8y7-000434-Sg
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909Ab3HRTsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:48:52 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:63758 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107Ab3HRTsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:48:50 -0400
Received: by mail-we0-f179.google.com with SMTP id t57so3208745wes.10
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FWVBp8rd6uwgZMCntiyM8DCG+NTiqQ1B8mXqTw7us7M=;
        b=VHqNwOGWSLgWtcgHR26eBqYeQtO9huPfAEFPVHeZel8PKyaBf/A7sSfv/fVTef6bmO
         +QY8G9P6wDIqBS7UoeEaYdLw8Iqqr6qKaGsNesvg/J5P8ftjJg81ZmSpm8XJIKpeUxH1
         LWnGvVuIp2B0RxIEGZPVHkkwHAP2HlbBmfbbDa0OyCpGWTfY3pI+ONzvAkhKQyagDv8U
         ZKDHXwvVML+glzKFoORwQbpymmhKxV1LGl2Qe5d2XCLNW6Z7vnjVhzVo/SN8axZnvqNL
         XJS1VUXFr4xTJ5Ty65HTb4kc4ixOepSqBNWa/Uf89GkTcf6cZ3aW2i6dTIk1643nyCPQ
         zARw==
X-Received: by 10.180.84.225 with SMTP id c1mr5502820wiz.53.1376855329824;
        Sun, 18 Aug 2013 12:48:49 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id ff5sm6919245wib.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232501>

Make the in-memory format aware of the stat_crc used by index-v5.
It is simply ignored by index version prior to v5.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h      |  1 +
 read-cache.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/cache.h b/cache.h
index da224c9..714a334 100644
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
index 7a27f9b..a232372 100644
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
1.8.3.4.1231.g9fbf354.dirty
