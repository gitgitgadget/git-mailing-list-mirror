From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/23] Read .gitignore from index if it is skip-worktree
Date: Mon, 14 Dec 2009 17:30:54 +0700
Message-ID: <1260786666-8405-12-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:33:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8FH-0007wL-Mc
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756151AbZLNKc5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756103AbZLNKcx
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:32:53 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:62201 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756131AbZLNKct (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:32:49 -0500
Received: by mail-px0-f174.google.com with SMTP id 4so1691169pxi.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=XBLwEptkNTe8nkH8sBkLJns2AT+TrxEhKmrFgdenSjg=;
        b=TsoKrXsUYKIcRtHlHhZnBsZFJxS64e1cJUSkCES0sTUE6v1zn5zNUgvBobYxyskf6a
         QHP10r34BOFzDucXODDP9uQcuedPDlKFv9LqHTVGi6iiHYsDKYQcY23H2faspU5tl+Zm
         PbBnFCVtrCZiy3fyz6U77A0zzSQdEZFZOelAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Kn4MU5MfNIqq3oUAlKeEfmErH+HuP+6smRpiVmUuG2xtSUD7JTQ6hYAaTMZvDZpW1Z
         EF8j9DsNxqgcu4CmpDQdODL/jxbU+ClDmFGXVmSwZggRwPt8Jijwpr65OM3P0pSfQU0g
         HxRdddBhHLRlUKGEnnOtZK016kYmFc40cD8xY=
Received: by 10.143.26.32 with SMTP id d32mr3005526wfj.297.1260786769273;
        Mon, 14 Dec 2009 02:32:49 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 23sm4910448pzk.12.2009.12.14.02.32.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:32:48 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:32:06 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135186>

This adds index as a prerequisite for directory listing (with
exclude).  At the moment directory listing is used by "git clean",
"git add", "git ls-files" and "git status"/"git commit" and
unpack_trees()-related commands.  These commands have been
checked/modified to populate index before doing directory listing.

add_excludes_from_file() does not enable this feature, because it
is used to read .git/info/exclude and some explicit files specified
by "git ls-files".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/api-directory-listing.txt |    3 +
 builtin-clean.c                                   |    4 +-
 builtin-ls-files.c                                |    4 +-
 dir.c                                             |   65 +++++++++++++=
+------
 t/t3001-ls-files-others-exclude.sh                |   22 +++++++
 t/t7300-clean.sh                                  |   19 ++++++
 6 files changed, 95 insertions(+), 22 deletions(-)

diff --git a/Documentation/technical/api-directory-listing.txt b/Docume=
ntation/technical/api-directory-listing.txt
index 5bbd18f..add6f43 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -58,6 +58,9 @@ The result of the enumeration is left in these fields=
::
 Calling sequence
 ----------------
=20
+Note: index may be looked at for .gitignore files that are CE_SKIP_WOR=
KTREE
+marked. If you to exclude files, make sure you have loaded index first=
=2E
+
 * Prepare `struct dir_struct dir` and clear it with `memset(&dir, 0,
   sizeof(dir))`.
=20
diff --git a/builtin-clean.c b/builtin-clean.c
index 2d8c735..e424b77 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -71,11 +71,13 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
=20
 	dir.flags |=3D DIR_SHOW_OTHER_DIRECTORIES;
=20
+	if (read_cache() < 0)
+		die("index file corrupt");
+
 	if (!ignored)
 		setup_standard_excludes(&dir);
=20
 	pathspec =3D get_pathspec(prefix, argv);
-	read_cache();
=20
 	fill_directory(&dir, pathspec);
=20
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index ad7e447..2e47242 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -485,6 +485,9 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 		prefix_offset =3D strlen(prefix);
 	git_config(git_default_config, NULL);
=20
+	if (read_cache() < 0)
+		die("index file corrupt");
+
 	argc =3D parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
 	if (show_tag || show_valid_bit) {
@@ -513,7 +516,6 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 	pathspec =3D get_pathspec(prefix, argv);
=20
 	/* be nice with submodule paths ending in a slash */
-	read_cache();
 	if (pathspec)
 		strip_trailing_slash_from_submodules();
=20
diff --git a/dir.c b/dir.c
index 1170d64..e8e5b79 100644
--- a/dir.c
+++ b/dir.c
@@ -200,11 +200,35 @@ void add_exclude(const char *string, const char *=
base,
 	which->excludes[which->nr++] =3D x;
 }
=20
+static void *read_skip_worktree_file_from_index(const char *path, size=
_t *size)
+{
+	int pos, len;
+	unsigned long sz;
+	enum object_type type;
+	void *data;
+	struct index_state *istate =3D &the_index;
+
+	len =3D strlen(path);
+	pos =3D index_name_pos(istate, path, len);
+	if (pos < 0)
+		return NULL;
+	if (!ce_skip_worktree(istate->cache[pos]))
+		return NULL;
+	data =3D read_sha1_file(istate->cache[pos]->sha1, &type, &sz);
+	if (!data || type !=3D OBJ_BLOB) {
+		free(data);
+		return NULL;
+	}
+	*size =3D xsize_t(sz);
+	return data;
+}
+
 static int add_excludes_from_file_1(const char *fname,
 				    const char *base,
 				    int baselen,
 				    char **buf_p,
-				    struct exclude_list *which)
+				    struct exclude_list *which,
+				    int check_index)
 {
 	struct stat st;
 	int fd, i;
@@ -212,20 +236,26 @@ static int add_excludes_from_file_1(const char *f=
name,
 	char *buf, *entry;
=20
 	fd =3D open(fname, O_RDONLY);
-	if (fd < 0 || fstat(fd, &st) < 0)
-		goto err;
-	size =3D xsize_t(st.st_size);
-	if (size =3D=3D 0) {
-		close(fd);
-		return 0;
+	if (fd < 0 || fstat(fd, &st) < 0) {
+		if (0 <=3D fd)
+			close(fd);
+		if (!check_index ||
+		    (buf =3D read_skip_worktree_file_from_index(fname, &size)) =3D=3D=
 NULL)
+			return -1;
 	}
-	buf =3D xmalloc(size+1);
-	if (read_in_full(fd, buf, size) !=3D size)
-	{
-		free(buf);
-		goto err;
+	else {
+		size =3D xsize_t(st.st_size);
+		if (size =3D=3D 0) {
+			close(fd);
+			return 0;
+		}
+		buf =3D xmalloc(size);
+		if (read_in_full(fd, buf, size) !=3D size) {
+			close(fd);
+			return -1;
+		}
+		close(fd);
 	}
-	close(fd);
=20
 	if (buf_p)
 		*buf_p =3D buf;
@@ -240,17 +270,12 @@ static int add_excludes_from_file_1(const char *f=
name,
 		}
 	}
 	return 0;
-
- err:
-	if (0 <=3D fd)
-		close(fd);
-	return -1;
 }
=20
 void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 {
 	if (add_excludes_from_file_1(fname, "", 0, NULL,
-				     &dir->exclude_list[EXC_FILE]) < 0)
+				     &dir->exclude_list[EXC_FILE], 0) < 0)
 		die("cannot use %s as an exclude file", fname);
 }
=20
@@ -301,7 +326,7 @@ static void prep_exclude(struct dir_struct *dir, co=
nst char *base, int baselen)
 		strcpy(dir->basebuf + stk->baselen, dir->exclude_per_dir);
 		add_excludes_from_file_1(dir->basebuf,
 					 dir->basebuf, stk->baselen,
-					 &stk->filebuf, el);
+					 &stk->filebuf, el, 1);
 		dir->exclude_stack =3D stk;
 		current =3D stk->baselen;
 	}
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-othe=
rs-exclude.sh
index c65bca8..132c476 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -64,6 +64,8 @@ two/*.4
 echo '!*.2
 !*.8' >one/two/.gitignore
=20
+allignores=3D'.gitignore one/.gitignore one/two/.gitignore'
+
 test_expect_success \
     'git ls-files --others with various exclude options.' \
     'git ls-files --others \
@@ -85,6 +87,26 @@ test_expect_success \
        >output &&
      test_cmp expect output'
=20
+test_expect_success 'setup skip-worktree gitignore' '
+	git add $allignores &&
+	git update-index --skip-worktree $allignores &&
+	rm $allignores
+'
+
+test_expect_success \
+    'git ls-files --others with various exclude options.' \
+    'git ls-files --others \
+       --exclude=3D\*.6 \
+       --exclude-per-directory=3D.gitignore \
+       --exclude-from=3D.git/ignore \
+       >output &&
+     test_cmp expect output'
+
+test_expect_success 'restore gitignore' '
+	git checkout $allignores &&
+	rm .git/index
+'
+
 cat > excludes-file <<\EOF
 *.[1-8]
 e*
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 929d5d4..8073d02 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -22,6 +22,25 @@ test_expect_success 'setup' '
=20
 '
=20
+test_expect_success 'git clean with skip-worktree .gitignore' '
+	git update-index --skip-worktree .gitignore &&
+	rm .gitignore &&
+	mkdir -p build docs &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	git clean &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test ! -f src/part3.c &&
+	test -f docs/manual.txt &&
+	test -f obj.o &&
+	test -f build/lib.so &&
+	git update-index --no-skip-worktree .gitignore &&
+	git checkout .gitignore
+'
+
 test_expect_success 'git clean' '
=20
 	mkdir -p build docs &&
--=20
1.6.5.2.216.g9c1ec
