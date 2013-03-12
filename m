From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 01/13] dir.c: add MEASURE_EXCLUDE code for tracking exclude performance
Date: Tue, 12 Mar 2013 20:04:48 +0700
Message-ID: <1363093500-16796-2-git-send-email-pclouds@gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 12 14:06:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFOu1-0007HA-LL
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 14:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426Ab3CLNF3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 09:05:29 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:49194 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114Ab3CLNFY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 09:05:24 -0400
Received: by mail-pb0-f50.google.com with SMTP id up1so4979424pbc.37
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 06:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=mvUhNH8mB4FWBrCc2aTTlAYnX0DsVqCCHTUxLqdsQu4=;
        b=OYk9Ylv/+28UDosQTWK0/g/82x+eK8C901XFVF0Gybsc5AA5XZ1kZW5LW+2qYpmqMm
         EYOg+S2d5R9lY4e198X+eePqRRzEZ7IFfrdG5bGF07iocHUREgcb4sAmR8D4UHlcq0qu
         ONZbrYtcTk7fUEs57fusgLju+Hq3rhqpT5/9DywbdHjU8ujeUSCGb/pBhvoXUgs4SN8u
         KvD+vFrqptMrvMO1dczlCj2Rdjw8BgNdOwC5FlK0f18X8fiJO+MxoETXDeAPpMgSuCQZ
         PmCVbhPBr3hkOlX3tW/lxAbEkktOfXlmOzoEcmCUvz8g/bJEAnFT0YWTGtkCVb9TtKhw
         FALw==
X-Received: by 10.68.216.39 with SMTP id on7mr37670448pbc.75.1363093523626;
        Tue, 12 Mar 2013 06:05:23 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id ax3sm24977874pbd.42.2013.03.12.06.05.20
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 06:05:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Mar 2013 20:05:17 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217949>

Hot read_directory() codepaths are tracked. This could be helpful to
see how changes affect read_directory() performance.

Results are printed when environment variable GIT_MEASURE_EXCLUDE is se=
t.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++------
 1 file changed, 100 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index 57394e4..69c045b 100644
--- a/dir.c
+++ b/dir.c
@@ -12,6 +12,32 @@
 #include "refs.h"
 #include "wildmatch.h"
