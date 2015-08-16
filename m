From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3] untracked-cache: fix subdirectory handling
Date: Sun, 16 Aug 2015 01:17:07 -0400
Message-ID: <1439702227-15453-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 16 07:17:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQqKB-0005H3-Dc
	for gcvg-git-2@plane.gmane.org; Sun, 16 Aug 2015 07:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbbHPFR3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Aug 2015 01:17:29 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34545 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbbHPFR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2015 01:17:28 -0400
Received: by qkcs67 with SMTP id s67so37653998qkc.1
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 22:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=KLy0fDY0mreLDxvCCTreTGfpfnAG6XScYInwNh5uU4c=;
        b=NK+o0SPWcCwxuS+heeSUMPH30zrXiTztFgTr5NA2j2arW2ghHxAFHaPOkYXBXkfQU4
         rwvAKtJhJWzV/1pk3ah95/ZWRdTS58RYfWgojKa0S77W25KxM6lYolqA67ofSRPwk3Zp
         nsDGDnf/3OR+8DzgvoJug4vxiEGjFBTKwpmb8kVoibYWzhT9xzYQ9FSzLzSx3LZBJYGS
         tkcn8Cpp1icVWdlZP4X8ly0Wm8tLDwsOMM89K0+3zeyXlE1UzAt7L9yF+5n5sIe1K9YJ
         O42HnhTCinof10RLuoN2ta6mPwGsBNSoMhgZgYAsHl03ZaISkecsv7sfIkzOnFUaJtfy
         LQ3Q==
X-Gm-Message-State: ALoCoQngY5Q62iix669nFxwNJn5WqrE/skjA/cewL0Az0kismAK8z/vAK/QINKl+nqxaWV2rm8qs
X-Received: by 10.55.197.208 with SMTP id k77mr12725977qkl.83.1439702247365;
        Sat, 15 Aug 2015 22:17:27 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id x201sm6059267qkx.28.2015.08.15.22.17.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Aug 2015 22:17:26 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.622.gac67c30-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276011>

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

This version incorporates Duy's version of the dir.c code, and his
suggested test speedup.

---
 dir.c                             | 14 ++++----
 t/t7063-status-untracked-cache.sh | 74 +++++++++++++++++++++++++++++++=
++++++--
 2 files changed, 80 insertions(+), 8 deletions(-)

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
index ff23f4e..6716f69 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -402,13 +402,14 @@ test_expect_success 'set up sparse checkout' '
 	echo "done/[a-z]*" >.git/info/sparse-checkout &&
 	test_config core.sparsecheckout true &&
 	git checkout master &&
-	git update-index --untracked-cache &&
+	git update-index --untracked-cache --force-untracked-cache &&
 	git status --porcelain >/dev/null && # prime the cache
 	test_path_is_missing done/.gitignore &&
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
2.4.2.622.gac67c30-twtrsrc
