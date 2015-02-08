From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/24] untracked cache: guard and disable on system changes
Date: Sun,  8 Feb 2015 15:55:47 +0700
Message-ID: <1423385748-19825-24-git-send-email-pclouds@gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 09:58:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNgt-0003YQ-P5
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 09:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbbBHI6D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 03:58:03 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:46882 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbbBHI6B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 03:58:01 -0500
Received: by pdjz10 with SMTP id z10so24351754pdj.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 00:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WF+3c/jRzks2IqXGwo6XAO44Cr8Im1dOPGalOMDoA+I=;
        b=Uc2IX+Q3aShDMJMFabOX7lZ9Agtq2hTHd6VAzOY53mm3abIOIPRJJND/IJK7st8lKm
         A1/7X450YmR4EJiH10N6R0pNNaoxHr9mp0IC9FOaKGxzhyxioPZPTuUSxZ0y/XWaOuoM
         MiD38fugJx0fx8v0XoxzjflG7m10NDNYm573gP7KGauDA+PnFvp5IYjzIH69BAM8mzwG
         dje6bukjGBnoHhuIpOs9dzMdJtn5kRW7RsFc7mFZr1u1MGBp1hV+oK9NBPGa1FnOkFJG
         NJEpVxuzLL3bgBG89PGd/yLkNWTD6bKSi4ZqDenAJTJnk0OzBV7y3QtNGTP8BAuGBi58
         rgaw==
X-Received: by 10.66.62.138 with SMTP id y10mr19184545par.51.1423385880748;
        Sun, 08 Feb 2015 00:58:00 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id ir9sm12942208pbc.3.2015.02.08.00.57.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 00:58:00 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 15:58:08 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263485>

If the user enables untracked cache, then

 - move worktree to an unsupported filesystem
 - or simply upgrade OS
 - or move the whole (portable) disk from one machine to another
 - or access a shared fs from another machine

there's no guarantee that untracked cache can still function properly.
Record the worktree location and OS footprint in the cache. If it
changes, err on the safe side and disable the cache. The user can
'update-index --untracked-cache' again to make sure all conditions are
met.

This adds a new requirement that setup_git_directory* must be called
before read_cache() because we need worktree location by then, or the
cache is dropped.

This change does not cover all bases, you can fool it if you try
hard. The point is to stop accidents.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/index-format.txt |  4 +++
 builtin/update-index.c                   | 16 ++++++----
 dir.c                                    | 55 ++++++++++++++++++++++++=
+++++++-
 dir.h                                    |  2 ++
 git-compat-util.h                        |  1 +
 test-dump-untracked-cache.c              |  1 +
 6 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
index 899dd3d..e24b4bc 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -242,6 +242,10 @@ Git index format
=20
   The extension starts with
=20
+  - A sequence of NUL-terminated strings, preceded by the size of the
+    sequence in variable width encoding. Each string describes the
+    environment where the cache can be used.
+
   - Stat data of $GIT_DIR/info/exclude. See "Index entry" section from
     ctime field until "file size".
=20
diff --git a/builtin/update-index.c b/builtin/update-index.c
index f5f6689..fc5e108 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1103,7 +1103,7 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
 		the_index.split_index =3D NULL;
 		the_index.cache_changed |=3D SOMETHING_CHANGED;
 	}
