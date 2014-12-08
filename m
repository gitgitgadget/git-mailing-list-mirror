From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 16/23] untracked cache: mark index dirty if untracked cache is updated
Date: Mon,  8 Dec 2014 21:05:00 +0700
Message-ID: <1418047507-22892-18-git-send-email-pclouds@gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:56:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxynP-000526-Bl
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522AbaLHN4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 08:56:10 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:52549 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376AbaLHN4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:56:08 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so5273654pab.21
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=E8iTiyKEbWaA0lBWaukVL+F0Ju2tIvjFdM0WgsNBB2U=;
        b=FN3DhxVQRCQx0aHnR17hW4kyI7guqFQM8nMJBHBWDGBkvq0M0rotAgb3ujSvgul64/
         +4uONexKjyzkwVQgufwe9zuKyRuFNXjYhmCQIO+akwd2nocGNcbTlT0v1CIxjqd6bzh+
         UlXHTuVaRKR/o5uuVn0/6xkJmPJ01qxda85DOkcsktqaPJ4jkghZFz0RUFqr1arkPWfb
         iaTYy9AKdfP0GM8u6lg/NRU2XWvxEgSmGheykCiJCO1Ts8mYAkufi6s/2QwwUEj1+8tv
         kb9x/wZeP/vurCNFpUjFG40AhHDlRwnzyCxpXGsqSnEXZviHVn8Nw1FubNzS8J3nsyk5
         ESGA==
X-Received: by 10.66.220.34 with SMTP id pt2mr53064950pac.142.1418046967822;
        Mon, 08 Dec 2014 05:56:07 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id m3sm36004823pda.75.2014.12.08.05.56.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 05:56:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 21:06:43 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261034>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
index 14dbd7a..9b0e1a1 100644
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
2.2.0.60.gb7b3c64
