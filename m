From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v6 2/3] lstat_cache(): introduce
 has_symlink_or_noent_leading_path() function
Date: Sun, 11 Jan 2009 14:29:01 +0100
Message-ID: <1231680542-17315-3-git-send-email-barvik@broadpark.no>
References: <1231680542-17315-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Ren=E9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 14:30:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM0Ot-000569-Q4
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 14:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbZAKN3W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jan 2009 08:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbZAKN3U
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 08:29:20 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:33558 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798AbZAKN3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 08:29:16 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDB00DFT6SRDUB0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 14:29:15 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.153])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KDB00HSC6SEFR30@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 14:29:15 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.49.g7f705
In-reply-to: <1231680542-17315-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105179>

In some cases, especially inside the unpack-trees.c file, and inside
the verify_absent() function, we can avoid some unnecessary calls to
lstat(), if the lstat_cache() function can also can be told to keep
track of none existing directories.

So we update the lstat_cache() function to handle this fact new fact,
introduce a new wrapper function, and the result is that we save lots
of lstat() calls for a removed directory which previously contained
lots of files, when we call this new wrapper of lstat_cache() instead
of the old one.

We do similar changes inside the unlink_entry() function, since if we
can already say that the leading directory component of a pathname
does not exist, it is not necessary to try to remove a pathname below
it!

Thanks to Junio C Hamano, Linus Torvalds and Ren=E9 Scharfe for valuabl=
e
comments to this patch!

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
:100644 100644 231c06d... 11181aa... M	cache.h
:100644 100644 1061072... 0004e97... M	symlinks.c
:100644 100644 54f301d... a3fd383... M	unpack-trees.c
 cache.h        |    1 +
 symlinks.c     |   87 ++++++++++++++++++++++++++++++++++++------------=
--------
 unpack-trees.c |    4 +-
 3 files changed, 59 insertions(+), 33 deletions(-)

diff --git a/cache.h b/cache.h
index 231c06d7726b575f6e522d5b0c0fe43557e8c651..11181aa0079ce94bfbdb2bb=
a77205f49aa3cbcb3 100644
--- a/cache.h
+++ b/cache.h
@@ -720,6 +720,7 @@ struct checkout {
=20
 extern int checkout_entry(struct cache_entry *ce, const struct checkou=
t *state, char *topath);
 extern int has_symlink_leading_path(int len, const char *name);
+extern int has_symlink_or_noent_leading_path(int len, const char *name=
);
=20
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/symlinks.c b/symlinks.c
index 1061072e9b18b12ca22c643bf9a3ea977eeb9916..0004e97d2547467564b1462=
32f40cba4f5b04a3e 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -4,6 +4,7 @@ static struct cache_def {
 	char path[PATH_MAX];
 	int len;
 	int flags;
+	int track_flags;
 } cache;
=20
 static inline int greatest_match_lstat_cache(int len, const char *name=
)
@@ -24,21 +25,23 @@ static inline int greatest_match_lstat_cache(int le=
n, const char *name)
 	return match_len;
 }
=20
-static inline void reset_lstat_cache(void)
+static inline void reset_lstat_cache(int track_flags)
 {
 	cache.path[0] =3D '\0';
 	cache.len =3D 0;
 	cache.flags =3D 0;
+	cache.track_flags =3D track_flags;
 }
=20
 #define FL_DIR      (1 << 0)
