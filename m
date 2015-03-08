From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/24] untracked cache: load from UNTR index extension
Date: Sun,  8 Mar 2015 17:12:34 +0700
Message-ID: <1425809567-25518-12-git-send-email-pclouds@gmail.com>
References: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 11:14:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYDw-0003NP-HW
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbbCHKOM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 06:14:12 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36389 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbbCHKOK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:14:10 -0400
Received: by pdbnh10 with SMTP id nh10so63849718pdb.3
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VKFFWuiX2YB05OL4UmTiRbWVrxYNTdfIOR9fH4rHuhA=;
        b=mPq/9lF/2n1Pm2USwZ9SteregDikXN/+EdX/x7UIMgW+7e+WzTRNRRd2Hs9ozlJRej
         P11nzzhmhnaBzuBOCNqCzJSWjhH8O2CNCrK++ImyLkcp93WeSY7ZH5lCktyf/gLj8JJQ
         Hqe/KOZa+gDqwK0KlNMgQqVw7PwtlwDQ6W4CMqZYeN0dlZlCJ+qHtHhUmBWChccyYEiH
         5EttzLFJXExYF72kWzO08RUmHhamY763GH9EjzgsXRnf87doNi2CZawmIHFJF3ucGddf
         onhy2rkH+4759mhfsx/Wr4v+kxkD5C5/7IZujjwZhdE2vHhJWxcCeQaiT/mj0NKIBasA
         QGCQ==
X-Received: by 10.70.131.227 with SMTP id op3mr236196pdb.12.1425809650360;
        Sun, 08 Mar 2015 03:14:10 -0700 (PDT)
Received: from lanh ([115.73.247.162])
        by mx.google.com with ESMTPSA id sf7sm14396563pbc.29.2015.03.08.03.14.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:14:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Mar 2015 17:14:06 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265065>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c        | 219 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 dir.h        |   2 +
 read-cache.c |   5 ++
 3 files changed, 226 insertions(+)

