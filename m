From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 3/9] t5520: test no merge candidates cases
Date: Wed, 13 May 2015 17:08:50 +0800
Message-ID: <1431508136-15313-4-git-send-email-pyokagan@gmail.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:09:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsSfb-0003HM-0N
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870AbbEMJJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:09:35 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35138 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbbEMJJb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:09:31 -0400
Received: by pabtp1 with SMTP id tp1so44525475pab.2
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5zLDRAEymmFOdlyMgrpc48FxAZbAZ4Gaf4aw8UvewL0=;
        b=gh1zOa9mS4tdRU+pWxDMwrN2+d4FMMvkgBUaFlGrF0r66kakWJVZarcUvHDKDzVQ9Q
         /DbWVEP7plhbUF4hHzJqqGWsPUrjlct8WPhSmk6bpLug3qNssb5tJlN5b9xcdNZ9WODE
         COdBEsVNOSLOS7+4SGPkZIFnpGR9azORvOyQC9OZKnyrls+YYn864YmK3TI9rKOoPQUe
         0BxDVXHySvD9t/QOnGtk1qDSzia85XmDQSfrdgDUmfXwLM5csZQk5ZC7y3BqwKF/VxF3
         DJRdg80xF49YKTP+8x5k+/1o10f6AxgxA8fDlJDBfUkU72PoZvyidXJzpqH7R0omaTk7
         pUFg==
X-Received: by 10.70.49.229 with SMTP id x5mr35133053pdn.81.1431508170699;
        Wed, 13 May 2015 02:09:30 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id df7sm18645685pdb.32.2015.05.13.02.09.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:09:29 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268952>

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

* File content comparisons are now quoted.


 t/t5520-pull.sh | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 14a9280..e53d8e9 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -109,6 +109,61 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	verbose test "$(cat file)" = modified
 '
 
+test_expect_success 'fail if wildcard spec does not match any refs' '
+	git checkout -b test copy^ &&
+	test_when_finished "git checkout -f copy && git branch -D test" &&
+	verbose test "$(cat file)" = file &&
+	test_must_fail git pull . "refs/nonexisting1/*:refs/nonexisting2/*" 2>err &&
+	test_i18ngrep "no candidates for merging" err &&
+	verbose test "$(cat file)" = file
+'
+
+test_expect_success 'fail if no branches specified with non-default remote' '
+	git remote add test_remote . &&
+	test_when_finished "git remote remove test_remote" &&
+	git checkout -b test copy^ &&
+	test_when_finished "git checkout -f copy && git branch -D test" &&
+	verbose test "$(cat file)" = file &&
+	test_config branch.test.remote origin &&
+	test_must_fail git pull test_remote 2>err &&
+	test_i18ngrep "specify a branch on the command line" err &&
+	verbose test "$(cat file)" = file
+'
+
+test_expect_success 'fail if not on a branch' '
+	git remote add origin . &&
+	test_when_finished "git remote remove origin" &&
+	git checkout HEAD^ &&
+	test_when_finished "git checkout -f copy" &&
+	verbose test "$(cat file)" = file &&
+	test_must_fail git pull 2>err &&
+	test_i18ngrep "not currently on a branch" err &&
+	verbose test "$(cat file)" = file
+'
+
+test_expect_success 'fail if no configuration for current branch' '
+	git remote add test_remote . &&
+	test_when_finished "git remote remove test_remote" &&
+	git checkout -b test copy^ &&
+	test_when_finished "git checkout -f copy && git branch -D test" &&
+	test_config branch.test.remote test_remote &&
+	verbose test "$(cat file)" = file &&
+	test_must_fail git pull 2>err &&
+	test_i18ngrep "no tracking information" err &&
+	verbose test "$(cat file)" = file
+'
+
+test_expect_success 'fail if upstream branch does not exist' '
+	git checkout -b test copy^ &&
+	test_when_finished "git checkout -f copy && git branch -D test" &&
+	test_config branch.test.remote . &&
+	test_config branch.test.merge refs/heads/nonexisting &&
+	verbose test "$(cat file)" = file &&
+	test_must_fail git pull 2>err &&
+	test_i18ngrep "no such ref was fetched" err &&
+	verbose test "$(cat file)" = file
+'
+
 test_expect_success '--rebase' '
 	git branch to-rebase &&
 	echo modified again > file &&
-- 
2.1.4