-#define FL_SYMLINK  (1 << 1)
-#define FL_LSTATERR (1 << 2)
-#define FL_ERR      (1 << 3)
+#define FL_NOENT    (1 << 1)
+#define FL_SYMLINK  (1 << 2)
+#define FL_LSTATERR (1 << 3)
+#define FL_ERR      (1 << 4)
=20
 /*
  * Check if name 'name' of length 'len' has a symlink leading
- * component, or if the directory exists and is real.
+ * component, or if the directory exists and is real, or not.
  *
  * To speed up the check, some information is allowed to be cached.
  * This is can be indicated by the 'track_flags' argument.
@@ -50,22 +53,32 @@ static int lstat_cache(int len, const char *name,
 	int match_flags, ret_flags, save_flags;
 	struct stat st;
=20
-	/*
-	 * Check to see if we have a match from the cache for the
-	 * symlink path type.
-	 */
-	match_len =3D last_slash =3D greatest_match_lstat_cache(len, name);
-	match_flags =3D cache.flags & track_flags & FL_SYMLINK;
-	if (match_flags && match_len =3D=3D cache.len)
-		return match_flags;
-	/*
-	 * If 'name' is a substring of the cache on a path component
-	 * basis, and a directory is cached, we can return
-	 * immediately.
-	 */
-	match_flags =3D cache.flags & track_flags & FL_DIR;
-	if (match_flags && match_len =3D=3D len)
-		return match_flags;
+	if (cache.track_flags !=3D track_flags) {
+		/*
+		 * As a safeguard we clear the cache if the value of
+		 * track_flags does not match with the last supplied
+		 * value.
+		 */
+		reset_lstat_cache(track_flags);
+		match_len =3D last_slash =3D 0;
+	} else {
+		/*
+		 * Check to see if we have a match from the cache for
+		 * the 2 "excluding" path types.
+		 */
+		match_len =3D last_slash =3D greatest_match_lstat_cache(len, name);
+		match_flags =3D cache.flags & track_flags & (FL_NOENT|FL_SYMLINK);
+		if (match_flags && match_len =3D=3D cache.len)
+			return match_flags;
+		/*
+		 * If 'name' is a substring of the cache on a path
+		 * component basis, and a directory is cached, we
+		 * can return immediately.
+		 */
+		match_flags =3D cache.flags & track_flags & FL_DIR;
+		if (match_flags && match_len =3D=3D len)
+			return match_flags;
+	}
=20
 	/* Okay, no match from the cache so far, so now we have to
 	 * check the rest of the path components.
@@ -85,6 +98,8 @@ static int lstat_cache(int len, const char *name,
=20
 		if (lstat(cache.path, &st)) {
 			ret_flags =3D FL_LSTATERR;
+			if (errno =3D=3D ENOENT)
+				ret_flags |=3D FL_NOENT;
 		} else if (S_ISDIR(st.st_mode)) {
 			last_slash_dir =3D last_slash;
 			continue;
@@ -96,11 +111,11 @@ static int lstat_cache(int len, const char *name,
 		break;
 	}
=20
-	/* At the end update the cache.  Note that max 2 different
-	 * path types, FL_SYMLINK and FL_DIR, can be cached for the
-	 * moment!
+	/* At the end update the cache.  Note that max 3 different
+	 * path types, FL_NOENT, FL_SYMLINK and FL_DIR, can be cached
+	 * for the moment!
 	 */
-	save_flags =3D ret_flags & track_flags & FL_SYMLINK;
+	save_flags =3D ret_flags & track_flags & (FL_NOENT|FL_SYMLINK);
 	if (save_flags && last_slash > 0 && last_slash <=3D PATH_MAX) {
 		cache.path[last_slash] =3D '\0';
 		cache.len   =3D last_slash;
@@ -108,20 +123,20 @@ static int lstat_cache(int len, const char *name,
 	} else if (track_flags & FL_DIR &&
 		   last_slash_dir > 0 && last_slash_dir <=3D PATH_MAX) {
 		/* We have a separate test for the directory case,
-		 * since it could be that we have found a symlink and
-		 * the track_flags says that we can not cache this
-		 * fact, so the cache would then have been left empty
-		 * in this case.
+		 * since it could be that we have found a symlink or a
+		 * none existing directory and the track_flags says
+		 * that we can not cache this fact, so the cache would
+		 * then have been left empty in this case.
 		 *
 		 * But, if we is allowed to track real directories, we
 		 * can still cache the path components before the last
-		 * one (the found symlink component).
+		 * one (the found symlink or none existing component).
 		 */
 		cache.path[last_slash_dir] =3D '\0';
 		cache.len   =3D last_slash_dir;
 		cache.flags =3D FL_DIR;
 	} else {
-		reset_lstat_cache();
+		reset_lstat_cache(track_flags);
 	}
 	return ret_flags;
 }
@@ -134,3 +149,13 @@ int has_symlink_leading_path(int len, const char *=
name)
 			   FL_SYMLINK|FL_DIR) &
 		FL_SYMLINK;
 }
+
+/* Return non-zero if path 'name' has a leading symlink component or
+ * if some leading path component does not exists.
+ */
+int has_symlink_or_noent_leading_path(int len, const char *name)
+{
+	return lstat_cache(len, name,
+			   FL_SYMLINK|FL_NOENT|FL_DIR) &
+		(FL_SYMLINK|FL_NOENT);
+}
diff --git a/unpack-trees.c b/unpack-trees.c
index 54f301da67be879c80426bc21776427fdd38c02e..a3fd383afbe951fea8dbe43=
78cbe489657843c4a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -61,7 +61,7 @@ static void unlink_entry(struct cache_entry *ce)
 	char *cp, *prev;
 	char *name =3D ce->name;
=20
-	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
+	if (has_symlink_or_noent_leading_path(ce_namelen(ce), ce->name))
 		return;
 	if (unlink(name))
 		return;
@@ -584,7 +584,7 @@ static int verify_absent(struct cache_entry *ce, co=
nst char *action,
 	if (o->index_only || o->reset || !o->update)
 		return 0;
=20
-	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
+	if (has_symlink_or_noent_leading_path(ce_namelen(ce), ce->name))
 		return 0;
=20
 	if (!lstat(ce->name, &st)) {
--=20
1.6.1.rc1.49.g7f705
