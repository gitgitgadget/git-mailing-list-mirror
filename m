From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/8] t/checkout-last: test "checkout -" after a rebase
Date: Tue, 18 Jun 2013 17:44:25 +0530
Message-ID: <1371557670-12534-4-git-send-email-artagnon@gmail.com>
References: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:17:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uour7-00080s-Ah
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597Ab3FRMRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:17:42 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:39414 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab3FRMRk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:17:40 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so3862335pdj.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 05:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/MP4rKB4/SCFWUIjXeZuRG/q5sPwBwVCiWekViZFcmg=;
        b=BnG+7PCJ62kcTsuVmRDcanbyLeGPo6j5ytAq6JnLJtZ30vogm0sSicGvvuwL+Pmgo9
         mbpGpdaO3P8AnGN6whgpG1GtbLGM9DHiopn41BvN6S88QGWdmXNFCyA3ktsR/DuG0Dcy
         8FRci33lgCsgr0k9Nh8akE+NJKiOKnxQ3yT8jnZ5bZg+ToyCDvEjk2KzljZUlyIqO0SS
         APsjDCrez2VlZjE0rJEpWmlSX62F3nurIE8RLeJcGxlyKhEFO5ZY1KS/pTikkBwQFQPw
         6ppI0zV7GADP37XIpjkFoncC4KafOLaM46rP6A2hxhptV97cPXlUxB/y2yH+iBYZuKBE
         titg==
X-Received: by 10.66.122.163 with SMTP id lt3mr1844560pab.219.1371557860582;
        Tue, 18 Jun 2013 05:17:40 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id fm2sm19398332pab.13.2013.06.18.05.17.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 05:17:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.456.gb7f4cb6
In-Reply-To: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228204>

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
1.8.3.1.456.gb7f4cb6
