From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 3/3] untracked cache: fix entry invalidation
Date: Wed, 19 Aug 2015 20:01:26 +0700
Message-ID: <1439989286-24355-4-git-send-email-pclouds@gmail.com>
References: <1439702227-15453-1-git-send-email-dturner@twopensource.com>
 <1439989286-24355-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 19 15:01:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS30A-0004NN-9t
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 15:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbbHSNBx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2015 09:01:53 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34687 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbbHSNBw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 09:01:52 -0400
Received: by pdbfa8 with SMTP id fa8so1496125pdb.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fNiX1Q/5r0nbOVtqmV6gWpj44ZVNz2Smp52FnQY9o6Q=;
        b=vBo/psD0CSp2S/agzbYvroMDzYFLpAinC5/O9MsNcM/DSmiwOK7c9WJCeiyn587GH2
         QDBIBWR9rrr022wxDfebhIl6SkhYlzW8CQSH4XaMzYTCTzLwDvnzhqZZvmWc7W2jTQp9
         irQxbeA5DTn42/EX01s+xadEFbmNHknEbvolIQ+EqMz2EFFqKyq4F7NqUOR6/i4SZ0ol
         YPHmCYp8XF3kqH6o/AWIbKGJnC3/4Xwc9LHLWy9goD/lj93d350kW2W4tAbq6b++m/HL
         Toi9RFoKCrjnlee56qQ4E87KFVuqhCuznOQUm1Oq7RKK29JN3glPlx86lnLs4jho0PxS
         p26A==
X-Received: by 10.70.98.163 with SMTP id ej3mr24856127pdb.61.1439989312435;
        Wed, 19 Aug 2015 06:01:52 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id gu2sm894851pbc.1.2015.08.19.06.01.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Aug 2015 06:01:51 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 19 Aug 2015 20:01:48 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1439989286-24355-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276176>

=46irst, the current code in untracked_cache_invalidate_path() is wrong
because it can only handle paths "a" or "a/b", not "a/b/c" because
lookup_untracked() only looks for entries directly under the given
directory. In the last case, it will look for the entry "b/c" in
directory "a" instead. This means if you delete or add an entry in a
subdirectory, untracked cache may become out of date because it does no=
t
invalidate properly. This is noticed by David Turner.

The second problem is about invalidation inside a fully untracked/exclu=
ded
directory. In this case we may have to invalidate back to root. See the
comment block for detail.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c                             | 68 +++++++++++++++++++++++++++++++=
+-------
 t/t7063-status-untracked-cache.sh | 28 +++++++++++++++-
 2 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/dir.c b/dir.c
index cd4ac77..c1edabf 100644
--- a/dir.c
+++ b/dir.c
@@ -2616,23 +2616,67 @@ done2:
 	return uc;
 }
=20
+static void invalidate_one_directory(struct untracked_cache *uc,
+				     struct untracked_cache_dir *ucd)
+{
+	uc->dir_invalidated++;
+	ucd->valid =3D 0;
+	ucd->untracked_nr =3D 0;
+}
+
+/*
+ * Normally when an entry is added or removed from a directory,
+ * invalidating that directory is enough. No need to touch its
+ * ancestors. When a directory is shown as "foo/bar/" in git-status
+ * however, deleting or adding an entry may have cascading effect.
+ *
+ * Say the "foo/bar/file" has become untracked, we need to tell the
+ * untracked_cache_dir of "foo" that "bar/" is not an untracked
+ * directory any more (because "bar" is managed by foo as an untracked
+ * "file").
+ *
+ * Similarly, if "foo/bar/file" moves from untracked to tracked and it
+ * was the last untracked entry in the entire "foo", we should show
+ * "foo/" instead. Which means we have to invalidate past "bar" up to
+ * "foo".
+ *
+ * This function traverses all directories from root to leaf. If there
+ * is a chance of one of the above cases happening, we invalidate back
+ * to root. Otherwise we just invalidate the leaf. There may be a more
+ * sophisticated way than checking for SHOW_OTHER_DIRECTORIES to
+ * detect these cases and avoid unnecessary invalidation, for example,
+ * checking for the untracked entry named "bar/" in "foo", but for now
+ * stick to something safe and simple.
+ */
+static int invalidate_one_component(struct untracked_cache *uc,
+				    struct untracked_cache_dir *dir,
+				    const char *path, int len)
+{
+	const char *rest =3D strchr(path, '/');
+
+	if (rest) {
+		int component_len =3D rest - path;
+		struct untracked_cache_dir *d =3D
+			lookup_untracked(uc, dir, path, component_len);
+		int ret =3D
+			invalidate_one_component(uc, d, rest + 1,
+						 len - (component_len + 1));
+		if (ret)
+			invalidate_one_directory(uc, dir);
+		return ret;
+	}
+
+	invalidate_one_directory(uc, dir);
+	return uc->dir_flags & DIR_SHOW_OTHER_DIRECTORIES;
+}
+
 void untracked_cache_invalidate_path(struct index_state *istate,
 				     const char *path)
 {
-	const char *sep;
-	struct untracked_cache_dir *d;
 	if (!istate->untracked || !istate->untracked->root)
 		return;
-	sep =3D strrchr(path, '/');
-	if (sep)
-		d =3D lookup_untracked(istate->untracked,
-				     istate->untracked->root,
-				     path, sep - path);
-	else
-		d =3D istate->untracked->root;
-	istate->untracked->dir_invalidated++;
-	d->valid =3D 0;
-	d->untracked_nr =3D 0;
+	invalidate_one_component(istate->untracked, istate->untracked->root,
+				 path, strlen(path));
 }
=20
 void untracked_cache_remove_from_index(struct index_state *istate,
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untrack=
ed-cache.sh
index 22393b9..37a24c1 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -375,7 +375,7 @@ EOF
 node creation: 0
 gitignore invalidation: 0
 directory invalidation: 0
-opendir: 1
+opendir: 2
 EOF
 	test_cmp ../trace.expect ../trace
 '
@@ -543,4 +543,30 @@ EOF
 	test_cmp ../trace.expect ../trace
 '
=20
+test_expect_success 'move entry in subdir from untracked to cached' '
+	git add dtwo/two &&
+	git status --porcelain >../status.actual &&
+	cat >../status.expect <<EOF &&
+ M done/two
+A  dtwo/two
+?? .gitignore
+?? done/five
+?? done/sub/
+EOF
+	test_cmp ../status.expect ../status.actual
+'
+
+test_expect_success 'move entry in subdir from cached to untracked' '
+	git rm --cached dtwo/two &&
+	git status --porcelain >../status.actual &&
+	cat >../status.expect <<EOF &&
+ M done/two
+?? .gitignore
+?? done/five
+?? done/sub/
+?? dtwo/
+EOF
+	test_cmp ../status.expect ../status.actual
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
