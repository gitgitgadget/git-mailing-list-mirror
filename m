From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 12/13] name-hash: allow to lookup a name with precalculated base hash
Date: Tue, 12 Mar 2013 20:04:59 +0700
Message-ID: <1363093500-16796-13-git-send-email-pclouds@gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 12 14:07:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFOvH-00086y-92
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 14:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643Ab3CLNGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 09:06:48 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:45251 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932605Ab3CLNGq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 09:06:46 -0400
Received: by mail-pb0-f50.google.com with SMTP id up1so4914747pbc.23
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 06:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=I/5ffpEF2DV9HN3aaFxpfOd/HWutR9p/xdNoNfKO85A=;
        b=sTZsgPqusQdQplQHcf3+JsbL9RDMwu2fZbztRFVWJQG6A4oW2o+gsHzeHMXkkeHj9M
         bncmxhiMZrX+/Bjej7D8Lb0FE7OsIIlNxXsT+XIQH0/gT/YyjlBS6hgaDPa979IhaqI4
         HExBuxqO3/csKywmaXkBkWxj5l70z0dg5OPqZEYNeYQGBZRUuE5AZYLv5Gb4NeRmlevX
         tmM1VELYq0vZxcOpcabTyBiN6xH0PLWQy2o2wlQNPgZ/vGB6om86iTkewIby3RSRheT/
         Pd/yJEv0nlmAIuZQ7+CjqhOltOzsEoViyEeB1I1oGbicWxCj0oJEQkhLzlGm+nb3igh8
         9QYQ==
X-Received: by 10.68.134.201 with SMTP id pm9mr29279339pbb.182.1363093606154;
        Tue, 12 Mar 2013 06:06:46 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id kb3sm24996942pbc.21.2013.03.12.06.06.42
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 06:06:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Mar 2013 20:06:38 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217962>

index_name_exists_base() differs from index_name_exists() in how the
hash is calculated. It uses the base hash as the seed and skips the
baselen part.

The intention is to reduce hashing cost during directory traversal,
where the hash of the directory is calculated once, and used as base
hash for all entries inside.

This poses a constraint in hash function. The function has not changed
since 2008. With luck it'll never change again. If resuming hashing at
any characters are not feasible with a new (better) hash function,
maybe we could stop at directory boundary.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile          |  1 +
 cache.h           |  2 --
 dir.c             |  1 +
 name-hash.c       | 48 ++++++++++++++++++++++-------------------------=
-
 name-hash.h (new) | 45 +++++++++++++++++++++++++++++++++++++++++++++
 read-cache.c      |  1 +
 unpack-trees.c    |  1 +
 7 files changed, 71 insertions(+), 28 deletions(-)
 create mode 100644 name-hash.h

diff --git a/Makefile b/Makefile
index 26d3332..8d753af 100644
--- a/Makefile
+++ b/Makefile
@@ -690,6 +690,7 @@ LIB_H +=3D mailmap.h
 LIB_H +=3D merge-blobs.h
 LIB_H +=3D merge-recursive.h
 LIB_H +=3D mergesort.h
+LIB_H +=3D name-hash.h
 LIB_H +=3D notes-cache.h
 LIB_H +=3D notes-merge.h
 LIB_H +=3D notes.h
diff --git a/cache.h b/cache.h
index e493563..cf33c67 100644
--- a/cache.h
+++ b/cache.h
@@ -313,7 +313,6 @@ static inline void remove_name_hash(struct cache_en=
try *ce)
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, =
NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce),=
 (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st=
), (options))
-#define cache_name_exists(name, namelen, igncase) index_name_exists(&t=
he_index, (name), (namelen), (igncase))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_in=
dex, (name), (namelen))
 #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
 #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, =
