From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v4 3/5] t7300: add tests to document behavior of clean and nested git
Date: Sat, 25 Apr 2015 11:06:39 +0200
Message-ID: <1429952801-2646-4-git-send-email-erik.elfstrom@gmail.com>
References: <1429952801-2646-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 11:07:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylw3b-0005IE-MF
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 11:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758756AbbDYJHX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Apr 2015 05:07:23 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34663 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757787AbbDYJHT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 05:07:19 -0400
Received: by lbcga7 with SMTP id ga7so52111003lbc.1
        for <git@vger.kernel.org>; Sat, 25 Apr 2015 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=23+xAsw2Sc50uIgH7vAdjeUq5eh7zO2dL2ChEld9Xso=;
        b=jx5vzvI/3ZRRpRynJcjBoJ81FYmD4xmZpJKKEb9ncDBexJ0voD4BNHS2b/rFsku8om
         hv1/1GOPTbmULYpqzmCGZnArFfS8Ivu+x/0AjDWg214dY52bOrD4SJmvc/mLdZeMylFL
         Ai6W9JXVI/lYWn9aW3wCG26Tl+nRrmAtILKzefAXRzEbv4rnnD1xBXv/8Ujavwcw+mod
         Ky4ky2LxGUpekwKVBULdKS9fN54FMHHUms5JLILXjkSZyH8xXMj/q7T5TAxuIAjv5nD6
         7d9d7TkoleXb2sMLjNnrChW9ivYcEjfBoRRxvOv4zgapl6L68tIuyDqEuCgDuxid+80z
         N9SQ==
X-Received: by 10.112.204.72 with SMTP id kw8mr2141910lbc.88.1429952838027;
        Sat, 25 Apr 2015 02:07:18 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id r6sm3249243lbw.10.2015.04.25.02.07.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Apr 2015 02:07:17 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.8.g86acfbd
In-Reply-To: <1429952801-2646-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267785>

Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 t/t7300-clean.sh | 128 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 128 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 99be5d9..11f3a6d 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -455,6 +455,134 @@ test_expect_success 'nested git work tree' '
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
2.4.0.rc3.8.g4ebd28d
