From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 2/3] untracked-cache: fix subdirectory handling
Date: Wed, 19 Aug 2015 20:01:25 +0700
Message-ID: <1439989286-24355-3-git-send-email-pclouds@gmail.com>
References: <1439702227-15453-1-git-send-email-dturner@twopensource.com>
 <1439989286-24355-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 19 15:01:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS302-0004Ix-U2
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 15:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbbHSNBq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2015 09:01:46 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36625 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbbHSNBp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 09:01:45 -0400
Received: by pawq9 with SMTP id q9so2915325paw.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6lX6MpiURVpmY3PU789rzS30frf2bHCgSMuLYzeIwhA=;
        b=MQOLACrcqF1QDkTxoWHy5jXzOIuYLf6pZDTQ1hwUhIT8mWCNLc/PspuKvGCHzUX/vN
         HmMNt93Y20E9tXRX47XsHNwgt7NnvrR/5GrSK4+hQNwP8VF4ImS/HYNjeOGAYT7OO1tD
         NeP7Twf8DI0Q6n/OZBENEpdhA+DJC9N9+r7j6AieiwHPRWyxs0vlA4zaKA4mhmja9Iof
         CumxrKn4j4mDEtKw+IUYo+UEVgY1vNNRTMb0d1FGu41gufKZ0vRMzabfRSDAmhzQtqNO
         BztE5N6qIviH2aELiQ9ESMr2W9MlANetS7hISJKY3EsUuTbZklTz7ODlx0UbkeCVDi9j
         WIrg==
X-Received: by 10.68.95.68 with SMTP id di4mr24768214pbb.36.1439989305267;
        Wed, 19 Aug 2015 06:01:45 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id v10sm882873pbs.19.2015.08.19.06.01.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Aug 2015 06:01:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 19 Aug 2015 20:01:43 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1439989286-24355-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276174>

=46rom: David Turner <dturner@twopensource.com>

Previously, some calls lookup_untracked would pass a full path.  But
lookup_untracked assumes that the portion of the path up to and
including to the untracked_cache_dir has been removed.  So
lookup_untracked would be looking in the untracked_cache for 'foo' for
'foo/bar' (instead of just looking for 'bar').  This would cause
untracked cache corruption.

Instead, treat_directory learns to track the base length of the parent
directory, so that only the last path component is passed to
lookup_untracked.

Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c                             | 14 ++++----
 t/t7063-status-untracked-cache.sh | 72 +++++++++++++++++++++++++++++++=
+++++++-
 2 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index e7b89fe..cd4ac77 100644
