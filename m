From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/21] t3080: tests for git-list-files
Date: Sun, 25 Jan 2015 19:37:56 +0700
Message-ID: <1422189476-7518-22-git-send-email-pclouds@gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 13:29:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFMJn-0004N0-Lz
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 13:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbbAYM30 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 07:29:26 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:41028 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839AbbAYM3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 07:29:25 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb1so6468286pad.10
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 04:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0lPNPM5O00v/sueLkD8X6a6qp6ZdqX9gMDx/F3DbglE=;
        b=rc5obNoeE65DmNRc9bwF8C4w/bKuFYQxmlhM7Gb97pcnzCaBosVp2TuhsxQHj0Q1IS
         6stl2nieZVLAeJaxo8imChFYMx/ElDi7Mj7eDg4e72W6gND10+nYqx27KtdS4yjXzRpl
         f0zLarcKKvMiTXdFMcVBPb8Ky3qn40Aa2l10jZi2fW6OpOJYH9adkueo39gUfJyytlNC
         x9RUibrSOblIZjYMTn7v+hlhZe1RGDsG2T/4UgBPgHHerxErUuRciXF6LcLt+Dw/H+AS
         +JJZL9/vWx1AbIOvfDS2G7fGjzAS1JqLNUPSX8RQp3UBvscazSZWF8HOhQYV+vfsgB+Q
         NH9g==
X-Received: by 10.68.221.165 with SMTP id qf5mr25792755pbc.101.1422188964885;
        Sun, 25 Jan 2015 04:29:24 -0800 (PST)
Received: from lanh ([115.73.204.104])
        by mx.google.com with ESMTPSA id ps9sm7135244pbb.21.2015.01.25.04.29.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 04:29:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 Jan 2015 19:40:48 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263018>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3080-list-files.sh (new +x) | 122 +++++++++++++++++++++++++++++++++=
++++++++
 t/t3080/color_ls (new)         |   3 +
 t/t3080/ls_colors (new)        |   2 +
 3 files changed, 127 insertions(+)
 create mode 100755 t/t3080-list-files.sh
 create mode 100644 t/t3080/color_ls
 create mode 100644 t/t3080/ls_colors

diff --git a/t/t3080-list-files.sh b/t/t3080-list-files.sh
new file mode 100755
index 0000000..6313dd9
--- /dev/null
+++ b/t/t3080-list-files.sh
@@ -0,0 +1,122 @@
+#!/bin/sh
+
+test_description=3D'git list-files test'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir dir &&
+	touch file dir/file &&
+	git init gitlink &&
+	( cd gitlink && test_commit foo ) &&
+	git add file dir/file gitlink &&
+	git commit -qm1
+'
+
+test_expect_success 'LS_COLORS env variable' '
+	LS_COLORS=3D"rs=3D0:fi=3D31:di=3D32" \
+		git list-files --color=3Dalways | grep -v gitlink >actual &&
+	test_cmp "$TEST_DIRECTORY"/t3080/ls_colors actual
+'
+
+test_expect_success 'color.ls.*' '
+	test_config color.ls.file red &&
+	test_config color.ls.directory green &&
+	test_config color.ls.submodule yellow &&
+	git list-files --color=3Dalways >actual &&
+	test_cmp "$TEST_DIRECTORY"/t3080/color_ls actual
+'
+
+test_expect_success 'column output' '
+	COLUMNS=3D20 git list-files --column=3Dalways >actual &&
+	cat >expected <<-\EOF &&
+	dir      gitlink
+	file
+	EOF
+	test_cmp expected actual &&
+	git list-files -1 >actual &&
+	cat >expected <<-\EOF &&
+	dir
+	file
+	gitlink
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success '--max-depth' '
+	git list-files --max-depth=3D1 >actual &&
+	cat >expected <<-\EOF &&
+	dir/file
+	file
+	gitlink
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'recursive' '
+	git list-files -R >actual &&
+	cat >expected <<-\EOF &&
+	dir/file
+	file
+	gitlink
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'globbing' '
+	git list-files "f*" >actual &&
+	cat >expected <<-\EOF &&
+	file
+	EOF
+	test_cmp expected actual &&
+	git list-files "**/f*" >actual &&
+	cat >expected <<-\EOF &&
+	dir/file
+	file
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'no dups' '
+	echo dirty >>file &&
+	git list-files -m file >actual &&
+	echo "file" >expected &&
+	test_cmp expected actual &&
+	git list-files -cm file >actual &&
+	echo "C file" >expected &&
+	test_cmp expected actual &&
+	git list-files -tcm file >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--classify' '
+	git list-files -F >actual &&
+	cat >expected <<-\EOF &&
+	dir/
+	file
+	gitlink&
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'diff-cached' '
+	echo dirty >>file &&
+	git add file &&
+	git list-files -M >actual &&
+	echo "file" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'unmerged files' '
+	git ls-files --stage file >index-info &&
+	sed "s/ 0/ 2/;s/file/unmerged/" index-info | git update-index --index=
-info &&
+	sed "s/ 0/ 3/;s,file,dir/unmerged," index-info | git update-index --i=
ndex-info &&
+	git list-files -u >actual &&
+	cat >expected <<-\EOF &&
+	dir
+	unmerged
+	EOF
+	test_cmp expected actual
+'
+
+test_done
diff --git a/t/t3080/color_ls b/t/t3080/color_ls
new file mode 100644
index 0000000..47f77ad
--- /dev/null
+++ b/t/t3080/color_ls
@@ -0,0 +1,3 @@
+=1B[32mdir=1B[m
+=1B[31mfile=1B[m
+=1B[33mgitlink=1B[m
diff --git a/t/t3080/ls_colors b/t/t3080/ls_colors
new file mode 100644
index 0000000..423c016
--- /dev/null
+++ b/t/t3080/ls_colors
@@ -0,0 +1,2 @@
+=1B[32mdir=1B[m
+=1B[31mfile=1B[m
--=20
2.2.0.84.ge9c7a8a
