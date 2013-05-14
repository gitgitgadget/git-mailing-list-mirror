From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 29/47] remote-hg: add remote tests
Date: Mon, 13 May 2013 23:36:52 -0500
Message-ID: <1368506230-19614-30-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:41:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc73O-0005Hx-HA
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092Ab3ENEl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:41:29 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:42503 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403Ab3ENEkO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:14 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so101727oag.34
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=t3m4dQ8k00v/arvww6Hpso/FYIX+rIbcb+ya7lGg/Cs=;
        b=TW3oA4waXX9KVK3R8c8tNDzvBDSx0jtdhVSvj7wqUCUN5H/p1LRmD/SY96cLzbEb/Z
         nSqPM3XZyzY5Dl/aDn6GcJxYiBI6fTekuDSBcgeAqhoddr/RCQbz+v7IkgqpoOOsYf+8
         8JrT4bxaUMaJ+o88jpfJ7b3sHy19kl0dovoJCMeFTyONSSsaOy38Ebj8wqlkTz1p3eeI
         KHvR6tg+XXv3NlJHx6MKYoGTsJOMLdrzdmYF07cGhoS0hc713tLgdqSvEkVU9Lub2md7
         34mY8AcVOf2M1elsDzUt6usWoeXXZuCG9daTpvpmxiIuZJhKNZhO0knbddX1YPxS+sDZ
         tXwA==
X-Received: by 10.60.42.197 with SMTP id q5mr15060440oel.37.1368506414462;
        Mon, 13 May 2013 21:40:14 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id yx4sm9277971obb.11.2013.05.13.21.40.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224280>

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
index 776c5af..6c7392f 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -368,7 +368,7 @@ def get_repo(url, alias):
 
     extensions.loadall(myui)
 
-    if hg.islocal(url):
+    if hg.islocal(url) and not os.environ.get('GIT_REMOTE_HG_TEST_REMOTE'):
         repo = hg.repository(myui, url)
         if not os.path.exists(dirname):
             os.makedirs(dirname)
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index dc71c37..44764a0 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -184,4 +184,42 @@ test_expect_success 'strip' '
 	test_cmp actual expected
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
1.8.3.rc1.579.g184e698
