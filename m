From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 2/4] cache-tree: replace "for" loops in update_one with "while" loops
Date: Sun, 16 Dec 2012 11:15:26 +0700
Message-ID: <1355631328-26678-3-git-send-email-pclouds@gmail.com>
References: <1355631328-26678-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 05:15:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tk5dZ-0004J7-NH
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 05:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab2LPEPP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Dec 2012 23:15:15 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab2LPEPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 23:15:13 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so3258683pbc.19
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 20:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8aRsKaMMLX3MC9T8HgVob4U1MDxf2JOmGCePfduO7sc=;
        b=tvMAIoqt7Nu4R7T7Cgq9JWsUVh+sJw8VoIbfTP6Ny9FxVe2gNTAM6O9yUyp0qH6TPI
         wOivDHdvUtWwwX4yrBAhv8FQlkFmNc+Er4XiIszL0x7Vy+jGYZ96AYNWVhY1lo7j2clb
         P/ty8Ea9Us+HrWTtsS2pPr0Il4N3jPWXGjbpJhsw/Y/J8LbUnjUNQ7m8hzksPckHYNVh
         ptzWsYQjqXI7xzV/88LEmc6nJgldPrNZSkKkwCALNx9Qw+xSMzihW8jBNN3XZ5H4sxn1
         0kTMSI9XXP+gdPJQwukuYHzIrgFYu2Ycc4BSoUXIs/fcVDLh/82mv0NFNG/PMxVUa6gN
         QGIg==
Received: by 10.66.86.101 with SMTP id o5mr30200403paz.15.1355631312510;
        Sat, 15 Dec 2012 20:15:12 -0800 (PST)
Received: from lanh ([115.74.41.198])
        by mx.google.com with ESMTPS id ty4sm5722570pbc.57.2012.12.15.20.15.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 20:15:11 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Dec 2012 11:15:50 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1355631328-26678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211575>

The loops in update_one can be increased in two different ways: step
by one for files and by <n> for directories. "for" loop is not
suitable for this as it always steps by one and special handling is
required for directories. Replace them with "while" loops for clarity.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache-tree.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index e2beab5..44eed28 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -259,7 +259,8 @@ static int update_one(struct cache_tree *it,
 	/*
 	 * Find the subtrees and update them.
 	 */
-	for (i =3D 0; i < entries; i++) {
+	i =3D 0;
+	while (i < entries) {
 		struct cache_entry *ce =3D cache[i];
 		struct cache_tree_sub *sub;
 		const char *path, *slash;
@@ -271,8 +272,10 @@ static int update_one(struct cache_tree *it,
 			break; /* at the end of this level */
=20
 		slash =3D strchr(path + baselen, '/');
-		if (!slash)
+		if (!slash) {
+			i++;
 			continue;
+		}
 		/*
 		 * a/bbb/c (base =3D a/, slash =3D /c)
 		 * =3D=3D>
@@ -289,7 +292,7 @@ static int update_one(struct cache_tree *it,
 				    flags);
 		if (subcnt < 0)
 			return subcnt;
-		i +=3D subcnt - 1;
+		i +=3D subcnt;
 		sub->used =3D 1;
 	}
=20
@@ -300,7 +303,8 @@ static int update_one(struct cache_tree *it,
 	 */
 	strbuf_init(&buffer, 8192);
=20
-	for (i =3D 0; i < entries; i++) {
+	i =3D 0;
+	while (i < entries) {
 		struct cache_entry *ce =3D cache[i];
 		struct cache_tree_sub *sub;
 		const char *path, *slash;
@@ -320,7 +324,7 @@ static int update_one(struct cache_tree *it,
 			if (!sub)
 				die("cache-tree.c: '%.*s' in '%s' not found",
 				    entlen, path + baselen, path);
-			i +=3D sub->cache_tree->entry_count - 1;
+			i +=3D sub->cache_tree->entry_count;
 			sha1 =3D sub->cache_tree->sha1;
 			mode =3D S_IFDIR;
 		}
@@ -328,6 +332,7 @@ static int update_one(struct cache_tree *it,
 			sha1 =3D ce->sha1;
 			mode =3D ce->ce_mode;
 			entlen =3D pathlen - baselen;
+			i++;
 		}
 		if (mode !=3D S_IFGITLINK && !missing_ok && !has_sha1_file(sha1)) {
 			strbuf_release(&buffer);
--=20
1.8.0.rc2.23.g1fb49df
