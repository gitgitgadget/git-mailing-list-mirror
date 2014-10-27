From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/19] untracked cache: mark index dirty if untracked cache is updated
Date: Mon, 27 Oct 2014 19:10:42 +0700
Message-ID: <1414411846-4450-16-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 13:12:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xij9d-0003EO-Ak
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbaJ0MME convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 08:12:04 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:53038 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbaJ0MMB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 08:12:01 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so3680523pad.11
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 05:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CTr4qtwE4JVrSU6nCsw2asTI5SR2z0wQ7NQD0LQxCno=;
        b=kXhZa4In/oyVi5NzcE9xZVR4EyKJe24yWfLahBF6BxT1vD4j3wlXJtKR+ahLmxYquk
         q4dvZ1HFXgdnCRElAgLH7baK+ujy3KQeCvoOo4JxY9xxUYp8nPCVp6uYf4k6P6/R9Fgk
         g2swSqgqqtB/+Ny52iQAEoOW81xo8UYeKlhm/tzSacbVo1DZSQ/8eue2mykcAxY/kBQR
         G9OwMBVzIuM7yRck2eZCrC7q8BS4h9qZ4LVULVoEFGOibTrAlEvuPMRgBcWob9YzqfnX
         NLOJoHha+NOF4M5sNKDJi2MTJQj5y7WjLZoIA+shf1QbaL3dI6u+6vyg8OirvNMMaMiU
         Br8w==
X-Received: by 10.66.182.200 with SMTP id eg8mr23943085pac.53.1414411921542;
        Mon, 27 Oct 2014 05:12:01 -0700 (PDT)
Received: from lanh ([115.73.192.230])
        by mx.google.com with ESMTPSA id pc8sm10777943pbc.10.2014.10.27.05.11.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 05:12:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 Oct 2014 19:12:04 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
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
index 2b93217..dcbdc3c 100644
--- a/cache.h
+++ b/cache.h
@@ -296,6 +296,7 @@ static inline unsigned int canon_mode(unsigned int =
mode)
 #define RESOLVE_UNDO_CHANGED	(1 << 4)
 #define CACHE_TREE_CHANGED	(1 << 5)
 #define SPLIT_INDEX_ORDERED	(1 << 6)
+#define UNTRACKED_CHANGED       (1 << 7)
=20
 struct split_index;
 struct untracked_cache;
diff --git a/dir.c b/dir.c
index 57b49f7..d373d9a 100644
--- a/dir.c
+++ b/dir.c
@@ -1929,6 +1929,15 @@ int read_directory(struct dir_struct *dir, const=
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
index 177cbae..779c080 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -43,7 +43,7 @@ static struct cache_entry *refresh_cache_entry(struct=
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
