From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 01/23] dir.c: optionally compute sha-1 of a .gitignore file
Date: Mon,  8 Dec 2014 21:04:45 +0700
Message-ID: <1418047507-22892-3-git-send-email-pclouds@gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:55:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxymE-0004Al-6f
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467AbaLHNy4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 08:54:56 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:60998 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755446AbaLHNyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:54:53 -0500
Received: by mail-pd0-f180.google.com with SMTP id w10so2103175pde.39
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hOep2CSEC6v0DjcfoxNCslWTjZw5o/T+NPCgdDSodsY=;
        b=zIFNrE6DJBJ6gKIpnSMzI2quVk5Kr/6oNTL6U2yr3+3V3jACKtkzKm7ii5h250hYjl
         rjxjULS6aGWjlPjHXNrAhDnX2WA7P+R4CZr9a3TWzcHO/O6YGmKJrcnJ0slG/MLoujAA
         NZTkQWnL7l3blKo3cGlKYYCuRApXtHiMMy5wG53NoGkVlxY6WcKD2MGyWDySzEy6P1+i
         IXl3Hhpb1v8nJk5PF0r67r1aRX/c5rK5rm+WWYPXmxowwWb4VWsDZvLtR1EzVvHKF6Up
         GJDJMIwLmeuF9IkxnSSw6HXZfxyTBFlliap0580zqgBQ7Fp/8DVH4BsjIPWSEZrWIGzq
         lBpw==
X-Received: by 10.68.246.229 with SMTP id xz5mr61116986pbc.131.1418046893246;
        Mon, 08 Dec 2014 05:54:53 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id df1sm36434481pbb.2.2014.12.08.05.54.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 05:54:52 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 21:05:29 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261019>

This is not used anywhere yet. But the goal is to compare quickly if a
=2Egitignore file has changed when we have the SHA-1 of both old (cache=
d
somewhere) and new (from index or a tree) versions.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-------
 dir.h |  6 ++++++
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index fcb6872..4cc936b 100644
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
+						struct sha1_stat *sha1_stat)
 {
 	int pos, len;
 	unsigned long sz;
@@ -485,6 +486,10 @@ static void *read_skip_worktree_file_from_index(co=
nst char *path, size_t *size)
 		return NULL;
 	}
 	*size =3D xsize_t(sz);
+	if (sha1_stat) {
+		memset(&sha1_stat->stat, 0, sizeof(sha1_stat->stat));
+		hashcpy(sha1_stat->sha1, active_cache[pos]->sha1);
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
+			struct sha1_stat *sha1_stat)
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
+		    (buf =3D read_skip_worktree_file_from_index(fname, &size, sha1_s=
tat)) =3D=3D NULL)
 			return -1;
 		if (size =3D=3D 0) {
 			free(buf);
@@ -560,6 +572,11 @@ int add_excludes_from_file_to_list(const char *fna=
me,
 	} else {
 		size =3D xsize_t(st.st_size);
 		if (size =3D=3D 0) {
+			if (sha1_stat) {
+				fill_stat_data(&sha1_stat->stat, &st);
+				hashcpy(sha1_stat->sha1, EMPTY_BLOB_SHA1_BIN);
+				sha1_stat->valid =3D 1;
+			}
 			close(fd);
 			return 0;
 		}
@@ -571,6 +588,21 @@ int add_excludes_from_file_to_list(const char *fna=
me,
 		}
 		buf[size++] =3D '\n';
 		close(fd);
+		if (sha1_stat) {
+			int pos;
+			if (sha1_stat->valid &&
+			    !match_stat_data(&sha1_stat->stat, &st))
+				; /* no content change, ss->sha1 still good */
+			else if (check_index &&
+				 (pos =3D cache_name_pos(fname, strlen(fname))) >=3D 0 &&
+				 !ce_stage(active_cache[pos]) &&
+				 ce_uptodate(active_cache[pos]))
+				hashcpy(sha1_stat->sha1, active_cache[pos]->sha1);
+			else
+				hash_sha1_file(buf, size, "blob", sha1_stat->sha1);
+			fill_stat_data(&sha1_stat->stat, &st);
+			sha1_stat->valid =3D 1;
+		}
 	}
=20
 	el->filebuf =3D buf;
@@ -589,6 +621,13 @@ int add_excludes_from_file_to_list(const char *fna=
me,
 	return 0;
 }
=20
+int add_excludes_from_file_to_list(const char *fname, const char *base=
,
+				   int baselen, struct exclude_list *el,
+				   int check_index)
+{
+	return add_excludes(fname, base, baselen, el, check_index, NULL);
+}
+
 struct exclude_list *add_exclude_list(struct dir_struct *dir,
 				      int group_type, const char *src)
 {
diff --git a/dir.h b/dir.h
index 6c45e9d..cdca71b 100644
--- a/dir.h
+++ b/dir.h
@@ -73,6 +73,12 @@ struct exclude_list_group {
 	struct exclude_list *el;
 };
=20
+struct sha1_stat {
+	struct stat_data stat;
+	unsigned char sha1[20];
+	int valid;
+};
+
 struct dir_struct {
 	int nr, alloc;
 	int ignored_nr, ignored_alloc;
--=20
2.2.0.60.gb7b3c64
