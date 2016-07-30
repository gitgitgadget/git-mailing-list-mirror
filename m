Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493491F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 20:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbcG3UUD (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 16:20:03 -0400
Received: from mout1.wup.tal.de ([195.8.227.225]:44913 "EHLO mout1.wup.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336AbcG3UT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 16:19:57 -0400
Received: from point.localnet (mue-88-130-73-059.dsl.tropolys.de [88.130.73.59])
	(Authenticated sender: ib@wtal.de)
	by smtp.tal.de (Postfix) with ESMTPA id 40D928001567;
	Sat, 30 Jul 2016 22:19:53 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.30) id
 1bTajg-0hy-00; Sat, 30 Jul 2016 22:19:52 +0200
Message-ID: <579d0a83.4bd3c8e4.bm002@wupperonline.de>
From:	=?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
To:	git@vger.kernel.org
Subject: [PATCH v3 3/3] t3700: add a test_mode_in_index helper function
Date:	Sat, 30 Jul 2016 22:13:54 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: blueMail/Linux 1.5
Cc:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The case statement to check the file mode of a staged file appears
a number of times.

Simplify the test by utilizing a test_mode_in_index helper function.

Signed-off-by: Ingo Brückl <ib@wupperonline.de>
---
 t/t3700-add.sh | 54 ++++++++++++++++++++++--------------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 1fa5dfd..7b98483 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -7,6 +7,20 @@ test_description='Test of git add, including the -- option.'

 . ./test-lib.sh

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
+
 test_expect_success \
     'Test of git add' \
     'touch foo && git add foo'
@@ -25,18 +39,12 @@ test_expect_success \
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
@@ -45,28 +53,19 @@ test_expect_success \
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
@@ -336,15 +335,9 @@ test_expect_success 'git add --chmod=[+-]x stages correctly' '
 	rm -f foo1 &&
 	echo foo >foo1 &&
 	git add --chmod=+x foo1 &&
-	case "$(git ls-files --stage foo1)" in
-	100755" "*foo1) echo pass;;
-	*) echo fail; git ls-files --stage foo1; (exit 1);;
-	esac &&
+	test_mode_in_index 100755 foo1 &&
 	git add --chmod=-x foo1 &&
-	case "$(git ls-files --stage foo1)" in
-	100644" "*foo1) echo pass;;
-	*) echo fail; git ls-files --stage foo1; (exit 1);;
-	esac
+	test_mode_in_index 100644 foo1
 '

 test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
@@ -353,10 +346,7 @@ test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
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
