From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/22] untracked cache: save to an index extension
Date: Sat,  8 Nov 2014 16:39:42 +0700
Message-ID: <1415439595-469-10-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 10:40:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn2Vi-0000yp-LP
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 10:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbaKHJkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 04:40:39 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:37631 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbaKHJkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 04:40:36 -0500
Received: by mail-pd0-f174.google.com with SMTP id p10so4758970pdj.5
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 01:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RqSR274gNkAUokjoAYHgX+UVHF626g9oJMb7ziozhrs=;
        b=R/eG23jtAlO4nsqzaa62CvJhGMbnZOlHgp3uoh9jzAXsx3WR1iAfjXFbe2Tjr2JsKH
         JVZZMlxyfKQSM8tFCstPNlybHAIgTjAa6J5vY9u5cUag0nTWwktTR+qfa1tNGQdYI03x
         mp8sP62mGEOVFCXEk9vXC7niu2P3woCMNum7vfxYNfFjzImzoWjTPCqgw406YTDfjWMb
         hv8/mIQWi3UtSdBfhvTOLez/mQ0iZrelzE3NMKBWR5AfCse5NPKMFoO5i01bFijO+Cab
         lffDbfv8H6+NIfRCYzF9HxqtECfOzCm0y5Awqz0ZmrdgnbHC7jEP19jmevvKijOrxkhu
         YwWQ==
X-Received: by 10.68.98.99 with SMTP id eh3mr18389134pbb.64.1415439635691;
        Sat, 08 Nov 2014 01:40:35 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id q7sm8994898pdm.37.2014.11.08.01.40.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 01:40:35 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Nov 2014 16:40:49 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415439595-469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      |  3 +++
 dir.c        | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 dir.h        |  1 +
 read-cache.c | 12 +++++++++
 4 files changed, 101 insertions(+)

diff --git a/cache.h b/cache.h
index dcf3a2a..b14d6e2 100644
--- a/cache.h
+++ b/cache.h
@@ -297,6 +297,8 @@ static inline unsigned int canon_mode(unsigned int =
mode)
 #define SPLIT_INDEX_ORDERED	(1 << 6)
=20
 struct split_index;
+struct untracked_cache;
+
 struct index_state {
 	struct cache_entry **cache;
 	unsigned int version;
@@ -310,6 +312,7 @@ struct index_state {
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
 	unsigned char sha1[20];
+	struct untracked_cache *untracked;
 };
=20
 extern struct index_state the_index;
diff --git a/dir.c b/dir.c
index 5936c84..4e15f20 100644
--- a/dir.c
+++ b/dir.c
@@ -12,6 +12,7 @@
 #include "refs.h"
 #include "wildmatch.h"
 #include "pathspec.h"
+#include "varint.h"
=20
 struct path_simplify {
 	int len;
@@ -2138,3 +2139,87 @@ void clear_directory(struct dir_struct *dir)
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
+static void stat_data_to_disk(struct stat_data *to, const struct stat_=
data *from)
+{
+	to->sd_ctime.sec  =3D htonl(from->sd_ctime.sec);
+	to->sd_ctime.nsec =3D htonl(from->sd_ctime.nsec);
+	to->sd_mtime.sec  =3D htonl(from->sd_mtime.sec);
+	to->sd_mtime.nsec =3D htonl(from->sd_mtime.nsec);
+	to->sd_dev	  =3D htonl(from->sd_dev);
+	to->sd_ino	  =3D htonl(from->sd_ino);
+	to->sd_uid	  =3D htonl(from->sd_uid);
+	to->sd_gid	  =3D htonl(from->sd_gid);
+	to->sd_size	  =3D htonl(from->sd_size);
+}
+
+static void write_one_dir(struct strbuf *out, struct untracked_cache_d=
ir *untracked)
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
+		untracked->untracked_nr =3D 0;
+		untracked->check_only =3D 0;
+	}
+
+	value  =3D untracked->valid;
+	value |=3D untracked->check_only   << 1;
+	value |=3D untracked->untracked_nr << 2;
+	intlen =3D encode_varint(value, intbuf);
+	strbuf_add(out, intbuf, intlen);
+
+	/* skip non-recurse directories */
+	for (i =3D 0, value =3D 0; i < untracked->dirs_nr; i++)
+		if (untracked->dirs[i]->recurse)
+			value++;
+	intlen =3D encode_varint(value, intbuf);
+	strbuf_add(out, intbuf, intlen);
+
+	strbuf_add(out, untracked->name, strlen(untracked->name) + 1);
+
+	for (i =3D 0; i < untracked->untracked_nr; i++)
+		strbuf_add(out, untracked->untracked[i],
+			   strlen(untracked->untracked[i]) + 1);
+
+	for (i =3D 0; i < untracked->dirs_nr; i++)
+		if (untracked->dirs[i]->recurse)
+			write_one_dir(out, untracked->dirs[i]);
+}
+
+void write_untracked_extension(struct strbuf *out, struct untracked_ca=
che *untracked)
+{
+	struct ondisk_untracked_cache *ouc;
+	int len =3D 0;
+	if (untracked->exclude_per_dir)
+		len =3D strlen(untracked->exclude_per_dir);
+	ouc =3D xmalloc(sizeof(*ouc) + len);
+	stat_data_to_disk(&ouc->info_exclude_stat, &untracked->ss_info_exclud=
e.stat);
+	stat_data_to_disk(&ouc->excludes_file_stat, &untracked->ss_excludes_f=
ile.stat);
+	hashcpy(ouc->info_exclude_sha1, untracked->ss_info_exclude.sha1);
+	hashcpy(ouc->excludes_file_sha1, untracked->ss_excludes_file.sha1);
+	ouc->dir_flags =3D htonl(untracked->dir_flags);
+	memcpy(ouc->exclude_per_dir, untracked->exclude_per_dir, len + 1);
+	strbuf_add(out, ouc, sizeof(*ouc) + len);
+	if (untracked->root)
+		write_one_dir(out, untracked->root);
+}
diff --git a/dir.h b/dir.h
index 5c688da..c771057 100644
--- a/dir.h
+++ b/dir.h
@@ -298,4 +298,5 @@ static inline int dir_path_match(const struct dir_e=
ntry *ent,
 			      has_trailing_dir);
 }
=20
+void write_untracked_extension(struct strbuf *out, struct untracked_ca=
che *untracked);
 #endif
diff --git a/read-cache.c b/read-cache.c
index 6f0057f..26e938d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -37,6 +37,7 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce,
 #define CACHE_EXT_TREE 0x54524545	/* "TREE" */
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
 #define CACHE_EXT_LINK 0x6c696e6b	  /* "link" */
+#define CACHE_EXT_UNTRACKED 0x554E5452	  /* "UNTR" */
=20
 /* changes that can be kept in $GIT_DIR/index (basically all extension=
s) */
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
@@ -2016,6 +2017,17 @@ static int do_write_index(struct index_state *is=
tate, int newfd,
 		if (err)
 			return -1;
 	}
+	if (istate->untracked) {
+		struct strbuf sb =3D STRBUF_INIT;
+
+		write_untracked_extension(&sb, istate->untracked);
+		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_UNTRACKED,
+					     sb.len) < 0 ||
+			ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
=20
 	if (ce_flush(&c, newfd, istate->sha1) || fstat(newfd, &st))
 		return -1;
--=20
2.1.0.rc0.78.gc0d8480
