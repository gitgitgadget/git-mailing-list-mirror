From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 07/14] t/t5516-fetch-push: don't use branches-file
Date: Sat, 22 Jun 2013 13:28:14 +0530
Message-ID: <1371887901-5659-8-git-send-email-artagnon@gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 10:02:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqIln-00086I-ER
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 10:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423751Ab3FVIB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 04:01:58 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:61912 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423719Ab3FVIB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 04:01:56 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so8824497pbc.1
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 01:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=riIn4JuwhUIp8bPrG2mrwQRGWawB7PKQRKW/GLnKh1A=;
        b=wrQFdE3HEee7CdLJS/Pkch2HCChmxd0TChptRqyERcsSAAkAOQB4h7nySybLpt4jJM
         5X8qGycYLPoNYg8qVUFfdtLXckig90Iah+vBE5jzGR5LUD8CClDQS46lHahAtwsbPKrt
         8OsGOlzWyPpKbN7KpZerpEUS1MbCnfzYnUoQ3+R3PgHSplPBDluqwTBvJ2irT1FePF8D
         MDbQClXrMemmvL+Q+JvkEG1dp+mWOuCfk8vg0jk5HouYgETjH8MCqQLR143FvAD7INLR
         he2dMlizl5uTzanj3UFlhU2NHAARJH9Uc1vDDmZRo9fej5St1RJaV35hK1E9wsePCooX
         n84g==
X-Received: by 10.68.143.73 with SMTP id sc9mr15427804pbb.2.1371888115910;
        Sat, 22 Jun 2013 01:01:55 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id dc3sm8355333pbc.9.2013.06.22.01.01.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 01:01:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.gd3dfebf
In-Reply-To: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228682>

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
1.8.3.1.498.gacf2885
