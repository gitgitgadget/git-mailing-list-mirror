From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v2 1/3] t7300: add tests to document behavior of clean and nested git
Date: Sat, 11 Apr 2015 18:43:05 +0200
Message-ID: <1428770587-9674-3-git-send-email-erik.elfstrom@gmail.com>
References: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 18:43:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgyVP-0005ik-UX
	for gcvg-git-2@plane.gmane.org; Sat, 11 Apr 2015 18:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbbDKQnc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2015 12:43:32 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33720 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbbDKQn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2015 12:43:29 -0400
Received: by lbbzk7 with SMTP id zk7so32978809lbb.0
        for <git@vger.kernel.org>; Sat, 11 Apr 2015 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+crzOf2snDi++0rRKSNwXlxza1af3mjCZMjRtxdaW3A=;
        b=Vzpao4bhlP6GLeyvCftKT4USjLHUExbqzaD/juBT9V/sMEfzDHGHPP9Wc5Xq1i8CCD
         6iNdgDg0H1RPwDugJJ8Wa3taJTePq8LYzvoHeuAW9ibLXKh158J2Rl24sanJLOsFZrCF
         77ontJDM4+pezOZb/9RyWLlvQ2mUq4P2Bx+BJx4CYbmqzbbSNn9cCT90tX0VDgFVDmbI
         DLL/1SaeH4fHTGxXHcaKoRP8rxVHkZ473fp4UThVuFn7cOenlW1qh3tZx6zjSgLlm1KO
         bCF9ZFqh74qpCecbVaOAhwRydOk3+ahY2/m00W1hWzBVff4XEXYSaCt3sDNgYgtw2laZ
         K+bQ==
X-Received: by 10.152.6.136 with SMTP id b8mr6009376laa.93.1428770608140;
        Sat, 11 Apr 2015 09:43:28 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id kx8sm501395lbc.3.2015.04.11.09.43.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Apr 2015 09:43:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc0.37.ga3b75b3
In-Reply-To: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267026>

Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 t/t7300-clean.sh | 72 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 72 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 99be5d9..58e6b4a 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -455,6 +455,78 @@ test_expect_success 'nested git work tree' '
 	! test -d bar
 '
=20
+test_expect_failure 'nested git (only init) should be kept' '
+	rm -fr foo bar &&
+	git init foo &&
+	mkdir bar &&
+	>bar/goodbye.people &&
+	git clean -f -d &&
+	test_path_is_file foo/.git/HEAD &&
+	test_path_is_missing bar
+'
+
+test_expect_failure 'nested git (bare) should be kept' '
+	rm -fr foo bar &&
+	git init --bare foo &&
+	mkdir bar &&
+	>bar/goodbye.people &&
+	git clean -f -d &&
+	test_path_is_file foo/HEAD &&
+	test_path_is_missing bar
+'
+
+test_expect_success 'giving path in nested git work tree will remove i=
t' '
+	rm -fr foo &&
+	mkdir foo &&
+	(
+		cd foo &&
+		git init &&
+		mkdir -p bar/baz &&
+		(
+			cd bar/baz &&
+			>hello.world &&
+			git add . &&
+			git commit -a -m nested
+		)
+	) &&
+	git clean -f -d foo/bar/baz &&
+	test_path_is_file foo/.git/HEAD &&
+	test_path_is_dir foo/bar/ &&
+	test_path_is_missing foo/bar/baz
+'
+
+test_expect_success 'giving path to nested .git will not remove it' '
+	rm -fr foo &&
+	mkdir foo bar &&
+	(
+		cd foo &&
+		git init &&
+		>hello.world &&
+		git add . &&
+		git commit -a -m nested
+	) &&
+	git clean -f -d foo/.git &&
+	test_path_is_file foo/.git/HEAD &&
+	test_path_is_dir foo/.git/refs &&
+	test_path_is_dir foo/.git/objects &&
+	test_path_is_dir bar/
+'
+
+test_expect_success 'giving path to nested .git/ will remove contents'=
 '
+	rm -fr foo bar &&
+	mkdir foo bar &&
+	(
+		cd foo &&
+		git init &&
+		>hello.world &&
+		git add . &&
+		git commit -a -m nested
+	) &&
+	git clean -f -d foo/.git/ &&
+	test_path_is_dir foo/.git &&
+	test_dir_is_empty foo/.git
+'
+
 test_expect_success 'force removal of nested git work tree' '
 	rm -fr foo bar baz &&
 	mkdir -p foo bar baz/boo &&
--=20
2.4.0.rc0.37.ga3b75b3
