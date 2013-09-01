From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/6] t: branch add publish branch tests
Date: Sun,  1 Sep 2013 03:26:40 -0500
Message-ID: <1378024002-26190-5-git-send-email-felipe.contreras@gmail.com>
References: <1378024002-26190-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 10:32:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG34o-0001DU-Mv
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 10:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab3IAIbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 04:31:49 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:54445 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298Ab3IAIbg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 04:31:36 -0400
Received: by mail-ob0-f177.google.com with SMTP id f8so3446640obp.36
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 01:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9jk3vPVC/n1/uLorJmyAY8bvcp2M8Z3HRR7qTGzV5o4=;
        b=H7A0E0cCfHmIFwNj8mfB+sYj/IKvzLyrDanbKBOiUGcPed78aH6Aqg4USKKat3c3nR
         l4mUZkjoz29zI1qE5dbRphUFm/M3Yy3MBMO/Ymrybm2JLEBujITH9C5MCDfY22EGB7QW
         leZET8ylzbP28foh2yXP0NIFXw31VscXBwb6rSJHGdSP+LJr+vy0O7SWryw7iEUj2J3f
         BVifIInTHoGHIph+m/rCR3xSgWs0YM6ipTK24HgZ2ohdJ76nXkthlsnQhwqUseAjEMb2
         0T7q1wgcJtmgwd9WENe+VVpab71zi7stwdE2FjtqGamNJHiX5ylGhtSYQ87X97A1I357
         qswQ==
X-Received: by 10.182.101.165 with SMTP id fh5mr13062573obb.58.1378024294627;
        Sun, 01 Sep 2013 01:31:34 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm7776024oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Sep 2013 01:31:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-337-g7358a66-dirty
In-Reply-To: <1378024002-26190-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233576>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t3200-branch.sh | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 44ec6a4..cd0b8e9 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -870,4 +870,80 @@ test_expect_success '--merged catches invalid object names' '
 	test_must_fail git branch --merged 0000000000000000000000000000000000000000
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
1.8.4-337-g7358a66-dirty