=20
+#ifdef MEASURE_EXCLUDE
+static uint32_t tv_treat_leading_path;
+static uint32_t tv_read_directory;
+static uint32_t tv_treat_one_path;
+static uint32_t tv_is_excluded;
+static uint32_t tv_prep_exclude;
+static uint32_t tv_last_exclude_matching;
+static uint32_t tv_dir_add_name;
+static uint32_t tv_directory_exists_in_index;
+static uint32_t tv_simplify_away;
+static uint32_t tv_index_name_exists;
+static uint32_t tv_lazy_init_name_hash;
+#define START_CLOCK() \
+	{ \
+		struct timeval tv1, tv2; \
+		gettimeofday(&tv1, NULL);
+#define STOP_CLOCK(v) \
+		gettimeofday(&tv2, NULL); \
+		v +=3D (uint64_t)tv2.tv_sec * 1000000 + tv2.tv_usec - \
+			(uint64_t)tv1.tv_sec * 1000000 - tv1.tv_usec; \
+	}
+#else
+#define START_CLOCK()
+#define STOP_CLOCK(v)
+#endif
+
 struct path_simplify {
 	int len;
 	const char *path;
@@ -768,8 +794,11 @@ static struct exclude *last_exclude_matching(struc=
t dir_struct *dir,
 	const char *basename =3D strrchr(pathname, '/');
 	basename =3D (basename) ? basename+1 : pathname;
=20
+	START_CLOCK();
 	prep_exclude(dir, pathname, basename-pathname);
+	STOP_CLOCK(tv_prep_exclude);
=20
+	START_CLOCK();
 	for (i =3D EXC_CMDL; i <=3D EXC_FILE; i++) {
 		group =3D &dir->exclude_list_group[i];
 		for (j =3D group->nr - 1; j >=3D 0; j--) {
@@ -780,6 +809,7 @@ static struct exclude *last_exclude_matching(struct=
 dir_struct *dir,
 				return exclude;
 		}
 	}
+	STOP_CLOCK(tv_last_exclude_matching);
 	return NULL;
 }
=20
@@ -897,9 +927,14 @@ static struct dir_entry *dir_entry_new(const char =
*pathname, int len)
=20
 static struct dir_entry *dir_add_name(struct dir_struct *dir, const ch=
ar *pathname, int len)
 {
-	if (!(dir->flags & DIR_SHOW_IGNORED) &&
-	    cache_name_exists(pathname, len, ignore_case))
-		return NULL;
+	if (!(dir->flags & DIR_SHOW_IGNORED)) {
+		struct cache_entry *ce;
+		START_CLOCK();
+		ce =3D cache_name_exists(pathname, len, ignore_case);
+		STOP_CLOCK(tv_index_name_exists);
+		if (ce)
+			return NULL;
+	}
=20
 	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
 	return dir->entries[dir->nr++] =3D dir_entry_new(pathname, len);
@@ -1034,8 +1069,12 @@ static enum directory_treatment treat_directory(=
struct dir_struct *dir,
 	const char *dirname, int len, int exclude,
 	const struct path_simplify *simplify)
 {
+	int ret;
+	START_CLOCK();
 	/* The "len-1" is to strip the final '/' */
-	switch (directory_exists_in_index(dirname, len-1)) {
+	ret =3D directory_exists_in_index(dirname, len-1);
+	STOP_CLOCK(tv_directory_exists_in_index);
+	switch (ret) {
 	case index_directory:
 		if ((dir->flags & DIR_SHOW_OTHER_DIRECTORIES) && exclude)
 			break;
@@ -1179,7 +1218,9 @@ static int get_index_dtype(const char *path, int =
len)
 	int pos;
 	struct cache_entry *ce;
=20
+	START_CLOCK();
 	ce =3D cache_name_exists(path, len, 0);
+	STOP_CLOCK(tv_index_name_exists);
 	if (ce) {
 		if (!ce_uptodate(ce))
 			return DT_UNKNOWN;
@@ -1244,7 +1285,12 @@ static enum path_treatment treat_one_path(struct=
 dir_struct *dir,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
 {
-	int exclude =3D is_excluded(dir, path->buf, &dtype);
+	int exclude;
+
+	START_CLOCK();
+	exclude =3D is_excluded(dir, path->buf,  &dtype);
+	STOP_CLOCK(tv_is_excluded);
+
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
 	    && exclude_matches_pathspec(path->buf, path->len, simplify))
 		dir_add_ignored(dir, path->buf, path->len);
@@ -1292,17 +1338,23 @@ static enum path_treatment treat_path(struct di=
r_struct *dir,
 				      int baselen,
 				      const struct path_simplify *simplify)
 {
-	int dtype;
+	int dtype, ret;
=20
 	if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
 		return path_ignored;
 	strbuf_setlen(path, baselen);
 	strbuf_addstr(path, de->d_name);
-	if (simplify_away(path->buf, path->len, simplify))
+	START_CLOCK();
+	ret =3D simplify_away(path->buf, path->len, simplify);
+	STOP_CLOCK(tv_simplify_away);
+	if (ret)
 		return path_ignored;
=20
 	dtype =3D DTYPE(de);
-	return treat_one_path(dir, path, simplify, dtype, de);
+	START_CLOCK();
+	ret =3D treat_one_path(dir, path, simplify, dtype, de);
+	STOP_CLOCK(tv_treat_one_path);
+	return ret;
 }
=20
 /*
@@ -1345,7 +1397,9 @@ static int read_directory_recursive(struct dir_st=
ruct *dir,
 		contents++;
 		if (check_only)
 			break;
+		START_CLOCK();
 		dir_add_name(dir, path.buf, path.len);
+		STOP_CLOCK(tv_dir_add_name);
 	}
 	closedir(fdir);
  out:
@@ -1405,6 +1459,7 @@ static int treat_leading_path(struct dir_struct *=
dir,
 		len--;
 	if (!len)
 		return 1;
+	START_CLOCK();
 	baselen =3D 0;
 	while (1) {
 		cp =3D path + baselen + !!baselen;
@@ -1428,6 +1483,7 @@ static int treat_leading_path(struct dir_struct *=
dir,
 		}
 	}
 	strbuf_release(&sb);
+	STOP_CLOCK(tv_treat_leading_path);
 	return rc;
 }
=20
@@ -1439,8 +1495,43 @@ int read_directory(struct dir_struct *dir, const=
 char *path, int len, const char
 		return dir->nr;
=20
 	simplify =3D create_simplify(pathspec);
-	if (!len || treat_leading_path(dir, path, len, simplify))
+	if (!len || treat_leading_path(dir, path, len, simplify)) {
+#ifdef MEASURE_EXCLUDE
+		/* The first call triggers lazy_init_name_hash() */
+		START_CLOCK();
+		index_name_exists(&the_index, "", 0, ignore_case);
+		STOP_CLOCK(tv_lazy_init_name_hash);
+#endif
+		START_CLOCK();
 		read_directory_recursive(dir, path, len, 0, simplify);
+		STOP_CLOCK(tv_read_directory);
+	}
+#ifdef MEASURE_EXCLUDE
+	if (getenv("GIT_MEASURE_EXCLUDE")) {
+		fprintf(stderr, "treat_leading_path:  %10.3f\n",
+			(float)tv_treat_leading_path / 1000000);
+		fprintf(stderr, "read_directory:      %10.3f\n",
+			(float)tv_read_directory / 1000000);
+		fprintf(stderr, "+treat_one_path:     %10.3f\n",
+			(float)tv_treat_one_path / 1000000);
+		fprintf(stderr, "++is_excluded:       %10.3f\n",
+			(float)tv_is_excluded / 1000000);
+		fprintf(stderr, "+++prep_exclude:     %10.3f\n",
+			(float)tv_prep_exclude / 1000000);
+		fprintf(stderr, "+++matching:         %10.3f\n",
+			(float)tv_last_exclude_matching / 1000000);
+		fprintf(stderr, "++dir_exist:         %10.3f\n",
+			(float)tv_directory_exists_in_index / 1000000);
+		fprintf(stderr, "++index_name_exists: %10.3f\n",
+			(float)tv_index_name_exists / 1000000);
+		fprintf(stderr, "lazy_init_name_hash: %10.3f\n",
+			(float)tv_lazy_init_name_hash / 1000000);
+		fprintf(stderr, "+simplify_away:      %10.3f\n",
+			(float)tv_simplify_away / 1000000);
+		fprintf(stderr, "+dir_add_name:       %10.3f\n",
+			(float)tv_dir_add_name / 1000000);
+	}
+#endif
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_=
name);
--=20
1.8.1.2.536.gf441e6d
