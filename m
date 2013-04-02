From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/6] Re-roll rr/triangle
Date: Tue,  2 Apr 2013 13:10:28 +0530
Message-ID: <1364888434-30388-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 02 09:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMvop-0007DT-E7
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 09:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760255Ab3DBHjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 03:39:19 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:59214 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab3DBHjS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 03:39:18 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so146806pab.24
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 00:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=lNXVkFCF5jdVrK3tLJduCQ7oThw0nBR9O9I9zer77u4=;
        b=U49njCDbk9eWJL/QIOZXPZqDST9fccBUCBQM5zaKa0m3aVuecSj+n08jNoVs2LjTzu
         uUS+GVTKGyoMAn00HY5bTs/qxWi59/GrViMvITelHqk/pEDosNQ61+lmp/zMzdjuzSHR
         j4WEaDYcEVhPOmUsiub+DXFLLZODBpZwK/ot6qmSzvKwNuhEm4ITgaxNIHiReRUKs4xb
         q+csvrnWFtXXibSak2R4J5bjE7rGNjuDy9aaQHmTbpAnTUhpdQOd6xLecGXJZchtsGL1
         K6r2h6ammOHPhNoIerhrG0hjthkWVEV3gGFKBD+arsR5xYzYF/eVXgj0AkXQ+Rt5bRnE
         3K0g==
X-Received: by 10.66.230.198 with SMTP id ta6mr23199448pac.126.1364888358119;
        Tue, 02 Apr 2013 00:39:18 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id oq3sm1259341pac.16.2013.04.02.00.39.15
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 00:39:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.363.g901f5bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219743>

There are two important changes in this round:

1. Rebased on latest master, resolving all conflicts (all in t5516).
   I ran the testsuite immediately after resolving the conflicts, so
   everything should be good.

2. Peff's suggestion to avoid using test_must_fail on compound
   statements.  I've changed the meaning of the tests slightly to
   (approximately) invert the tests.  The inter-diff follows.

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 13028a4..3281ff1 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -521,14 +521,14 @@ git config --remove-section remote.there
 git config --remove-section branch.master
 
 test_expect_success 'push with remote.pushdefault' '
-	mk_test up_repo heads/frotz &&
+	mk_test up_repo heads/master &&
 	mk_test down_repo heads/master &&
 	test_config remote.up.url up_repo &&
 	test_config remote.down.url down_repo &&
 	test_config branch.master.remote up &&
 	test_config remote.pushdefault down &&
 	git push &&
-	test_must_fail check_push_result up_repo $the_commit heads/master &&
+	check_push_result up_repo $the_first_commit heads/master &&
 	check_push_result down_repo $the_commit heads/master
 '
 
@@ -543,8 +543,8 @@ test_expect_success 'push with config remote.*.pushurl' '
 '
 
 test_expect_success 'push with config branch.*.pushremote' '
-	mk_test up_repo heads/frotz &&
-	mk_test side_repo heads/quux &&
+	mk_test up_repo heads/master &&
+	mk_test side_repo heads/master &&
 	mk_test down_repo heads/master &&
 	test_config remote.up.url up_repo &&
 	test_config remote.pushdefault side_repo &&
@@ -552,8 +552,8 @@ test_expect_success 'push with config branch.*.pushremote' '
 	test_config branch.master.remote up &&
 	test_config branch.master.pushremote down &&
 	git push &&
-	test_must_fail check_push_result up_repo $the_commit heads/master &&
-	test_must_fail check_push_result side_repo $the_commit heads/master &&
+	check_push_result up_repo $the_first_commit heads/master &&
+	check_push_result side_repo $the_first_commit heads/master &&
 	check_push_result down_repo $the_commit heads/master
 '

Jeff King (1):
  t5516 (fetch-push): drop implicit arguments from helper functions

Ramkumar Ramachandra (5):
  remote.c: simplify a bit of code using git_config_string()
  t5516 (fetch-push): update test description
  remote.c: introduce a way to have different remotes for fetch/push
  remote.c: introduce remote.pushdefault
  remote.c: introduce branch.<name>.pushremote

 Documentation/config.txt |  24 +++-
 builtin/push.c           |   2 +-
 remote.c                 |  41 ++++--
 remote.h                 |   1 +
 t/t5516-fetch-push.sh    | 322 +++++++++++++++++++++++++++--------------------
 5 files changed, 241 insertions(+), 149 deletions(-)

-- 
1.8.2.363.g901f5bc
