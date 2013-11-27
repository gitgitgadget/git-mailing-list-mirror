From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 11/24] read-cache: make in-memory format aware of stat_crc
Date: Wed, 27 Nov 2013 13:00:46 +0100
Message-ID: <1385553659-9928-12-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:02:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vldoo-0001z0-TO
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169Ab3K0MCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:02:05 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:57291 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161Ab3K0MCA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:02:00 -0500
Received: by mail-la0-f54.google.com with SMTP id hp15so3385166lab.27
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zRCAHD4qLoXX47R903FQ5gaJHnsMDqBtxOnY5ruq6dc=;
        b=gjGzQFO00pOJnfM2bAOkX1nEEdyARSHzsHAgjYsnO+w7W21Y4gY2HLnsY5dhatvdor
         t16PlaFwoCzmI0VUKcqkdSs1JJ6+ULbXS7VfTpyef7LSlYQYiTnHnL8/S28il+mYwUmF
         Y2362n0aXja0bSSkI4v8HGbXEgE1SaRokVGkoxKp1+zKdQmj0r0Vc/ux6NPCVmz9bAvL
         vrT3q2HERFo5OngrlHik1h2fEV1+2Pn+3SDPa4GVG/Xgif+hGxYAm2eXVX924IpACtk9
         8Brl//UnQUUFiH+GiXzGiezC40cslQQJDAmzt9CQDd11Dk4VcCqPeviYgOR7mir6Y88m
         xDXQ==
X-Received: by 10.152.22.4 with SMTP id z4mr29487155lae.14.1385553719336;
        Wed, 27 Nov 2013 04:01:59 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id c8sm1272090lag.3.2013.11.27.04.01.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:01:58 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238425>

Make the in-memory format aware of the stat_crc used by index-v5.
It is simply ignored by index version prior to v5.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h      |  1 +
 read-cache.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/cache.h b/cache.h
index 38d57e7..8c2ccc4 100644
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
index 7020f26..baa052c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -106,6 +106,29 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
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
@@ -120,6 +143,8 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 
 	if (S_ISREG(st->st_mode))
 		ce_mark_uptodate(ce);
+
+	ce->ce_stat_crc = calculate_stat_crc(ce);
 }
 
 static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
-- 
1.8.4.2
