From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/20] untracked cache: save to an index extension
Date: Wed,  7 May 2014 21:51:51 +0700
Message-ID: <1399474320-6840-12-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:53:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3Di-00067n-3R
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285AbaEGOxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:53:05 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43285 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbaEGOxC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:53:02 -0400
Received: by mail-pa0-f46.google.com with SMTP id kx10so1267395pab.19
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aEDJS5jLDgMyaEuGIkLPBIixlE9tlOnSgEas4sA7st4=;
        b=CCROSJVGTQpe6XnTBsHrof33ns/oTZym62p5N/6+XxXgXfANqrIq/K+bqU1W7Tb0gk
         2ltF7xRbL3bIU6/xoOBLDeZxXNGuDb57QYqJcNypMxW1T0kw169fVlOJakYu9PgGbD2P
         D1oeM5JektIROjoHiZ3sYIR9j0Nt7ryocTVx9g5HF5WUolpeEp6rcBDXB/bYtfUPkGC2
         LO65x4A+VZPjLZF28AMY+ZouunfMsJ9yBczSOE9meznXF7/wlBIQ17fzeyd3fOxb8ZKV
         fMjiBRDjlnq3/QoaZrRKPiOBwrBkpBTo62VYot4xDCU8ZPPxGyLaPy5YKcIZdZJM/7Es
         YXsA==
X-Received: by 10.66.233.9 with SMTP id ts9mr19881924pac.37.1399474382353;
        Wed, 07 May 2014 07:53:02 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id op3sm3651538pbc.40.2014.05.07.07.52.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:53:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:53:02 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248317>

FIXME: save check_only
---
 cache.h      |  3 ++
 dir.c        | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 dir.h        |  1 +
 read-cache.c | 12 ++++++++
 4 files changed, 107 insertions(+)

diff --git a/cache.h b/cache.h
index 107ac61..06fcb6b 100644
--- a/cache.h
+++ b/cache.h
@@ -268,6 +268,8 @@ static inline unsigned int canon_mode(unsigned int mode)
 
 #define cache_entry_size(len) (offsetof(struct cache_entry,name) + (len) + 1)
 
+
+struct untracked_cache;
 struct index_state {
 	struct cache_entry **cache;
 	unsigned int version;
@@ -279,6 +281,7 @@ struct index_state {
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
+	struct untracked_cache *untracked;
 };
 
 extern struct index_state the_index;
diff --git a/dir.c b/dir.c
index b5bfda8..b7d394a 100644
--- a/dir.c
+++ b/dir.c
@@ -12,6 +12,7 @@
 #include "refs.h"
 #include "wildmatch.h"
 #include "pathspec.h"
+#include "varint.h"
 
 struct path_simplify {
 	int len;
@@ -2165,3 +2166,93 @@ void clear_directory(struct dir_struct *dir)
 	}
 	strbuf_release(&dir->basebuf);
 }