at)
@@ -442,7 +441,6 @@ extern int write_index(struct index_state *, int ne=
wfd);
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
-extern struct cache_entry *index_name_exists(struct index_state *istat=
e, const char *name, int namelen, int igncase);
 extern int index_name_pos(const struct index_state *, const char *name=
, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
diff --git a/dir.c b/dir.c
index 6809dd2..5fda5af 100644
--- a/dir.c
+++ b/dir.c
@@ -11,6 +11,7 @@
 #include "dir.h"
 #include "refs.h"
 #include "wildmatch.h"
+#include "name-hash.h"
=20
 #ifdef MEASURE_EXCLUDE
 static uint32_t tv_treat_leading_path;
diff --git a/name-hash.c b/name-hash.c
index 1287a19..572d232 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -7,30 +7,7 @@
  */
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
-
-/*
- * This removes bit 5 if bit 6 is set.
- *
- * That will make US-ASCII characters hash to their upper-case
- * equivalent. We could easily do this one whole word at a time,
- * but that's for future worries.
- */
-static inline unsigned char icase_hash(unsigned char c)
-{
-	return c & ~((c & 0x40) >> 1);
-}
-
-static unsigned int hash_name(const char *name, int namelen)
-{
-	unsigned int hash =3D 0x123;
-
-	while (namelen--) {
-		unsigned char c =3D *name++;
-		c =3D icase_hash(c);
-		hash =3D hash*101 + c;
-	}
-	return hash;
-}
+#include "name-hash.h"
=20
 static void hash_index_entry_directories(struct index_state *istate, s=
truct cache_entry *ce)
 {
@@ -152,9 +129,11 @@ static int same_name(const struct cache_entry *ce,=
 const char *name, int namelen
 	return slow_same_name(name, namelen, ce->name, namelen < len ? namele=
n : len);
 }
=20
-struct cache_entry *index_name_exists(struct index_state *istate, cons=
t char *name, int namelen, int icase)
+static inline struct cache_entry *find_entry_by_hash(struct index_stat=
e *istate,
+						     const char *name, int namelen,
+						     unsigned int hash,
+						     int icase)
 {
-	unsigned int hash =3D hash_name(name, namelen);
 	struct cache_entry *ce;
=20
 	lazy_init_name_hash(istate);
@@ -189,3 +168,20 @@ struct cache_entry *index_name_exists(struct index=
_state *istate, const char *na
 	}
 	return NULL;
 }
+
+struct cache_entry *index_name_exists(struct index_state *istate,
+				      const char *name, int namelen,
+				      int icase)
+{
+	unsigned int hash =3D hash_name(name, namelen);
+	return find_entry_by_hash(istate, name, namelen, hash, icase);
+}
+
+struct cache_entry *index_name_exists_base(struct index_state *istate,
+					   unsigned int basehash, int baselen,
+					   const char *name, int namelen,
+					   int icase)
+{
+	unsigned int hash =3D hash_name_from(basehash, name + baselen, namele=
n - baselen);
+	return find_entry_by_hash(istate, name, namelen, hash, icase);
+}
diff --git a/name-hash.h b/name-hash.h
new file mode 100644
index 0000000..997de30
--- /dev/null
+++ b/name-hash.h
@@ -0,0 +1,45 @@
+#ifndef NAME_HASH_H
+#define NAME_HASH_H
+
+extern struct cache_entry *index_name_exists(struct index_state *istat=
e,
+					     const char *name, int namelen,
+					     int igncase);
+extern struct cache_entry *index_name_exists_base(struct index_state *=
istate,
+						  unsigned int basehash, int baselen,
+						  const char *name, int namelen,
+						  int igncase);
+
+static inline struct cache_entry *cache_name_exists(const char *name, =
int namelen, int igncase)
+{
+	return index_name_exists(&the_index, name, namelen, igncase);
+}
+
+/*
+ * This removes bit 5 if bit 6 is set.
+ *
+ * That will make US-ASCII characters hash to their upper-case
+ * equivalent. We could easily do this one whole word at a time,
+ * but that's for future worries.
+ */
+static inline unsigned char icase_hash(unsigned char c)
+{
+	return c & ~((c & 0x40) >> 1);
+}
+
+static inline unsigned int hash_name_from(unsigned int hash,
+					  const char *name, int namelen)
+{
+	while (namelen--) {
+		unsigned char c =3D *name++;
+		c =3D icase_hash(c);
+		hash =3D hash*101 + c;
+	}
+	return hash;
+}
+
+static inline unsigned int hash_name(const char *name, int namelen)
+{
+	return hash_name_from(0x123, name, namelen);
+}
+
+#endif
diff --git a/read-cache.c b/read-cache.c
index 827ae55..8bd3ec8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -14,6 +14,7 @@
 #include "resolve-undo.h"
 #include "strbuf.h"
 #include "varint.h"
+#include "name-hash.h"
=20
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,=
 int really);
=20
diff --git a/unpack-trees.c b/unpack-trees.c
index 09e53df..60fa5d4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -8,6 +8,7 @@
 #include "progress.h"
 #include "refs.h"
 #include "attr.h"
+#include "name-hash.h"
=20
 /*
  * Error messages expected by scripts out of plumbing commands such as
--=20
1.8.1.2.536.gf441e6d
