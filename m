From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/3] lockfile.c: store absolute path
Date: Thu, 31 Jul 2014 20:43:34 +0700
Message-ID: <1406814214-21725-4-git-send-email-pclouds@gmail.com>
References: <1405858399-23082-1-git-send-email-pclouds@gmail.com>
 <1406814214-21725-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, ramsay@ramsay1.demon.co.uk,
	yuelinho777@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 15:44:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCqeE-0004jf-Ly
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 15:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbaGaNny convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2014 09:43:54 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:58787 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbaGaNnx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 09:43:53 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so3495057pdi.25
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lg+5xgzBPPBdUer2Z91G5/9CZZwrrtL1EEHkTKFrShs=;
        b=j4VGdWB5xWvDH7sV2AKldGoGH0pKOgvK2FpyT7x7a41p9thVLRDiNj0YZmo0421HhS
         pzv1R5L4yAPFvIaL7wVAYkwzDeb/Jsjm0x6xHXJmy/OTUqrugceil7cgxsu8fQzjywMy
         WpcxQmECgf/hY9LmS+g7VflUNCs1QwGMQ3mPmikH4c7YlosniINJ5YWkVWG079yRJMjU
         mHU59yoO4J2745Z++v3v65EWMPKTJc0D3i+/O3n6Xtk+7KTQ2bdptXMG/+LNUwfkuKCv
         Hbx04ZOu+D0fthzm4LsVAmkA5nu+UdTBKo3L79fz5dkWgBjxKDFKfwIiEb52rh6GZcIa
         o5fA==
X-Received: by 10.70.89.139 with SMTP id bo11mr12405423pdb.50.1406814233454;
        Thu, 31 Jul 2014 06:43:53 -0700 (PDT)
Received: from lanh ([115.73.244.27])
        by mx.google.com with ESMTPSA id vk5sm5603805pbc.44.2014.07.31.06.43.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jul 2014 06:43:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 31 Jul 2014 20:43:58 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1406814214-21725-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254573>

Locked paths can be saved in a linked list so that if something wrong
happens, *.lock are removed. For relative paths, this works fine if we
keep cwd the same, which is true 99% of time except:

- update-index and read-tree hold the lock on $GIT_DIR/index really
  early, then later on may call setup_work_tree() to move cwd.

- Suppose a lock is being held (e.g. by "git add") then somewhere
  down the line, somebody calls real_path (e.g. "link_alt_odb_entry"),
  which temporarily moves cwd away and back.

During that time when cwd is moved (either permanently or temporarily)
and we decide to die(), attempts to remove relative *.lock will fail,
and the next operation will complain that some files are still locked.

Avoid this case by turning relative paths to absolute before storing
the path in "filename" field.

Reported-by: Yue Lin Ho <yuelinho777@gmail.com>
Helped-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 lockfile.c                    | 10 +++++-----
 t/t2107-update-index-basic.sh | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 154915f..0aa70a5 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -117,13 +117,13 @@ static char *resolve_symlink(const char *in)
=20
 static int lock_file(struct lock_file *lk, const char *path, int flags=
)
 {
-	int len;
+	struct strbuf sb =3D STRBUF_INIT;
+
 	if (!(flags & LOCK_NODEREF) && !(path =3D resolve_symlink(path)))
 		return -1;
-	len =3D strlen(path) + 5; /* .lock */
-	lk->filename =3D xmallocz(len);
-	strcpy(lk->filename, path);
-	strcat(lk->filename, ".lock");
+	strbuf_add_absolute_path(&sb, path);
+	strbuf_addstr(&sb, ".lock");
+	lk->filename =3D strbuf_detach(&sb, NULL);
 	lk->fd =3D open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <=3D lk->fd) {
 		if (!lock_file_list) {
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic=
=2Esh
index 1bafb90..dfe02f4 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -65,4 +65,19 @@ test_expect_success '--cacheinfo mode,sha1,path (new=
 syntax)' '
 	test_cmp expect actual
 '
=20
+test_expect_success '.lock files cleaned up' '
+	mkdir cleanup &&
+	(
+	cd cleanup &&
+	mkdir worktree &&
+	git init repo &&
+	cd repo &&
+	git config core.worktree ../../worktree &&
+	# --refresh triggers late setup_work_tree,
+	# active_cache_changed is zero, rollback_lock_file fails
+	git update-index --refresh &&
+	! test -f .git/index.lock
+	)
+'
+
 test_done
--=20
2.1.0.rc0.78.gc0d8480
