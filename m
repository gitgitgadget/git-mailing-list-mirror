From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v3 3/8] Read .gitignore from index if it is assume-unchanged
Date: Tue, 11 Aug 2009 22:44:01 +0700
Message-ID: <1250005446-12047-4-git-send-email-pclouds@gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
 <1250005446-12047-2-git-send-email-pclouds@gmail.com>
 <1250005446-12047-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:44:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MatWr-0006wH-LR
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 17:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbZHKPoc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 11:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbZHKPoc
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 11:44:32 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:29186 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbZHKPoa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 11:44:30 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1344620rvb.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 08:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=trAK5fs409qyohj0JSkOby9lyhQ3UgaiJ+xXCHc+6X8=;
        b=GroAFdxR0NbXMBUnEAN0vikNcUesJ0r5DxhOyNYDahNO4qQGY3/Xvb9JArcwYZXPtN
         8fe7ogd0BkuVHG0pw5O0kMGI1Dmln/lN2grhTF1F24hG6OOoqavYORQJAMEQsfhn5vFq
         JWTyxwiVRjw1QmtSEgfsyVkOUV+Vdi3ykjMgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=x4WUT8gojSmcJNsuhcAIRtSBENiWluPfK6fl4DXkMLiMiY9xZG1AC4gCsC/s6asGMu
         TavOAr3JIVsIM7nEa1SPMC4xZSxi2lpD7lLIYG4yurV9PGGdSs5aF7OKi4ZESeLv+BCA
         inyXWi7TGCSL/ma3Srwt5ShIRsFDPUBauazaY=
Received: by 10.141.41.3 with SMTP id t3mr2305176rvj.93.1250005472350;
        Tue, 11 Aug 2009 08:44:32 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.239.0])
        by mx.google.com with ESMTPS id k2sm30105027rvb.7.2009.08.11.08.44.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 08:44:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 11 Aug 2009 22:44:26 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250005446-12047-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125579>

In sparse checkout mode (aka CE_VALID or assume-unchanged) some files
may be missing from working directory. If some of those files are
=2Egitignore, it will affect how git excludes files.

Because those files are by definition "assume unchanged" we can
instead read them from index. This adds index as a prerequisite for
directory listing. At the moment directory listing is used by "git
clean", "git add", "git ls-files" and "git status"/"git commit" and
unpack_trees()-related commands.  These commands have been
checked/modified to populate index before doing directory listing.

add_excludes_from_file() does not enable this feature, because it
is used to read .git/info/exclude and some explicit files specified
by "git ls-files".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/api-directory-listing.txt |    3 +
 builtin-clean.c                                   |    5 +-
 builtin-ls-files.c                                |    4 +-
 dir.c                                             |   66 +++++++++++++=
+------
 t/t3001-ls-files-others-exclude.sh                |   22 +++++++
 t/t7300-clean.sh                                  |   19 ++++++
 6 files changed, 97 insertions(+), 22 deletions(-)

diff --git a/Documentation/technical/api-directory-listing.txt b/Docume=
ntation/technical/api-directory-listing.txt
index 5bbd18f..7d0e282 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -58,6 +58,9 @@ The result of the enumeration is left in these fields=
::
 Calling sequence
 ----------------
=20
+* Ensure the_index is populated as it may have CE_VALID entries that
+  affect directory listing.
+
 * Prepare `struct dir_struct dir` and clear it with `memset(&dir, 0,
   sizeof(dir))`.
=20
diff --git a/builtin-clean.c b/builtin-clean.c
index 2d8c735..d917472 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -71,8 +71,11 @@ int cmd_clean(int argc, const char **argv, const cha=
r *prefix)
=20
 	dir.flags |=3D DIR_SHOW_OTHER_DIRECTORIES;
=20
-	if (!ignored)
+	if (!ignored) {
+		if (read_cache() < 0)
+			die("index file corrupt");
 		setup_standard_excludes(&dir);
+	}
=20
 	pathspec =3D get_pathspec(prefix, argv);
 	read_cache();
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index f473220..d1a23c4 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -481,6 +481,9 @@ int cmd_ls_files(int argc, const char **argv, const=
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
@@ -508,7 +511,6 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 	pathspec =3D get_pathspec(prefix, argv);
=20
 	/* be nice with submodule paths ending in a slash */
-	read_cache();
 	if (pathspec)
 		strip_trailing_slash_from_submodules();
=20
diff --git a/dir.c b/dir.c
index 1170d64..66b485c 100644
--- a/dir.c
+++ b/dir.c
@@ -200,11 +200,36 @@ void add_exclude(const char *string, const char *=
base,
 	which->excludes[which->nr++] =3D x;
 }
=20
+static void *read_assume_unchanged_from_index(const char *path, size_t=
 *size)
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
+	/* only applies to CE_VALID entries */
+	if (!(istate->cache[pos]->ce_flags & CE_VALID))
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
@@ -212,20 +237,26 @@ static int add_excludes_from_file_1(const char *f=
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
+		    (buf =3D read_assume_unchanged_from_index(fname, &size)) =3D=3D =
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
@@ -240,17 +271,12 @@ static int add_excludes_from_file_1(const char *f=
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
@@ -301,7 +327,7 @@ static void prep_exclude(struct dir_struct *dir, co=
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
index c65bca8..fdd5dd8 100755
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
+test_expect_success 'setup sparse gitignore' '
+	git add $allignores &&
+	git update-index --assume-unchanged $allignores &&
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
index 929d5d4..4886d5f 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -22,6 +22,25 @@ test_expect_success 'setup' '
=20
 '
=20
+test_expect_success 'git clean with assume-unchanged .gitignore' '
+	git update-index --assume-unchanged .gitignore &&
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
+	git update-index --no-assume-unchanged .gitignore &&
+	git checkout .gitignore
+'
+
 test_expect_success 'git clean' '
=20
 	mkdir -p build docs &&
--=20
1.6.3.GIT
