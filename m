From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v6 3/3] lstat_cache(): introduce has_dirs_only_path()
 function
Date: Sun, 11 Jan 2009 14:29:02 +0100
Message-ID: <1231680542-17315-4-git-send-email-barvik@broadpark.no>
References: <1231680542-17315-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Ren=E9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 14:30:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM0Ou-000569-Fp
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 14:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859AbZAKN30 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jan 2009 08:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752396AbZAKN3Y
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 08:29:24 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:33562 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489AbZAKN3U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 08:29:20 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDB00DG36SUDUB0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 14:29:18 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.153])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KDB00HSC6SEFR30@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 14:29:18 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.49.g7f705
In-reply-to: <1231680542-17315-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105176>

Inside the create_directories() function inside entry.c we currently
do an stat() or lstat() call for each path component of the pathname
'path' each and every time called.  For the 'git checkout' command,
this function is called on each file for which we must do an update
(ce->ce_flags & CE_UPDATE), so we get lots and lots of calls...

To fix this, we make a new wrapper to the lstat_cache() function, and
call the wrapper function instead of the calls to the stat() or the
lstat() functions.  Since the paths given to the create_directories()
function, is sorted alphabetically, the new wrapper would be very
cache effective in this situation.

To support it we must update the lstat_cache() function to be able to
say that "pleace test the complete length of 'name'", and also to give
it the length of a prefix, where the cache should use the stat()
function instead of the lstat() function to test each path component.

Thanks to Junio C Hamano, Linus Torvalds and Ren=E9 Scharfe for valuabl=
e
comments to this patch!

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
:100644 100644 11181aa... 7c8c8e4... M	cache.h
:100644 100644 aa2ee46... b0295bd... M	entry.c
:100644 100644 0004e97... c92fac7... M	symlinks.c
 cache.h    |    1 +
 entry.c    |   34 +++++++++++-----------------------
 symlinks.c |   59 ++++++++++++++++++++++++++++++++++++++++++++--------=
-------
 3 files changed, 56 insertions(+), 38 deletions(-)

