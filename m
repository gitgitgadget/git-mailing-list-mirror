From: Jonathan Nieder <jrnieder@gmail.com>
Subject: jn/svn-fe
Date: Thu, 12 Aug 2010 19:08:48 -0500
Message-ID: <20100813000848.GA8076@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C63BD9B.6000608@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Aug 13 02:10:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojhqy-0002Ri-FH
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 02:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761132Ab0HMAKW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 20:10:22 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33278 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810Ab0HMAKV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 20:10:21 -0400
Received: by qwh6 with SMTP id 6so2112719qwh.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 17:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=2tPcsLMhNPWZ9rCn37uzyB6QdECNPG7QFMbSl/weOZQ=;
        b=QeefZSM58QzysymeQoPRG7KViimhJkbwdq4uZb8DC8no+wNh1IbAN2PCTW+VlVSyzT
         w0jSctQNMKLH9oHougBnQ+BKQIJ/LXgoOpi6qQxsoUNMAbTdiXJr4dLtmg01e7FmRefC
         LGmQUt1BDdpR88wF/+XBb/+i46k0yafTkSeyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=r9Ha/CD4X5/9ZSWA5YJ7poFXf+zkPN5wUhPMiXyoEd1VsUFn5qKWJjFzMu/uhKTml7
         aiRdde4kyPvfUeCJ5T+JhI4DgRdciq6GhBolIRJFnCe0J3iTFwkd2qWLBuhN4R+9hz0D
         OK2HrkcMtN9vsY7HawvXPL2FuMmLlOlV00Nmk=
Received: by 10.220.62.72 with SMTP id w8mr528380vch.201.1281658220284;
        Thu, 12 Aug 2010 17:10:20 -0700 (PDT)
Received: from burratino ([66.99.3.154])
        by mx.google.com with ESMTPS id d19sm865639vcs.25.2010.08.12.17.10.18
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 17:10:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C63BD9B.6000608@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153443>

(pruned Ccs)

Johannes Sixt wrote:
> Am 8/12/2010 1:35, schrieb Junio C Hamano:

>> * jn/svn-fe (2010-08-09) 10 commits
[...]
> This fails to build under MinGW because we don't have strtok_r() and =
a
> whole lot of other things that I didn't even look at. Can we have an
> opt-in or opt-out for this?

How about something like this instead?

-- 8< --
Subject: vcs-svn: Port to Windows

MSys #define-s dirent away.  Avoid trouble by avoiding that
identifier.

Windows does not have strtok_r (and while does have an identical
strtok_s, but it is not obvious how to use it).  Grab an
implementation from glibc.

The svn-fe test fails in the =E2=80=9Csvn export=E2=80=9D step because =
of the
lack of symlink support.  With a less ambitious dump, it passes.

Cc: Johannes Sixt <j6t@kdbg.org>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile              |    8 ++
 compat/strtok_r.c     |   61 ++++++++++++++++
 git-compat-util.h     |    5 ++
 t/t9010-svn-fe.sh     |    4 +-
 vcs-svn/fast_export.c |    4 +-
 vcs-svn/repo_tree.c   |  188 ++++++++++++++++++++++++-----------------=
-------
 6 files changed, 172 insertions(+), 98 deletions(-)
 create mode 100644 compat/strtok_r.c

diff --git a/Makefile b/Makefile
index c441414..444a0fe 100644
--- a/Makefile
+++ b/Makefile
@@ -68,6 +68,8 @@ all::
 #
 # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
 #
+# Define NO_STRTOK_R if you don't have strtok_r in the C library.
+#
 # Define NO_LIBGEN_H if you don't have libgen.h.
 #
 # Define NEEDS_LIBGEN if your libgen needs -lgen when linking
@@ -1041,6 +1043,7 @@ ifeq ($(uname_S),Windows)
 	NO_UNSETENV =3D YesPlease
 	NO_STRCASESTR =3D YesPlease
 	NO_STRLCPY =3D YesPlease
+	NO_STRTOK_R =3D YesPlease
 	NO_MEMMEM =3D YesPlease
 	# NEEDS_LIBICONV =3D YesPlease
 	NO_ICONV =3D YesPlease
