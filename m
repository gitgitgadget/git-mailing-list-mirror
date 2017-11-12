Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D10D9201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 15:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbdKLPc5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 10:32:57 -0500
Received: from avasout06.plus.net ([212.159.14.18]:54858 "EHLO
        avasout06.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751012AbdKLPc4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2017 10:32:56 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Nov 2017 10:32:56 EST
Received: from hashpling.plus.com ([212.159.69.125])
        by smtp with ESMTP
        id Du8ReQOcKFv8cDu8SeQvwd; Sun, 12 Nov 2017 15:25:25 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Ful1xyjq c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=BNFp--SqAAAA:8
 a=D44XyuJtSjERKikMyhAA:9 a=wCHOS_8tIzIYXQCUOVd6:22
From:   Charles Bailey <charles@hashpling.org>
To:     git@vger.kernel.org
Subject: [PATCH] Make t4201-shortlog.sh test more robust
Date:   Sun, 12 Nov 2017 15:25:23 +0000
Message-Id: <20171112152523.7186-1-charles@hashpling.org>
X-Mailer: git-send-email 2.10.2
X-CMAE-Envelope: MS4wfHvQPMXp0q8R0l5BoiJvObM9PJYFrlwuSbIYCzFxyhgeyl5KJ3t3xO/zmt9L9Ta0uSj4Kmf3ucfuGTwLqw5YT7ecxFha0nHIgUyXW1SX3yTZlFsc75Yk
 WUvBaKgjbRubi28KIXnDnHy2civv3/u3AZTZUu0bl7r3UwKOurmf3413uViomP5YkB9NlFUEQgjK0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Charles Bailey <cbailey32@bloomberg.net>

The test for '--abbrev' in t4201-shortlog.sh assumes that the commits
generated in the test can always be uniquely abbreviated to 5 hex digits
but this is not always the case. If you were unlucky and happened to run
the test at (say) Thu Jun 22 03:04:49 2017 +0000, you would find that
the first commit generated would collide with a tree object created
later in the same test.

This can be simulated in the version of t4201-shortlog.sh prior to this
commit by setting GIT_COMMITTER_DATE and GIT_AUTHOR_DATE to 1498100689
after sourcing test-lib.sh.

Change the test to test --abbrev=35 instead of --abbrev=5 to almost
completely avoid the possibility of a partial collision and add a call
to test_tick in the setup to make the test repeatable.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---
 t/t4201-shortlog.sh | 5 +++--
 t/test-lib.sh       | 7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 9df054b..da10478 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -9,6 +9,7 @@ test_description='git shortlog
 . ./test-lib.sh
 
 test_expect_success 'setup' '
+	test_tick &&
 	echo 1 >a1 &&
 	git add a1 &&
 	tree=$(git write-tree) &&
@@ -59,7 +60,7 @@ fuzz() {
 	file=$1 &&
 	sed "
 			s/$_x40/OBJECT_NAME/g
-			s/$_x05/OBJID/g
+			s/$_x35/OBJID/g
 			s/^ \{6\}[CTa].*/      SUBJECT/g
 			s/^ \{8\}[^ ].*/        CONTINUATION/g
 		" <"$file" >"$file.fuzzy" &&
@@ -81,7 +82,7 @@ test_expect_success 'pretty format' '
 
 test_expect_success '--abbrev' '
 	sed s/SUBJECT/OBJID/ expect.template >expect &&
-	git shortlog --format="%h" --abbrev=5 HEAD >log &&
+	git shortlog --format="%h" --abbrev=35 HEAD >log &&
 	fuzz log >log.predictable &&
 	test_cmp expect log.predictable
 '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9b61f16..116bd6a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -175,9 +175,10 @@ esac
 
 # Convenience
 #
-# A regexp to match 5 and 40 hexdigits
+# A regexp to match 5, 35 and 40 hexdigits
 _x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x05$_x05$_x05$_x05$_x05$_x05$_x05$_x05"
+_x35="$_x05$_x05$_x05$_x05$_x05$_x05$_x05"
+_x40="$_x35$_x05"
 
 # Zero SHA-1
 _z40=0000000000000000000000000000000000000000
@@ -193,7 +194,7 @@ LF='
 # when case-folding filenames
 u200c=$(printf '\342\200\214')
 
-export _x05 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB
+export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB
 
 # Each test should start with something like this, after copyright notices:
 #
-- 
2.10.2

