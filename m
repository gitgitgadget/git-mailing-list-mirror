From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 p1 08/13] remote-testgit: cleanup tests
Date: Wed, 28 Nov 2012 23:11:04 +0100
Message-ID: <1354140669-23533-9-git-send-email-felipe.contreras@gmail.com>
References: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:12:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdprs-0003JU-58
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 23:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932811Ab2K1WLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 17:11:54 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43342 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932776Ab2K1WLv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 17:11:51 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5972393bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 14:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IR7n23tr0YkwGt4V7pz6ogrD6/PWt3YWrbFGNu+avxk=;
        b=VX7cGaBwzoF484P+fN9tDS22XQLfXhhWR/nKXww/UIf6mjL9iFI5knZFnVQrJRtCSA
         WYvm367z/Is7fT9FEjPE/u90G2rWZ3k5TzodqNwdjzc49rg4uUIxDxBUdDdhcnYSmo/h
         YiClylXRHobSyJaTs3ZneQQIv77Cg+JN1GcDkE9aga4PbSYlOI7xWi3fvedt49GT9+s1
         y6Z1HMoQ5blA4Afh6CuzjR+2f8QNPFbSZGZW4IXOLswijKs1q8ajEQ47Ml6kcV5/vH4/
         UXcRkIAAm6Om2dmvj0zVD7Z/OI4myy4V0yPnEiA2859gSWZAkotEP1CxP/rJmXZLojpJ
         x8qg==
Received: by 10.204.146.85 with SMTP id g21mr4501590bkv.52.1354140710667;
        Wed, 28 Nov 2012 14:11:50 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id i20sm13783239bkw.5.2012.11.28.14.11.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 14:11:49 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210793>

We don't need a bare 'server' and an intermediary 'public'. The repos
can talk to each other directly; that's what we want to exercise.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.8.0.1
