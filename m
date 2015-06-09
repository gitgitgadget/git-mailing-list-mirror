From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v7 5/5] clean: improve performance when removing lots of directories
Date: Tue,  9 Jun 2015 20:24:39 +0200
Message-ID: <1433874279-30720-6-git-send-email-erik.elfstrom@gmail.com>
References: <1433874279-30720-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 20:53:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Oep-000445-Ld
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 20:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbbFISxw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2015 14:53:52 -0400
Received: from mail-la0-f65.google.com ([209.85.215.65]:34832 "EHLO
	mail-la0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbbFISxu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 14:53:50 -0400
Received: by lams18 with SMTP id s18so2839710lam.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 11:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=P1S9ly2ZXCozdJHXQJIONSSAZdbVyhjwB0xZnGyBIDU=;
        b=T0SL3Kzojq/Z99IL0HNjELpPTB9tQ4OxYvDDGhORW96HF4nWC7whTT9UcGiyIC2jGH
         dn6gTT7v15+ZQDqFCrBKCIlgS5Pxv1gQYE3AS3AR7Psli3i8Z9mjoJszL88ZDFmI7vb9
         mQYj59dO9jbBiDrZBVebQMvG2MSo8UOGPMUC1ztJcEPQ2cBZa1kGNTrhkmOAp2mwY+0I
         5lXW+2sCOmQHXecEIFYUYAu6oGqHry2jOzemGwXgG+f9UduUwhf0sIWgZ6RUcd2RoYBa
         116EOVTFS2vPbx27nNsrpk0QoBSZhQYnoPlquQgLTXwPom/HlNLo/zsatauOeHLMKU5g
         q5OQ==
X-Received: by 10.112.234.163 with SMTP id uf3mr24276363lbc.9.1433874340734;
        Tue, 09 Jun 2015 11:25:40 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id bm5sm285250lbc.45.2015.06.09.11.25.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Jun 2015 11:25:39 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.373.gc496bfb
In-Reply-To: <1433874279-30720-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271230>

"git clean" uses resolve_gitlink_ref() to check for the presence of
nested git repositories, but it has the drawback of creating a
ref_cache entry for every directory that should potentially be
cleaned. The linear search through the ref_cache list causes a massive
performance hit for large number of directories.

Modify clean.c:remove_dirs to use setup.c:is_git_directory and
setup.c:read_gitfile_gently instead.

Both these functions will open files and parse contents when they find
something that looks like a git repository. This is ok from a
performance standpoint since finding repository candidates should be
comparatively rare.

Using is_git_directory and read_gitfile_gently should give a more
standardized check for what is and what isn't a git repository but
also gives three behavioral changes.

The first change is that we will now detect and avoid cleaning empty
nested git repositories (only init run). This is desirable.

Second, we will no longer die when cleaning a file named ".git" with
garbage content (it will be cleaned instead). This is also desirable.

The last change is that we will detect and avoid cleaning empty bare
repositories that have been placed in a directory named ".git". This
is not desirable but should have no real user impact since we already
fail to clean non-empty bare repositories in the same scenario. This
is thus deemed acceptable.

On top of this we add some extra precautions. If read_gitfile_gently
fails to open the git file, read the git file or verify the path in
the git file we assume that the path with the git file is a valid
repository and avoid cleaning.

Update t7300 to reflect these changes in behavior.

The time to clean an untracked directory containing 100000 sub
directories went from 61s to 1.7s after this change.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 builtin/clean.c  | 30 ++++++++++++++++++++++++++----
 t/t7300-clean.sh | 10 ++++------
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 6dcb72e..df53def 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -10,7 +10,6 @@
 #include "cache.h"
 #include "dir.h"
 #include "parse-options.h"
-#include "refs.h"
 #include "string-list.h"
 #include "quote.h"
 #include "column.h"
@@ -148,6 +147,31 @@ static int exclude_cb(const struct option *opt, co=
nst char *arg, int unset)
 	return 0;
 }
