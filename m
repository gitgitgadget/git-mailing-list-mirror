From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/21] t3080: tests for git-list-files
Date: Sun,  8 Feb 2015 16:01:39 +0700
Message-ID: <1423386099-19994-22-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:04:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNmx-0006Yo-U7
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755976AbbBHJET convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:04:19 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:40569 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbbBHJEN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:04:13 -0500
Received: by pdev10 with SMTP id v10so6995384pde.7
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=w5+/TLYJ0HKQVP1OGpYCTXQlkFP3TppPCExrz8eYlLI=;
        b=w9FiPko7OaBF6l4m6YFPTI4gp5cWZzr+fcVWDfRMC+Y79JllLS1OYz2xQzMaVu9bMx
         gUrDXeMf8aAGcT9Ayn5WKjwO77nZI4kibv96K9ESIXe6RVQ8Plm54gtWw19RSHHvhKnh
         Swmt2JJ+fWYo5MgwwbK94mve1ZAZb88dqm3t8A3PuacRiqFY73gb/UIivRVRgX/3rQJD
         QX79RFa+kUoDx5g0pSFp4U88rpqpIytSIiduNaI67Lpo6cMY8F5/lq5luhu72xY5YAwH
         h71yqsd0cCDSxj7AZ4b28954ho+4DgEzhz61Yl3yg3jWrZllYQBa07S/3xh3le9gSEQu
         9Usg==
X-Received: by 10.68.68.139 with SMTP id w11mr19536807pbt.82.1423386253510;
        Sun, 08 Feb 2015 01:04:13 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id go1sm12232005pbd.75.2015.02.08.01.04.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:04:12 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:04:21 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263508>

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3080-list-files.sh (new +x) | 134 +++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 134 insertions(+)
 create mode 100755 t/t3080-list-files.sh

diff --git a/t/t3080-list-files.sh b/t/t3080-list-files.sh
new file mode 100755
index 0000000..01b9662
--- /dev/null
+++ b/t/t3080-list-files.sh
@@ -0,0 +1,134 @@
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
+		git list-files --color=3Dalways | test_decode_color | \
+		grep -v gitlink >actual &&
+	cat >expected <<-\EOF &&
+	<GREEN>dir<RESET>
+	<RED>file<RESET>
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'color.ls.*' '
+	test_config color.ls.file red &&
+	test_config color.ls.directory green &&
+	test_config color.ls.submodule yellow &&
+	git list-files --color=3Dalways | test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<GREEN>dir<RESET>
+	<RED>file<RESET>
+	<YELLOW>gitlink<RESET>
+	EOF
+	test_cmp expected actual
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
+	test_when_finished "git checkout file" &&
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
+	test_when_finished "git checkout file" &&
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
--=20
2.3.0.rc1.137.g477eb31
