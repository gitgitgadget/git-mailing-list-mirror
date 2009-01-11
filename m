From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v6 1/3] lstat_cache(): more cache effective
 symlink/directory detection
Date: Sun, 11 Jan 2009 14:29:00 +0100
Message-ID: <1231680542-17315-2-git-send-email-barvik@broadpark.no>
References: <1231680542-17315-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Ren=E9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 14:30:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM0Ot-000569-4P
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 14:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbZAKN3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jan 2009 08:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbZAKN3S
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 08:29:18 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:33553 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489AbZAKN3M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 08:29:12 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDB00DFH6SNDUB0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 14:29:11 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.153])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KDB00HSC6SEFR30@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 14:29:11 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.49.g7f705
In-reply-to: <1231680542-17315-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105177>

Make the cache functionality more effective.  Previously when A/B/C/D
was in the cache and A/B/C/E/file.c was called for, there was no match
at all from the cache.  Now we use the fact that the paths "A", "A/B"
and "A/B/C" are already tested, and we only need to do an lstat() call
on "A/B/C/E".

We only cache/store the last path regardless of its type.  Since the
cache functionality is always used with alphabetically sorted names
(at least it seems so for me), there is no need to store both the last
symlink-leading path and the last real-directory path.  Note that if
the cache is not called with (mostly) alphabetically sorted names,
neither the old, nor this new one, would be very effective.

Previously, when symlink A/B/C/S was cached/stored in the symlink-
leading path, and A/B/C/file.c was called for, it was not easy to use
the fact that we already knew that the paths "A", "A/B" and "A/B/C"
are real directories.

Avoid copying the first path components of the name 2 zillion times
when we test new path components.  Since we always cache/store the
last path, we can copy each component as we test those directly into
the cache.  Previously we ended up doing a memcpy() for the full
path/name right before each lstat() call, and when updating the cache
for each time we have tested a new path component.

We also use less memory, that is, PATH_MAX bytes less memory on the
stack and PATH_MAX bytes less memory on the heap.

Thanks to Junio C Hamano, Linus Torvalds and Ren=E9 Scharfe for valuabl=
e
comments to this patch!

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
:100644 100644 5a5e781... 1061072... M	symlinks.c
 symlinks.c |  152 ++++++++++++++++++++++++++++++++++++++++++++--------=
--------
 1 files changed, 112 insertions(+), 40 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 5a5e781a15d7d9cb60797958433eca896b31ec85..1061072e9b18b12ca22c643=
bf9a3ea977eeb9916 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -1,64 +1,136 @@
 #include "cache.h"
