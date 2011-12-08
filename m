From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] t1006 (cat-file): use test_cmp
Date: Thu,  8 Dec 2011 18:40:14 +0530
Message-ID: <1323349817-15737-6-git-send-email-artagnon@gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 14:11:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYdlK-0004PD-1G
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 14:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214Ab1LHNLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 08:11:39 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50863 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027Ab1LHNLh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 08:11:37 -0500
Received: by mail-qy0-f174.google.com with SMTP id z2so1236541qcq.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 05:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=noTY+YpjpZVvt+TqzRVITHcGECRSkTMYxYgkQminkxo=;
        b=WC7p9aZz0e5wNcTmyzbdy/JA7vQX778H2IoeW3N4mFyZ0F5QkHoDhRFCPewgu2W5xM
         jX2jS2u5AwJmLlGPWx7tOklGIrfm1mUoOsSCuSWjFSyI8pHFroR5Hw4amJ8SSv+avJJM
         JoC5gICoEqs6SmVtlJNmeJwSCP4ZtyJMwWjQo=
Received: by 10.50.169.33 with SMTP id ab1mr3784390igc.0.1323349897164;
        Thu, 08 Dec 2011 05:11:37 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id dd36sm19583344ibb.7.2011.12.08.05.11.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 05:11:36 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186558>

Use test_cmp in preference to repeatedly comparing command outputs by
hand.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1006-cat-file.sh |  119 ++++++++++++++++++++++++---------------------------
 1 files changed, 56 insertions(+), 63 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d8b7f2f..0ca6c43 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -36,66 +36,41 @@ $content"
     '
 
     test_expect_success "Type of $type is correct" '
-        test $type = "$(git cat-file -t $sha1)"
+	echo $type >expect &&
+	git cat-file -t $sha1 >actual &&
+	test_cmp expect actual
     '
 
     test_expect_success "Size of $type is correct" '
-        test $size = "$(git cat-file -s $sha1)"
+	echo $size >expect &&
+	git cat-file -s $sha1 >actual &&
+	test_cmp expect actual
     '
 
     test -z "$content" ||
     test_expect_success "Content of $type is correct" '
-	expect="$(maybe_remove_timestamp "$content" $no_ts)"
-	actual="$(maybe_remove_timestamp "$(git cat-file $type $sha1)" $no_ts)"
-
-        if test "z$expect" = "z$actual"
-	then
-		: happy
-	else
-		echo "Oops: expected $expect"
-		echo "but got $actual"
-		false
-        fi
+	maybe_remove_timestamp "$content" $no_ts >expect &&
+	maybe_remove_timestamp "$(git cat-file $type $sha1)" $no_ts >actual &&
+	test_cmp expect actual
     '
 
     test_expect_success "Pretty content of $type is correct" '
-	expect="$(maybe_remove_timestamp "$pretty_content" $no_ts)"
-	actual="$(maybe_remove_timestamp "$(git cat-file -p $sha1)" $no_ts)"
-        if test "z$expect" = "z$actual"
-	then
-		: happy
-	else
-		echo "Oops: expected $expect"
-		echo "but got $actual"
-		false
-        fi
+	maybe_remove_timestamp "$pretty_content" $no_ts >expect &&
+	maybe_remove_timestamp "$(git cat-file -p $sha1)" $no_ts >actual &&
+	test_cmp expect actual
     '
 
     test -z "$content" ||
     test_expect_success "--batch output of $type is correct" '
-	expect="$(maybe_remove_timestamp "$batch_output" $no_ts)"
-	actual="$(maybe_remove_timestamp "$(echo $sha1 | git cat-file --batch)" $no_ts)"
-        if test "z$expect" = "z$actual"
-	then
-		: happy
-	else
-		echo "Oops: expected $expect"
-		echo "but got $actual"
-		false
-        fi
+	maybe_remove_timestamp "$batch_output" $no_ts >expect &&
+	maybe_remove_timestamp "$(echo $sha1 | git cat-file --batch)" $no_ts >actual &&
+	test_cmp expect actual
     '
 
     test_expect_success "--batch-check output of $type is correct" '
