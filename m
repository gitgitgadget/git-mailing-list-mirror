Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A0681F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 20:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbcG3UUB (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 16:20:01 -0400
Received: from mout1.wup.tal.de ([195.8.227.225]:35816 "EHLO mout1.wup.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753315AbcG3UT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 16:19:57 -0400
Received: from point.localnet (mue-88-130-73-059.dsl.tropolys.de [88.130.73.59])
	(Authenticated sender: ib@wtal.de)
	by smtp.tal.de (Postfix) with ESMTPA id 3E07D8001518;
	Sat, 30 Jul 2016 22:19:53 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.30) id
 1bTajg-0hW-00; Sat, 30 Jul 2016 22:19:52 +0200
Message-ID: <579d0a83.02cb01fa.bm000@wupperonline.de>
From:	=?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
To:	git@vger.kernel.org
Subject: [PATCH v3 1/3] t3700: remove unwanted leftover files before running new tests
Date:	Sat, 30 Jul 2016 22:13:38 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: blueMail/Linux 1.5
Cc:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When an earlier test that has prerequisite is skipped, files
used by later tests may be left in the working tree in an
unexpected state.  For example, a test runs this sequence:

        echo foo >xfoo1 && chmod 755 xfoo1

to create an executable file xfoo1, expecting that xfoo1
does not exist before it runs in the test sequence.
However, the absence of this file depends on "git reset
--hard" done in an earlier test, that is skipped when SANITY
prerequisite is not met, and worse yet, xfoo1 originally is
created as a symbolic link, which means the chmod does not
affect the modes of xfoo1 as this test expects.

Fix this by starting the test with "rm -f xfoo1" to make
sure the file is created from scratch, and do the same to
other similar tests.

Signed-off-by: Ingo Brückl <ib@wupperonline.de>
---
 t/t3700-add.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 4865304..494f5b8 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -333,6 +333,7 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
 '

 test_expect_success 'git add --chmod=+x stages a non-executable file with +x' '
+	rm -f foo1 &&
 	echo foo >foo1 &&
 	git add --chmod=+x foo1 &&
 	case "$(git ls-files --stage foo1)" in
@@ -342,6 +343,7 @@ test_expect_success 'git add --chmod=+x stages a non-executable file with +x' '
 '

 test_expect_success 'git add --chmod=-x stages an executable file with -x' '
+	rm -f xfoo1 &&
 	echo foo >xfoo1 &&
 	chmod 755 xfoo1 &&
 	git add --chmod=-x xfoo1 &&
@@ -354,6 +356,7 @@ test_expect_success 'git add --chmod=-x stages an executable file with -x' '
 test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
 	git config core.filemode 1 &&
 	git config core.symlinks 1 &&
+	rm -f foo2 &&
 	echo foo >foo2 &&
 	git add --chmod=+x foo2 &&
 	case "$(git ls-files --stage foo2)" in
--
2.9.2