-	if (untracked_cache > 0 && !the_index.untracked) {
+	if (untracked_cache > 0) {
 		struct untracked_cache *uc;
=20
 		if (untracked_cache < 2) {
@@ -1111,11 +1111,15 @@ int cmd_update_index(int argc, const char **arg=
v, const char *prefix)
 			if (!test_if_untracked_cache_is_supported())
 				return 1;
 		}
-		uc =3D xcalloc(1, sizeof(*uc));
-		uc->exclude_per_dir =3D ".gitignore";
-		/* should be the same flags used by git-status */
-		uc->dir_flags =3D DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECT=
ORIES;
-		the_index.untracked =3D uc;
+		if (!the_index.untracked) {
+			uc =3D xcalloc(1, sizeof(*uc));
+			strbuf_init(&uc->ident, 100);
+			uc->exclude_per_dir =3D ".gitignore";
+			/* should be the same flags used by git-status */
+			uc->dir_flags =3D DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIREC=
TORIES;
+			the_index.untracked =3D uc;
+		}
+		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |=3D UNTRACKED_CHANGED;
 	} else if (!untracked_cache && the_index.untracked) {
 		the_index.untracked =3D NULL;
diff --git a/dir.c b/dir.c
index 5b9dd5d..b8a4f9e 100644
--- a/dir.c
+++ b/dir.c
@@ -1793,6 +1793,40 @@ static int treat_leading_path(struct dir_struct =
*dir,
 	return rc;
 }
=20
+static const char *get_ident_string(void)
+{
+	static struct strbuf sb =3D STRBUF_INIT;
+	struct utsname uts;
+
+	if (sb.len)
+		return sb.buf;
+	if (uname(&uts))
+		die_errno(_("failed to get kernel name and information"));
+	strbuf_addf(&sb, "Location %s, system %s %s %s", get_git_work_tree(),
+		    uts.sysname, uts.release, uts.version);
+	return sb.buf;
+}
+
+static int ident_in_untracked(const struct untracked_cache *uc)
+{
+	const char *end =3D uc->ident.buf + uc->ident.len;
+	const char *p   =3D uc->ident.buf;
+
+	for (p =3D uc->ident.buf; p < end; p +=3D strlen(p) + 1)
+		if (!strcmp(p, get_ident_string()))
+			return 1;
+	return 0;
+}
+
+void add_untracked_ident(struct untracked_cache *uc)
+{
+	if (ident_in_untracked(uc))
+		return;
+	strbuf_addstr(&uc->ident, get_ident_string());
+	/* this strbuf contains a list of strings, save NUL too */
+	strbuf_addch(&uc->ident, 0);
+}
+
 static struct untracked_cache_dir *validate_untracked_cache(struct dir=
_struct *dir,
 						      int base_len,
 						      const struct pathspec *pathspec)
@@ -1859,6 +1893,11 @@ static struct untracked_cache_dir *validate_untr=
acked_cache(struct dir_struct *d
 		if (ce_skip_worktree(active_cache[i]))
 			return NULL;
=20
+	if (!ident_in_untracked(dir->untracked)) {
+		warning(_("Untracked cache is disabled on this system."));
+		return NULL;
+	}
+
 	if (!dir->untracked->root) {
 		const int len =3D sizeof(*dir->untracked->root);
 		dir->untracked->root =3D xmalloc(len);
@@ -2263,6 +2302,11 @@ void write_untracked_extension(struct strbuf *ou=
t, struct untracked_cache *untra
 	hashcpy(ouc->excludes_file_sha1, untracked->ss_excludes_file.sha1);
 	ouc->dir_flags =3D htonl(untracked->dir_flags);
 	memcpy(ouc->exclude_per_dir, untracked->exclude_per_dir, len + 1);
+
+	varint_len =3D encode_varint(untracked->ident.len, varbuf);
+	strbuf_add(out, varbuf, varint_len);
+	strbuf_add(out, untracked->ident.buf, untracked->ident.len);
+
 	strbuf_add(out, ouc, ouc_size(len));
 	if (!untracked->root) {
 		varint_len =3D encode_varint(0, varbuf);
@@ -2446,17 +2490,26 @@ struct untracked_cache *read_untracked_extensio=
n(const void *data, unsigned long
 	struct untracked_cache *uc;
 	struct read_data rd;
 	const unsigned char *next =3D data, *end =3D (const unsigned char *)d=
ata + sz;
-	int len;
+	const char *ident;
+	int ident_len, len;
=20
 	if (sz <=3D 1 || end[-1] !=3D '\0')
 		return NULL;
 	end--;
=20
+	ident_len =3D decode_varint(&next);
+	if (next + ident_len > end)
+		return NULL;
+	ident =3D (const char *)next;
+	next +=3D ident_len;
+
 	ouc =3D (const struct ondisk_untracked_cache *)next;
 	if (next + ouc_size(0) > end)
 		return NULL;
=20
 	uc =3D xcalloc(1, sizeof(*uc));
+	strbuf_init(&uc->ident, ident_len);
+	strbuf_add(&uc->ident, ident, ident_len);
 	load_sha1_stat(&uc->ss_info_exclude, &ouc->info_exclude_stat,
 		       ouc->info_exclude_sha1);
 	load_sha1_stat(&uc->ss_excludes_file, &ouc->excludes_file_stat,
diff --git a/dir.h b/dir.h
index 2ce7dd3..6ccbc45 100644
--- a/dir.h
+++ b/dir.h
@@ -127,6 +127,7 @@ struct untracked_cache {
 	struct sha1_stat ss_info_exclude;
 	struct sha1_stat ss_excludes_file;
 	const char *exclude_per_dir;
+	struct strbuf ident;
 	/*
 	 * dir_struct#flags must match dir_flags or the untracked
 	 * cache is ignored.
@@ -305,4 +306,5 @@ void untracked_cache_add_to_index(struct index_stat=
e *, const char *);
 void free_untracked_cache(struct untracked_cache *);
 struct untracked_cache *read_untracked_extension(const void *data, uns=
igned long sz);
 void write_untracked_extension(struct strbuf *out, struct untracked_ca=
che *untracked);
+void add_untracked_ident(struct untracked_cache *);
 #endif
diff --git a/git-compat-util.h b/git-compat-util.h
index f587749..e9502a1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -132,6 +132,7 @@
 #elif defined(_MSC_VER)
 #include "compat/msvc.h"
 #else
+#include <sys/utsname.h>
 #include <sys/wait.h>
 #include <sys/resource.h>
 #include <sys/socket.h>
diff --git a/test-dump-untracked-cache.c b/test-dump-untracked-cache.c
index 710441e..25d855d 100644
--- a/test-dump-untracked-cache.c
+++ b/test-dump-untracked-cache.c
@@ -44,6 +44,7 @@ int main(int ac, char **av)
 {
 	struct untracked_cache *uc;
 	struct strbuf base =3D STRBUF_INIT;
+	setup_git_directory();
 	if (read_cache() < 0)
 		die("unable to read index file");
 	uc =3D the_index.untracked;
--=20
2.3.0.rc1.137.g477eb31
