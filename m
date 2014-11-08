From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/22] untracked cache: load from UNTR index extension
Date: Sat,  8 Nov 2014 16:39:43 +0700
Message-ID: <1415439595-469-11-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 10:40:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn2Vm-000157-TE
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 10:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbaKHJkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 04:40:43 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:62439 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbaKHJkl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 04:40:41 -0500
Received: by mail-pd0-f182.google.com with SMTP id fp1so4731542pdb.41
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 01:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=utqZvTbHP3Wcadf3m49Ks+KC5hm9H8MKa0caW7CeD8E=;
        b=SKAySxZMMQKo05QV7rHoP9Dis2tW8vvMNtRZFQ5TBiWY65AKYgiXCZiWNU+KMatQZw
         rVAmx7giv4krO/wUQwLbXtwmnQXVHo9gWO8vGQj/UmQVoy79EEpYOHp8B/sInj3CyN6w
         H2H167bcwYveQpgSXSofMt+DdGRoDdkpUM7lhcvj6O9Cy9c8A4BJSDMBEstgbeHc2DzO
         LJv6PdrFW4XwSUlBG9P6j+RdRWJK30uxwyKimsjd4iAYVtpgLpQeofBQbORlPDxrRg2k
         8BQvX2enYBd34DF2kegxkQ7R0K1PgZqUGjodwt8q3sHBOagEGMBnNkdvP8v7mIQJUOaR
         0miA==
X-Received: by 10.68.110.69 with SMTP id hy5mr17733843pbb.121.1415439640731;
        Sat, 08 Nov 2014 01:40:40 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id hb6sm11015195pbc.31.2014.11.08.01.40.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 01:40:40 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Nov 2014 16:40:54 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415439595-469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c        | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 dir.h        |   2 +
 read-cache.c |   5 +++
 3 files changed, 142 insertions(+)

diff --git a/dir.c b/dir.c
index 4e15f20..bc196b3 100644
--- a/dir.c
+++ b/dir.c
@@ -2223,3 +2223,138 @@ void write_untracked_extension(struct strbuf *o=
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
+static void load_sha1_stat(struct sha1_stat *sha1_stat,
+			   const struct stat_data *stat,
+			   const unsigned char *sha1)
+{
+	stat_data_from_disk(&sha1_stat->stat, stat);
+	hashcpy(sha1_stat->sha1, sha1);
+	sha1_stat->valid =3D 1;
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
+	load_sha1_stat(&uc->ss_info_exclude, &ouc->info_exclude_stat,
+		       ouc->info_exclude_sha1);
+	load_sha1_stat(&uc->ss_excludes_file, &ouc->excludes_file_stat,
+		       ouc->excludes_file_sha1);
+	uc->dir_flags =3D get_be32(&ouc->dir_flags);
+	uc->exclude_per_dir =3D xstrdup(ouc->exclude_per_dir);
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
index c771057..14ee4fd 100644
--- a/dir.h
+++ b/dir.h
@@ -298,5 +298,7 @@ static inline int dir_path_match(const struct dir_e=
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
index 26e938d..f5bd174 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1366,6 +1366,9 @@ static int read_index_extension(struct index_stat=
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
@@ -1631,6 +1634,8 @@ int discard_index(struct index_state *istate)
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
