From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 1/6] t/checkout-last: checkout - doesn't work after rebase
Date: Sun, 16 Jun 2013 14:15:11 +0530
Message-ID: <1371372316-16059-2-git-send-email-artagnon@gmail.com>
References: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 16 10:47:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo8cV-0001uf-CE
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 10:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961Ab3FPIrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 04:47:14 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:40688 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754890Ab3FPIrI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 04:47:08 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so1834402pde.32
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 01:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NxfkZWq0P0j+7F+G4k7Kc00OtouVs+RMwOM+7xAFUMQ=;
        b=loAB92X0hXcPfTXWnBjn3jDwWTQFsfEB4sffC2FZSVsh54uywiVq7Ek8qNBJ2s0z6t
         uzRqJCqT+U0whYUKIwruxH4qoI+BYdbQj1JUlNY5BUylvtSrlCtZIu8zpd7qqphgtpEZ
         myqJXirsLBIfVmErKNtdk/izFQ0LZXugJdq90qiCIlK2/8yO5xV+QVGoZ2T1NrcqA1HA
         IDd9ZReUPyNLV6DWPiZ3z3rJxHlGcs9NOFVdNCb68OQZxSKbr6d80rpchMue772wooA4
         /ROTykgo83qCQGmdZizl9wWefZJkjPQ+4WbaAdSLlznEsEomwD74CNVp0YtcPpvJXuqG
         I8jQ==
X-Received: by 10.68.132.34 with SMTP id or2mr8607719pbb.99.1371372427521;
        Sun, 16 Jun 2013 01:47:07 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id vu5sm9917919pab.10.2013.06.16.01.47.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Jun 2013 01:47:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.443.g4fd77b9
In-Reply-To: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227995>

The following command

  $ git checkout -

does not work as expected after a rebase.  Every kind of rebase must
behave in the exactly same way: for the purposes of checkout -, the
rebase event should be inconsequential.

Add four failing tests documenting this bug: two for a normal rebase,
and another two for an interactive rebase.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t2012-checkout-last.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index b44de9d..6ad6edf 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -116,4 +116,38 @@ test_expect_success 'master...' '
 	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
 '
 
+test_expect_failure '"checkout -" works after a rebase A' '
+	git checkout master &&
+	git checkout other &&
+	git rebase master &&
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+'
+
+test_expect_failure '"checkout -" works after a rebase A B' '
+	git branch moodle master~1 &&
+	git checkout master &&
+	git checkout other &&
+	git rebase master moodle &&
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+'
+
+test_expect_failure '"checkout -" works after a rebase -i A' '
+	git checkout master &&
+	git checkout other &&
+	git rebase -i master &&
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+'
+
+test_expect_failure '"checkout -" works after a rebase -i A B' '
+	git branch foodle master~1 &&
+	git checkout master &&
+	git checkout other &&
+	git rebase master foodle &&
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+'
+
 test_done
-- 
1.8.3.1.443.g4fd77b9
