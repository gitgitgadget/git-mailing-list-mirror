From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/19] untracked cache: load from UNTR index extension
Date: Mon, 27 Oct 2014 19:10:37 +0700
Message-ID: <1414411846-4450-11-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 13:11:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xij9C-0002zL-RG
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbaJ0MLh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 08:11:37 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:58323 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbaJ0MLh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 08:11:37 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so5549541pde.4
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=q8i1ddBXhrLVvB+eNzWa5bSjEAxwL2kMDAb2qzgmfYA=;
        b=BxZhTrIviAKhKlK63ML7rcLXMpxlAiIGVR2Z27yO4UddwOwxXMWLqWC5JTgwyKO42s
         7aJKngq852BTnZRLhHT5V3dfBchqhJHf0EjKZ2Zd1vedghmUNqfeeGgZJvfYsvjFJRn1
         WtQT0D2vAZcYlTCBgMXMSCXYOauE1+qT5ZhUcDANsDgnQOX0rdMwyQqoruKQJ5e9wskm
         uE2fMrIJM+uVbh/1/bqoNaYsH8tu5oGgojONDOo5IAG4VyHH2kWgu6mF2e4McQxmM+ee
         QWd+SnORY1Gr215K3BqqbWaJ8R4vzYZ6u9OGYQljWAcZ2yu4mVSxjeXt2eaQzRwl0w1v
         bSDQ==
X-Received: by 10.66.251.194 with SMTP id zm2mr24174163pac.33.1414411896635;
        Mon, 27 Oct 2014 05:11:36 -0700 (PDT)
Received: from lanh ([115.73.192.230])
        by mx.google.com with ESMTPSA id w6sm2157568pbs.59.2014.10.27.05.11.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 05:11:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 Oct 2014 19:11:39 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c        | 147 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 dir.h        |   3 ++
 read-cache.c |   5 ++
 3 files changed, 151 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index d696388..c97b0c3 100644
--- a/dir.c
+++ b/dir.c
@@ -2085,15 +2085,27 @@ void setup_standard_excludes(struct dir_struct =
*dir)
 	}
 	if (!access_or_warn(path, R_OK, 0)) {
 		struct sha1_stat *ss =3D NULL;
-		if (dir->untracked)
+		int ss_valid =3D 0;
+		if (dir->untracked) {
 			ss =3D &dir->ss_info_exclude;
-		add_excludes_from_file_1(dir, path, ss, 0);
+			if (dir->untracked->loaded) {
+				*ss =3D dir->untracked->ss_info_exclude;
+				ss_valid =3D 1;
+			}
+		}
+		add_excludes_from_file_1(dir, path, ss, ss_valid);
 	}
 	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0)) {
 		struct sha1_stat *ss =3D NULL;
-		if (dir->untracked)
+		int ss_valid =3D 0;
+		if (dir->untracked) {
 			ss =3D &dir->ss_excludes_file;
-		add_excludes_from_file_1(dir, excludes_file, ss, 0);
+			if (dir->untracked->loaded) {
+				*ss =3D dir->untracked->ss_excludes_file;
+				ss_valid =3D 1;
+			}
+		}
+		add_excludes_from_file_1(dir, excludes_file, ss, ss_valid);
 	}
 }
=20
@@ -2230,3 +2242,130 @@ void write_untracked_extension(struct strbuf *o=
ut, struct untracked_cache *untra
 	if (untracked->root)
 		write_one_dir(out, untracked->root);
 }
