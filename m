From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 3/7] t/t2012-checkout-last: test "checkout -" after a rebase
Date: Wed, 19 Jun 2013 00:25:33 +0530
Message-ID: <1371581737-10013-4-git-send-email-artagnon@gmail.com>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 20:59:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up17V-0002gV-MP
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 20:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933702Ab3FRS65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 14:58:57 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:60656 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933351Ab3FRS6w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 14:58:52 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so4212931pbc.2
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=itZenTu2tUmPZFWLQ5ZYPcIfjdovm7onRjYLHg4VASU=;
        b=pRTV0v61hCHGAw6D/UH5uWhqrg34M7lStzwTo89tvtUOgqlBCicu1qSaIIqKEEHSpV
         /BaKdPc36XRUBoCdcwBHTyFDpJK+ukyS9YAPnlHNnSbiqwSbonqJOm+ApCEsrOjvvoVs
         zEF/czJL7Abm8z6jUWOxSAAZrzWyTaOW+TSXB/3ZKqkmBCOY/A+ltLzKq9e5Gc1+wXx1
         pHKPYLZVA7GJ0zTqyE/zfcN/8X45sYFxEDcn0hH5GJ2L918f7iZ7miqy3m9JfGcoH1K/
         Rg74o/E+D4ZyP6kmsHxTWo1XXTtkwNCiasPHTit28aL0CHksSsN0aH1R/s4DuPjoPhLD
         ftQw==
X-Received: by 10.66.158.36 with SMTP id wr4mr3312106pab.28.1371581932418;
        Tue, 18 Jun 2013 11:58:52 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id ag4sm19432751pbc.20.2013.06.18.11.58.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 11:58:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.455.g5932b31
In-Reply-To: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228299>

  $ git checkout -

does not work as expected after a rebase.  This is because the
reflog records "checkout" made by "rebase" as its implementation
detail the same way as end-user initiated "checkout", and makes it
count as the branch that was previously checked out.

Add four failing tests documenting this bug: two for a normal rebase,
and another two for an interactive rebase.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.8.3.1.455.g5932b31
