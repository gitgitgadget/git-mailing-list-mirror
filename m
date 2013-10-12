From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 6/8] t: branch add publish branch tests
Date: Sat, 12 Oct 2013 02:05:55 -0500
Message-ID: <1381561561-20459-3-git-send-email-felipe.contreras@gmail.com>
References: <1381561561-20459-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtN9-0004mg-7j
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990Ab3JLHMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:13 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:60164 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab3JLHMH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:07 -0400
Received: by mail-oa0-f45.google.com with SMTP id i4so255939oah.18
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iGKysemuvDBmfddhfrGZC2xhc92HwyWKhJp89l2RZOE=;
        b=SmNWAiyAHfDnQJQ3IbD62ds34KTKDnGtfzL12XpgaSLkhn3q74oZ9/ThUhn4casX0A
         TGhcm7jp3zMp0m4keyZv+y+ewna7n+bHz6io+fQDiN3Qj4ef14q21tSDadlWB9xVciX1
         D4QYEUdOIRIwQYh5G+RVXb5MDIfMWSEZxVWCCW4qRud0af1BsKf5hJKoQK0mqAltnaK1
         Lo1apPoTrboJJerMoW5Wy3YtP9uG4/oFYQ2pswurj2cwMELHmWH5ItN6kRGAu8q0Dh7b
         dr7BGn8nrtfueiy38LZnKOTp2r/wIlVbwZkRlp4x9Z6LeKSSEAWBVI0uyMxYdsUMfIKW
         mA2A==
X-Received: by 10.182.22.226 with SMTP id h2mr17793722obf.8.1381561927502;
        Sat, 12 Oct 2013 00:12:07 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hs4sm28636866obb.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561561-20459-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235988>

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
1.8.4-fc
