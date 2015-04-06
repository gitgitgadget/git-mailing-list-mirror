From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH 3/3] clean: improve performance when removing lots of directories
Date: Mon,  6 Apr 2015 13:48:24 +0200
Message-ID: <1428320904-12366-4-git-send-email-erik.elfstrom@gmail.com>
References: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 14:03:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf5WR-0003W1-4q
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 13:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbbDFLst convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 07:48:49 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:36129 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbbDFLsp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 07:48:45 -0400
Received: by lagv1 with SMTP id v1so18015526lag.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 04:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=whwcF6FyEcLNVRJJL3tq0pHV8VedUw+/soX3vjfr974=;
        b=FaLlynjHVPQdzd/dZ5iBJRaDHMEinfpSk+m6FuXCkI2KurGNTloO/H8HVqhMP1jXjs
         sEK9VJVjOpMqvILPiKSIRj+7GP7XBZGAbi1w08806tVVND47dvcD2QA36sznLo5G4Q1z
         ls50FdgSvJAL+nnJep7J8r2p2OQHa/yudhCnTDlOY31LGcMNShw30OdIbNmFTv4P3AKr
         IMojTkhgcpPz4t3KLEg9yEyxYF76Awg5MeF2Q6Wu6644bVukjoPZBRxTbKeC1bOae17+
         uP/ghc6ED41WXN6F6isUOLwThm5xxU7rRmZg6CoXS8Ge4EAvJycAHzKIyPuH0JRWhHWc
         fkrQ==
X-Received: by 10.112.38.72 with SMTP id e8mr12767186lbk.99.1428320923912;
        Mon, 06 Apr 2015 04:48:43 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id pd1sm933083lbc.9.2015.04.06.04.48.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Apr 2015 04:48:43 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc0.37.ga3b75b3
In-Reply-To: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266841>

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

Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
Helped-by: Jeff King <peff@peff.net>
---
 builtin/clean.c  | 23 +++++++++++++++++++----
 t/t7300-clean.sh |  4 ++--
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 98c103f..e951bd9 100644
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
@@ -148,6 +147,24 @@ static int exclude_cb(const struct option *opt, co=
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
+		int orig_path_len =3D path->len;
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
@@ -155,13 +172,11 @@ static int remove_dirs(struct strbuf *path, const=
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
index cfdf6d4..ada569d 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -455,7 +455,7 @@ test_expect_success 'nested git work tree' '
 	! test -d bar
 '
=20
-test_expect_failure 'nested git (only init) should be kept' '
+test_expect_success 'nested git (only init) should be kept' '
 	rm -fr foo bar &&
 	mkdir foo bar &&
 	(
@@ -471,7 +471,7 @@ test_expect_failure 'nested git (only init) should =
be kept' '
 	! test -d bar
 '
=20
-test_expect_failure 'nested git (bare) should be kept' '
+test_expect_success 'nested git (bare) should be kept' '
 	rm -fr foo bar &&
 	mkdir foo bar &&
 	(
--=20
2.4.0.rc0.37.ga3b75b3