+
+static void free_untracked(struct untracked_cache_dir *ucd)
+{
+	int i;
+	if (!ucd)
+		return;
+	for (i =3D 0; i < ucd->dirs_nr; i++)
+		free_untracked(ucd->dirs[i]);
+	for (i =3D 0; i < ucd->untracked_nr; i++)
+		free(ucd->untracked[i]);
+	free(ucd->untracked);
+	free(ucd->dirs);
+	free(ucd);
+}
+
+void free_untracked_cache(struct untracked_cache *uc)
+{
+	if (uc)
+		free_untracked(uc->root);
+	free(uc);
+}
+
+static void stat_data_from_disk(struct stat_data *to, const struct sta=
t_data *from)
+{
+	to->sd_ctime.sec  =3D get_be32(&from->sd_ctime.sec);
+	to->sd_ctime.nsec =3D get_be32(&from->sd_ctime.nsec);
+	to->sd_mtime.sec  =3D get_be32(&from->sd_mtime.sec);
+	to->sd_mtime.nsec =3D get_be32(&from->sd_mtime.nsec);
+	to->sd_dev	  =3D get_be32(&from->sd_dev);
+	to->sd_ino	  =3D get_be32(&from->sd_ino);
+	to->sd_uid	  =3D get_be32(&from->sd_uid);
+	to->sd_gid	  =3D get_be32(&from->sd_gid);
+	to->sd_size	  =3D get_be32(&from->sd_size);
+}
+
+static int read_one_dir(struct untracked_cache_dir **untracked_,
+			const unsigned char *data_, unsigned long sz)
+{
+#define NEXT(x) \
+	next =3D data + (x); \
+	if (next > data_ + sz) \
+		return -1;
+
+	struct untracked_cache_dir ud, *untracked;
+	const unsigned char *next, *data =3D data_;
+	unsigned int value;
+	int i, len;
+
+	memset(&ud, 0, sizeof(ud));
+
+	NEXT(sizeof(struct stat_data));
+	stat_data_from_disk(&ud.stat_data, (struct stat_data *)data);
+	data =3D next;
+
+	NEXT(20);
+	hashcpy(ud.exclude_sha1, data);
+	data =3D next;
+
+	next =3D data;
+	value =3D decode_varint(&next);
+	if (next > data_ + sz)
+		return -1;
+	ud.recurse =3D 1;
+	ud.valid =3D value & 1;
+	ud.check_only =3D (value >> 1) & 1;
+	ud.untracked_alloc =3D ud.untracked_nr =3D value >> 2;
+	if (ud.untracked_nr)
+		ud.untracked =3D xmalloc(sizeof(*ud.untracked) * ud.untracked_nr);
+	data =3D next;
+
+	next =3D data;
+	ud.dirs_alloc =3D ud.dirs_nr =3D decode_varint(&next);
+	if (next > data_ + sz)
+		return -1;
+	ud.dirs =3D xmalloc(sizeof(*ud.dirs) * ud.dirs_nr);
+	data =3D next;
+
+	len =3D strlen((const char *)data);
+	NEXT(len + 1);
+	*untracked_ =3D untracked =3D xmalloc(sizeof(*untracked) + len);
+	memcpy(untracked, &ud, sizeof(ud));
+	memcpy(untracked->name, data, len + 1);
+	data =3D next;
+
+	for (i =3D 0; i < untracked->untracked_nr; i++) {
+		len =3D strlen((const char *)data);
+		NEXT(len + 1);
+		untracked->untracked[i] =3D xstrdup((const char*)data);
+		data =3D next;
+	}
+
+	for (i =3D 0; i < untracked->dirs_nr; i++) {
+		len =3D read_one_dir(untracked->dirs + i, data, sz - (data - data_))=
;
+		if (len < 0)
+			return -1;
+		data +=3D len;
+	}
+	return data - data_;
+}
+
+struct untracked_cache *read_untracked_extension(const void *data, uns=
igned long sz)
+{
+	const struct ondisk_untracked_cache *ouc =3D data;
+	struct untracked_cache *uc;
+	int len;
+
+	if (sz < sizeof(*ouc))
+		return NULL;
+
+	uc =3D xcalloc(1, sizeof(*uc));
+	stat_data_from_disk(&uc->ss_info_exclude.stat, &ouc->info_exclude_sta=
t);
+	stat_data_from_disk(&uc->ss_excludes_file.stat, &ouc->excludes_file_s=
tat);
+	hashcpy(uc->ss_info_exclude.sha1, ouc->info_exclude_sha1);
+	hashcpy(uc->ss_excludes_file.sha1, ouc->excludes_file_sha1);
+	uc->dir_flags =3D get_be32(&ouc->dir_flags);
+	uc->exclude_per_dir =3D xstrdup(ouc->exclude_per_dir);
+	uc->loaded =3D 1;
+	len =3D sizeof(*ouc) + strlen(ouc->exclude_per_dir);
+	if (sz =3D=3D len)
+		return uc;
+	if (sz > len &&
+	    read_one_dir(&uc->root, (const unsigned char *)data + len,
+			 sz - len) =3D=3D sz - len)
+		return uc;
+	free_untracked_cache(uc);
+	return NULL;
+}
diff --git a/dir.h b/dir.h
index 7ef0f63..014f3ed 100644
--- a/dir.h
+++ b/dir.h
@@ -137,6 +137,7 @@ struct untracked_cache {
 	int gitignore_invalidated;
 	int dir_invalidated;
 	int dir_opened;
+	int loaded;
 };
=20
 struct dir_struct {
@@ -297,5 +298,7 @@ static inline int dir_path_match(const struct dir_e=
ntry *ent,
 			      has_trailing_dir);
 }
=20
+void free_untracked_cache(struct untracked_cache *);
+struct untracked_cache *read_untracked_extension(const void *data, uns=
igned long sz);
 void write_untracked_extension(struct strbuf *out, struct untracked_ca=
che *untracked);
 #endif
diff --git a/read-cache.c b/read-cache.c
index efff4e2..60baeaf 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1359,6 +1359,9 @@ static int read_index_extension(struct index_stat=
e *istate,
 		if (read_link_extension(istate, data, sz))
 			return -1;
 		break;
+	case CACHE_EXT_UNTRACKED:
+		istate->untracked =3D read_untracked_extension(data, sz);
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand=
",
@@ -1650,6 +1653,8 @@ int discard_index(struct index_state *istate)
 	istate->cache =3D NULL;
 	istate->cache_alloc =3D 0;
 	discard_split_index(istate);
+	free_untracked_cache(istate->untracked);
+	istate->untracked =3D NULL;
 	return 0;
 }
=20
--=20
2.1.0.rc0.78.gc0d8480
