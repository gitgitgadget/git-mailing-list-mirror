From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/24] untracked cache: mark index dirty if untracked cache is updated
Date: Tue, 20 Jan 2015 20:03:25 +0700
Message-ID: <1421759013-8494-17-git-send-email-pclouds@gmail.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 14:05:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDYUr-0003u0-3r
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 14:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbbATNFW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 08:05:22 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:64447 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbbATNFU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 08:05:20 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so45597467pab.0
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 05:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yRDjg+V9SEjuCAQdBqUL2l3Jm+dWYEg1l4/egiHg9PI=;
        b=cdyafMAunFmo8BEQAwHDUHLfByiG1stigCI3yEICjZacgHmWRFQTskgX6Gf8OqKVt6
         jr/H6HX41tHPNhj1siaEx69AjLi5RdaSomLAn7mO9BcKf+q7s42QtB43C6mz3+yzhzDo
         yPmS0HCcy3ZoIvUfMJdCV2ExrCjbTLwr6jXiSB0KnrtRtJ8UhlFEdu0RiCNAf6TA87OD
         Bd+ykFDjDbDOcssbNuVvuBfiWezNHqTdbqLISEssj9exZNhupCEwcPyPi08Mv0tCZc0h
         pX3TL8arODeAdKEnt0BrxL8L7j7xGGwMvkbKGmM1s5gVg0vpKibXwJ7znvG7/c3MRB70
         JFdA==
X-Received: by 10.68.211.161 with SMTP id nd1mr54035130pbc.92.1421759120481;
        Tue, 20 Jan 2015 05:05:20 -0800 (PST)
Received: from lanh ([115.73.212.1])
        by mx.google.com with ESMTPSA id bn13sm102117pdb.4.2015.01.20.05.05.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2015 05:05:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 20 Jan 2015 20:05:31 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262668>

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
2.2.0.84.ge9c7a8a
