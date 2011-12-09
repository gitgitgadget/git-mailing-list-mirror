From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] t1006 (cat-file): use test_cmp
Date: Fri,  9 Dec 2011 16:59:15 +0530
Message-ID: <1323430158-14885-4-git-send-email-artagnon@gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323430158-14885-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@mgmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 12:30:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYyex-0000FT-Sh
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 12:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab1LILab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 06:30:31 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42923 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab1LILaa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 06:30:30 -0500
Received: by mail-gx0-f174.google.com with SMTP id r5so3168867ggn.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 03:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ekThW7qx25Ee6WCJGsVsltx/tMeK/B0pyxFnig+6wRY=;
        b=PdupER0YnlELLE8YkAsnRItmHQ+sCVTAp8DoytK+2gwsoVdYn/0WBhmxYqDP8ql4Le
         L/qc+nHR4QbrbPa+94bPD2ahtE3wTrYGdEb5GNDuQhq+WaJoA14ETPyQ/q6O+geNpHsf
         etIYHx2s8hIfp4vzN5Ftc00teeq3zUflHHIHI=
Received: by 10.50.156.133 with SMTP id we5mr3015221igb.74.1323430230096;
        Fri, 09 Dec 2011 03:30:30 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id d19sm9096588ibh.8.2011.12.09.03.30.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 03:30:29 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323430158-14885-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186627>

In testing, a common paradigm involves checking the expected output
with the actual output: test-lib provides a test_cmp to show the diff
between the two outputs.  So, use this function in preference to
calling a human over to compare command outputs by eye.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1006-cat-file.sh |  119 ++++++++++++++++++++++++---------------------------
 1 files changed, 56 insertions(+), 63 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d8b7f2f..5be3ce9 100755
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
+    echo foobar42; echo_without_newline foobar84 | \
+    git cat-file --batch-check >actual &&
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
+    echo 0000000000000000000000000000000000000042;
+    echo_without_newline 0000000000000000000000000000000000000084 | \
+    git cat-file --batch-check >actual &&
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
+    echo $tag_sha1; echo_without_newline 0000000000000000000000000000000000000000 | \
+    git cat-file --batch >actual &&
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
+	maybe_remove_timestamp "echo_without_newline "$batch_input" | \
+	git cat-file --batch" 1 >actual &&
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
