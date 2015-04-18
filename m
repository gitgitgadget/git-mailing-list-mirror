From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH/RFC v3 4/4] clean: improve performance when removing lots of directories
Date: Sat, 18 Apr 2015 22:41:12 +0200
Message-ID: <1429389672-30209-5-git-send-email-erik.elfstrom@gmail.com>
References: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 22:42:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjZYt-0005nC-IO
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 22:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbbDRUlz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2015 16:41:55 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:36818 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274AbbDRUlx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 16:41:53 -0400
Received: by lagv1 with SMTP id v1so102291736lag.3
        for <git@vger.kernel.org>; Sat, 18 Apr 2015 13:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ApUdpdTfT+1tEFMl6CJIBqzAUL9/8pOt8RPdLK+W+Fs=;
        b=R+iGF1sDkilzObfDpWWhJIzBm7+p0/yfeEfn5rfso1pjrHsDvObKVfYAZs7Benomy+
         R4amQ/betgteKENHa/8zCINBb3vakHT8cTPZH1vzGDKms8R5ZvA6Q2CDZxg38dFXSIVd
         YbZJHpH8hngRAf5BnZ7oYsrfEU0ImnVX6pmWUpntv1/90pXx6K/7LgN5zaLpenPgrFUc
         jmps5VbNR/IWGSRG+5EBvChY9xce6wEaowaPgzVpciVjBQqs0qozCsl+stNPBT9FGRcj
         cTvNOo0j6sjaCm/SRCfL4qL0eTYXMLV+JqqlDXkV13qVbEo1Lx1H6xPjqtPkg1k0drmC
         yLnQ==
X-Received: by 10.152.182.167 with SMTP id ef7mr9594282lac.109.1429389711477;
        Sat, 18 Apr 2015 13:41:51 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id sh6sm3249256lbb.31.2015.04.18.13.41.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Apr 2015 13:41:50 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc2.5.g2871d5e
In-Reply-To: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267424>

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
also gives a slight behavioral change. We will now detect and respect
empty nested git repositories (only init run) and empty bare
repositories that have been placed in a ".git" directory. We will also
no longer die when cleaning a file named ".git" with garbage content
(it will be cleaned instead). Update t7300 to reflect this.

The time to clean an untracked directory containing 100000 sub
directories went from 61s to 1.7s after this change.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 builtin/clean.c  | 25 +++++++++++++++++++++----
 t/t7300-clean.sh |  8 +++-----
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 98c103f..5cda3c5 100644
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
@@ -148,6 +147,26 @@ static int exclude_cb(const struct option *opt, co=
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
+	size_t orig_path_len =3D path->len;
+	assert(orig_path_len !=3D 0);
+	if (path->buf[orig_path_len - 1] !=3D '/')
+		strbuf_addch(path, '/');
+	strbuf_addstr(path, ".git");
+	if (read_gitfile_gently(path->buf) || is_git_directory(path->buf))
+		ret =3D 1;
+	strbuf_setlen(path, orig_path_len);
+	return ret;
+}
+
 static int remove_dirs(struct strbuf *path, const char *prefix, int fo=
rce_flag,
 		int dry_run, int quiet, int *dir_gone)
 {
@@ -155,13 +174,11 @@ static int remove_dirs(struct strbuf *path, const=
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
index 4b9a72a..1bbb8ef 100755
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
-test_expect_failure 'nested (empty) git should be kept' '
+test_expect_success 'nested (empty) git should be kept' '
 	rm -fr foo bar &&
 	git init foo &&
 	mkdir bar &&
@@ -523,7 +521,7 @@ test_expect_success 'nested bare repositories shoul=
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
2.4.0.rc2.5.g2871d5e