=20
-struct pathname {
-	int len;
+static struct cache_def {
 	char path[PATH_MAX];
-};
+	int len;
+	int flags;
+} cache;
=20
-/* Return matching pathname prefix length, or zero if not matching */
-static inline int match_pathname(int len, const char *name, struct pat=
hname *match)
+static inline int greatest_match_lstat_cache(int len, const char *name=
)
 {
-	int match_len =3D match->len;
-	return (len > match_len &&
-		name[match_len] =3D=3D '/' &&
-		!memcmp(name, match->path, match_len)) ? match_len : 0;
+	int max_len, match_len =3D 0, i =3D 0;
+
+	max_len =3D len < cache.len ? len : cache.len;
+	while (i < max_len && name[i] =3D=3D cache.path[i]) {
+		if (name[i] =3D=3D '/') match_len =3D i;
+		i++;
+	}
+	if (i =3D=3D cache.len && len > cache.len && name[cache.len] =3D=3D '=
/')
+		match_len =3D cache.len;
+	else if (i =3D=3D len && len < cache.len && cache.path[len] =3D=3D '/=
')
+		match_len =3D len;
+	else if (i =3D=3D len && i =3D=3D cache.len)
+		match_len =3D len;
+	return match_len;
 }
=20
-static inline void set_pathname(int len, const char *name, struct path=
name *match)
+static inline void reset_lstat_cache(void)
 {
-	if (len < PATH_MAX) {
-		match->len =3D len;
-		memcpy(match->path, name, len);
-		match->path[len] =3D 0;
-	}
+	cache.path[0] =3D '\0';
+	cache.len =3D 0;
+	cache.flags =3D 0;
 }
=20
-int has_symlink_leading_path(int len, const char *name)
+#define FL_DIR      (1 << 0)
+#define FL_SYMLINK  (1 << 1)
+#define FL_LSTATERR (1 << 2)
+#define FL_ERR      (1 << 3)
+
+/*
+ * Check if name 'name' of length 'len' has a symlink leading
+ * component, or if the directory exists and is real.
+ *
+ * To speed up the check, some information is allowed to be cached.
+ * This is can be indicated by the 'track_flags' argument.
+ */
+static int lstat_cache(int len, const char *name,
+		       int track_flags)
 {
-	static struct pathname link, nonlink;
-	char path[PATH_MAX];
+	int match_len, last_slash, last_slash_dir, max_len;
+	int match_flags, ret_flags, save_flags;
 	struct stat st;
-	char *sp;
-	int known_dir;
=20
 	/*
-	 * See if the last known symlink cache matches.
+	 * Check to see if we have a match from the cache for the
+	 * symlink path type.
 	 */
-	if (match_pathname(len, name, &link))
-		return 1;
-
+	match_len =3D last_slash =3D greatest_match_lstat_cache(len, name);
+	match_flags =3D cache.flags & track_flags & FL_SYMLINK;
+	if (match_flags && match_len =3D=3D cache.len)
+		return match_flags;
 	/*
-	 * Get rid of the last known directory part
+	 * If 'name' is a substring of the cache on a path component
+	 * basis, and a directory is cached, we can return
+	 * immediately.
 	 */
-	known_dir =3D match_pathname(len, name, &nonlink);
+	match_flags =3D cache.flags & track_flags & FL_DIR;
+	if (match_flags && match_len =3D=3D len)
+		return match_flags;
=20
-	while ((sp =3D strchr(name + known_dir + 1, '/')) !=3D NULL) {
-		int thislen =3D sp - name ;
-		memcpy(path, name, thislen);
-		path[thislen] =3D 0;
+	/* Okay, no match from the cache so far, so now we have to
+	 * check the rest of the path components.
+	 */
+	ret_flags =3D FL_DIR;
+	last_slash_dir =3D last_slash;
+	max_len =3D len < PATH_MAX ? len : PATH_MAX;
+	while (match_len < max_len) {
+		do {
+			cache.path[match_len] =3D name[match_len];
+			match_len++;
+		} while (match_len < max_len && name[match_len] !=3D '/');
+		if (match_len >=3D max_len)
+			break;
+		last_slash =3D match_len;
+		cache.path[last_slash] =3D '\0';
=20
-		if (lstat(path, &st))
-			return 0;
-		if (S_ISDIR(st.st_mode)) {
-			set_pathname(thislen, path, &nonlink);
-			known_dir =3D thislen;
+		if (lstat(cache.path, &st)) {
+			ret_flags =3D FL_LSTATERR;
+		} else if (S_ISDIR(st.st_mode)) {
+			last_slash_dir =3D last_slash;
 			continue;
-		}
-		if (S_ISLNK(st.st_mode)) {
-			set_pathname(thislen, path, &link);
-			return 1;
+		} else if (S_ISLNK(st.st_mode)) {
+			ret_flags =3D FL_SYMLINK;
+		} else {
+			ret_flags =3D FL_ERR;
 		}
 		break;
 	}
-	return 0;
+
+	/* At the end update the cache.  Note that max 2 different
+	 * path types, FL_SYMLINK and FL_DIR, can be cached for the
+	 * moment!
+	 */
+	save_flags =3D ret_flags & track_flags & FL_SYMLINK;
+	if (save_flags && last_slash > 0 && last_slash <=3D PATH_MAX) {
+		cache.path[last_slash] =3D '\0';
+		cache.len   =3D last_slash;
+		cache.flags =3D save_flags;
+	} else if (track_flags & FL_DIR &&
+		   last_slash_dir > 0 && last_slash_dir <=3D PATH_MAX) {
+		/* We have a separate test for the directory case,
+		 * since it could be that we have found a symlink and
+		 * the track_flags says that we can not cache this
+		 * fact, so the cache would then have been left empty
+		 * in this case.
+		 *
+		 * But, if we is allowed to track real directories, we
+		 * can still cache the path components before the last
+		 * one (the found symlink component).
+		 */
+		cache.path[last_slash_dir] =3D '\0';
+		cache.len   =3D last_slash_dir;
+		cache.flags =3D FL_DIR;
+	} else {
+		reset_lstat_cache();
+	}
+	return ret_flags;
+}
+
+/* Return non-zero if path 'name' has a leading symlink component.
+ */
+int has_symlink_leading_path(int len, const char *name)
+{
+	return lstat_cache(len, name,
+			   FL_SYMLINK|FL_DIR) &
+		FL_SYMLINK;
 }
--=20
1.6.1.rc1.49.g7f705
