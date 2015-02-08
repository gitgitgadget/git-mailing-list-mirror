From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/24] untracked cache: mark index dirty if untracked cache is updated
Date: Sun,  8 Feb 2015 15:55:40 +0700
Message-ID: <1423385748-19825-17-git-send-email-pclouds@gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 09:57:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNgF-0003Dm-4c
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 09:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbbBHI5W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 03:57:22 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:37565 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452AbbBHI5W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 03:57:22 -0500
Received: by pdbfp1 with SMTP id fp1so24352939pdb.4
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 00:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8RPWZZrr8wxQrFUhr5toC/VwiqYtDPaSXwvMbrVA5rA=;
        b=DzG2kOfutcba7GePYxGL/QlQkAZE71PN3qTjnEmVE/Ac8uq+1BT3l8S5rQUkIZthZX
         BIYRPBMz0X95Wfzdkp0Zy079nUHBnLLivCU6F3Rr3t5cY2+DSgymswOq1bLzqGizXeoz
         PHz5VjzTvPpNIAoUCRPYtUzNlqOfGzXtZGFfUw+2+X9+zdOFNq4FGnF5ckN0Ldv/yMmo
         G3D472v+97uxH64jvRcJxLA1Zi+4bzQynFFt1uuoYiy3itH/SJMlfyxWMYDjrePDShz+
         Imsh3QgDLCqdKnjQo2EJxaPIEQ3wyh4zlfquffZZU9fKyQD/GoiFIX+TabAfcGK1TV8k
         1z9Q==
X-Received: by 10.66.222.72 with SMTP id qk8mr19162559pac.121.1423385841802;
        Sun, 08 Feb 2015 00:57:21 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id om9sm12921913pbb.34.2015.02.08.00.57.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 00:57:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 15:57:29 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263478>

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
index c5ca5ce..1c3db0b 100644
--- a/dir.c
+++ b/dir.c
@@ -1933,6 +1933,15 @@ int read_directory(struct dir_struct *dir, const=
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
