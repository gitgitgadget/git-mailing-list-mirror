From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 15/22] untracked cache: mark index dirty if untracked cache is updated
Date: Sat,  8 Nov 2014 16:39:48 +0700
Message-ID: <1415439595-469-16-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 10:41:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn2WA-0001Rd-Qg
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 10:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbaKHJlI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 04:41:08 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:59918 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664AbaKHJlG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 04:41:06 -0500
Received: by mail-pd0-f176.google.com with SMTP id ft15so4776020pdb.21
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 01:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1+leL1aJyPVojjAHXyOd+o2Qtnj+lAXWgCcKJsw8WZI=;
        b=nrI3e2EZButVhfQw18fBJxnQ7JAArIkRP+bLu3Y5lVY/+jwVLcoXNLRHumQHO9D2UL
         KNS+WBDzl45c2zR3TO6TslSmIH0EgrztI2O5LjbKnzceLBNYlPEjo0RY7/p42xI9U0NB
         q6jxa5f7WoRarnDA63Xn06c0OCtJqXIVzD1qGUpv3+Oec5ZZ4pLZqAexq65IQE3lNWWi
         Yot9IL+AgEFyCfNqLj0TNgA0ET58Su97a/9fV9j4QGNU8rHE5gi9nw/c53aAPpaE0IdL
         WQ+eMrYsGparl43ReXk+sgBYbT3EM009eRmuqaQbPHLmv/SRYcI5xo+gUxnvd97zBMqx
         WYeA==
X-Received: by 10.70.45.40 with SMTP id j8mr18350323pdm.130.1415439666091;
        Sat, 08 Nov 2014 01:41:06 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id y10sm11057961pdq.15.2014.11.08.01.41.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 01:41:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Nov 2014 16:41:20 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415439595-469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      | 1 +
 dir.c        | 9 +++++++++
 read-cache.c | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index f8b3dc5..201b22e 100644
--- a/cache.h
+++ b/cache.h
@@ -295,6 +295,7 @@ static inline unsigned int canon_mode(unsigned int =
mode)
 #define RESOLVE_UNDO_CHANGED	(1 << 4)
 #define CACHE_TREE_CHANGED	(1 << 5)
 #define SPLIT_INDEX_ORDERED	(1 << 6)
+#define UNTRACKED_CHANGED       (1 << 7)
=20
 struct split_index;
 struct untracked_cache;
diff --git a/dir.c b/dir.c
index 27bd40a..b1f2be5 100644
--- a/dir.c
+++ b/dir.c
@@ -1931,6 +1931,15 @@ int read_directory(struct dir_struct *dir, const=
 char *path, int len, const stru
 				 dir->untracked->gitignore_invalidated,
 				 dir->untracked->dir_invalidated,
 				 dir->untracked->dir_opened);
+		if (dir->untracked =3D=3D the_index.untracked &&
+		    (dir->untracked->dir_opened ||
+		     dir->untracked->gitignore_invalidated ||
+		     dir->untracked->dir_invalidated))
+			the_index.cache_changed |=3D UNTRACKED_CHANGED;
+		if (dir->untracked !=3D the_index.untracked) {
+			free(dir->untracked);
+			dir->untracked =3D NULL;
+		}
 	}
 	return dir->nr;
 }
diff --git a/read-cache.c b/read-cache.c
index 103c294..21ae963 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -42,7 +42,7 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce,
 /* changes that can be kept in $GIT_DIR/index (basically all extension=
s) */
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
 		 CE_ENTRY_ADDED | CE_ENTRY_REMOVED | CE_ENTRY_CHANGED | \
-		 SPLIT_INDEX_ORDERED)
+		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED)
=20
 struct index_state the_index;
 static const char *alternate_index_output;
--=20
2.1.0.rc0.78.gc0d8480
