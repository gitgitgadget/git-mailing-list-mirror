Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DF591F855
	for <e@80x24.org>; Fri, 29 Jul 2016 21:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbcG2VTU (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 17:19:20 -0400
Received: from mout1.wup.tal.de ([195.8.227.225]:47380 "EHLO mout1.wup.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981AbcG2VTR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 17:19:17 -0400
Received: from point.localnet (mue-88-130-96-149.dsl.tropolys.de [88.130.96.149])
	(Authenticated sender: ib@wtal.de)
	by smtp.tal.de (Postfix) with ESMTPA id 0337E8004CC6;
	Fri, 29 Jul 2016 23:19:12 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.30) id
 1bTFBY-6su-00; Fri, 29 Jul 2016 23:19:12 +0200
Message-ID: <579bc6ca.12c67c12.bm002@wupperonline.de>
From:	=?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
To:	git@vger.kernel.org
Subject: [PATCH v2 3/3] Simplify test t3700-add.sh
Date:	Fri, 29 Jul 2016 23:12:38 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: blueMail/Linux 1.5
Cc:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>
Cc:	Johannes Sixt <j6t@kdbg.org>
Cc:	Edward Thomson <ethomson@edwardthomson.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Utilize the test_mode_in_index helper function.

Signed-off-by: Ingo Brückl <ib@wupperonline.de>
---
 t/t3700-add.sh | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index c08ec9e..0e21a52 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -25,18 +25,12 @@ test_expect_success \
 	 echo foo >xfoo1 &&
 	 chmod 755 xfoo1 &&
 	 git add xfoo1 &&
-	 case "$(git ls-files --stage xfoo1)" in
-	 100644" "*xfoo1) echo pass;;
-	 *) echo fail; git ls-files --stage xfoo1; (exit 1);;
-	 esac'
+	 test_mode_in_index 100644 xfoo1'

 test_expect_success 'git add: filemode=0 should not get confused by symlink' '
 	rm -f xfoo1 &&
 	test_ln_s_add foo xfoo1 &&
-	case "$(git ls-files --stage xfoo1)" in
-	120000" "*xfoo1) echo pass;;
-	*) echo fail; git ls-files --stage xfoo1; (exit 1);;
-	esac
+	test_mode_in_index 120000 xfoo1
 '

 test_expect_success \
@@ -45,28 +39,19 @@ test_expect_success \
 	 echo foo >xfoo2 &&
 	 chmod 755 xfoo2 &&
 	 git update-index --add xfoo2 &&
-	 case "$(git ls-files --stage xfoo2)" in
-	 100644" "*xfoo2) echo pass;;
-	 *) echo fail; git ls-files --stage xfoo2; (exit 1);;
-	 esac'
+	 test_mode_in_index 100644 xfoo2'

 test_expect_success 'git add: filemode=0 should not get confused by symlink' '
 	rm -f xfoo2 &&
 	test_ln_s_add foo xfoo2 &&
-	case "$(git ls-files --stage xfoo2)" in
-	120000" "*xfoo2) echo pass;;
-	*) echo fail; git ls-files --stage xfoo2; (exit 1);;
-	esac
+	test_mode_in_index 120000 xfoo2
 '

 test_expect_success \
 	'git update-index --add: Test that executable bit is not used...' \
 	'git config core.filemode 0 &&
 	 test_ln_s_add xfoo2 xfoo3 &&	# runs git update-index --add
-	 case "$(git ls-files --stage xfoo3)" in
-	 120000" "*xfoo3) echo pass;;
-	 *) echo fail; git ls-files --stage xfoo3; (exit 1);;
-	 esac'
+	 test_mode_in_index 120000 xfoo3'

 test_expect_success '.gitignore test setup' '
 	echo "*.ig" >.gitignore &&
@@ -347,10 +332,7 @@ test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
 	rm -f foo2 &&
 	echo foo >foo2 &&
 	git add --chmod=+x foo2 &&
-	case "$(git ls-files --stage foo2)" in
-	100755" "*foo2) echo pass;;
-	*) echo fail; git ls-files --stage foo2; (exit 1);;
-	esac
+	test_mode_in_index 100755 foo2
 '

 test_done
--
2.9.2

