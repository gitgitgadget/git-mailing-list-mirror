From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 07/16] t/t5516-fetch-push: don't use branches-file
Date: Fri, 21 Jun 2013 16:42:31 +0530
Message-ID: <1371813160-4200-8-git-send-email-artagnon@gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzKq-0004Dq-EQ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935578Ab3FULQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:16:51 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:58535 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030216Ab3FULQN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:16:13 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so7695815pac.1
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5oclCCi8VJCO5EWbYfabvXGUjPXcUcz/1ZMPwpT+N04=;
        b=GnqPIsxgJhiqEIYf0WkrK7ffkZ9pByyS+nGG+VUD6ItvWtJTzKn9rPDpuksFLSk+VK
         Ss/5CLKr8Zrm0jSrKrRc0HJkF1wwI52Eh/syIHAnn1c9GQ5ET2YPeKAVAKjx9AR4NMjS
         yD2coexAvNlXtCXOBNyCgYL4AUtNphwLznFUa4RINP53cX7EUUoeS94A7R/1q5biwDXl
         WkInbQbtCV0jPNHlDFTEKmSYTjuIQ+zY/1w6QCimO0VPcw6W23DbdCML4jn2njrGiEil
         H9v4uNptghfbLU43FDzeF1Y8J7LHSZ4nyoebdXQ2iTvfU9YinghfXSzXaoys5xYWByFm
         4YTQ==
X-Received: by 10.66.219.1 with SMTP id pk1mr15670114pac.29.1371813372501;
        Fri, 21 Jun 2013 04:16:12 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.16.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:16:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228610>

Four tests exercising fetch and push functionality unnecessarily depend
on $GIT_DIR/branches files.  Modern Git does not encourage the use of
those files, and the parser remote.c:read_branches_file() is only
provided for backward compatibility with older repositories.  We already
have tests in t/t5505-remote to verify that the parser works: so,
substitute the $GIT_DIR/branches configuration with an equivalent
gitconfig-style configuration, using the results of those tests.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5516-fetch-push.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4691d51..6e9fa84 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -852,9 +852,11 @@ test_expect_success 'fetch with branches' '
 	mk_empty testrepo &&
 	git branch second $the_first_commit &&
 	git checkout second &&
-	echo ".." > testrepo/.git/branches/branch1 &&
 	(
 		cd testrepo &&
+		test_config remote.branch1.url ".."  &&
+		test_config remote.branch1.fetch "refs/heads/master:refs/heads/branch1"  &&
+		test_config remote.branch1.push "HEAD:refs/heads/master"  &&
 		git fetch branch1 &&
 		echo "$the_commit commit	refs/heads/branch1" >expect &&
 		git for-each-ref refs/heads >actual &&
@@ -865,9 +867,11 @@ test_expect_success 'fetch with branches' '
 
 test_expect_success 'fetch with branches containing #' '
 	mk_empty testrepo &&
-	echo "..#second" > testrepo/.git/branches/branch2 &&
 	(
 		cd testrepo &&
+		test_config remote.branch2.url ".."  &&
+		test_config remote.branch2.fetch "refs/heads/second:refs/heads/branch2"  &&
+		test_config remote.branch2.push "HEAD:refs/heads/second"  &&
 		git fetch branch2 &&
 		echo "$the_first_commit commit	refs/heads/branch2" >expect &&
 		git for-each-ref refs/heads >actual &&
@@ -879,7 +883,9 @@ test_expect_success 'fetch with branches containing #' '
 test_expect_success 'push with branches' '
 	mk_empty testrepo &&
 	git checkout second &&
-	echo "testrepo" > .git/branches/branch1 &&
+	test_config remote.branch1.url testrepo &&
+	test_config remote.branch1.fetch "refs/heads/master:refs/heads/branch1" &&
+	test_config remote.branch1.push "HEAD:refs/heads/master" &&
 	git push branch1 &&
 	(
 		cd testrepo &&
@@ -891,7 +897,9 @@ test_expect_success 'push with branches' '
 
 test_expect_success 'push with branches containing #' '
 	mk_empty testrepo &&
-	echo "testrepo#branch3" > .git/branches/branch2 &&
+	test_config remote.branch2.url testrepo &&
+	test_config remote.branch2.fetch "refs/heads/branch3:refs/heads/branch2" &&
+	test_config remote.branch2.push "HEAD:refs/heads/branch3" &&
 	git push branch2 &&
 	(
 		cd testrepo &&
-- 
1.8.3.1.499.g7ad3486.dirty
