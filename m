From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 4/4] t1006: add tests for git cat-file --allow-unknown-type
Date: Sun,  3 May 2015 20:00:02 +0530
Message-ID: <1430663402-26717-4-git-send-email-karthik.188@gmail.com>
References: <55463094.9040204@gmail.com>
 <1430663402-26717-1-git-send-email-karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 16:30:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Youun-00062p-34
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 16:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbbECOah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 10:30:37 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36824 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbbECOad (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 10:30:33 -0400
Received: by pabsx10 with SMTP id sx10so138366446pab.3
        for <git@vger.kernel.org>; Sun, 03 May 2015 07:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AiOHbr99mPDJUpa4J59X9xFzDgCC9Kb1eCrKgv3A4i4=;
        b=L1Fnr9Yu8lGfZpcn/JKd7+3piIZJTtixElQTLPf+m0urjDp4ljiCkVQFdP06o7UzxS
         ca/w8MccuiNTQ66/864gMypJ8y8VnIqg+5QDVLoLNIdb4u5zWcxLH1LS98zelshpafJ3
         F9oO+AYBFOepBFcZxd2oAX+eb66hCbbz6Grv+5t9GT8TQZvkfHSnr6Lmd9i8RelomdqA
         hR2BpnkeCGX4eLQFfuwL0Qg0dhDl7G50Z9cuplzdGLQ18kld6R2eD0saVSI2QRtZsI1E
         HlOtbgTcVghpkj9Tl5o/UICldT78yksYHaaKK7Axn6wT+9n9wtrXK61y8oJprUrEj3bx
         dGyw==
X-Received: by 10.68.198.36 with SMTP id iz4mr34771203pbc.167.1430663433254;
        Sun, 03 May 2015 07:30:33 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id xt9sm10097262pbc.14.2015.05.03.07.30.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 May 2015 07:30:32 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.250.gfbd73bd
In-Reply-To: <1430663402-26717-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268266>

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t1006-cat-file.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ab36b1e..de8eaf1 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -47,6 +47,18 @@ $content"
 	test_cmp expect actual
     '
 
+    test_expect_success "Type of $type is correct using --allow-unknown-type" '
+	echo $type >expect &&
+    git cat-file -t --allow-unknown-type $sha1 >actual &&
+	test_cmp expect actual
+    '
+
+    test_expect_success "Size of $type is correct using --allow-unknown-type" '
+	echo $size >expect &&
+    git cat-file -s --allow-unknown-type $sha1 >actual &&
+	test_cmp expect actual
+    '
+
     test -z "$content" ||
     test_expect_success "Content of $type is correct" '
 	maybe_remove_timestamp "$content" $no_ts >expect &&
@@ -296,4 +308,37 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	}
 '
 
+bogus_type="bogus"
+bogus_content="bogus"
+bogus_size=$(strlen "$bogus_content")
+bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
+
+test_expect_success "Type of broken object is correct" '
+	echo $bogus_type >expect &&
+	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "Size of broken object is correct" '
+	echo $bogus_size >expect &&
+	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
+	test_cmp expect actual
+'
+bogus_type="abcdefghijklmnopqrstuvwxyz1234679"
+bogus_content="bogus"
+bogus_size=$(strlen "$bogus_content")
+bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
+
+test_expect_success "Type of broken object is correct when type is large" '
+	echo $bogus_type >expect &&
+	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "Size of large broken object is correct when type is large" '
+	echo $bogus_size >expect &&
+	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.0.rc1.250.gfbd73bd
