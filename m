From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 07/14] remote-testgit: cleanup tests
Date: Fri,  2 Nov 2012 03:02:11 +0100
Message-ID: <1351821738-17526-8-git-send-email-felipe.contreras@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 03:03:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU6bL-0000vf-PH
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 03:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965812Ab2KBCC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 22:02:58 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43159 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965791Ab2KBCC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 22:02:57 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1234245bkc.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 19:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CLepjUpoRuGyneAcHLb0z6dvU5mDyEWpPleiU5dTZQQ=;
        b=yXNH0LIfgrvJxN5fIxdXd1XKHe8s2L1/4xfsURWxCC1OPp39I2HoDBn72nxF6fpqGZ
         tFQL7lcSO9IA3hu9M1hxbq1vr+3nqfdM67esw22xHmaxsVq1tLhBwjFwQVVsoZM1Xz3D
         UAxZ1360P3ECC22Aanrj96rlvJGmk/RNygZqk1xyCMohlQlAxQQ12ExJe1wPYJvLDfkx
         n3euZjEYl9rOB3evoxvjp7NZGDyYEApOslh1+/zvNbwUPw5Vd2Dq5hEkIDgIfnjVPVwK
         EhRVU6MMkrQM+ftmFoyXkTrOmNjTOCQGLfQmNQ2GgtEZ+VJXgPX8HcA0Sx6JD2V8KHOG
         9U+g==
Received: by 10.205.135.20 with SMTP id ie20mr26658bkc.16.1351821776429;
        Thu, 01 Nov 2012 19:02:56 -0700 (PDT)
Received: from localhost (ip-109-43-0-51.web.vodafone.de. [109.43.0.51])
        by mx.google.com with ESMTPS id 1sm5772840bks.3.2012.11.01.19.02.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 19:02:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208904>

We don't need a bare 'server' and an intermediary 'public'. The repos
can talk to each other directly; that's what we want to exercise.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh | 67 +++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index a03d087..3c4e09a 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -14,96 +14,95 @@ compare_refs() {
 }
 
 test_expect_success 'setup repository' '
-	git init --bare server/.git &&
-	git clone server public &&
-	(cd public &&
+	git init server &&
+	(cd server &&
 	 echo content >file &&
 	 git add file &&
-	 git commit -m one &&
-	 git push origin master)
+	 git commit -m one)
 '
 
 test_expect_success 'cloning from local repo' '
-	git clone "testgit::${PWD}/server" localclone &&
-	test_cmp public/file localclone/file
+	git clone "testgit::${PWD}/server" local &&
+	test_cmp server/file local/file
 '
 
 test_expect_success 'create new commit on remote' '
-	(cd public &&
+	(cd server &&
 	 echo content >>file &&
-	 git commit -a -m two &&
-	 git push)
+	 git commit -a -m two)
 '
 
 test_expect_success 'pulling from local repo' '
-	(cd localclone && git pull) &&
-	test_cmp public/file localclone/file
+	(cd local && git pull) &&
+	test_cmp server/file local/file
 '
 
 test_expect_success 'pushing to local repo' '
-	(cd localclone &&
+	(cd local &&
 	echo content >>file &&
 	git commit -a -m three &&
 	git push) &&
-	compare_refs localclone HEAD server HEAD
+	compare_refs local HEAD server HEAD
 '
 
 test_expect_success 'fetch new branch' '
-	(cd public &&
+	(cd server &&
+	 git reset --hard &&
 	 git checkout -b new &&
 	 echo content >>file &&
-	 git commit -a -m five &&
-	 git push origin new
+	 git commit -a -m five
 	) &&
-	(cd localclone &&
+	(cd local &&
 	 git fetch origin new
 	) &&
-	compare_refs public HEAD localclone FETCH_HEAD
+	compare_refs server HEAD local FETCH_HEAD
 '
 
-test_expect_success 'bump commit in public' '
-	(cd public &&
+#
+# This is only needed because of a bug not detected by this script. It will be
+# fixed shortly, but for now lets not cause regressions.
+# 
+test_expect_success 'bump commit in server' '
+	(cd server &&
 	git checkout master &&
-	git pull &&
 	echo content >>file &&
-	git commit -a -m four &&
-	git push) &&
-	compare_refs public HEAD server HEAD
+	git commit -a -m four) &&
+	compare_refs server HEAD server HEAD
 '
 
 test_expect_success 'fetch multiple branches' '
-	(cd localclone &&
+	(cd local &&
 	 git fetch
 	) &&
-	compare_refs server master localclone refs/remotes/origin/master &&
-	compare_refs server new localclone refs/remotes/origin/new
+	compare_refs server master local refs/remotes/origin/master &&
+	compare_refs server new local refs/remotes/origin/new
 '
 
 test_expect_success 'push when remote has extra refs' '
-	(cd localclone &&
+	(cd local &&
 	 git reset --hard origin/master &&
 	 echo content >>file &&
 	 git commit -a -m six &&
 	 git push
 	) &&
-	compare_refs localclone master server master
+	compare_refs local master server master
 '
 
 test_expect_success 'push new branch by name' '
-	(cd localclone &&
+	(cd local &&
 	 git checkout -b new-name  &&
 	 echo content >>file &&
 	 git commit -a -m seven &&
 	 git push origin new-name
 	) &&
-	compare_refs localclone HEAD server refs/heads/new-name
+	compare_refs local HEAD server refs/heads/new-name
 '
 
 test_expect_failure 'push new branch with old:new refspec' '
-	(cd localclone &&
+	(cd local &&
 	 git push origin new-name:new-refspec
 	) &&
-	compare_refs localclone HEAD server refs/heads/new-refspec
+	compare_refs local HEAD server refs/heads/new-refspec
 '
 
 test_done
-- 
1.8.0
