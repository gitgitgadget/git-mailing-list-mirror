From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/23] Teach ls-files and update-index to respect skip-worktree bit
Date: Mon, 14 Dec 2009 17:30:48 +0700
Message-ID: <1260786666-8405-6-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:33:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8FE-0007wL-5L
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbZLNKc3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbZLNKcZ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:32:25 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:60353 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbZLNKcU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:32:20 -0500
Received: by mail-pw0-f42.google.com with SMTP id 9so1838737pwj.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=A3yZtsjTaE0NJ4poLu0YPHpencrgF84CGV4b6VETp7k=;
        b=NNMHzsEci2iU4IqR0elVYrcdrkwAvB95xVXBxCtJee3GZsteufJlkdIykO1xBCdmzC
         6hEHFbRWNRqxsA7L+P0Ovxr5Lo9yhVnXpptkJswEFU4aD8TXUbdqw6KQaOeg2j+8me1l
         dTdldIgnfDn1Y/eEkSH+rk6ftHGQ7anZyn5D4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Thn4obM5ggH6q09mWmeWzoFRT791gNE3ac27OhJ6Du7UbBogPsmWPEcMdn9XKflXEo
         AK3NYrM56/B7tNNY7r7o0h/RSJoMrW2LXLJialEP3u+7EUqUi44PlkzBPk9yeF8uNcU2
         JMAYp6glgek8n3Hsu7DpV78NlQND3quc5MqQI=
Received: by 10.141.187.19 with SMTP id o19mr3179402rvp.134.1260786739768;
        Mon, 14 Dec 2009 02:32:19 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 22sm4897686pzk.10.2009.12.14.02.32.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:32:19 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:31:38 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135174>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-ls-files.c               |    2 +
 builtin-update-index.c           |   38 +++++++-----
 t/t7011-skip-worktree-reading.sh |  114 ++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 138 insertions(+), 16 deletions(-)
 create mode 100755 t/t7011-skip-worktree-reading.sh

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index c1afbad..ad7e447 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -194,6 +194,8 @@ static void show_files(struct dir_struct *dir, cons=
t char *prefix)
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
+			if (ce_skip_worktree(ce))
+				continue;
 			err =3D lstat(ce->name, &st);
 			if (show_deleted && err)
 				show_ce_entry(tag_removed, ce);
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 5e97d09..97b9ea6 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -172,29 +172,29 @@ static int process_directory(const char *path, in=
t len, struct stat *st)
 	return error("%s: is a directory - add files inside instead", path);
 }
=20
-/*
- * Process a regular file
- */
-static int process_file(const char *path, int len, struct stat *st)
-{
-	int pos =3D cache_name_pos(path, len);
-	struct cache_entry *ce =3D pos < 0 ? NULL : active_cache[pos];
-
-	if (ce && S_ISGITLINK(ce->ce_mode))
-		return error("%s is already a gitlink, not replacing", path);
-
-	return add_one_path(ce, path, len, st);
-}
-
 static int process_path(const char *path)
 {
-	int len;
+	int pos, len;
 	struct stat st;
+	struct cache_entry *ce;
=20
 	len =3D strlen(path);
 	if (has_symlink_leading_path(path, len))
 		return error("'%s' is beyond a symbolic link", path);
=20
+	pos =3D cache_name_pos(path, len);
+	ce =3D pos < 0 ? NULL : active_cache[pos];
+	if (ce && ce_skip_worktree(ce)) {
+		/*
+		 * working directory version is assumed "good"
+		 * so updating it does not make sense.
+		 * On the other hand, removing it from index should work
+		 */
+		if (allow_remove && remove_file_from_cache(path))
+			return error("%s: cannot remove from the index", path);
+		return 0;
+	}
+
 	/*
 	 * First things first: get the stat information, to decide
 	 * what to do about the pathname!
@@ -205,7 +205,13 @@ static int process_path(const char *path)
 	if (S_ISDIR(st.st_mode))
 		return process_directory(path, len, &st);
=20
-	return process_file(path, len, &st);
+	/*
+	 * Process a regular file
+	 */
+	if (ce && S_ISGITLINK(ce->ce_mode))
+		return error("%s is already a gitlink, not replacing", path);
+
+	return add_one_path(ce, path, len, &st);
 }
=20
 static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-r=
eading.sh
new file mode 100755
index 0000000..ede3ee1
--- /dev/null
+++ b/t/t7011-skip-worktree-reading.sh
@@ -0,0 +1,114 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
+#
+
+test_description=3D'skip-worktree bit test'
+
+. ./test-lib.sh
+
+cat >expect.full <<EOF
+H 1
+H 2
+H init.t
+H sub/1
+H sub/2
+EOF
+
+cat >expect.skip <<EOF
+S 1
+H 2
+H init.t
+S sub/1
+H sub/2
+EOF
+
+NULL_SHA1=3De69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+ZERO_SHA1=3D0000000000000000000000000000000000000000
+setup_absent() {
+	test -f 1 && rm 1
+	git update-index --remove 1 &&
+	git update-index --add --cacheinfo 100644 $NULL_SHA1 1 &&
+	git update-index --skip-worktree 1
+}
+
+test_absent() {
+	echo "100644 $NULL_SHA1 0	1" > expected &&
+	git ls-files --stage 1 > result &&
+	test_cmp expected result &&
+	test ! -f 1
+}
+
+setup_dirty() {
+	git update-index --force-remove 1 &&
+	echo dirty > 1 &&
+	git update-index --add --cacheinfo 100644 $NULL_SHA1 1 &&
+	git update-index --skip-worktree 1
+}
+
+test_dirty() {
+	echo "100644 $NULL_SHA1 0	1" > expected &&
+	git ls-files --stage 1 > result &&
+	test_cmp expected result &&
+	echo dirty > expected
+	test_cmp expected 1
+}
+
+test_expect_success 'setup' '
+	test_commit init &&
+	mkdir sub &&
+	touch ./1 ./2 sub/1 sub/2 &&
+	git add 1 2 sub/1 sub/2 &&
+	git update-index --skip-worktree 1 sub/1 &&
+	git ls-files -t > result &&
+	test_cmp expect.skip result
+'
+
+test_expect_success 'update-index' '
+	setup_absent &&
+	git update-index 1 &&
+	test_absent
+'
+
+test_expect_success 'update-index' '
+	setup_dirty &&
+	git update-index 1 &&
+	test_dirty
+'
+
+test_expect_success 'update-index --remove' '
+	setup_absent &&
+	git update-index --remove 1 &&
+	test -z "$(git ls-files 1)" &&
+	test ! -f 1
+'
+
+test_expect_success 'update-index --remove' '
+	setup_dirty &&
+	git update-index --remove 1 &&
+	test -z "$(git ls-files 1)" &&
+	echo dirty > expected &&
+	test_cmp expected 1
+'
+
+test_expect_success 'ls-files --delete' '
+	setup_absent &&
+	test -z "$(git ls-files -d)"
+'
+
+test_expect_success 'ls-files --delete' '
+	setup_dirty &&
+	test -z "$(git ls-files -d)"
+'
+
+test_expect_success 'ls-files --modified' '
+	setup_absent &&
+	test -z "$(git ls-files -m)"
+'
+
+test_expect_success 'ls-files --modified' '
+	setup_dirty &&
+	test -z "$(git ls-files -m)"
+'
+
+test_done
--=20
1.6.5.2.216.g9c1ec