@@ -1095,6 +1098,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_UNSETENV =3D YesPlease
 	NO_STRCASESTR =3D YesPlease
 	NO_STRLCPY =3D YesPlease
+	NO_STRTOK_R =3D YesPlease
 	NO_MEMMEM =3D YesPlease
 	NEEDS_LIBICONV =3D YesPlease
 	OLD_ICONV =3D YesPlease
@@ -1325,6 +1329,10 @@ endif
 ifdef NO_STRTOULL
 	COMPAT_CFLAGS +=3D -DNO_STRTOULL
 endif
+ifdef NO_STRTOK_R
+	COMPAT_CFLAGS +=3D -DNO_STRTOK_R
+	COMPAT_OBJS +=3D compat/strtok_r.o
+endif
 ifdef NO_SETENV
 	COMPAT_CFLAGS +=3D -DNO_SETENV
 	COMPAT_OBJS +=3D compat/setenv.o
diff --git a/compat/strtok_r.c b/compat/strtok_r.c
new file mode 100644
index 0000000..7b5d568
--- /dev/null
+++ b/compat/strtok_r.c
@@ -0,0 +1,61 @@
+/* Reentrant string tokenizer.  Generic version.
+   Copyright (C) 1991,1996-1999,2001,2004 Free Software Foundation, In=
c.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful=
,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include "../git-compat-util.h"
+
+/* Parse S into tokens separated by characters in DELIM.
+   If S is NULL, the saved pointer in SAVE_PTR is used as
+   the next starting point.  For example:
+	char s[] =3D "-abc-=3D-def";
+	char *sp;
+	x =3D strtok_r(s, "-", &sp);	// x =3D "abc", sp =3D "=3D-def"
+	x =3D strtok_r(NULL, "-=3D", &sp);	// x =3D "def", sp =3D NULL
+	x =3D strtok_r(NULL, "=3D", &sp);	// x =3D NULL
+		// s =3D "abc\0-def\0"
+*/
+char *
+gitstrtok_r (char *s, const char *delim, char **save_ptr)
+{
+  char *token;
+
+  if (s =3D=3D NULL)
+    s =3D *save_ptr;
+
+  /* Scan leading delimiters.  */
+  s +=3D strspn (s, delim);
+  if (*s =3D=3D '\0')
+    {
+      *save_ptr =3D s;
+      return NULL;
+    }
+
+  /* Find the end of the token.  */
+  token =3D s;
+  s =3D strpbrk (token, delim);
+  if (s =3D=3D NULL)
+    /* This token finishes the string.  */
+    *save_ptr =3D token + strlen (token);
+  else
+    {
+      /* Terminate the token and make *SAVE_PTR point past it.  */
+      *s =3D '\0';
+      *save_ptr =3D s + 1;
+    }
+  return token;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 02a73ee..28d6b00 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -312,6 +312,11 @@ extern size_t gitstrlcpy(char *, const char *, siz=
e_t);
 extern uintmax_t gitstrtoumax(const char *, char **, int);
 #endif
=20
+#ifdef NO_STRTOK_R
+#define strtok_r gitstrtok_r
+extern char *gitstrtok_r(char *s, const char *delim, char **save_ptr);
+#endif
+
 #ifdef NO_HSTRERROR
 #define hstrerror githstrerror
 extern const char *githstrerror(int herror);
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index bf9bbd6..a713dfc 100644
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -10,7 +10,7 @@ test_dump() {
 	test_expect_success "$dump" '
 		svnadmin create "$label-svn" &&
 		svnadmin load "$label-svn" < "$TEST_DIRECTORY/$dump" &&
-		svn_cmd export "file://$(pwd)/$label-svn" "$label-svnco" &&
+		svn_cmd export "file://$PWD/$label-svn" "$label-svnco" &&
 		git init "$label-git" &&
 		test-svn-fe "$TEST_DIRECTORY/$dump" >"$label.fe" &&
 		(
@@ -27,6 +27,6 @@ test_dump() {
 	'
 }
=20
-test_dump simple t9111/svnsync.dump
+test_dump simple t9135/svn.dump
=20
 test_done
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 3a6156f..1f8d8ab 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -48,8 +48,8 @@ void fast_export_commit(uint32_t revision, uint32_t a=
uthor, char *log,
 		   ~author ? pool_fetch(author) : "nobody",
 		   ~author ? pool_fetch(author) : "nobody",
 		   ~uuid ? pool_fetch(uuid) : "local", timestamp);
-	printf("data %zd\n%s%s\n",
-		   strlen(log) + strlen(gitsvnline), log, gitsvnline);
+	printf("data %d\n%s%s\n",
+		   (int) strlen(log) + strlen(gitsvnline), log, gitsvnline);
 	if (!first_commit_done) {
 		if (revision > 1)
 			printf("from refs/heads/master^0\n");
diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index c3d7ee7..194218d 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -12,7 +12,7 @@
=20
 #include "trp.h"
=20
-struct repo_dirent {
+struct repo_dent {
 	uint32_t name_offset;
 	struct trp_node children;
 	uint32_t mode;
@@ -27,18 +27,18 @@ struct repo_commit {
 	uint32_t root_dir_offset;
 };
=20
-/* Memory pools for commit, dir and dirent */
+/* Memory pools for commit, dir and dent */
 obj_pool_gen(commit, struct repo_commit, 4096)
 obj_pool_gen(dir, struct repo_dir, 4096)
-obj_pool_gen(dirent, struct repo_dirent, 4096)
+obj_pool_gen(dent, struct repo_dent, 4096)
=20
 static uint32_t active_commit;
 static uint32_t mark;
=20
-static int repo_dirent_name_cmp(const void *a, const void *b);
+static int repo_dent_name_cmp(const void *a, const void *b);
=20
 /* Treap for directory entries */
-trp_gen(static, dirent_, struct repo_dirent, children, dirent, repo_di=
rent_name_cmp);
+trp_gen(static, dent_, struct repo_dent, children, dent, repo_dent_nam=
e_cmp);
=20
 uint32_t next_blob_mark(void)
 {
@@ -50,29 +50,29 @@ static struct repo_dir *repo_commit_root_dir(struct=
 repo_commit *commit)
 	return dir_pointer(commit->root_dir_offset);
 }
=20
-static struct repo_dirent *repo_first_dirent(struct repo_dir *dir)
+static struct repo_dent *repo_first_dent(struct repo_dir *dir)
 {
-	return dirent_first(&dir->entries);
+	return dent_first(&dir->entries);
 }
=20
-static int repo_dirent_name_cmp(const void *a, const void *b)
+static int repo_dent_name_cmp(const void *a, const void *b)
 {
-	const struct repo_dirent *dirent1 =3D a, *dirent2 =3D b;
-	uint32_t a_offset =3D dirent1->name_offset;
-	uint32_t b_offset =3D dirent2->name_offset;
+	const struct repo_dent *dent1 =3D a, *dent2 =3D b;
+	uint32_t a_offset =3D dent1->name_offset;
+	uint32_t b_offset =3D dent2->name_offset;
 	return (a_offset > b_offset) - (a_offset < b_offset);
 }
=20
-static int repo_dirent_is_dir(struct repo_dirent *dirent)
+static int repo_dent_is_dir(struct repo_dent *dent)
 {
-	return dirent !=3D NULL && dirent->mode =3D=3D REPO_MODE_DIR;
+	return dent !=3D NULL && dent->mode =3D=3D REPO_MODE_DIR;
 }
=20
-static struct repo_dir *repo_dir_from_dirent(struct repo_dirent *diren=
t)
+static struct repo_dir *repo_dir_from_dent(struct repo_dent *dent)
 {
-	if (!repo_dirent_is_dir(dirent))
+	if (!repo_dent_is_dir(dent))
 		return NULL;
-	return dir_pointer(dirent->content_offset);
+	return dir_pointer(dent->content_offset);
 }
=20
 static struct repo_dir *repo_clone_dir(struct repo_dir *orig_dir)
@@ -87,31 +87,31 @@ static struct repo_dir *repo_clone_dir(struct repo_=
dir *orig_dir)
 	return dir_pointer(new_o);
 }
=20
-static struct repo_dirent *repo_read_dirent(uint32_t revision, uint32_=
t *path)
+static struct repo_dent *repo_read_dent(uint32_t revision, uint32_t *p=
ath)
 {
 	uint32_t name =3D 0;
-	struct repo_dirent *key =3D dirent_pointer(dirent_alloc(1));
+	struct repo_dent *key =3D dent_pointer(dent_alloc(1));
 	struct repo_dir *dir =3D NULL;
-	struct repo_dirent *dirent =3D NULL;
+	struct repo_dent *dent =3D NULL;
 	dir =3D repo_commit_root_dir(commit_pointer(revision));
 	while (~(name =3D *path++)) {
 		key->name_offset =3D name;
-		dirent =3D dirent_search(&dir->entries, key);
-		if (dirent =3D=3D NULL || !repo_dirent_is_dir(dirent))
+		dent =3D dent_search(&dir->entries, key);
+		if (dent =3D=3D NULL || !repo_dent_is_dir(dent))
 			break;
-		dir =3D repo_dir_from_dirent(dirent);
+		dir =3D repo_dir_from_dent(dent);
 	}
-	dirent_free(1);
-	return dirent;
+	dent_free(1);
+	return dent;
 }
=20
-static void repo_write_dirent(uint32_t *path, uint32_t mode,
+static void repo_write_dent(uint32_t *path, uint32_t mode,
 			      uint32_t content_offset, uint32_t del)
 {
 	uint32_t name, revision, dir_o =3D ~0, parent_dir_o =3D ~0;
 	struct repo_dir *dir;
-	struct repo_dirent *key;
-	struct repo_dirent *dirent =3D NULL;
+	struct repo_dent *key;
+	struct repo_dent *dent =3D NULL;
 	revision =3D active_commit;
 	dir =3D repo_commit_root_dir(commit_pointer(revision));
 	dir =3D repo_clone_dir(dir);
@@ -119,127 +119,127 @@ static void repo_write_dirent(uint32_t *path, u=
int32_t mode,
 	while (~(name =3D *path++)) {
 		parent_dir_o =3D dir_offset(dir);
=20
-		key =3D dirent_pointer(dirent_alloc(1));
+		key =3D dent_pointer(dent_alloc(1));
 		key->name_offset =3D name;
=20
-		dirent =3D dirent_search(&dir->entries, key);
-		if (dirent =3D=3D NULL)
-			dirent =3D key;
+		dent =3D dent_search(&dir->entries, key);
+		if (dent =3D=3D NULL)
+			dent =3D key;
 		else
-			dirent_free(1);
+			dent_free(1);
=20
-		if (dirent =3D=3D key) {
-			dirent->mode =3D REPO_MODE_DIR;
-			dirent->content_offset =3D 0;
-			dirent_insert(&dir->entries, dirent);
+		if (dent =3D=3D key) {
+			dent->mode =3D REPO_MODE_DIR;
+			dent->content_offset =3D 0;
+			dent_insert(&dir->entries, dent);
 		}
=20
-		if (dirent_offset(dirent) < dirent_pool.committed) {
-			dir_o =3D repo_dirent_is_dir(dirent) ?
-					dirent->content_offset : ~0;
-			dirent_remove(&dir->entries, dirent);
-			dirent =3D dirent_pointer(dirent_alloc(1));
-			dirent->name_offset =3D name;
-			dirent->mode =3D REPO_MODE_DIR;
-			dirent->content_offset =3D dir_o;
-			dirent_insert(&dir->entries, dirent);
+		if (dent_offset(dent) < dent_pool.committed) {
+			dir_o =3D repo_dent_is_dir(dent) ?
+					dent->content_offset : ~0;
+			dent_remove(&dir->entries, dent);
+			dent =3D dent_pointer(dent_alloc(1));
+			dent->name_offset =3D name;
+			dent->mode =3D REPO_MODE_DIR;
+			dent->content_offset =3D dir_o;
+			dent_insert(&dir->entries, dent);
 		}
=20
-		dir =3D repo_dir_from_dirent(dirent);
+		dir =3D repo_dir_from_dent(dent);
 		dir =3D repo_clone_dir(dir);
-		dirent->content_offset =3D dir_offset(dir);
+		dent->content_offset =3D dir_offset(dir);
 	}
-	if (dirent =3D=3D NULL)
+	if (dent =3D=3D NULL)
 		return;
-	dirent->mode =3D mode;
-	dirent->content_offset =3D content_offset;
+	dent->mode =3D mode;
+	dent->content_offset =3D content_offset;
 	if (del && ~parent_dir_o)
-		dirent_remove(&dir_pointer(parent_dir_o)->entries, dirent);
+		dent_remove(&dir_pointer(parent_dir_o)->entries, dent);
 }
=20
 uint32_t repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst)
 {
 	uint32_t mode =3D 0, content_offset =3D 0;
-	struct repo_dirent *src_dirent;
-	src_dirent =3D repo_read_dirent(revision, src);
-	if (src_dirent !=3D NULL) {
-		mode =3D src_dirent->mode;
-		content_offset =3D src_dirent->content_offset;
-		repo_write_dirent(dst, mode, content_offset, 0);
+	struct repo_dent *src_dent;
+	src_dent =3D repo_read_dent(revision, src);
+	if (src_dent !=3D NULL) {
+		mode =3D src_dent->mode;
+		content_offset =3D src_dent->content_offset;
+		repo_write_dent(dst, mode, content_offset, 0);
 	}
 	return mode;
 }
=20
 void repo_add(uint32_t *path, uint32_t mode, uint32_t blob_mark)
 {
-	repo_write_dirent(path, mode, blob_mark, 0);
+	repo_write_dent(path, mode, blob_mark, 0);
 }
=20
 uint32_t repo_replace(uint32_t *path, uint32_t blob_mark)
 {
 	uint32_t mode =3D 0;
-	struct repo_dirent *src_dirent;
-	src_dirent =3D repo_read_dirent(active_commit, path);
-	if (src_dirent !=3D NULL) {
-		mode =3D src_dirent->mode;
-		repo_write_dirent(path, mode, blob_mark, 0);
+	struct repo_dent *src_dent;
+	src_dent =3D repo_read_dent(active_commit, path);
+	if (src_dent !=3D NULL) {
+		mode =3D src_dent->mode;
+		repo_write_dent(path, mode, blob_mark, 0);
 	}
 	return mode;
 }
=20
 void repo_modify(uint32_t *path, uint32_t mode, uint32_t blob_mark)
 {
-	struct repo_dirent *src_dirent;
-	src_dirent =3D repo_read_dirent(active_commit, path);
-	if (src_dirent !=3D NULL && blob_mark =3D=3D 0)
-		blob_mark =3D src_dirent->content_offset;
-	repo_write_dirent(path, mode, blob_mark, 0);
+	struct repo_dent *src_dent;
+	src_dent =3D repo_read_dent(active_commit, path);
+	if (src_dent !=3D NULL && blob_mark =3D=3D 0)
+		blob_mark =3D src_dent->content_offset;
+	repo_write_dent(path, mode, blob_mark, 0);
 }
=20
 void repo_delete(uint32_t *path)
 {
-	repo_write_dirent(path, 0, 0, 1);
+	repo_write_dent(path, 0, 0, 1);
 }
=20
 static void repo_git_add_r(uint32_t depth, uint32_t *path, struct repo=
_dir *dir);
=20
-static void repo_git_add(uint32_t depth, uint32_t *path, struct repo_d=
irent *dirent)
+static void repo_git_add(uint32_t depth, uint32_t *path, struct repo_d=
ent *dent)
 {
-	if (repo_dirent_is_dir(dirent))
-		repo_git_add_r(depth, path, repo_dir_from_dirent(dirent));
+	if (repo_dent_is_dir(dent))
+		repo_git_add_r(depth, path, repo_dir_from_dent(dent));
 	else
 		fast_export_modify(depth, path,
-				   dirent->mode, dirent->content_offset);
+				   dent->mode, dent->content_offset);
 }
=20
 static void repo_git_add_r(uint32_t depth, uint32_t *path, struct repo=
_dir *dir)
 {
-	struct repo_dirent *de =3D repo_first_dirent(dir);
+	struct repo_dent *de =3D repo_first_dent(dir);
 	while (de) {
 		path[depth] =3D de->name_offset;
 		repo_git_add(depth + 1, path, de);
-		de =3D dirent_next(&dir->entries, de);
+		de =3D dent_next(&dir->entries, de);
 	}
 }
=20
 static void repo_diff_r(uint32_t depth, uint32_t *path, struct repo_di=
r *dir1,
 			struct repo_dir *dir2)
 {
-	struct repo_dirent *de1, *de2;
-	de1 =3D repo_first_dirent(dir1);
-	de2 =3D repo_first_dirent(dir2);
+	struct repo_dent *de1, *de2;
+	de1 =3D repo_first_dent(dir1);
+	de2 =3D repo_first_dent(dir2);
=20
 	while (de1 && de2) {
 		if (de1->name_offset < de2->name_offset) {
 			path[depth] =3D de1->name_offset;
 			fast_export_delete(depth + 1, path);
-			de1 =3D dirent_next(&dir1->entries, de1);
+			de1 =3D dent_next(&dir1->entries, de1);
 			continue;
 		}
 		if (de1->name_offset > de2->name_offset) {
 			path[depth] =3D de2->name_offset;
 			repo_git_add(depth + 1, path, de2);
-			de2 =3D dirent_next(&dir2->entries, de2);
+			de2 =3D dent_next(&dir2->entries, de2);
 			continue;
 		}
 		path[depth] =3D de1->name_offset;
@@ -247,28 +247,28 @@ static void repo_diff_r(uint32_t depth, uint32_t =
*path, struct repo_dir *dir1,
 		if (de1->mode =3D=3D de2->mode &&
 		    de1->content_offset =3D=3D de2->content_offset) {
 			; /* No change. */
-		} else if (repo_dirent_is_dir(de1) && repo_dirent_is_dir(de2)) {
+		} else if (repo_dent_is_dir(de1) && repo_dent_is_dir(de2)) {
 			repo_diff_r(depth + 1, path,
-				    repo_dir_from_dirent(de1),
-				    repo_dir_from_dirent(de2));
-		} else if (!repo_dirent_is_dir(de1) && !repo_dirent_is_dir(de2)) {
+				    repo_dir_from_dent(de1),
+				    repo_dir_from_dent(de2));
+		} else if (!repo_dent_is_dir(de1) && !repo_dent_is_dir(de2)) {
 			repo_git_add(depth + 1, path, de2);
 		} else {
 			fast_export_delete(depth + 1, path);
 			repo_git_add(depth + 1, path, de2);
 		}
-		de1 =3D dirent_next(&dir1->entries, de1);
-		de2 =3D dirent_next(&dir2->entries, de2);
+		de1 =3D dent_next(&dir1->entries, de1);
+		de2 =3D dent_next(&dir2->entries, de2);
 	}
 	while (de1) {
 		path[depth] =3D de1->name_offset;
 		fast_export_delete(depth + 1, path);
-		de1 =3D dirent_next(&dir1->entries, de1);
+		de1 =3D dent_next(&dir1->entries, de1);
 	}
 	while (de2) {
 		path[depth] =3D de2->name_offset;
 		repo_git_add(depth + 1, path, de2);
-		de2 =3D dirent_next(&dir2->entries, de2);
+		de2 =3D dent_next(&dir2->entries, de2);
 	}
 }
=20
@@ -286,7 +286,7 @@ void repo_commit(uint32_t revision, uint32_t author=
, char *log, uint32_t uuid,
 		 uint32_t url, unsigned long timestamp)
 {
 	fast_export_commit(revision, author, log, uuid, url, timestamp);
-	dirent_commit();
+	dent_commit();
 	dir_commit();
 	active_commit =3D commit_alloc(1);
 	commit_pointer(active_commit)->root_dir_offset =3D
@@ -297,10 +297,10 @@ static void mark_init(void)
 {
 	uint32_t i;
 	mark =3D 0;
-	for (i =3D 0; i < dirent_pool.size; i++)
-		if (!repo_dirent_is_dir(dirent_pointer(i)) &&
-		    dirent_pointer(i)->content_offset > mark)
-			mark =3D dirent_pointer(i)->content_offset;
+	for (i =3D 0; i < dent_pool.size; i++)
+		if (!repo_dent_is_dir(dent_pointer(i)) &&
+		    dent_pointer(i)->content_offset > mark)
+			mark =3D dent_pointer(i)->content_offset;
 	mark++;
 }
=20
@@ -325,5 +325,5 @@ void repo_reset(void)
 	pool_reset();
 	commit_reset();
 	dir_reset();
-	dirent_reset();
+	dent_reset();
 }
--=20
1.7.2.1.544.ga752d.dirty
