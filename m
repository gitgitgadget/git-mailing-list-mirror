From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 2/8] t5520: test no merge candidates cases
Date: Fri, 29 May 2015 19:44:39 +0800
Message-ID: <1432899885-25143-3-git-send-email-pyokagan@gmail.com>
References: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 13:45:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyIir-0003ty-Qt
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 13:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbbE2LpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 07:45:04 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35834 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889AbbE2LpA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 07:45:00 -0400
Received: by pacrp13 with SMTP id rp13so9521499pac.2
        for <git@vger.kernel.org>; Fri, 29 May 2015 04:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q3K5JN5hUE6n+tygMVQ8uLfU9B+OauOn6oajPl+OzAg=;
        b=PakRDwBatKT7vMBOlAFfRhyIQdj0jDhyk7ZiVy7JkNUs3aQYB3HJvRGCTx2F9peY4m
         NrtAXxSDuOJieTozVnY6Jn2URSi0b2vZ+3Dz7+Dd/8CVRR2IvusC5bNvIBbdTXG76rwM
         j6rBxeaat6BGSTg0Bd6yPSiKtaKdDsQLX45oUtV3OwvWzOTkUWnpMTO0fJxcSNopLREM
         VTS4FzV/ayL6NeZsLYtDdsA1gJYYjltLl3EpXew7X8+39FDpnKkpe2GYpe+zmq3XtK+2
         9KWtajsiLI1ridCceToib/NfK8TXjmHFzHPw4TyrjAfSDGnVGfsJlQgYpI0yC3o741BG
         fH/Q==
X-Received: by 10.68.235.38 with SMTP id uj6mr14265055pbc.57.1432899899833;
        Fri, 29 May 2015 04:44:59 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qg5sm5392460pdb.13.2015.05.29.04.44.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 May 2015 04:44:58 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270230>

a8c9bef (pull: improve advice for unconfigured error case, 2009-10-05)
fully established the current advices given by git-pull for the
different cases where git-fetch will not have anything marked for merge:

1. We fetched from a specific remote, and a refspec was given, but it
   ended up not fetching anything. This is usually because the user
   provided a wildcard refspec which had no matches on the remote end.

2. We fetched from a non-default remote, but didn't specify a branch to
   merge. We can't use the configured one because it applies to the
   default remote, and thus the user must specify the branches to merge.

3. We fetched from the branch's or repo's default remote, but:

   a. We are not on a branch, so there will never be a configured branch
      to merge with.

   b. We are on a branch, but there is no configured branch to merge
      with.

4. We fetched from the branch's or repo's default remote, but the
   configured branch to merge didn't get fetched (either it doesn't
   exist, or wasn't part of the configured fetch refspec)

Implement tests for the above 5 cases to ensure that the correct code
paths are triggered for each of these cases.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

 t/t5520-pull.sh | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 5e4db67..4a2c0a1 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -109,6 +109,61 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	test "$(cat file)" = modified
 '
 
+test_expect_success 'fail if wildcard spec does not match any refs' '
+	git checkout -b test copy^ &&
+	test_when_finished "git checkout -f copy && git branch -D test" &&
+	test "$(cat file)" = file &&
+	test_must_fail git pull . "refs/nonexisting1/*:refs/nonexisting2/*" 2>err &&
+	test_i18ngrep "no candidates for merging" err &&
+	test "$(cat file)" = file
+'
+
+test_expect_success 'fail if no branches specified with non-default remote' '
+	git remote add test_remote . &&
+	test_when_finished "git remote remove test_remote" &&
+	git checkout -b test copy^ &&
+	test_when_finished "git checkout -f copy && git branch -D test" &&
+	test "$(cat file)" = file &&
+	test_config branch.test.remote origin &&
+	test_must_fail git pull test_remote 2>err &&
+	test_i18ngrep "specify a branch on the command line" err &&
+	test "$(cat file)" = file
+'
+
+test_expect_success 'fail if not on a branch' '
+	git remote add origin . &&
+	test_when_finished "git remote remove origin" &&
+	git checkout HEAD^ &&
+	test_when_finished "git checkout -f copy" &&
+	test "$(cat file)" = file &&
+	test_must_fail git pull 2>err &&
+	test_i18ngrep "not currently on a branch" err &&
+	test "$(cat file)" = file
+'
+
+test_expect_success 'fail if no configuration for current branch' '
+	git remote add test_remote . &&
+	test_when_finished "git remote remove test_remote" &&
+	git checkout -b test copy^ &&
+	test_when_finished "git checkout -f copy && git branch -D test" &&
+	test_config branch.test.remote test_remote &&
+	test "$(cat file)" = file &&
+	test_must_fail git pull 2>err &&
+	test_i18ngrep "no tracking information" err &&
+	test "$(cat file)" = file
+'
+
+test_expect_success 'fail if upstream branch does not exist' '
+	git checkout -b test copy^ &&
+	test_when_finished "git checkout -f copy && git branch -D test" &&
+	test_config branch.test.remote . &&
+	test_config branch.test.merge refs/heads/nonexisting &&
+	test "$(cat file)" = file &&
+	test_must_fail git pull 2>err &&
+	test_i18ngrep "no such ref was fetched" err &&
+	test "$(cat file)" = file
+'
+
 test_expect_success '--rebase' '
 	git branch to-rebase &&
 	echo modified again > file &&
-- 
2.1.4
