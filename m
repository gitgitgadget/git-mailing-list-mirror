From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 13/13] read_directory: calculate name hashes incrementally
Date: Tue, 12 Mar 2013 20:05:00 +0700
Message-ID: <1363093500-16796-14-git-send-email-pclouds@gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 12 14:07:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFOvH-00086y-PU
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 14:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652Ab3CLNGz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 09:06:55 -0400
Received: from mail-da0-f50.google.com ([209.85.210.50]:42391 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932183Ab3CLNGw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 09:06:52 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so897023dae.23
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 06:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=PicOj0GeVseIvbWsYZmqMtmoTE+1IC8ShMOjr5VIac0=;
        b=baW96HMBCIGmSA2d1y25Z0M5qIoJ45PzUQ3hu5Lkn59tYrH4dUeOIShThj54D9chZV
         FlW4xyN1N2r7PTIpsfGSSFj63uuvvLMMy5PAgQKaYuRYUwoZFKs9uFkEmZT5dh0KzSqC
         9IWtjy5EjGBqWxESE+tEes2bo5SzlDTw2OTOE+t4FncZPq+MxTYYl0ux1XPMUCtlDbfc
         C3OukHRnb+h3Frq2vxvUbyO7EPPtGGYmFbGYKINyjsP51V//kqDmxeL/MbR6r1fjB0I0
         fbG9kFPtkSrRe3Va3u1fDbBOc9aLGyDJzZtv3fD+zKTLano1Iu5S+Sx+45lMhm9W+3ha
         bNMw==
X-Received: by 10.68.48.168 with SMTP id m8mr31326561pbn.138.1363093611853;
        Tue, 12 Mar 2013 06:06:51 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id tm1sm25004358pbc.11.2013.03.12.06.06.48
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 06:06:51 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Mar 2013 20:06:46 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217961>

Instead of index_name_exists() calculating a hash for full pathname
for every entry, we calculate partial hash per directory, use it as a
seed. The number of characters that icase_hash has to chew will
reduce.

treat_leading_path:   0.000  0.000
read_directory:       1.296  1.235
+treat_one_path:      0.599  0.531
++is_excluded:        0.102  0.102
+++prep_exclude:      0.040  0.040
+++matching:          0.035  0.035
++dir_exist:          0.035  0.035
++index_name_exists:  0.292  0.225
lazy_init_name_hash:  0.155  0.155
+simplify_away:       0.082  0.083
+dir_add_name:        0.000  0.000

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/dir.c b/dir.c
index 5fda5af..8638dcd 100644
--- a/dir.c
+++ b/dir.c
@@ -46,6 +46,7 @@ struct path_simplify {
=20
 static void read_directory_recursive(struct dir_struct *dir,
 				     const char *path, int len,
+				     unsigned int hash,
 				     int check_only,
 				     const struct path_simplify *simplify,
 				     int *contents);
@@ -1044,12 +1045,17 @@ static struct dir_entry *dir_entry_new(const ch=
ar *pathname, int len)
 	return ent;
 }
=20
-static struct dir_entry *dir_add_name(struct dir_struct *dir, const ch=
ar *pathname, int len)
+static struct dir_entry *dir_add_name(struct dir_struct *dir,
+				      const char *pathname, int len,
+				      unsigned int hash, int baselen)
 {
 	if (!(dir->flags & DIR_SHOW_IGNORED)) {
 		struct cache_entry *ce;
 		START_CLOCK();
-		ce =3D cache_name_exists(pathname, len, ignore_case);
+		ce =3D index_name_exists_base(&the_index,
+					    hash, baselen,
+					    pathname, len,
+					    ignore_case);
 		STOP_CLOCK(tv_index_name_exists);
 		if (ce)
 			return NULL;
@@ -1225,7 +1231,9 @@ static enum directory_treatment treat_directory(s=
truct dir_struct *dir,
 	if ((dir->flags & DIR_SHOW_IGNORED) && !exclude) {
 		dir->flags &=3D ~DIR_SHOW_IGNORED;
 		dir->flags |=3D DIR_HIDE_EMPTY_DIRECTORIES;
-		read_directory_recursive(dir, dirname, len, 1, simplify, &contents);
+		read_directory_recursive(dir, dirname, len,
+					 hash_name(dirname, len),
+					 1, simplify, &contents);
 		dir->flags &=3D ~DIR_HIDE_EMPTY_DIRECTORIES;
 		dir->flags |=3D DIR_SHOW_IGNORED;
=20
@@ -1234,7 +1242,9 @@ static enum directory_treatment treat_directory(s=
truct dir_struct *dir,
 	if (!(dir->flags & DIR_SHOW_IGNORED) &&
 	    !(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		return show_directory;
-	read_directory_recursive(dir, dirname, len, 1, simplify, &contents);
+	read_directory_recursive(dir, dirname, len,
+				 hash_name(dirname, len),
+				 1, simplify, &contents);
 	if (!contents)
 		return ignore_directory;
 	return show_directory;
@@ -1401,6 +1411,8 @@ enum path_treatment {
=20
 static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  struct strbuf *path,
+					  unsigned int hash,
+					  int baselen,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de,
 					  int exclude_shortcut_ok)
@@ -1416,7 +1428,8 @@ static enum path_treatment treat_one_path(struct =
dir_struct *dir,
 	    dtype !=3D DT_DIR) {
 		struct cache_entry *ce;
 		START_CLOCK();
-		ce =3D cache_name_exists(path->buf, path->len, ignore_case);
+		ce =3D index_name_exists_base(&the_index, hash, baselen,
+					    path->buf, path->len, ignore_case);
 		STOP_CLOCK(tv_index_name_exists);
 		if (ce)
 			return path_ignored;
@@ -1467,6 +1480,7 @@ static enum path_treatment treat_one_path(struct =
dir_struct *dir,
 static enum path_treatment treat_path(struct dir_struct *dir,
 				      struct dirent *de,
 				      struct strbuf *path,
+				      unsigned int hash,
 				      int baselen,
 				      const struct path_simplify *simplify,
 				      int exclude_shortcut_ok)
@@ -1485,7 +1499,8 @@ static enum path_treatment treat_path(struct dir_=
struct *dir,
=20
 	dtype =3D DTYPE(de);
 	START_CLOCK();
-	ret =3D treat_one_path(dir, path, simplify, dtype, de, exclude_shortc=
ut_ok);
+	ret =3D treat_one_path(dir, path, hash, baselen,
+			     simplify, dtype, de, exclude_shortcut_ok);
 	STOP_CLOCK(tv_treat_one_path);
 	return ret;
 }
@@ -1501,6 +1516,7 @@ static enum path_treatment treat_path(struct dir_=
struct *dir,
  */
 static void read_directory_recursive(struct dir_struct *dir,
 				     const char *base, int baselen,
+				     unsigned int hash,
 				     int check_only,
 				     const struct path_simplify *simplify,
 				     int *contents)
@@ -1517,12 +1533,16 @@ static void read_directory_recursive(struct dir=
_struct *dir,
=20
 	dir->exclude_prepared =3D 0;
 	while ((de =3D readdir(fdir)) !=3D NULL) {
-		switch (treat_path(dir, de, &path, baselen,
+		switch (treat_path(dir, de, &path, hash, baselen,
 				   simplify,
 				   !check_only && !contents)) {
 		case path_recurse:
 			read_directory_recursive(dir, path.buf,
-						 path.len, 0,
+						 path.len,
+						 hash_name_from(hash,
+								path.buf + baselen,
+								path.len - baselen),
+						 0,
 						 simplify,
 						 contents);
 			continue;
@@ -1543,7 +1563,7 @@ static void read_directory_recursive(struct dir_s=
truct *dir,
 		if (check_only)
 			break;
 		START_CLOCK();
-		dir_add_name(dir, path.buf, path.len);
+		dir_add_name(dir, path.buf, path.len, hash, baselen);
 		STOP_CLOCK(tv_dir_add_name);
 	}
 	closedir(fdir);
@@ -1619,7 +1639,7 @@ static int treat_leading_path(struct dir_struct *=
dir,
 		if (simplify_away(sb.buf, sb.len, simplify))
 			break;
 		dir->exclude_prepared =3D 0;
-		if (treat_one_path(dir, &sb, simplify,
+		if (treat_one_path(dir, &sb, 0, 0, simplify,
 				   DT_DIR, NULL, 0) =3D=3D path_ignored)
 			break; /* do not recurse into it */
 		if (len <=3D baselen) {
@@ -1648,7 +1668,9 @@ int read_directory(struct dir_struct *dir, const =
char *path, int len, const char
 		STOP_CLOCK(tv_lazy_init_name_hash);
 #endif
 		START_CLOCK();
-		read_directory_recursive(dir, path, len, 0, simplify, NULL);
+		read_directory_recursive(dir, path, len,
+					 hash_name(path, len),
+					 0, simplify, NULL);
 		STOP_CLOCK(tv_read_directory);
 	}
 #ifdef MEASURE_EXCLUDE
--=20
1.8.1.2.536.gf441e6d
