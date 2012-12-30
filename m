From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 2/2] git-status: Test --ignored behavior
Date: Sun, 30 Dec 2012 15:39:01 +0100
Message-ID: <1356878341-12942-2-git-send-email-apelisse@gmail.com>
References: <1356878341-12942-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 15:47:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpKAK-0006sO-TQ
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 15:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614Ab2L3Oqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 09:46:47 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:48202 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab2L3Oqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 09:46:45 -0500
Received: by mail-wi0-f173.google.com with SMTP id hn17so8972462wib.12
        for <git@vger.kernel.org>; Sun, 30 Dec 2012 06:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=+tRPk2mFSY30gHgEN++0Bwf/6dlAhXPU11Spa3O89GU=;
        b=uMm+U8UnZnb6+mJQ2kIHrtFwUir2KnM2pewDMeoV5NxJ/xaH3SuqAfxZTU/lQMiYHj
         oHVzhpEyzJPvGh+hK0gNQpMhWACRI5Rs3dRUgg24RAxkMXtE5Sty897UzFfGRkyNx7j+
         pKOpRs9QjbxlsH68E4KEUVm0Ic/maU8B+QtZf0Dw/oSD8UMnjICRbXSf8j7reoPdAn7e
         MSOAroRxbfnKRF157ImPRCQ5AWMTIV/XYYjpjmYJ8JWHlp0KhvwJyCKtUdMfa0Pgg6hV
         M9x5TurBPYsKro/EnDNnFgZfrqiFTKuzjxVH2rHN+wgEi5GaEzcFYPHkaBUAQWdKAC1e
         +FAA==
X-Received: by 10.180.95.135 with SMTP id dk7mr52290283wib.29.1356878389659;
        Sun, 30 Dec 2012 06:39:49 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id gz3sm71210191wib.2.2012.12.30.06.39.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 30 Dec 2012 06:39:49 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1356878341-12942-1-git-send-email-apelisse@gmail.com>
In-Reply-To: <20121229072249.GB15408@sigill.intra.peff.net>
References: <20121229072249.GB15408@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212332>

Test all possible use-cases of git-status --ignored with
--untracked-files to normal and all:

 - untracked directory is listed as untracked if it has a mix of
 untracked and ignored files in it.
 with -uall, ignored/untracked files are listed as
 ignored/untracked.

 - untracked directory with only ignored files is listed as ignored.
 with -uall, all files in the directory are listed.

 - ignored directory is listed as ignored. With -uall, all files in
 the directory are listed as ignored.

 - ignored and committed directory is listed as ignored if it has
 untracked files.
 with -uall, all untracked files in the directory are listed as
 ignored.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 t/t7061-wtstatus-ignore.sh |  146 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100755 t/t7061-wtstatus-ignore.sh

diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
new file mode 100755
index 0000000..0da1214
--- /dev/null
+++ b/t/t7061-wtstatus-ignore.sh
@@ -0,0 +1,146 @@
+#!/bin/sh
+
+test_description='git-status ignored files'
+
+. ./test-lib.sh
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+?? untracked/
+EOF
+
+test_expect_success 'status untracked directory with --ignored' '
+	echo "ignored" >.gitignore &&
+	mkdir untracked &&
+	: >untracked/ignored &&
+	: >untracked/uncommitted &&
+	git status --porcelain --ignored >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+?? untracked/uncommitted
+!! untracked/ignored
+EOF
+
+test_expect_success 'status untracked directory with --ignored -u' '
+	git status --porcelain --ignored -u >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+!! ignored/
+EOF
+
+test_expect_success 'status ignored directory with --ignore' '
+	rm -rf untracked &&
+	mkdir ignored &&
+	: >ignored/uncommitted &&
+	git status --porcelain --ignored >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+!! ignored/uncommitted
+EOF
+
+test_expect_success 'status ignored directory with --ignore -u' '
+	git status --porcelain --ignored -u >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+!! untracked-ignored/
+EOF
+
+test_expect_success 'status untracked directory with ignored files with --ignore' '
+	rm -rf ignored &&
+	mkdir untracked-ignored &&
+	mkdir untracked-ignored/test &&
+	: >untracked-ignored/ignored &&
+	: >untracked-ignored/test/ignored &&
+	git status --porcelain --ignored >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+!! untracked-ignored/ignored
+!! untracked-ignored/test/ignored
+EOF
+
+test_expect_success 'status untracked directory with ignored files with --ignore -u' '
+	git status --porcelain --ignored -u >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+EOF
+
+test_expect_success 'status ignored tracked directory with --ignore' '
+	rm -rf untracked-ignored &&
+	mkdir tracked &&
+	: >tracked/committed &&
+	git add tracked/committed &&
+	git commit -m. &&
+	echo "tracked" >.gitignore &&
+	git status --porcelain --ignored >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+EOF
+
+test_expect_success 'status ignored tracked directory with --ignore -u' '
+	git status --porcelain --ignored -u >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+!! tracked/
+EOF
+
+test_expect_success 'status ignored tracked directory and uncommitted file with --ignore' '
+	: >tracked/uncommitted &&
+	git status --porcelain --ignored >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+!! tracked/uncommitted
+EOF
+
+test_expect_success 'status ignored tracked directory and uncommitted file with --ignore -u' '
+	git status --porcelain --ignored -u >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.7.9.5
