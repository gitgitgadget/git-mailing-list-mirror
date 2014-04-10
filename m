From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/9] t: branch add publish branch tests
Date: Thu, 10 Apr 2014 14:04:41 -0500
Message-ID: <1397156686-31349-5-git-send-email-felipe.contreras@gmail.com>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 21:15:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKRX-0006Q6-Rd
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbaDJTPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:15:13 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:63997 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161169AbaDJTPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:15:09 -0400
Received: by mail-ob0-f180.google.com with SMTP id wn1so4923039obc.11
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tABK49Bf6Gjgk+qapaSLNJgN4rLvhu+Wi4JHyhQfd18=;
        b=gVfUtE9K5rcZSCjUM0FO2AdopSm6wBP5j6aDTbmmFdQdxffiawJk8AbqFENZ+dHXLc
         yNDzC4AU6eoRZWnfTyTGrqLsMq+kDllpoVzHDEucAdCv0eF9E6/AMHBdA2hO7hj17jhM
         DWJHLX7dpbze4lfi9CDoZgY28/tqT5+PzL/ITC8d/rY5xu8AErV+45/GJdZ5E/Ot32Hj
         wTUdhAtF5q1yLj9MFqKUXHfF+KUkG7LfQgVrjzRUQyN8nEwBSi9sXnGN7pQ4Wb5f/yAm
         tP5UResnRgwuEYzUTvR4ZpleOWb3uo18Fv/fv4Xf7/CXlxVGZ7EIpaWTnslbiO1n2vN7
         8pAg==
X-Received: by 10.60.134.137 with SMTP id pk9mr15268873oeb.40.1397157309053;
        Thu, 10 Apr 2014 12:15:09 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id dh8sm21236893oeb.10.2014.04.10.12.15.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 12:15:05 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246042>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t3200-branch.sh | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fcdb867..8cd21d1 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -907,4 +907,80 @@ test_expect_success 'tracking with unexpected .fetch refspec' '
 	)
 '
 
+test_expect_success '--set-publish-to fails on multiple branches' '
+	test_must_fail git branch --set-publish-to master a b c
+'
+
+test_expect_success '--set-publish-to fails on detached HEAD' '
+	test_when_finished "git checkout master" &&
+	git checkout master^{} &&
+	test_must_fail git branch --set-publish-to master
+'
+
+test_expect_success '--set-publish-to fails on a missing dst branch' '
+	test_must_fail git branch --set-publish-to master does-not-exist
+'
+
+test_expect_success '--set-publish-to fails on a missing src branch' '
+	test_must_fail git branch --set-publish-to does-not-exist master
+'
+
+test_expect_success '--set-publish-to fails on a non-ref' '
+	test_must_fail git branch --set-publish-to HEAD^{}
+'
+
+test_expect_success 'use --set-publish-to modify HEAD' '
+	git checkout master &&
+	test_config branch.master.pushremote foo &&
+	test_config branch.master.push foo &&
+	git branch -f test &&
+	git branch --set-publish-to test &&
+	test "$(git config branch.master.pushremote)" = "." &&
+	test "$(git config branch.master.push)" = "refs/heads/test"
+'
+
+test_expect_success 'use --set-publish-to modify a particular branch' '
+	git branch -f test &&
+	git branch -f test2 &&
+	git branch --set-publish-to test2 test &&
+	test "$(git config branch.test.pushremote)" = "." &&
+	test "$(git config branch.test.push)" = "refs/heads/test2"
+'
+
+test_expect_success '--unset-publish should fail if given a non-existent branch' '
+	test_must_fail git branch --unset-publish i-dont-exist
+'
+
+test_expect_success 'test --unset-publish on HEAD' '
+	git checkout master &&
+	git branch -f test &&
+	test_config branch.master.pushremote foo &&
+	test_config branch.master.push foo &&
+	git branch --set-publish-to test &&
+	git branch --unset-publish &&
+	test_must_fail git config branch.master.pushremote &&
+	test_must_fail git config branch.master.push &&
+	# fail for a branch without publish set
+	test_must_fail git branch --unset-publish
+'
+
+test_expect_success '--unset-publish should fail on multiple branches' '
+	test_must_fail git branch --unset-publish a b c
+'
+
+test_expect_success '--unset-publish should fail on detached HEAD' '
+	test_when_finished "git checkout -" &&
+	git checkout HEAD^{} &&
+	test_must_fail git branch --unset-publish
+'
+
+test_expect_success 'test --unset-publish on a particular branch' '
+	git branch -f test &&
+	git branch -f test2 &&
+	git branch --set-publish-to test2 test &&
+	git branch --unset-publish test &&
+	test_must_fail git config branch.test2.pushremote &&
+	test_must_fail git config branch.test2.push
+'
+
 test_done
-- 
1.9.1+fc1
