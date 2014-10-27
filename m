From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/19] dir.c: optionally compute sha-1 of a .gitignore file
Date: Mon, 27 Oct 2014 19:10:28 +0700
Message-ID: <1414411846-4450-2-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 13:11:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xij8T-0002U5-54
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbaJ0MKw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 08:10:52 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:48350 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbaJ0MKv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 08:10:51 -0400
Received: by mail-pa0-f50.google.com with SMTP id eu11so5419239pac.9
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=J7RvCmU4/8XPqGhf8hz0clTqjMFGY/ekN+mgYSlxE78=;
        b=CATRTdf2crGJotEn2OsRNWuOrx8nykyv/BURBJYnKHn151M10IPTTKpQq4ugJZqA0e
         h6DW1fdwR1yGg6BB0Em8S7M94z2p7p1Q5f4PT9hZc8EhZ3de9hQaWzB63nfPRFaditHt
         Z79euUK1gqOYh7pK7xiimDtOZbouQiOnlLa4kRWnuvGlAkuYPSwnPoWyrngJ68I9ph6O
         XOKU+FK4YFYmSlhuFbZZcTweVdj6eO8jK12YdxwuV5nZVUpGN7maBW2Du8uNki64UZ15
         RGwjeUPj2OxQgl5BDpok5qnf8IYQElfepvB8zYO5UQUFvYCb/mUuOUddeb0+r7wR8Cj6
         VyIQ==
X-Received: by 10.68.225.99 with SMTP id rj3mr23929262pbc.97.1414411850604;
        Mon, 27 Oct 2014 05:10:50 -0700 (PDT)
Received: from lanh ([115.73.192.230])
        by mx.google.com with ESMTPSA id 16sm10790536pdj.42.2014.10.27.05.10.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 05:10:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 Oct 2014 19:10:53 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is not used anywhere yet. But the goal is to compare quickly if a
=2Egitignore file has changed when we have the SHA-1 of both old (cache=
d
somewhere) and new (from index or a tree) versions.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 dir.h |  5 +++++
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index bd274a7..33a35c1 100644
--- a/dir.c
+++ b/dir.c
@@ -466,7 +466,8 @@ void add_exclude(const char *string, const char *ba=
se,
 	x->el =3D el;
 }
=20
-static void *read_skip_worktree_file_from_index(const char *path, size=
_t *size)
+static void *read_skip_worktree_file_from_index(const char *path, size=
_t *size,
+						struct sha1_stat *ss)
 {
 	int pos, len;
 	unsigned long sz;
@@ -485,6 +486,10 @@ static void *read_skip_worktree_file_from_index(co=
nst char *path, size_t *size)
 		return NULL;
 	}
 	*size =3D xsize_t(sz);
+	if (ss) {
+		memset(&ss->stat, 0, sizeof(ss->stat));
+		hashcpy(ss->sha1, active_cache[pos]->sha1);
+	}
 	return data;
 }
=20
@@ -529,11 +534,18 @@ static void trim_trailing_spaces(char *buf)
 		*last_space =3D '\0';
 }
=20
-int add_excludes_from_file_to_list(const char *fname,
-				   const char *base,
-				   int baselen,
-				   struct exclude_list *el,
-				   int check_index)
+/*
+ * Given a file with name "fname", read it (either from disk, or from
+ * the index if "check_index" is non-zero), parse it and store the
+ * exclude rules in "el".
+ *
+ * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
+ * stat data from disk (only valid if add_excludes returns zero). If
+ * ss_valid is non-zero, "ss" must contain good value as input.
+ */
+static int add_excludes(const char *fname, const char *base, int basel=
en,
+			struct exclude_list *el, int check_index,
+			struct sha1_stat *ss, int ss_valid)
 {
 	struct stat st;
 	int fd, i, lineno =3D 1;
@@ -547,7 +559,7 @@ int add_excludes_from_file_to_list(const char *fnam=
e,
 		if (0 <=3D fd)
 			close(fd);
 		if (!check_index ||
-		    (buf =3D read_skip_worktree_file_from_index(fname, &size)) =3D=3D=
 NULL)
+		    (buf =3D read_skip_worktree_file_from_index(fname, &size, ss)) =3D=
=3D NULL)
 			return -1;
 		if (size =3D=3D 0) {
 			free(buf);
@@ -560,6 +572,10 @@ int add_excludes_from_file_to_list(const char *fna=
me,
 	} else {
 		size =3D xsize_t(st.st_size);
 		if (size =3D=3D 0) {
+			if (ss) {
+				fill_stat_data(&ss->stat, &st);
+				hashcpy(ss->sha1, EMPTY_BLOB_SHA1_BIN);
+			}
 			close(fd);
 			return 0;
 		}
@@ -571,6 +587,19 @@ int add_excludes_from_file_to_list(const char *fna=
me,
 		}
 		buf[size++] =3D '\n';
 		close(fd);
+		if (ss) {
+			int pos;
+			if (ss_valid && !match_stat_data(&ss->stat, &st))
+				; /* no content change, ss->sha1 still good */
+			else if (check_index &&
+				 (pos =3D cache_name_pos(fname, strlen(fname))) >=3D 0 &&
+				 !ce_stage(active_cache[pos]) &&
+				 ce_uptodate(active_cache[pos]))
+				hashcpy(ss->sha1, active_cache[pos]->sha1);
+			else
+				hash_sha1_file(buf, size, "blob", ss->sha1);
+			fill_stat_data(&ss->stat, &st);
+		}
 	}
=20
 	el->filebuf =3D buf;
@@ -589,6 +618,13 @@ int add_excludes_from_file_to_list(const char *fna=
me,
 	return 0;
 }
=20
+int add_excludes_from_file_to_list(const char *fname, const char *base=
,
+				   int baselen, struct exclude_list *el,
+				   int check_index)
+{
+	return add_excludes(fname, base, baselen, el, check_index, NULL, 0);
+}
+
 struct exclude_list *add_exclude_list(struct dir_struct *dir,
 				      int group_type, const char *src)
 {
diff --git a/dir.h b/dir.h
index 6c45e9d..032d197 100644
--- a/dir.h
+++ b/dir.h
@@ -73,6 +73,11 @@ struct exclude_list_group {
 	struct exclude_list *el;
 };
=20
+struct sha1_stat {
+	struct stat_data stat;
+	unsigned char sha1[20];
+};
+
 struct dir_struct {
 	int nr, alloc;
 	int ignored_nr, ignored_alloc;
--=20
2.1.0.rc0.78.gc0d8480
