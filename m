From: Alexander Rinass <alex@fournova.com>
Subject: [PATCH v2] diff: run arguments through precompose_argv
Date: Fri, 13 May 2016 22:41:02 +0200
Message-ID: <1463172062-4175-2-git-send-email-alex@fournova.com>
References: <1463172062-4175-1-git-send-email-alex@fournova.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Alexander Rinass <alex@fournova.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 22:41:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Jtp-0001Gz-Lm
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 22:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbcEMUlX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2016 16:41:23 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35941 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbcEMUlW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 16:41:22 -0400
Received: by mail-wm0-f42.google.com with SMTP id n129so36049503wmn.1
        for <git@vger.kernel.org>; Fri, 13 May 2016 13:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fournova-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GpaSqdD0xT75efr/6fduIkwd4BcqGVGAyILa3XNdqv8=;
        b=rJzX4b/4YKRzyO1kfswY5AsMJ+6DKI9Bco9XdxiCp32IPWemZaJQg8tKjCvjr44cEp
         PRrLt1v0dPQSqDrMgdIRJmB5enfFmubzBXGjOb4UuNASngcJc9MGoXzDN4Jc+CEp71tJ
         1ifouDzfLwlAI7whfMWQv8BZ2BqEGg2C6kvvVw6rVnGuFfVj6LZaL0msnqtZK4odltmj
         TQ5evmdCeKkNRrTH7Zz+qM/w4JHKcAwQCKdFUJFSEia1C+WPm1EVWeVO801PgO7Rfux1
         4nN4+2m1i1jCKVE5dPOX9NNFpFkZw27vypUzh2oNhFeHRT/k/4+IvaKBK2E6N3WBetlM
         rZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GpaSqdD0xT75efr/6fduIkwd4BcqGVGAyILa3XNdqv8=;
        b=Bd6H7QTDWBI5Lm653P4JUBTUClfeSa7HfPyPKD2cvli4vXzn1FF9NytoIxGARrVyat
         47dY+CKTACKeAECmUBqHuhoEnMFJWk9skzhs7VR1HT9cWUeLtefeRXlIlxNvhftAxleT
         lLOg6IfH2dHO8hAoSlpyCTpaPBTlqsQmeCo6XwOxe66gY34jf5iRNOaJvGhMbR2+S+0J
         c3Df7Dv382NwKw+3JonHduNYB8dmCbKHZlKXo/yArtC+BzhbuS0iUaLcXPLm8YBKGCK1
         ZOWpVlsaj5QiTGkKRVkYnyt93IrjvbUWmT17pm94o7gZMjTySt/CRML5k12YOC3IPS/B
         QQYA==
X-Gm-Message-State: AOPr4FWY8op9SJXn4/zTzHcU/nhp1Kt9b8rC+5VSRETdSUNt8kQti0AvKu/h00NKSCpseQ==
X-Received: by 10.28.211.10 with SMTP id k10mr5536291wmg.82.1463172080691;
        Fri, 13 May 2016 13:41:20 -0700 (PDT)
Received: from Alexanders-MacBook-Pro.fritz.box (aftr-109-90-232-30.unity-media.net. [109.90.232.30])
        by smtp.gmail.com with ESMTPSA id b15sm4950304wmd.1.2016.05.13.13.41.19
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 13 May 2016 13:41:20 -0700 (PDT)
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1463172062-4175-1-git-send-email-alex@fournova.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294575>

When running diff commands, a pathspec containing decomposed
unicode code points is not converted to precomposed unicode form
under Mac OS X, but we normalize the paths in the index and the
history to precomposed form on that platform.  As a result, the
pathspec would not match and no diff is shown.

Unlike many builtin commands, the "diff" family of commands do
not use parse_options(), which is how other builtin commands
indirectly call precompose_argv() to normalize argv[] into
precomposed form on Mac OSX.  Teach these commands to call
precompose_argv() themselves.

Note that precomopose_argv() normalizes not just paths but all
command line arguments, so things like "git diff -G $string"
when $string has the decomposed form would first normalized into
the precomposed form and would stop hitting the same string in
the decomposed form in the diff output with this change.  It is
not a problem per-se, as "log" family of commands already use
parse_options() and call precompose_argv()--we can think of it
as making the "diff" family of commands behave in a similar way
as the commands in the "log" family.

