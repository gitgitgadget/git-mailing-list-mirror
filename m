From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v2 3/3] clean: improve performance when removing lots of directories
Date: Sat, 11 Apr 2015 18:43:07 +0200
Message-ID: <1428770587-9674-5-git-send-email-erik.elfstrom@gmail.com>
References: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 18:43:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgyVT-0005ik-Mn
	for gcvg-git-2@plane.gmane.org; Sat, 11 Apr 2015 18:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbbDKQng convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2015 12:43:36 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33747 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489AbbDKQne (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2015 12:43:34 -0400
Received: by lbbzk7 with SMTP id zk7so32979523lbb.0
        for <git@vger.kernel.org>; Sat, 11 Apr 2015 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=z2/0Jmp4o7ss3QYnRAV8qPBCDyJTzjMqzs391lNCbw4=;
        b=uAWllBpyjYmAullnfwZSulSgmN/Ri83Fz2elG4RHVpoEpqqGzsZp4GKXmZUdD3dP8/
         sy0t7koDHA/Cv/OmFzIvGNkZNWxN3q/E0gP5hI9J++q+8ufFR+JiX+oNX6/Amb96Lg8/
         cOxx/DlgVB1aG6dk1JcUhmFdHl6qG5FJ+evkaPuHvH4f40Xc9nLkjfqg+mYSNYO1ydP8
         nh75EdX2KVXuYFHWApVvNtsBfKP9W7EXs3kfyZj+nRdZE0lJ2lfUSSjuq4TBg65RgC2L
         hukDZmDyEehkjOyt2XEONidTgtOQcoATMnXq64CBXEa4eOKcn7/K9hTOtlKO9TB9nEiS
         8MhQ==
X-Received: by 10.112.125.193 with SMTP id ms1mr6206489lbb.31.1428770612854;
        Sat, 11 Apr 2015 09:43:32 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id kx8sm501395lbc.3.2015.04.11.09.43.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Apr 2015 09:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc0.37.ga3b75b3
In-Reply-To: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267025>

Before this change, clean used resolve_gitlink_ref to check for the
presence of nested git repositories. This had the drawback of creating
a ref_cache entry for every directory that should potentially be
cleaned. The linear search through the ref_cache list caused a massive
performance hit for large number of directories.

Teach clean.c:remove_dirs to use setup.c:is_git_directory
instead. is_git_directory will actually open HEAD and parse the HEAD
ref but this implies a nested git repository and should be rare when
cleaning.

Using is_git_directory should give a more standardized check for what
is and what isn't a git repository but also gives a slight behavioral
change. We will now detect and respect bare and empty nested git
repositories (only init run). Update t7300 to reflect this.

The time to clean an untracked directory containing 100000 sub
directories went from 61s to 1.7s after this change.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 builtin/clean.c  | 24 ++++++++++++++++++++----
 t/t7300-clean.sh |  4 ++--
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 98c103f..b679913 100644
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
@@ -148,6 +147,25 @@ static int exclude_cb(const struct option *opt, co=
nst char *arg, int unset)
 	return 0;
 }
=20
+static int is_git_repository(struct strbuf *path)
+{
+	int ret =3D 0;
+	if (is_git_directory(path->buf))
+		ret =3D 1;
+	else {
+		size_t orig_path_len =3D path->len;
+		assert(orig_path_len !=3D 0);
+		if (path->buf[orig_path_len - 1] !=3D '/')
+			strbuf_addch(path, '/');
+		strbuf_addstr(path, ".git");
+		if (is_git_directory(path->buf))
+			ret =3D 1;
+		strbuf_setlen(path, orig_path_len);
+	}
+
+	return ret;
+}
+
 static int remove_dirs(struct strbuf *path, const char *prefix, int fo=
rce_flag,
 		int dry_run, int quiet, int *dir_gone)
 {
@@ -155,13 +173,11 @@ static int remove_dirs(struct strbuf *path, const=
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
index 58e6b4a..da294fe 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -455,7 +455,7 @@ test_expect_success 'nested git work tree' '
 	! test -d bar
 '
=20
-test_expect_failure 'nested git (only init) should be kept' '
+test_expect_success 'nested git (only init) should be kept' '
 	rm -fr foo bar &&
 	git init foo &&
 	mkdir bar &&
@@ -465,7 +465,7 @@ test_expect_failure 'nested git (only init) should =
be kept' '
 	test_path_is_missing bar
 '
=20
-test_expect_failure 'nested git (bare) should be kept' '
+test_expect_success 'nested git (bare) should be kept' '
 	rm -fr foo bar &&
 	git init --bare foo &&
 	mkdir bar &&
--=20
2.4.0.rc0.37.ga3b75b3
