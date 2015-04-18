From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH/RFC v3 2/4] t7300: add tests to document behavior of clean and nested git
Date: Sat, 18 Apr 2015 22:41:10 +0200
Message-ID: <1429389672-30209-3-git-send-email-erik.elfstrom@gmail.com>
References: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 22:41:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjZYm-0005hc-Ie
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 22:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207AbbDRUlt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2015 16:41:49 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:36779 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803AbbDRUlr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 16:41:47 -0400
Received: by lagv1 with SMTP id v1so102290775lag.3
        for <git@vger.kernel.org>; Sat, 18 Apr 2015 13:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9AnLRiFCxDJM5Zp/xM263Mq5xX2s52TDdk0lhDta+eM=;
        b=gxsxu5hmzdYq+mmKaClBAzo3RsaNs60RWshn9SdLZdo2nLftdl/ESSoLcwiJmakECH
         PCWpyMAC0Kq44CZ/r1r6MSVxQmmT2ewrsvtBY+pOk+DVAYlvQosLA8JzbBWI6ynfKNom
         lVh5MLUKIxZljEgRiCdvUYI4+dRtwv/LPCkYNM5sIqnLfEZPoCksDmnGqeS8nQfZEzlQ
         JeaiIX1Blepfj8k8BjrmX9KZbFpy9R5p3T+4vV4LWdYUxpee75f7KnIhMSvn7cQJ9eid
         zk8YU/tRfe4lXVZPZqCDh586jCF8jcvr/cwP25oOby0uoMCN9OW1AOm5ja3QQ8BCWDv8
         lR3w==
X-Received: by 10.152.28.97 with SMTP id a1mr9689915lah.9.1429389704733;
        Sat, 18 Apr 2015 13:41:44 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id sh6sm3249256lbb.31.2015.04.18.13.41.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Apr 2015 13:41:43 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc2.5.g2871d5e
In-Reply-To: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267425>

Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 t/t7300-clean.sh | 127 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 127 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 99be5d9..4b9a72a 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -455,6 +455,133 @@ test_expect_success 'nested git work tree' '
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
+test_expect_failure 'nested (empty) git should be kept' '
+	rm -fr foo bar &&
+	git init foo &&
+	mkdir bar &&
+	>bar/goodbye.people &&
+	git clean -f -d &&
+	test_path_is_file foo/.git/HEAD &&
+	test_path_is_missing bar
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
+	rm -fr foo &&
+	mkdir foo &&
+	(
+		cd foo &&
+		git init &&
+		mkdir -p bar/baz &&
+		test_commit msg bar/baz/hello.world
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
+		test_commit msg hello.world
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
+		test_commit msg hello.world
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
2.4.0.rc2.5.g2871d5e
