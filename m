From: Jeff King <peff@peff.net>
Subject: [PATCH 03/10] t1006: modernize output comparisons
Date: Wed, 10 Jul 2013 07:36:43 -0400
Message-ID: <20130710113642.GC21963@sigill.intra.peff.net>
References: <20130710113447.GA20113@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 13:36:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwshX-00020l-Pk
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 13:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab3GJLgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 07:36:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:47753 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab3GJLgr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 07:36:47 -0400
Received: (qmail 24968 invoked by uid 102); 10 Jul 2013 11:38:04 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 06:38:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 07:36:43 -0400
Content-Disposition: inline
In-Reply-To: <20130710113447.GA20113@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230044>

In modern tests, we typically put output into a file and
compare it with test_cmp. This is nicer than just comparing
via "test", and much shorter than comparing via "test" and
printing a custom message.

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't do the whole file, just the ones of a particular style close to
what I was touching.

 t/t1006-cat-file.sh | 61 ++++++++++++++++-------------------------------------
 1 file changed, 18 insertions(+), 43 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 9cc5c6b..c2f2503 100755
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
 
-- 
1.8.3.rc3.24.gec82cb9
