From: Alexander Rinass <alex@fournova.com>
Subject: [PATCH] diff: run arguments through precompose_argv
Date: Mon,  4 Apr 2016 22:38:45 +0200
Message-ID: <1459802325-22056-2-git-send-email-alex@fournova.com>
References: <1459802325-22056-1-git-send-email-alex@fournova.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Alexander Rinass <alex@fournova.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 22:40:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anBIR-0006hm-0P
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 22:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378AbcDDUkQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2016 16:40:16 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33894 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755616AbcDDUkP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 16:40:15 -0400
Received: by mail-lf0-f52.google.com with SMTP id c62so188933613lfc.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 13:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fournova-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ekdYY7xIW4mmIHSH9etODBfrjk4cEvAkut9kphklE6g=;
        b=p3/+2iHCSQ6r6hJgWOjL8KGvV/iZ9TRPT+bID3nvHFDTIA7jtTTxALZEhYdUMDSiKj
         VzdDuXCXlAFGACU10KuddNM4lkLzHRvdq4IgQwyz4yE+Ll3u6PBm6Nyr9b7ekX2ITEyP
         p/eCcduP9JlauAPvNIXwqpfxdqjRxkiGk9eD6mNUbBi27LYGfm4vy+w5QTwLAP4oFQA0
         5AKDczKL9Q3jOLLMqsEghkHHUmlOHH9Yj32vLf1wlOM90Wf+5acQ6A5GnW9LpSinZqJ0
         EPL4j/BCyPyukeOiHJeFoxdCBmc/cPruOInVjz/PS4jP8yUxKIZSUp82YkT4ht2hfUa4
         MSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ekdYY7xIW4mmIHSH9etODBfrjk4cEvAkut9kphklE6g=;
        b=OnCsftyZWVbjQEXLlFtHr6w2+JyhnS1XhrVMV7z1OD4pUNjRnN/lb/wOk0qdO+yZql
         dIJ3O4+PaxxSlebtKGVGe4JZAoKbnCFGSz4GmAUDWmOAzRaN9YnC5b+1+rVwnxSQr/Dl
         z+fzKjUvXhFidapZp+2dihy8nZ2SnVRJ5NLJMe3U2sc1djuPhOg01k23XA1XOU3UjZpi
         Fg4rVoMMzXwCj8FNMaO6bwOM+3sy+9X2kkTZCwb35iA7Nk78DTY9/f5sMmhcdSn0Ym10
         1vYs3hJaR2xal8+GeiS7k4m0tTodbZEogb/JTEOp1h8yZmCsJXh3Em4PDBpl1PIm399Z
         2R0Q==
X-Gm-Message-State: AD7BkJKwsSOO9ltOyn6wsN917hSBJ/XVOOwPkoSvTEaD7qIr09TIuNwv9OCU7mKj7sMpvg==
X-Received: by 10.194.2.225 with SMTP id 1mr4455786wjx.29.1459802413346;
        Mon, 04 Apr 2016 13:40:13 -0700 (PDT)
Received: from Alexanders-MacBook-Pro.fritz.box (aftr-95-222-24-110.unity-media.net. [95.222.24.110])
        by smtp.gmail.com with ESMTPSA id c144sm15724635wmd.0.2016.04.04.13.40.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 13:40:12 -0700 (PDT)
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1459802325-22056-1-git-send-email-alex@fournova.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290724>

=46ile paths containing decomposed unicode chars passed to diff
command are not converted to precomposed unicode form.

As a result, no diff is displayed when feeding such a file path to the
diff command.

Opposite to most builtin commands, the diff builtin is missing the
parse_options call, which internally runs arguments through the
precompose_argv call, which ensures all arguments are in precomposed
unicode form.

=46ix the problem by adding a precompose_argv call directly, as a call =
to
parse_options would require additional work to call it.

Also applies to diff-index, diff-files and diff-tree.

Signed-off-by: Alexander Rinass <alex@fournova.com>
Thanks-to: Torsten Bo=CC=88gershausen <tboegi@web.de>
Thanks-to: Junio C Hamano <gitster@pobox.com>
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
2.7.2
