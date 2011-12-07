From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 14/15] t1006 (cat-file): use test_cmp
Date: Thu,  8 Dec 2011 01:06:50 +0530
Message-ID: <1323286611-4806-15-git-send-email-artagnon@gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 20:39:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNKT-0001Ov-EN
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 20:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757743Ab1LGTit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 14:38:49 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36108 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757624Ab1LGTir (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 14:38:47 -0500
Received: by mail-qw0-f46.google.com with SMTP id b40so3739668qad.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 11:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6Ukpx+I1wLRrDdmoJ0NcP5kyK5iuWutWChYIz0bnCUE=;
        b=SfRxHL44/hro1zFSC/n1t2D+51gMRBSp42Q8Z4BCVQBuDql1KcQWVqdz8y7wEyD/A8
         v6agbsPSjXwU7ADwmUlDfsc0mJ36Yz+An3ApyBuZvXC8BHiMcUhKDv0RVex2hQi/yzzB
         /w0eUsfEIjiE3IV3pBecnvApg7p47p9kRdd+Y=
Received: by 10.50.178.68 with SMTP id cw4mr246430igc.31.1323286727299;
        Wed, 07 Dec 2011 11:38:47 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id ds5sm10016838ibb.5.2011.12.07.11.38.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 11:38:46 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186495>

Use test_cmp in preference to repeatedly comparing command outputs by
hand.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1006-cat-file.sh |   53 +++++++++++---------------------------------------
 1 files changed, 12 insertions(+), 41 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d8b7f2f..af6cacc 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -45,57 +45,28 @@ $content"
 
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
1.7.7.3