--- a/dir.c
+++ b/dir.c
@@ -1297,7 +1297,7 @@ static enum exist_status directory_exists_in_inde=
x(const char *dirname, int len)
  */
 static enum path_treatment treat_directory(struct dir_struct *dir,
 	struct untracked_cache_dir *untracked,
-	const char *dirname, int len, int exclude,
+	const char *dirname, int len, int baselen, int exclude,
 	const struct path_simplify *simplify)
 {
 	/* The "len-1" is to strip the final '/' */
@@ -1324,7 +1324,8 @@ static enum path_treatment treat_directory(struct=
 dir_struct *dir,
 	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		return exclude ? path_excluded : path_untracked;
=20
-	untracked =3D lookup_untracked(dir->untracked, untracked, dirname, le=
n);
+	untracked =3D lookup_untracked(dir->untracked, untracked,
+				     dirname + baselen, len - baselen);
 	return read_directory_recursive(dir, dirname, len,
 					untracked, 1, simplify);
 }
@@ -1444,6 +1445,7 @@ static int get_dtype(struct dirent *de, const cha=
r *path, int len)
 static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  struct untracked_cache_dir *untracked,
 					  struct strbuf *path,
+					  int baselen,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
 {
@@ -1495,8 +1497,8 @@ static enum path_treatment treat_one_path(struct =
dir_struct *dir,
 		return path_none;
 	case DT_DIR:
 		strbuf_addch(path, '/');
-		return treat_directory(dir, untracked, path->buf, path->len, exclude=
,
-			simplify);
+		return treat_directory(dir, untracked, path->buf, path->len,
+				       baselen, exclude, simplify);
 	case DT_REG:
 	case DT_LNK:
 		return exclude ? path_excluded : path_untracked;
@@ -1557,7 +1559,7 @@ static enum path_treatment treat_path(struct dir_=
struct *dir,
 		return path_none;
=20
 	dtype =3D DTYPE(de);
-	return treat_one_path(dir, untracked, path, simplify, dtype, de);
+	return treat_one_path(dir, untracked, path, baselen, simplify, dtype,=
 de);
 }
=20
 static void add_untracked(struct untracked_cache_dir *dir, const char =
*name)
@@ -1827,7 +1829,7 @@ static int treat_leading_path(struct dir_struct *=
dir,
 			break;
 		if (simplify_away(sb.buf, sb.len, simplify))
 			break;
-		if (treat_one_path(dir, NULL, &sb, simplify,
+		if (treat_one_path(dir, NULL, &sb, baselen, simplify,
 				   DT_DIR, NULL) =3D=3D path_none)
 			break; /* do not recurse into it */
 		if (len <=3D baselen) {
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untrack=
ed-cache.sh
index 744e922..22393b9 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -408,7 +408,8 @@ test_expect_success 'set up sparse checkout' '
 	test_path_is_file done/one
 '
=20
-test_expect_success 'create files, some of which are gitignored' '
+test_expect_success 'create/modify files, some of which are gitignored=
' '
+	echo two bis >done/two &&
 	echo three >done/three && # three is gitignored
 	echo four >done/four && # four is gitignored at a higher level
 	echo five >done/five # five is not gitignored
@@ -420,6 +421,7 @@ test_expect_success 'test sparse status with untrac=
ked cache' '
 	GIT_TRACE_UNTRACKED_STATS=3D"$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../status.actual &&
 	cat >../status.expect <<EOF &&
+ M done/two
 ?? .gitignore
 ?? done/five
 ?? dtwo/
@@ -459,6 +461,7 @@ test_expect_success 'test sparse status again with =
untracked cache' '
 	GIT_TRACE_UNTRACKED_STATS=3D"$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../status.actual &&
 	cat >../status.expect <<EOF &&
+ M done/two
 ?? .gitignore
 ?? done/five
 ?? dtwo/
@@ -473,4 +476,71 @@ EOF
 	test_cmp ../trace.expect ../trace
 '
=20
+test_expect_success 'set up for test of subdir and sparse checkouts' '
+	mkdir done/sub &&
+	mkdir done/sub/sub &&
+	echo "sub" > done/sub/sub/file
+'
+
+test_expect_success 'test sparse status with untracked cache and subdi=
r' '
+	avoid_racy &&
+	: >../trace &&
+	GIT_TRACE_UNTRACKED_STATS=3D"$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../status.actual &&
+	cat >../status.expect <<EOF &&
+ M done/two
+?? .gitignore
+?? done/five
+?? done/sub/
+?? dtwo/
+EOF
+	test_cmp ../status.expect ../status.actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 2
+gitignore invalidation: 0
+directory invalidation: 1
+opendir: 3
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
+test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+.gitignore
+dtwo/
+/done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
+five
+sub/
+/done/sub/ 0000000000000000000000000000000000000000 recurse check_only=
 valid
+sub/
+/done/sub/sub/ 0000000000000000000000000000000000000000 recurse check_=
only valid
+file
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only v=
alid
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only val=
id
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'test sparse status again with untracked cache and=
 subdir' '
+	avoid_racy &&
+	: >../trace &&
+	GIT_TRACE_UNTRACKED_STATS=3D"$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../status.actual &&
+	test_cmp ../status.expect ../status.actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 0
+directory invalidation: 0
+opendir: 0
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
