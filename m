From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p1.1 08/14] remote-testgit: cleanup tests
Date: Sat, 24 Nov 2012 04:17:08 +0100
Message-ID: <1353727034-24698-9-git-send-email-felipe.contreras@gmail.com>
References: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
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
X-From: git-owner@vger.kernel.org Sat Nov 24 04:18:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6Fx-0001zJ-Nb
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622Ab2KXDR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:17:57 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61989 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932594Ab2KXDR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:17:56 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063027bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ah2F2+xenwG0yxZXk4tbG0u/+Ii8+pk5ZN6ULMeOOa4=;
        b=tarfif4CRfVTAqyLtImlMotJtzcnYe7hMYreHV//sq+7PEIYx0qMXu2vUtf7gPLqEf
         BA0COviHDsLGnTdULO7ZdV9ZVheDjbqQiuAtH+L5YAHFki49VcU1RAGxUG/DeZ+AvItQ
         CBalb3gxhYvMXBX5ZiJTKRyKMJGnZwMEbbrwrZouLJkZUfaB5vw4L/zu/3VGrzOuFvn7
         tTZ/foLpgmnM8MMJoSPWHb6Dn1LDJBf14RgBtXLBMD01NaBPGAVZTkzH2FOqsTyeq3xO
         5aLUtp/DQg+xJTtGEKfoFI0ReWei4o9TWtKNC35lKd0TF51eFlQ03BfVZ1DJgI2LTPoV
         o+/Q==
Received: by 10.205.125.137 with SMTP id gs9mr1705900bkc.22.1353727075463;
        Fri, 23 Nov 2012 19:17:55 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id j16sm4400715bkv.1.2012.11.23.19.17.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:17:54 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210292>

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
