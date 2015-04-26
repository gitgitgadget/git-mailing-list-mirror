From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v5 5/5] clean: improve performance when removing lots of directories
Date: Sun, 26 Apr 2015 08:49:45 +0200
Message-ID: <1430030985-14499-6-git-send-email-erik.elfstrom@gmail.com>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
 <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 26 08:51:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmGP4-0007lc-IV
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 08:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbbDZGux convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2015 02:50:53 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35869 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbbDZGux (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 02:50:53 -0400
Received: by lbbqq2 with SMTP id qq2so62000306lbb.3
        for <git@vger.kernel.org>; Sat, 25 Apr 2015 23:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NvRrPrSvb7gldfy8YlaIA6HXSNndQBVdXklGsmViNMg=;
        b=rOTQsZt60qMPL9W48o7B7J50UrOL/bV+JSpBFN9OxVhsVeU7mYKQHcBNeF2cmXQYQP
         +0i55AWICVcYNXPEqwbDVR1mMgpt3x+gYbFNZhlwbd4R4z41dfggerl8tpbOcWQRAbq6
         r3AfenrKe9Ezy7yGKa1DrM0j5KYKZQnF/6QNJgC8S5TIwSLq9/o+d2l8eMBheiveqZ/r
         P4/DijcOMRIDSHVD2WWVXnYcrXVZFqN3xftAC6MmpWzmqBkCYK0TP9QNDkuMAxjaoAiU
         eSuAc9odk3GVaayCSjXx+mA6//CfGM/cIByl2TOWLcPEiJgVRU4icuBuVoVb1k6SgOWN
         oAqQ==
X-Received: by 10.112.35.230 with SMTP id l6mr5211025lbj.5.1430031051473;
        Sat, 25 Apr 2015 23:50:51 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id x2sm3884938laj.8.2015.04.25.23.50.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Apr 2015 23:50:50 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.8.gbb31afb
In-Reply-To: <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267827>

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

Update t7300 to reflect these changes in behavior.

The time to clean an untracked directory containing 100000 sub
directories went from 61s to 1.7s after this change.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 builtin/clean.c  | 26 ++++++++++++++++++++++----
 t/t7300-clean.sh |  8 +++-----
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 98c103f..17a1c13 100644
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
@@ -148,6 +147,27 @@ static int exclude_cb(const struct option *opt, co=
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
+	int unused_error_code;
+	size_t orig_path_len =3D path->len;
+	assert(orig_path_len !=3D 0);
+	if (path->buf[orig_path_len - 1] !=3D '/')
+		strbuf_addch(path, '/');
+	strbuf_addstr(path, ".git");
+	if (read_gitfile_gently(path->buf, &unused_error_code) || is_git_dire=
ctory(path->buf))
+		ret =3D 1;
+	strbuf_setlen(path, orig_path_len);
+	return ret;
+}
+
 static int remove_dirs(struct strbuf *path, const char *prefix, int fo=
rce_flag,
 		int dry_run, int quiet, int *dir_gone)
 {
@@ -155,13 +175,11 @@ static int remove_dirs(struct strbuf *path, const=
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
index 11f3a6d..4d07a4a 100755
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
 	rm -fr empty_repo to_clean &&
 	git init empty_repo &&
 	mkdir to_clean &&
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
2.4.0.rc3.8.gbb31afb
