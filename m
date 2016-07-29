Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDB781F855
	for <e@80x24.org>; Fri, 29 Jul 2016 21:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbcG2VTW (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 17:19:22 -0400
Received: from mout1.wup.tal.de ([195.8.227.225]:60947 "EHLO mout1.wup.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910AbcG2VTS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 17:19:18 -0400
Received: from point.localnet (mue-88-130-96-149.dsl.tropolys.de [88.130.96.149])
	(Authenticated sender: ib@wtal.de)
	by smtp.tal.de (Postfix) with ESMTPA id 050598004CD4;
	Fri, 29 Jul 2016 23:19:12 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.30) id
 1bTFBY-6sg-00; Fri, 29 Jul 2016 23:19:12 +0200
Message-ID: <579bc6ca.3f2601c7.bm001@wupperonline.de>
From:	=?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
To:	git@vger.kernel.org
Subject: [PATCH v2 2/3] Make test t3700-add.sh more robust
Date:	Fri, 29 Jul 2016 23:11:36 +0200
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

Don't rely on chmod to work on the underlying platform (although it
wouldn't harm the result of the '--chmod=-x' test). Directly check the
result of the --chmod option.

Add a test_mode_in_index helper function in order to check for success.

Signed-off-by: Ingo Brückl <ib@wupperonline.de>
---
 t/t3700-add.sh          | 20 ++++----------------
 t/test-lib-functions.sh | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 494f5b8..c08ec9e 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -332,25 +332,13 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
 	test_i18ncmp expect.err actual.err
 '

-test_expect_success 'git add --chmod=+x stages a non-executable file with +x' '
+test_expect_success 'git add --chmod=[+-]x stages correctly' '
 	rm -f foo1 &&
 	echo foo >foo1 &&
 	git add --chmod=+x foo1 &&
-	case "$(git ls-files --stage foo1)" in
-	100755" "*foo1) echo pass;;
-	*) echo fail; git ls-files --stage foo1; (exit 1);;
-	esac
-'
-
-test_expect_success 'git add --chmod=-x stages an executable file with -x' '
-	rm -f xfoo1 &&
-	echo foo >xfoo1 &&
-	chmod 755 xfoo1 &&
-	git add --chmod=-x xfoo1 &&
-	case "$(git ls-files --stage xfoo1)" in
-	100644" "*xfoo1) echo pass;;
-	*) echo fail; git ls-files --stage xfoo1; (exit 1);;
-	esac
+	test_mode_in_index 100755 foo1 &&
+	git add --chmod=-x foo1 &&
+	test_mode_in_index 100644 foo1
 '

 test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 4f7eadb..0e6652b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -990,3 +990,17 @@ test_copy_bytes () {
 		}
 	' - "$1"
 }
+
+# Test the file mode "$1" of the file "$2" in the index.
+test_mode_in_index () {
+	case "$(git ls-files --stage "$2")" in
+		$1\ *"$2")
+			echo pass
+			;;
+		*)
+			echo fail
+			git ls-files --stage "$2"
+			return 1
+			;;
+	esac
+}
--
2.9.2