diff --git a/cache.h b/cache.h
index 11181aa0079ce94bfbdb2bba77205f49aa3cbcb3..7c8c8e484259a69bdc2c75e=
9e820247b0df04d01 100644
--- a/cache.h
+++ b/cache.h
@@ -721,6 +721,7 @@ struct checkout {
 extern int checkout_entry(struct cache_entry *ce, const struct checkou=
t *state, char *topath);
 extern int has_symlink_leading_path(int len, const char *name);
 extern int has_symlink_or_noent_leading_path(int len, const char *name=
);
+extern int has_dirs_only_path(int len, const char *name, int prefix_le=
n);
=20
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/entry.c b/entry.c
index aa2ee46a84033585d8e07a585610c5a697af82c2..b0295bd5559d4a106d977da=
7a54b0cdd8399c208 100644
--- a/entry.c
+++ b/entry.c
@@ -8,35 +8,23 @@ static void create_directories(const char *path, cons=
t struct checkout *state)
 	const char *slash =3D path;
=20
 	while ((slash =3D strchr(slash+1, '/')) !=3D NULL) {
-		struct stat st;
-		int stat_status;
-
 		len =3D slash - path;
 		memcpy(buf, path, len);
 		buf[len] =3D 0;
=20
-		if (len <=3D state->base_dir_len)
-			/*
-			 * checkout-index --prefix=3D<dir>; <dir> is
-			 * allowed to be a symlink to an existing
-			 * directory.
-			 */
-			stat_status =3D stat(buf, &st);
-		else
-			/*
-			 * if there currently is a symlink, we would
-			 * want to replace it with a real directory.
-			 */
-			stat_status =3D lstat(buf, &st);
-
-		if (!stat_status && S_ISDIR(st.st_mode))
+		/* For 'checkout-index --prefix=3D<dir>', <dir> is
+		 * allowed to be a symlink to an existing directory,
+		 * and we set 'state->base_dir_len' below, such that
+		 * we test the path components of the prefix with the
+		 * stat() function instead of the lstat() function.
+		 */
+		if (has_dirs_only_path(len, buf, state->base_dir_len))
 			continue; /* ok, it is already a directory. */
=20
-		/*
-		 * We know stat_status =3D=3D 0 means something exists
-		 * there and this mkdir would fail, but that is an
-		 * error codepath; we do not care, as we unlink and
-		 * mkdir again in such a case.
+		/* If this mkdir() would fail, it could be that there
+		 * is already a symlink or something else exists
+		 * there, therefore we then try to unlink it and try
+		 * one more time to create the directory.
 		 */
 		if (mkdir(buf, 0777)) {
 			if (errno =3D=3D EEXIST && state->force &&
diff --git a/symlinks.c b/symlinks.c
index 0004e97d2547467564b146232f40cba4f5b04a3e..c92fac7506a702157e4b780=
d4331f3c7b412798d 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -1,10 +1,11 @@
 #include "cache.h"
=20
 static struct cache_def {
-	char path[PATH_MAX];
+	char path[PATH_MAX + 1];
 	int len;
 	int flags;
 	int track_flags;
+	int prefix_len_stat_func;
 } cache;
=20
 static inline int greatest_match_lstat_cache(int len, const char *name=
)
@@ -25,12 +26,13 @@ static inline int greatest_match_lstat_cache(int le=
n, const char *name)
 	return match_len;
 }
=20
-static inline void reset_lstat_cache(int track_flags)
+static inline void reset_lstat_cache(int track_flags, int prefix_len_s=
tat_func)
 {
 	cache.path[0] =3D '\0';
 	cache.len =3D 0;
 	cache.flags =3D 0;
 	cache.track_flags =3D track_flags;
+	cache.prefix_len_stat_func =3D prefix_len_stat_func;
 }
=20
 #define FL_DIR      (1 << 0)
@@ -38,28 +40,35 @@ static inline void reset_lstat_cache(int track_flag=
s)
 #define FL_SYMLINK  (1 << 2)
 #define FL_LSTATERR (1 << 3)
 #define FL_ERR      (1 << 4)
+#define FL_FULLPATH (1 << 5)
=20
 /*
  * Check if name 'name' of length 'len' has a symlink leading
  * component, or if the directory exists and is real, or not.
  *
  * To speed up the check, some information is allowed to be cached.
- * This is can be indicated by the 'track_flags' argument.
+ * This is can be indicated by the 'track_flags' argument, which also
+ * can be used to indicate that we should always check the full path.
+ *
+ * The 'prefix_len_stat_func' parameter can be used to set the length
+ * of the prefix, where the cache should use the stat() function
+ * instead of the lstat() function to test each path component.
  */
 static int lstat_cache(int len, const char *name,
-		       int track_flags)
+		       int track_flags, int prefix_len_stat_func)
 {
-	int match_len, last_slash, last_slash_dir, max_len;
+	int match_len, last_slash, last_slash_dir, max_len, ret;
 	int match_flags, ret_flags, save_flags;
 	struct stat st;
=20
-	if (cache.track_flags !=3D track_flags) {
+	if (cache.track_flags !=3D track_flags ||
+	    cache.prefix_len_stat_func !=3D prefix_len_stat_func) {
 		/*
-		 * As a safeguard we clear the cache if the value of
-		 * track_flags does not match with the last supplied
-		 * value.
+		 * As a safeguard we clear the cache if the values of
+		 * track_flags and/or prefix_len_stat_func does not
+		 * match with the last supplied values.
 		 */
-		reset_lstat_cache(track_flags);
+		reset_lstat_cache(track_flags, prefix_len_stat_func);
 		match_len =3D last_slash =3D 0;
 	} else {
 		/*
@@ -91,12 +100,17 @@ static int lstat_cache(int len, const char *name,
 			cache.path[match_len] =3D name[match_len];
 			match_len++;
 		} while (match_len < max_len && name[match_len] !=3D '/');
-		if (match_len >=3D max_len)
+		if (match_len >=3D max_len && !(track_flags & FL_FULLPATH))
 			break;
 		last_slash =3D match_len;
 		cache.path[last_slash] =3D '\0';
=20
-		if (lstat(cache.path, &st)) {
+		if (last_slash <=3D prefix_len_stat_func)
+			ret =3D stat(cache.path, &st);
+		else
+			ret =3D lstat(cache.path, &st);
+
+		if (ret) {
 			ret_flags =3D FL_LSTATERR;
 			if (errno =3D=3D ENOENT)
 				ret_flags |=3D FL_NOENT;
@@ -136,17 +150,19 @@ static int lstat_cache(int len, const char *name,
 		cache.len   =3D last_slash_dir;
 		cache.flags =3D FL_DIR;
 	} else {
-		reset_lstat_cache(track_flags);
+		reset_lstat_cache(track_flags, prefix_len_stat_func);
 	}
 	return ret_flags;
 }
=20
+#define USE_ONLY_LSTAT  0
+
 /* Return non-zero if path 'name' has a leading symlink component.
  */
 int has_symlink_leading_path(int len, const char *name)
 {
 	return lstat_cache(len, name,
-			   FL_SYMLINK|FL_DIR) &
+			   FL_SYMLINK|FL_DIR, USE_ONLY_LSTAT) &
 		FL_SYMLINK;
 }
=20
@@ -156,6 +172,19 @@ int has_symlink_leading_path(int len, const char *=
name)
 int has_symlink_or_noent_leading_path(int len, const char *name)
 {
 	return lstat_cache(len, name,
-			   FL_SYMLINK|FL_NOENT|FL_DIR) &
+			   FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT) &
 		(FL_SYMLINK|FL_NOENT);
 }
+
+/* Return non-zero if all path components of 'name' exists as a
+ * directory.  If prefix_len > 0, we will test with the stat()
+ * function instead of the lstat() function for a prefix length of
+ * 'prefix_len', thus we then allow for symlink(s) in the prefix part
+ * as long as those points to real existing directories.
+ */
+int has_dirs_only_path(int len, const char *name, int prefix_len)
+{
+	return lstat_cache(len, name,
+			   FL_DIR|FL_FULLPATH, prefix_len) &
+		FL_DIR;
+}
--=20
1.6.1.rc1.49.g7f705
