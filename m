From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 2/2] t3401: use test_commit in setup
Date: Fri,  9 Dec 2011 08:59:12 -0800
Message-ID: <1323449952-14161-2-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1323449952-14161-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 17:59:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ3nV-0001HH-Mi
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 17:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120Ab1LIQ7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 11:59:39 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55052 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab1LIQ7i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 11:59:38 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so4474464iak.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 08:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UX3DhnOUVrxwUol8KsB2dtznX0erjbdcKXmbPDv+QHQ=;
        b=hHN2DYoNorp+TMd7Gi3qcr90duhc3IJ5JdQLrd6Q9N1g/5BfaOOZFEy7EgLkfX1pWS
         pZT/6j5sJ08rfDGgesMGTdFJ8OCjNSTe2y7zaaV8SIwOtsvq4TGsidwFJrtuoUs5HGtL
         DJIcoSlPmO2OfzyBjHaEn8rZYIMAt/jYf4z74=
Received: by 10.50.159.136 with SMTP id xc8mr1335689igb.14.1323449978247;
        Fri, 09 Dec 2011 08:59:38 -0800 (PST)
Received: from martinvonz-glaptop.mtv.corp.google.com (dhcp-172-19-34-241.mtv.corp.google.com [172.19.34.241])
        by mx.google.com with ESMTPS id d19sm12003076ibh.8.2011.12.09.08.59.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 08:59:37 -0800 (PST)
X-Mailer: git-send-email 1.7.8.237.gcc4e3
In-Reply-To: <1323449952-14161-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186651>

Simplify t3401 by using test_commit in the setup. This lets us refer
to commits using their tags and there is no longer a need to create
the branch my-topic-branch-merge. Also, the branch master-merge points
to the same commit as master (even before this change), so that branch
does not need to be created either.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 t/t3401-rebase-partial.sh |   31 ++++++++-----------------------
 1 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
index d7c874c..1aac22c 100755
--- a/t/t3401-rebase-partial.sh
+++ b/t/t3401-rebase-partial.sh
@@ -12,32 +12,17 @@ local branch.
 . ./test-lib.sh
 
 test_expect_success 'prepare repository with topic branch' '
-	echo First > A &&
-	git update-index --add A &&
-	git commit -m "Add A." &&
-
+	test_commit A &&
 	git checkout -b my-topic-branch &&
-
-	echo Second > B &&
-	git update-index --add B &&
-	git commit -m "Add B." &&
-
-	echo AnotherSecond > C &&
-	git update-index --add C &&
-	git commit -m "Add C." &&
-
+	test_commit B &&
+	test_commit C &&
 	git checkout -f master &&
-
-	echo Third >> A &&
-	git update-index A &&
-	git commit -m "Modify A."
+	test_commit A2 A.t
 '
 
 test_expect_success 'pick top patch from topic branch into master' '
-	git cherry-pick my-topic-branch^0 &&
-	git checkout -f my-topic-branch &&
-	git branch master-merge master &&
-	git branch my-topic-branch-merge my-topic-branch
+	git cherry-pick C &&
+	git checkout -f my-topic-branch
 '
 
 test_debug '
@@ -52,8 +37,8 @@ test_expect_success 'rebase topic branch against new master and check git am did
 '
 
 test_expect_success 'rebase --merge topic branch that was partially merged upstream' '
-	git checkout -f my-topic-branch-merge &&
-	git rebase --merge master-merge &&
+	git reset --hard C &&
+	git rebase --merge master &&
 	test ! -d .git/rebase-merge
 '
 
-- 
1.7.8.237.gcc4e3
