From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/24] untracked cache: mark index dirty if untracked cache is updated
Date: Sun,  8 Mar 2015 17:12:39 +0700
Message-ID: <1425809567-25518-17-git-send-email-pclouds@gmail.com>
References: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 11:14:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYEN-0003uj-FO
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbbCHKOj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 06:14:39 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:43257 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbbCHKOi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:14:38 -0400
Received: by pablj1 with SMTP id lj1so55503892pab.10
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=opQmvSV43mrezAu7u1isRf9NOYh1vbg07gp3Q+GDp5U=;
        b=HGrR9UmIBXlW5dnvr7Slj3DP5zSKMvZMFQDWfOt5l7x6nIdPLy2RcLQw6qUOi4SIl9
         oTsAdbbBl0gTI7uowbpLGEgssdv5SO0xOTreOfc4CARfv7uNt0JpcKNNESZfkgyz7YyQ
         lKRa5Iso2D+TSy8spAbk06LOuTxXudHVVfvqjiY5pcKSsi21HOk22F8WiqEatecKEGSx
         bculr1HGrKgpL+Ze7t3lMSndm9g9AZDuxRbsU4kp8u+FXD5BZVEcfvMXabayI4vkv0ND
         e49ddXsRy+RsJDJ1Cvsu8e9KpDEhBxOA+OaWrLnMWd0FsYA65OvuXAK4Ao/FDfGadsas
         2OHg==
X-Received: by 10.68.200.134 with SMTP id js6mr35312123pbc.55.1425809678565;
        Sun, 08 Mar 2015 03:14:38 -0700 (PDT)
Received: from lanh ([115.73.247.162])
        by mx.google.com with ESMTPSA id qd6sm4669251pdb.89.2015.03.08.03.14.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:14:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Mar 2015 17:14:34 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265071>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h      | 1 +
 dir.c        | 9 +++++++++
 read-cache.c | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index f8b3dc5..fca979b 100644
--- a/cache.h
+++ b/cache.h
@@ -295,6 +295,7 @@ static inline unsigned int canon_mode(unsigned int =
mode)
 #define RESOLVE_UNDO_CHANGED	(1 << 4)
 #define CACHE_TREE_CHANGED	(1 << 5)
 #define SPLIT_INDEX_ORDERED	(1 << 6)
+#define UNTRACKED_CHANGED	(1 << 7)
=20
 struct split_index;
 struct untracked_cache;
diff --git a/dir.c b/dir.c
index 01f0032..1b98663 100644
--- a/dir.c
+++ b/dir.c
@@ -1934,6 +1934,15 @@ int read_directory(struct dir_struct *dir, const=
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
index 0ecba05..71d8e20 100644
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
2.3.0.rc1.137.g477eb31