diff --git a/dir.c b/dir.c
index 8f0deb1..0b37c65 100644
--- a/dir.c
+++ b/dir.c
@@ -2279,3 +2279,222 @@ void write_untracked_extension(struct strbuf *o=
ut, struct untracked_cache *untra
 	strbuf_release(&wd.sb_stat);
 	strbuf_release(&wd.sb_sha1);
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
+struct read_data {
+	int index;
+	struct untracked_cache_dir **ucd;
+	struct ewah_bitmap *check_only;
+	struct ewah_bitmap *valid;
+	struct ewah_bitmap *sha1_valid;
+	const unsigned char *data;
+	const unsigned char *end;
+};
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
+			struct read_data *rd)
+{
+	struct untracked_cache_dir ud, *untracked;
+	const unsigned char *next, *data =3D rd->data, *end =3D rd->end;
+	unsigned int value;
+	int i, len;
+
+	memset(&ud, 0, sizeof(ud));
+
+	next =3D data;
+	value =3D decode_varint(&next);
+	if (next > end)
+		return -1;
+	ud.recurse	   =3D 1;
+	ud.untracked_alloc =3D value;
+	ud.untracked_nr	   =3D value;
+	if (ud.untracked_nr)
+		ud.untracked =3D xmalloc(sizeof(*ud.untracked) * ud.untracked_nr);
+	data =3D next;
+
+	next =3D data;
+	ud.dirs_alloc =3D ud.dirs_nr =3D decode_varint(&next);
+	if (next > end)
+		return -1;
+	ud.dirs =3D xmalloc(sizeof(*ud.dirs) * ud.dirs_nr);
+	data =3D next;
+
+	len =3D strlen((const char *)data);
+	next =3D data + len + 1;
+	if (next > rd->end)
+		return -1;
+	*untracked_ =3D untracked =3D xmalloc(sizeof(*untracked) + len);
+	memcpy(untracked, &ud, sizeof(ud));
+	memcpy(untracked->name, data, len + 1);
+	data =3D next;
+
+	for (i =3D 0; i < untracked->untracked_nr; i++) {
+		len =3D strlen((const char *)data);
+		next =3D data + len + 1;
+		if (next > rd->end)
+			return -1;
+		untracked->untracked[i] =3D xstrdup((const char*)data);
+		data =3D next;
+	}
+
+	rd->ucd[rd->index++] =3D untracked;
+	rd->data =3D data;
+
+	for (i =3D 0; i < untracked->dirs_nr; i++) {
+		len =3D read_one_dir(untracked->dirs + i, rd);
+		if (len < 0)
+			return -1;
+	}
+	return 0;
+}
+
+static void set_check_only(size_t pos, void *cb)
+{
+	struct read_data *rd =3D cb;
+	struct untracked_cache_dir *ud =3D rd->ucd[pos];
+	ud->check_only =3D 1;
+}
+
+static void read_stat(size_t pos, void *cb)
+{
+	struct read_data *rd =3D cb;
+	struct untracked_cache_dir *ud =3D rd->ucd[pos];
+	if (rd->data + sizeof(struct stat_data) > rd->end) {
+		rd->data =3D rd->end + 1;
+		return;
+	}
+	stat_data_from_disk(&ud->stat_data, (struct stat_data *)rd->data);
+	rd->data +=3D sizeof(struct stat_data);
+	ud->valid =3D 1;
+}
+
+static void read_sha1(size_t pos, void *cb)
+{
+	struct read_data *rd =3D cb;
+	struct untracked_cache_dir *ud =3D rd->ucd[pos];
+	if (rd->data + 20 > rd->end) {
+		rd->data =3D rd->end + 1;
+		return;
+	}
+	hashcpy(ud->exclude_sha1, rd->data);
+	rd->data +=3D 20;
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
+	const struct ondisk_untracked_cache *ouc;
+	struct untracked_cache *uc;
+	struct read_data rd;
+	const unsigned char *next =3D data, *end =3D (const unsigned char *)d=
ata + sz;
+	int len;
+
+	if (sz <=3D 1 || end[-1] !=3D '\0')
+		return NULL;
+	end--;
+
+	ouc =3D (const struct ondisk_untracked_cache *)next;
+	if (next + ouc_size(0) > end)
+		return NULL;
+
+	uc =3D xcalloc(1, sizeof(*uc));
+	load_sha1_stat(&uc->ss_info_exclude, &ouc->info_exclude_stat,
+		       ouc->info_exclude_sha1);
+	load_sha1_stat(&uc->ss_excludes_file, &ouc->excludes_file_stat,
+		       ouc->excludes_file_sha1);
+	uc->dir_flags =3D get_be32(&ouc->dir_flags);
+	uc->exclude_per_dir =3D xstrdup(ouc->exclude_per_dir);
+	/* NUL after exclude_per_dir is covered by sizeof(*ouc) */
+	next +=3D ouc_size(strlen(ouc->exclude_per_dir));
+	if (next >=3D end)
+		goto done2;
+
+	len =3D decode_varint(&next);
+	if (next > end || len =3D=3D 0)
+		goto done2;
+
+	rd.valid      =3D ewah_new();
+	rd.check_only =3D ewah_new();
+	rd.sha1_valid =3D ewah_new();
+	rd.data	      =3D next;
+	rd.end	      =3D end;
+	rd.index      =3D 0;
+	rd.ucd        =3D xmalloc(sizeof(*rd.ucd) * len);
+
+	if (read_one_dir(&uc->root, &rd) || rd.index !=3D len)
+		goto done;
+
+	next =3D rd.data;
+	len =3D ewah_read_mmap(rd.valid, next, end - next);
+	if (len < 0)
+		goto done;
+
+	next +=3D len;
+	len =3D ewah_read_mmap(rd.check_only, next, end - next);
+	if (len < 0)
+		goto done;
+
+	next +=3D len;
+	len =3D ewah_read_mmap(rd.sha1_valid, next, end - next);
+	if (len < 0)
+		goto done;
+
+	ewah_each_bit(rd.check_only, set_check_only, &rd);
+	rd.data =3D next + len;
+	ewah_each_bit(rd.valid, read_stat, &rd);
+	ewah_each_bit(rd.sha1_valid, read_sha1, &rd);
+	next =3D rd.data;
+
+done:
+	free(rd.ucd);
+	ewah_free(rd.valid);
+	ewah_free(rd.check_only);
+	ewah_free(rd.sha1_valid);
+done2:
+	if (next !=3D end) {
+		free_untracked_cache(uc);
+		uc =3D NULL;
+	}
+	return uc;
+}
diff --git a/dir.h b/dir.h
index dc3ee0b..40a679a 100644
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
index baf3057..3736a56 100644
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
2.3.0.rc1.137.g477eb31