=20
+/*
+ * Return 1 if the given path is the root of a git repository or
+ * submodule else 0. Will not return 1 for bare repositories with the
+ * exception of creating a bare repository in "foo/.git" and calling
+ * is_git_repository("foo").
+ */
+static int is_git_repository(struct strbuf *path)
+{
+	int ret =3D 0;
+	int gitfile_error;
+	size_t orig_path_len =3D path->len;
+	assert(orig_path_len !=3D 0);
+	if (path->buf[orig_path_len - 1] !=3D '/')
+		strbuf_addch(path, '/');
+	strbuf_addstr(path, ".git");
+	if (read_gitfile_gently(path->buf, &gitfile_error) || is_git_director=
y(path->buf))
+		ret =3D 1;
+	if (gitfile_error =3D=3D READ_GITFILE_ERR_OPEN_FAILED ||
+	    gitfile_error =3D=3D READ_GITFILE_ERR_READ_FAILED)
+		ret =3D 1;  /* This could be a real .git file, take the
+			   * safe option and avoid cleaning */
+	strbuf_setlen(path, orig_path_len);
+	return ret;
+}
+
 static int remove_dirs(struct strbuf *path, const char *prefix, int fo=
rce_flag,
 		int dry_run, int quiet, int *dir_gone)
 {
@@ -155,13 +179,11 @@ static int remove_dirs(struct strbuf *path, const=
 char *prefix, int force_flag,
 	struct strbuf quoted =3D STRBUF_INIT;
 	struct dirent *e;
 	int res =3D 0, ret =3D 0, gone =3D 1, original_len =3D path->len, len=
;
-	unsigned char submodule_head[20];
 	struct string_list dels =3D STRING_LIST_INIT_DUP;
=20
 	*dir_gone =3D 1;
=20
-	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
-			!resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
+	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) && is_git_repository(pa=
th)) {
 		if (!quiet) {
 			quote_path_relative(path->buf, prefix, &quoted);
 			printf(dry_run ?  _(msg_would_skip_git_dir) : _(msg_skip_git_dir),
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index fbfdf2d..32e96da 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -455,7 +455,7 @@ test_expect_success 'nested git work tree' '
 	! test -d bar
 '
=20
-test_expect_failure 'should clean things that almost look like git but=
 are not' '
+test_expect_success 'should clean things that almost look like git but=
 are not' '
 	rm -fr almost_git almost_bare_git almost_submodule &&
 	mkdir -p almost_git/.git/objects &&
 	mkdir -p almost_git/.git/refs &&
@@ -468,8 +468,6 @@ test_expect_failure 'should clean things that almos=
t look like git but are not'
 	garbage
 	EOF
 	test_when_finished "rm -rf almost_*" &&
-	## This will fail due to die("Invalid gitfile format: %s", path); in
-	## setup.c:read_gitfile.
 	git clean -f -d &&
 	test_path_is_missing almost_git &&
 	test_path_is_missing almost_bare_git &&
@@ -501,7 +499,7 @@ test_expect_success 'should not clean submodules' '
 	test_path_is_missing to_clean
 '
=20
-test_expect_failure 'should avoid cleaning possible submodules' '
+test_expect_success 'should avoid cleaning possible submodules' '
 	rm -fr to_clean possible_sub1 &&
 	mkdir to_clean possible_sub1 &&
 	test_when_finished "rm -rf possible_sub*" &&
@@ -515,7 +513,7 @@ test_expect_failure 'should avoid cleaning possible=
 submodules' '
 	test_path_is_missing to_clean
 '
=20
-test_expect_failure 'nested (empty) git should be kept' '
+test_expect_success 'nested (empty) git should be kept' '
 	rm -fr empty_repo to_clean &&
 	git init empty_repo &&
 	mkdir to_clean &&
@@ -537,7 +535,7 @@ test_expect_success 'nested bare repositories shoul=
d be cleaned' '
 	test_path_is_missing subdir
 '
=20
-test_expect_success 'nested (empty) bare repositories should be cleane=
d even when in .git' '
+test_expect_failure 'nested (empty) bare repositories should be cleane=
d even when in .git' '
 	rm -fr strange_bare &&
 	mkdir strange_bare &&
 	git init --bare strange_bare/.git &&
--=20
2.4.3.373.gc496bfb
