From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] push test: use test_config when appropriate
Date: Mon, 18 Mar 2013 16:12:11 -0700
Message-ID: <20130318231211.GE5062@elie.Belkin>
References: <20130318220224.3b23a381@hoelz.ro>
 <20130318231043.GD5062@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	josh@joshtriplett.org
To: Rob Hoelz <rob@hoelz.ro>
X-From: git-owner@vger.kernel.org Tue Mar 19 00:12:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHjES-00065x-AA
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 00:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755651Ab3CRXMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 19:12:17 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:47529 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab3CRXMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 19:12:16 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so301030dan.19
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 16:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=LN0grJFX6dqgh8xrEj72x24HD9UKEgEGNWbm6ycsa7c=;
        b=wR7GO5nZR/Lb5XKM/WbA9iefj7KsdKWalm5kqpSaKL+ZFLT3Qmb0WvKrrBSqiBaPNe
         FwnkN3OtS09ld7mJuwvNGYGai5sY4In/ZvZH3blvWWMoAMGTWdrXAXeCAtBnJeyXYnaw
         i3Dq1tECPjxgselFwznCqS+juz5dhgzAc7W0VBNAhm9EWNW0WeG/ETxkioQvZi8oMm3b
         9i+qzZczdohptgWClzXgYRT7VsAgpOZGepP30kk7BfD+MO5ikK+c7qT/Fv2FKGRaLa4v
         /wEfsLe4D6/V341Kov1S/lPpkZ7NKeHeRT6UBcfhpN9BBMQeMzztldM66i8p6zIgZ356
         7fCQ==
X-Received: by 10.66.232.230 with SMTP id tr6mr97424pac.83.1363648336015;
        Mon, 18 Mar 2013 16:12:16 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id y1sm21709966pbg.10.2013.03.18.16.12.13
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 16:12:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130318231043.GD5062@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218462>

Configuration from test_config does not last beyond the end of the
current test assertion, making each test easier to think about in
isolation.

This changes the meaning of some of the tests.  For example, currently
"push with insteadOf" passes even if the line setting
"url.$TRASH.pushInsteadOf" is dropped because an url.$TRASH.insteadOf
setting leaks in from a previous test.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t5516-fetch-push.sh | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index c31e5c1c..5b89c111 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -203,7 +203,7 @@ test_expect_success 'push with wildcard' '
 test_expect_success 'push with insteadOf' '
 	mk_empty &&
 	TRASH="$(pwd)/" &&
-	git config "url.$TRASH.insteadOf" trash/ &&
+	test_config "url.$TRASH.insteadOf" trash/ &&
 	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
 		cd testrepo &&
@@ -217,7 +217,7 @@ test_expect_success 'push with insteadOf' '
 test_expect_success 'push with pushInsteadOf' '
 	mk_empty &&
 	TRASH="$(pwd)/" &&
-	git config "url.$TRASH.pushInsteadOf" trash/ &&
+	test_config "url.$TRASH.pushInsteadOf" trash/ &&
 	git push trash/testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
 		cd testrepo &&
@@ -231,9 +231,9 @@ test_expect_success 'push with pushInsteadOf' '
 test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf should not rewrite)' '
 	mk_empty &&
 	TRASH="$(pwd)/" &&
-	git config "url.trash2/.pushInsteadOf" trash/ &&
-	git config remote.r.url trash/wrong &&
-	git config remote.r.pushurl "$TRASH/testrepo" &&
+	test_config "url.trash2/.pushInsteadOf" trash/ &&
+	test_config remote.r.url trash/wrong &&
+	test_config remote.r.pushurl "$TRASH/testrepo" &&
 	git push r refs/heads/master:refs/remotes/origin/master &&
 	(
 		cd testrepo &&
@@ -489,31 +489,24 @@ test_expect_success 'push with config remote.*.push = HEAD' '
 		git checkout local &&
 		git reset --hard $the_first_commit
 	) &&
-	git config remote.there.url testrepo &&
-	git config remote.there.push HEAD &&
-	git config branch.master.remote there &&
+	test_config remote.there.url testrepo &&
+	test_config remote.there.push HEAD &&
+	test_config branch.master.remote there &&
 	git push &&
 	check_push_result $the_commit heads/master &&
 	check_push_result $the_first_commit heads/local
 '
 
-# clean up the cruft left with the previous one
-git config --remove-section remote.there
-git config --remove-section branch.master
-
 test_expect_success 'push with config remote.*.pushurl' '
 
 	mk_test heads/master &&
 	git checkout master &&
-	git config remote.there.url test2repo &&
-	git config remote.there.pushurl testrepo &&
+	test_config remote.there.url test2repo &&
+	test_config remote.there.pushurl testrepo &&
 	git push there &&
 	check_push_result $the_commit heads/master
 '
 
-# clean up the cruft left with the previous one
-git config --remove-section remote.there
-
 test_expect_success 'push with dry-run' '
 
 	mk_test heads/master &&
-- 
1.8.2.rc3
