From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v6 4/7] t7300: add tests to document behavior of clean and nested git
Date: Sun, 10 May 2015 22:00:38 +0200
Message-ID: <1431288041-21077-5-git-send-email-erik.elfstrom@gmail.com>
References: <1431288041-21077-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 22:03:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrXRY-00057Q-PP
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 22:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbbEJUDQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2015 16:03:16 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:35555 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbbEJUDP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 16:03:15 -0400
Received: by labbd9 with SMTP id bd9so81119303lab.2
        for <git@vger.kernel.org>; Sun, 10 May 2015 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0sltgv8fCo2+jBesPHMZy4F9Dile/6ZLKSXxrx4ffw8=;
        b=qv8foqLSpZEBlv1bPknsDCrHni6uKzIvy09inMTqFDmpBsH6xdCDe0RY3rm3LYs0Jt
         wqo9qkrSbxBEsAjkCI7TJ5fkOXeveKCfYfEfoNiZwFYPPykLKDqPXgN2PkbrMhZO/G+q
         V9UefkjwY+U8KXwfsAxi1JG+xUJck/9VlbMtOwK7UIzQkh36l8/ar3v2ZMgt0jYJI3TY
         5t4UpqZYjpXFDK3nx7DORXK37yHwFSYOhvwLpwQV7fQzY/DJd43rTFZ/SdcCoeQ3bYCf
         FuA1IguDDT6bq0EwGl0NwEtzsRBRM32vJPxmdlaatjY9rxmwi2pSnpDa1F5nY2j05cKC
         Hbaw==
X-Received: by 10.112.77.234 with SMTP id v10mr5553788lbw.119.1431288194465;
        Sun, 10 May 2015 13:03:14 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id k15sm2586218laa.28.2015.05.10.13.03.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 May 2015 13:03:13 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.60.gf7143f7
In-Reply-To: <1431288041-21077-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268744>

Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 t/t7300-clean.sh | 146 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 146 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 99be5d9..23962e4 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -455,6 +455,152 @@ test_expect_success 'nested git work tree' '
 	! test -d bar
 '
=20
+test_expect_failure 'should clean things that almost look like git but=
 are not' '
+	rm -fr almost_git almost_bare_git almost_submodule &&
+	mkdir -p almost_git/.git/objects &&
+	mkdir -p almost_git/.git/refs &&
+	cat >almost_git/.git/HEAD <<-\EOF &&
+	garbage
+	EOF
+	cp -r almost_git/.git/ almost_bare_git &&
+	mkdir almost_submodule/ &&
+	cat >almost_submodule/.git <<-\EOF &&
+	garbage
+	EOF
+	test_when_finished "rm -rf almost_*" &&
+	## This will fail due to die("Invalid gitfile format: %s", path); in
+	## setup.c:read_gitfile.
+	git clean -f -d &&
+	test_path_is_missing almost_git &&
+	test_path_is_missing almost_bare_git &&
+	test_path_is_missing almost_submodule
+'
+
+test_expect_success 'should not clean submodules' '
+	rm -fr repo to_clean sub1 sub2 &&
+	mkdir repo to_clean &&
+	(
+		cd repo &&
+		git init &&
+		test_commit msg hello.world
+	) &&
+	git submodule add ./repo/.git sub1 &&
+	git commit -m "sub1" &&
+	git branch before_sub2 &&
+	git submodule add ./repo/.git sub2 &&
+	git commit -m "sub2" &&
+	git checkout before_sub2 &&
+	>to_clean/should_clean.this &&
+	git clean -f -d &&
+	test_path_is_file repo/.git/index &&
+	test_path_is_file repo/hello.world &&
+	test_path_is_file sub1/.git &&
+	test_path_is_file sub1/hello.world &&
+	test_path_is_file sub2/.git &&
+	test_path_is_file sub2/hello.world &&
+	test_path_is_missing to_clean
+'
+
+test_expect_failure 'should avoid cleaning possible submodules' '
+	rm -fr to_clean possible_sub1 possible_sub2 &&
+	mkdir to_clean possible_sub1 &&
+	test_when_finished "rm -rf possible_sub*" &&
+	echo "gitdir: foo" > possible_sub1/.git &&
+	>possible_sub1/hello.world &&
+	cp -r possible_sub1 possible_sub2 &&
+	printf "%*s\n" 5000 | tr " " a >> possible_sub1/.git &&
+	chmod 0 possible_sub2/.git &&
+	>to_clean/should_clean.this &&
+	git clean -f -d &&
+	test_path_is_file possible_sub1/.git &&
+	test_path_is_file possible_sub1/hello.world &&
+	test_path_is_file possible_sub2/.git &&
+	test_path_is_file possible_sub2/hello.world &&
+	test_path_is_missing to_clean
+'
+
+test_expect_failure 'nested (empty) git should be kept' '
+	rm -fr empty_repo to_clean &&
+	git init empty_repo &&
+	mkdir to_clean &&
+	>to_clean/should_clean.this &&
+	git clean -f -d &&
+	test_path_is_file empty_repo/.git/HEAD &&
+	test_path_is_missing to_clean
+'
+
+test_expect_success 'nested bare repositories should be cleaned' '
+	rm -fr bare1 bare2 subdir &&
+	git init --bare bare1 &&
+	git clone --local --bare . bare2 &&
+	mkdir subdir &&
+	cp -r bare2 subdir/bare3 &&
+	git clean -f -d &&
+	test_path_is_missing bare1 &&
+	test_path_is_missing bare2 &&
+	test_path_is_missing subdir
+'
+
+test_expect_success 'nested (empty) bare repositories should be cleane=
d even when in .git' '
+	rm -fr strange_bare &&
+	mkdir strange_bare &&
+	git init --bare strange_bare/.git &&
+	git clean -f -d &&
+	test_path_is_missing strange_bare
+'
+
+test_expect_failure 'nested (non-empty) bare repositories should be cl=
eaned even when in .git' '
+	rm -fr strange_bare &&
+	mkdir strange_bare &&
+	git clone --local --bare . strange_bare/.git &&
+	git clean -f -d &&
+	test_path_is_missing strange_bare
+'
+
+test_expect_success 'giving path in nested git work tree will remove i=
t' '
+	rm -fr repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+		mkdir -p bar/baz &&
+		test_commit msg bar/baz/hello.world
+	) &&
+	git clean -f -d repo/bar/baz &&
+	test_path_is_file repo/.git/HEAD &&
+	test_path_is_dir repo/bar/ &&
+	test_path_is_missing repo/bar/baz
+'
+
+test_expect_success 'giving path to nested .git will not remove it' '
+	rm -fr repo &&
+	mkdir repo untracked &&
+	(
+		cd repo &&
+		git init &&
+		test_commit msg hello.world
+	) &&
+	git clean -f -d repo/.git &&
+	test_path_is_file repo/.git/HEAD &&
+	test_path_is_dir repo/.git/refs &&
+	test_path_is_dir repo/.git/objects &&
+	test_path_is_dir untracked/
+'
+
+test_expect_success 'giving path to nested .git/ will remove contents'=
 '
+	rm -fr repo untracked &&
+	mkdir repo untracked &&
+	(
+		cd repo &&
+		git init &&
+		test_commit msg hello.world
+	) &&
+	git clean -f -d repo/.git/ &&
+	test_path_is_dir repo/.git &&
+	test_dir_is_empty repo/.git &&
+	test_path_is_dir untracked/
+'
+
 test_expect_success 'force removal of nested git work tree' '
 	rm -fr foo bar baz &&
 	mkdir -p foo bar baz/boo &&
--=20
2.4.0.60.gf7143f7