+
+struct ondisk_untracked_cache {
+	struct stat_data info_exclude_stat;
+	struct stat_data excludes_file_stat;
+	uint32_t dir_flags;
+	unsigned char info_exclude_sha1[20];
+	unsigned char excludes_file_sha1[20];
+	char exclude_per_dir[1];
+};
+
+static void stat_data_to_disk(struct stat_data *to, const struct stat_data *from)
+{
+	to->sd_ctime.sec  = htonl(from->sd_ctime.sec);
+	to->sd_ctime.nsec = htonl(from->sd_ctime.nsec);
+	to->sd_mtime.sec  = htonl(from->sd_mtime.sec);
+	to->sd_mtime.nsec = htonl(from->sd_mtime.nsec);
+	to->sd_dev	  = htonl(from->sd_dev);
+	to->sd_ino	  = htonl(from->sd_ino);
+	to->sd_uid	  = htonl(from->sd_uid);
+	to->sd_gid	  = htonl(from->sd_gid);
+	to->sd_size	  = htonl(from->sd_size);
+}
+
+static void write_one_dir(struct strbuf *out, struct untracked_cache_dir *untracked)
+{
+	struct stat_data stat_data;
+	unsigned char intbuf[16];
+	unsigned int intlen, value;
+	int i;
+
+	stat_data_to_disk(&stat_data, &untracked->stat_data);
+	strbuf_add(out, &stat_data, sizeof(stat_data));
+	strbuf_add(out, untracked->exclude_sha1, 20);
+
+	/*
+	 * untracked_nr should be reset whenever valid is clear, but
+	 * for safety..
+	 */
+	if (!untracked->valid) {
+		untracked->untracked_nr = 0;
+		untracked->check_only = 0;
+	}
+
+	/*
+	 * encode_varint does not deal with signed integers. Use the
+	 * lowest bit to store the sign.
+	 */
+	value = untracked->untracked_nr << 2;
+	if (untracked->valid)
+		value |= 1;
+	if (untracked->check_only)
+		value |= 2;
+	intlen = encode_varint(value, intbuf);
+	strbuf_add(out, intbuf, intlen);
+
+	/* skip non-recurse directories */
+	for (i = 0, value = 0; i < untracked->dirs_nr; i++)
+		if (untracked->dirs[i]->recurse)
+			value++;
+	intlen = encode_varint(value, intbuf);
+	strbuf_add(out, intbuf, intlen);
+
+	strbuf_add(out, untracked->name, strlen(untracked->name) + 1);
+
+	for (i = 0; i < untracked->untracked_nr; i++)
+		strbuf_add(out, untracked->untracked[i],
+			   strlen(untracked->untracked[i]) + 1);
+
+	for (i = 0; i < untracked->dirs_nr; i++)
+		if (untracked->dirs[i]->recurse)
+			write_one_dir(out, untracked->dirs[i]);
+}
+
+void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked)
+{
+	struct ondisk_untracked_cache *ouc;
+	int len = 0;
+	if (untracked->exclude_per_dir)
+		len = strlen(untracked->exclude_per_dir);
+	ouc = xmalloc(sizeof(*ouc) + len);
+	stat_data_to_disk(&ouc->info_exclude_stat, &untracked->info_exclude_stat);
+	stat_data_to_disk(&ouc->excludes_file_stat, &untracked->excludes_file_stat);
+	hashcpy(ouc->info_exclude_sha1, untracked->info_exclude_sha1);
+	hashcpy(ouc->excludes_file_sha1, untracked->excludes_file_sha1);
+	ouc->dir_flags = htonl(untracked->dir_flags);
+	memcpy(ouc->exclude_per_dir, untracked->exclude_per_dir, len + 1);
+	strbuf_add(out, ouc, sizeof(*ouc) + len);
+	if (untracked->root)
+		write_one_dir(out, untracked->root);
+}
diff --git a/dir.h b/dir.h
index 5dde37b..e520d58 100644
--- a/dir.h
+++ b/dir.h
@@ -295,4 +295,5 @@ static inline int dir_path_match(const struct dir_entry *ent,
 			      has_trailing_dir);
 }
 
+void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 #endif
diff --git a/read-cache.c b/read-cache.c
index ba13353..a619666 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -34,6 +34,7 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
 #define CACHE_EXT_TREE 0x54524545	/* "TREE" */
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
+#define CACHE_EXT_UNTRACKED 0x554E5452	  /* "UNTR" */
 
 struct index_state the_index;
 
@@ -1869,6 +1870,17 @@ int write_index(struct index_state *istate, int newfd)
 		if (err)
 			return -1;
 	}
+	if (istate->untracked) {
+		struct strbuf sb = STRBUF_INIT;
+
+		write_untracked_extension(&sb, istate->untracked);
+		err = write_index_ext_header(&c, newfd, CACHE_EXT_UNTRACKED,
+					     sb.len) < 0 ||
+			ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
 
 	if (ce_flush(&c, newfd) || fstat(newfd, &st))
 		return -1;
-- 
1.9.1.346.ga2b5940
