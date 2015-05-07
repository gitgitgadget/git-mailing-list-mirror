From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 10/12] t5520: failing test for pull --all with no configured upstream
Date: Thu,  7 May 2015 16:44:06 +0800
Message-ID: <1430988248-18285-11-git-send-email-pyokagan@gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 10:45:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqHQP-0005jY-Mm
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 10:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbbEGIoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 04:44:54 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33273 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbbEGIou (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 04:44:50 -0400
Received: by pacwv17 with SMTP id wv17so34441162pac.0
        for <git@vger.kernel.org>; Thu, 07 May 2015 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=as0EKRbSKpA9xqrI606uwtvtWsTpNQJDvppqIue7cxU=;
        b=C5lKRK2QcUgqVnIeIXbK2RknbFSqwy8UV0iEN8sFnrwrKZJL/CU1QgFb8ZfSC9qxs8
         OIt7MeoPaNFmRK015neTLVEKo7pn7NbcCCmUJ45hllVCwvA/Z1AVya2ge+NsC80KVdXL
         8TNUKqRSaC++yo5GKN+/RkP7PZVZyAQld6kp+0Xl1PGL9icnxrMq/l43qOEq+MQUy/xW
         7tps7j3VhYpdJiOISx9GFXEMQQffqytZ3qfFMuZp7LyV+1V1/3PxT/a9VHvujsZYALxC
         7zb8X9Z+ddHG44IjhY/+ScIkNkash4GP8FQj/uW0ZKt4Na37aMJ2QQfeKACIeYthjNyw
         0boA==
X-Received: by 10.69.27.33 with SMTP id jd1mr4969531pbd.125.1430988290145;
        Thu, 07 May 2015 01:44:50 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id wh6sm1369308pbc.96.2015.05.07.01.44.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 01:44:47 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268520>

error_on_no_merge_candidates() does not consider the case where "$#"
includes command-line flags that are passed to git-fetch.

As such, when the current branch has no configured upstream, and there
are no merge candidates because of that, git-pull --all erroneously reports
that we are pulling from "--all", as it believes that the first argument
is the remote name.

Add a failing test that shows this case.

Reported-by: Stephen Robin <stephen.robin@gmail.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    * Added this test to the patch series.

 t/t5520-pull.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index d97a575..b93b735 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -153,6 +153,18 @@ test_expect_success 'fail if no configuration for current branch' '
 	test `cat file` = file
 '
 
+test_expect_failure 'pull --all: fail if no configuration for current branch' '
+	git remote add test_remote . &&
+	test_when_finished "git remote remove test_remote" &&
+	git checkout -b test copy^ &&
+	test_when_finished "git checkout -f copy && git branch -D test" &&
+	test_config branch.test.remote test_remote &&
+	test `cat file` = file &&
+	test_must_fail git pull --all 2>out &&
+	test_i18ngrep "There is no tracking information" out &&
+	test `cat file` = file
+'
+
 test_expect_success 'fail if upstream branch does not exist' '
 	git checkout -b test copy^ &&
 	test_when_finished "git checkout -f copy && git branch -D test" &&
-- 
2.1.4
