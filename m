From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 08/15] remote-testgit: cleanup tests
Date: Sun, 11 Nov 2012 14:59:45 +0100
Message-ID: <1352642392-28387-9-git-send-email-felipe.contreras@gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:01:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXY68-0007nz-Ai
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824Ab2KKOBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:01:01 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62032 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab2KKOBA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:01:00 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2062168bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ah2F2+xenwG0yxZXk4tbG0u/+Ii8+pk5ZN6ULMeOOa4=;
        b=EbitP9Kfmf/QCPnNkuopvMOhMGpNpfnHWStBqjkDRsVmQb/Uu6tbwA0MOW6bevrQuO
         3kBeEbXREfNK9rDYQsgxA179ZCoUumBqzdxm/+DrW1Z9FBfHluB8+KFKXNtr1EUpbcxl
         svO78ufQAqh93863pMJRkGp8DMhJwsLRxwaXqW78XOQtdTJyKEtI+LIhu51+QYdhx++4
         HbpXD4cGNY6/Oyu1mNd2+i8hYqt5GsDfiGdD2gH0zA14lHqlvGbRW4SIN9RPGDKZkllE
         Ck1iOa5LHyij/2YYMqZof5TjYryrsYcD+kKXIIxAoh0lc4R/Mh/6K6106bjtjpcjhOc1
         bPSA==
Received: by 10.204.5.148 with SMTP id 20mr6126707bkv.28.1352642459803;
        Sun, 11 Nov 2012 06:00:59 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id k21sm1494264bkv.1.2012.11.11.06.00.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:00:58 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209363>

We don't need a bare 'server' and an intermediary 'public'. The repos
can talk to each other directly; that's what we want to exercise.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh | 63 ++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 34 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 6801529..bc0b5f7 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -19,100 +19,95 @@ compare_refs() {
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
 
 #
 # This is only needed because of a bug not detected by this script. It will be
 # fixed shortly, but for now lets not cause regressions.
 #
-test_expect_success 'bump commit in public' '
-	(cd public &&
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
