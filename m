From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/24] untracked cache: load from UNTR index extension
Date: Sun,  8 Feb 2015 15:55:35 +0700
Message-ID: <1423385748-19825-12-git-send-email-pclouds@gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 09:57:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNfn-0002vU-2k
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 09:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbbBHI4z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 03:56:55 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:32968 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbbBHI4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 03:56:54 -0500
Received: by mail-pa0-f47.google.com with SMTP id lj1so26921580pab.6
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 00:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=W6arOZAckpTh0fIKrTWlii3VOU5zcIm72odASXzf6WU=;
        b=sJZfss7IChETidQlkM4Pz1MYeCG5MIc/OQxLUwIVCxlxj3myLjQhX9uMVCjC7RCJKM
         +RA+0Vsa2fN3e0enICALYWCpbbqNHJjQ1Hbal/8793axNEWzEp8gehWsoed5LjA/uge0
         3xbKcJGLdOPmbASUlRkOZ6yQpP26fZtxMr5g2qXY/WTYTdZ+yy+aHtlEYx/xNUCpOYlt
         9E42PvWD1b7ZT5AdSdIoKLttOL9bhU7HyLA942GUk+bpHfBGP2Ptt7TGU4znE+fC7QoB
         xt3dJuaJNnE0wk/s3uqjhmxODAWhVQriMwYVtCrelLYpmUi4eSLDzOZQADU31bzz8li4
         rqPQ==
X-Received: by 10.68.168.101 with SMTP id zv5mr19424224pbb.104.1423385813859;
        Sun, 08 Feb 2015 00:56:53 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id ca2sm12898465pbc.68.2015.02.08.00.56.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 00:56:53 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 15:57:01 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263472>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c        | 220 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 dir.h        |   2 +
 read-cache.c |   5 ++
 3 files changed, 227 insertions(+)

diff --git a/dir.c b/dir.c
index 1f2d701..e7d7df3 100644
--- a/dir.c
+++ b/dir.c
@@ -2275,3 +2275,223 @@ void write_untracked_extension(struct strbuf *o=
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
+#define NEXT(x) \
+	next =3D data + (x); \
+	if (next > rd->end) \
+		return -1;
+
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