Signed-off-by: Alexander Rinass <alex@fournova.com>
Helped-by: Torsten Bo=CC=88gershausen <tboegi@web.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/diff-files.c         |  1 +
 builtin/diff-index.c         |  1 +
 builtin/diff-tree.c          |  2 ++
 builtin/diff.c               |  1 +
 t/t3910-mac-os-precompose.sh | 42 ++++++++++++++++++++++++++++++++++++=
++++++
 5 files changed, 47 insertions(+)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 8ed2eb8..15c61fd 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -24,6 +24,7 @@ int cmd_diff_files(int argc, const char **argv, const=
 char *prefix)
 	gitmodules_config();
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	rev.abbrev =3D 0;
+	precompose_argv(argc, argv);
=20
 	argc =3D setup_revisions(argc, argv, &rev, NULL);
 	while (1 < argc && argv[1][0] =3D=3D '-') {
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index d979824..1af373d 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -21,6 +21,7 @@ int cmd_diff_index(int argc, const char **argv, const=
 char *prefix)
 	gitmodules_config();
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	rev.abbrev =3D 0;
+	precompose_argv(argc, argv);
=20
 	argc =3D setup_revisions(argc, argv, &rev, NULL);
 	for (i =3D 1; i < argc; i++) {
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 2a12b81..806dd7a 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -114,6 +114,8 @@ int cmd_diff_tree(int argc, const char **argv, cons=
t char *prefix)
 	opt->disable_stdin =3D 1;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.tweak =3D diff_tree_tweak_rev;
+
+	precompose_argv(argc, argv);
 	argc =3D setup_revisions(argc, argv, opt, &s_r_opt);
=20
 	while (--argc > 0) {
diff --git a/builtin/diff.c b/builtin/diff.c
index 52c98a9..d6b8f98 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -319,6 +319,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	if (!no_index)
 		gitmodules_config();
 	git_config(git_diff_ui_config, NULL);
+	precompose_argv(argc, argv);
=20
 	init_revisions(&rev, prefix);
=20
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.s=
h
index 8319356..26dd5b7 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -49,12 +49,54 @@ test_expect_success "setup" '
 test_expect_success "setup case mac" '
 	git checkout -b mac_os
 '
+# This will test nfd2nfc in git diff
+test_expect_success "git diff f.Adiar" '
+	touch f.$Adiarnfc &&
+	git add f.$Adiarnfc &&
+	echo f.Adiarnfc >f.$Adiarnfc &&
+	git diff f.$Adiarnfd >expect &&
+	git diff f.$Adiarnfc >actual &&
+	test_cmp expect actual &&
+	git reset HEAD f.Adiarnfc &&
+	rm f.$Adiarnfc expect actual
+'
+# This will test nfd2nfc in git diff-files
+test_expect_success "git diff-files f.Adiar" '
+	touch f.$Adiarnfc &&
+	git add f.$Adiarnfc &&
+	echo f.Adiarnfc >f.$Adiarnfc &&
+	git diff-files f.$Adiarnfd >expect &&
+	git diff-files f.$Adiarnfc >actual &&
+	test_cmp expect actual &&
+	git reset HEAD f.Adiarnfc &&
+	rm f.$Adiarnfc expect actual
+'
+# This will test nfd2nfc in git diff-index
+test_expect_success "git diff-index f.Adiar" '
+	touch f.$Adiarnfc &&
+	git add f.$Adiarnfc &&
+	echo f.Adiarnfc >f.$Adiarnfc &&
+	git diff-index HEAD f.$Adiarnfd >expect &&
+	git diff-index HEAD f.$Adiarnfc >actual &&
+	test_cmp expect actual &&
+	git reset HEAD f.Adiarnfc &&
+	rm f.$Adiarnfc expect actual
+'
 # This will test nfd2nfc in readdir()
 test_expect_success "add file Adiarnfc" '
 	echo f.Adiarnfc >f.$Adiarnfc &&
 	git add f.$Adiarnfc &&
 	git commit -m "add f.$Adiarnfc"
 '
+# This will test nfd2nfc in git diff-tree
+test_expect_success "git diff-tree f.Adiar" '
+	echo f.Adiarnfc >>f.$Adiarnfc &&
+	git diff-tree HEAD f.$Adiarnfd >expect &&
+	git diff-tree HEAD f.$Adiarnfc >actual &&
+	test_cmp expect actual &&
+	git checkout f.$Adiarnfc &&
+	rm expect actual
+'
 # This will test nfd2nfc in git stage()
 test_expect_success "stage file d.Adiarnfd/f.Adiarnfd" '
 	mkdir d.$Adiarnfd &&
--=20
2.8.2