-	expect="$sha1 $type $size"
-	actual="$(echo_without_newline $sha1 | git cat-file --batch-check)"
-        if test "z$expect" = "z$actual"
-	then
-		: happy
-	else
-		echo "Oops: expected $expect"
-		echo "but got $actual"
-		false
-        fi
+	echo "$sha1 $type $size" >expect &&
+	echo_without_newline $sha1 | git cat-file --batch-check >actual &&
+	test_cmp expect actual
     '
 }
 
@@ -144,10 +119,13 @@ tag_size=$(strlen "$tag_content")
 
 run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_pretty_content" 1
 
-test_expect_success \
-    "Reach a blob from a tag pointing to it" \
-    "test '$hello_content' = \"\$(git cat-file blob $tag_sha1)\""
+test_expect_success "Reach a blob from a tag pointing to it" '
+    echo_without_newline "$hello_content" >expect &&
+    git cat-file blob "$tag_sha1" >actual &&
+    test_cmp expect actual
+'
 
+test_done
 for batch in batch batch-check
 do
     for opt in t s e p
@@ -175,30 +153,41 @@ do
 done
 
 test_expect_success "--batch-check for a non-existent named object" '
-    test "foobar42 missing
-foobar84 missing" = \
-    "$( ( echo foobar42; echo_without_newline foobar84; ) | git cat-file --batch-check)"
+    cat >expect <<\-EOF &&
+foobar42 missing
+foobar84 missing
+EOF
+    $(echo foobar42; echo_without_newline foobar84) \
+    | git cat-file --batch-check >actual &&
+    test_cmp expect actual
 '
 
 test_expect_success "--batch-check for a non-existent hash" '
-    test "0000000000000000000000000000000000000042 missing
-0000000000000000000000000000000000000084 missing" = \
-    "$( ( echo 0000000000000000000000000000000000000042;
-         echo_without_newline 0000000000000000000000000000000000000084; ) \
-       | git cat-file --batch-check)"
+    cat >expect <<\-EOF &&
+0000000000000000000000000000000000000042 missing
+0000000000000000000000000000000000000084 missing
+EOF
+    $(echo 0000000000000000000000000000000000000042;
+    echo_without_newline 0000000000000000000000000000000000000084) \
+    | git cat-file --batch-check >actual &&
+    test_cmp expect actual
 '
 
 test_expect_success "--batch for an existent and a non-existent hash" '
-    test "$tag_sha1 tag $tag_size
+    cat >expect <<\-EOF &&
+tag_sha1 tag $tag_size
 $tag_content
-0000000000000000000000000000000000000000 missing" = \
-    "$( ( echo $tag_sha1;
-         echo_without_newline 0000000000000000000000000000000000000000; ) \
-       | git cat-file --batch)"
+0000000000000000000000000000000000000000 missing
+EOF
+    $(echo $tag_sha1; echo_without_newline 0000000000000000000000000000000000000000) \
+    | git cat-file --batch >actual &&
+    test_cmp expect_actual
 '
 
 test_expect_success "--batch-check for an emtpy line" '
-    test " missing" = "$(echo | git cat-file --batch-check)"
+    echo " missing" >expect &&
+    echo | git cat-file --batch-check >actual &&
+    test_cmp expect actual
 '
 
 batch_input="$hello_sha1
@@ -218,7 +207,10 @@ deadbeef missing
  missing"
 
 test_expect_success '--batch with multiple sha1s gives correct format' '
-	test "$(maybe_remove_timestamp "$batch_output" 1)" = "$(maybe_remove_timestamp "$(echo_without_newline "$batch_input" | git cat-file --batch)" 1)"
+	maybe_remove_timestamp "$batch_output" 1 >expect &&
+	maybe_remove_timestamp "$(echo_without_newline "$batch_input" \
+	| git cat-file --batch)" 1 >actual &&
+	test_cmp expect actual
 '
 
 batch_check_input="$hello_sha1
@@ -237,8 +229,9 @@ deadbeef missing
  missing"
 
 test_expect_success "--batch-check with multiple sha1s gives correct format" '
-    test "$batch_check_output" = \
-    "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
+    echo "$batch_check_output" >expect &&
+    echo_without_newline "$batch_check_input" | git cat-file --batch-check >actual &&
+    test_cmp expect actual
 '
 
 test_done
-- 
1.7.7.3
