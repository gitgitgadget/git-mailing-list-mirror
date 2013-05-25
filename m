From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 23/48] remote-hg: add remote tests
Date: Fri, 24 May 2013 21:29:39 -0500
Message-ID: <1369449004-17981-24-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4I2-00029y-F0
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340Ab3EYCcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:54 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:55986 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301Ab3EYCcx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:53 -0400
Received: by mail-ob0-f172.google.com with SMTP id tb18so6276085obb.3
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=r0edz04I41E4Nw9ciWlvyng7IhSakRHETZoFNNI/fmw=;
        b=1Gw3dNbzuN6e5MgI4eZYVXHWDRf1DTySLwePLjgvksaF2/RtQDuyOe6OcSXhi4aEqp
         pDgvq4HWOwElD9A1rpAsDM4+OF79AqCGlKXeS1F9PdIDU3fmoTF04KU/CI/VWrLZdfSn
         yX5AfebYc/ptIKRP8RCI7Ae7cJsmj+RbLg5tUk/+BcvNPE3Qa09tWvDTBH+N3wB9iZO7
         Hx7Coi1n/5M5W4lkhK29oWeJHu9Aw6LtMN0cbGqb906UA2tuz3AOEMusBRBR4iCJGF1m
         BctT+hWsOzckfk13xyGuCq+uSo/W8FDjsOMrZp5rffMESt3pzhFIRzsV7puPVHiicjWg
         DOXA==
X-Received: by 10.182.138.4 with SMTP id qm4mr13685597obb.101.1369449172832;
        Fri, 24 May 2013 19:32:52 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id zn5sm20044031obc.10.2013.05.24.19.32.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225437>

The logic when working with a local repository is totally different from
the one where we work with a remote repository; we need to pull and push
from it.

All this logic is currently not tested at all, so let's introduce a
variable to force the remote behavior.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg |  2 +-
 contrib/remote-helpers/test-hg.sh    | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 76438a6..61e6c87 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -383,7 +383,7 @@ def get_repo(url, alias):
 
     extensions.loadall(myui)
 
-    if hg.islocal(url):
+    if hg.islocal(url) and not os.environ.get('GIT_REMOTE_HG_TEST_REMOTE'):
         repo = hg.repository(myui, url)
         if not os.path.exists(dirname):
             os.makedirs(dirname)
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 2f2050c..d927495 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -250,4 +250,42 @@ test_expect_success 'remote push from master branch' '
 	check_branch hgrepo default one
 '
 
+GIT_REMOTE_HG_TEST_REMOTE=1
+export GIT_REMOTE_HG_TEST_REMOTE
+
+test_expect_success 'remote cloning' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo zero > content &&
+	hg add content &&
+	hg commit -m zero
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+	check gitrepo HEAD zero
+'
+
+test_expect_success 'remote update bookmark' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	cd hgrepo &&
+	hg bookmark devel
+	) &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git checkout --quiet devel &&
+	echo devel > content &&
+	git commit -a -m devel &&
+	git push --quiet
+	) &&
+
+	check_bookmark hgrepo devel devel
+'
+
 test_done
-- 
1.8.3.rc3.312.g47657de
