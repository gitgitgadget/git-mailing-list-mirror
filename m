From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 2/7] t5520: implement tests for no merge candidates cases
Date: Sat,  2 May 2015 23:37:10 +0800
Message-ID: <1430581035-29464-3-git-send-email-pyokagan@gmail.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 17:37:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoZTz-0002wB-Dy
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 17:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbbEBPhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 11:37:31 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33420 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbbEBPha (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 11:37:30 -0400
Received: by pdbnk13 with SMTP id nk13so121285655pdb.0
        for <git@vger.kernel.org>; Sat, 02 May 2015 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4V4iCr1s2jyqGehfolnBustwEaFfAluJ+2y41ZiqSs0=;
        b=dqn3FRCQSJy3JaYU+jhdoKbcmj33EAFVZxjlAfWSLGrMv7XDYr+LYr271Q4WsM/ufx
         qwdG4zRjjMfmBICNwJ9Pmfemdutese+hMvZtrjgJocWWhKdHLwr0uOMh5wfFyKEHVWNH
         ObhxEPbiu8WP0RWQqMJmDQdT+8/C7xmhPs/OaJutNDyXSmzcVtHxOBv1ok/V3XifBaoC
         WQhBI52gSlQR/B1CvBej7I5jGVSxdWDBJBY0vZWPhdrH21+CtfOev41V9OcLVowWWUDO
         Jy/NA/pur9OOx+O9S0AnKAuOHsflxWBPEpprWZmpSh5w0JUPf6aBIudLgiZqH7TiJROA
         UoYg==
X-Received: by 10.67.24.33 with SMTP id if1mr27272306pad.24.1430581050114;
        Sat, 02 May 2015 08:37:30 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.172.217])
        by mx.google.com with ESMTPSA id tk9sm7925072pbc.35.2015.05.02.08.37.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 May 2015 08:37:28 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268232>

Commit a8c9bef4 fully established the current advices given by git-pull
for the different cases where git-fetch will not have anything marked
for merge:

1. We're not on a branch, so there is no branch
   configuration.

2. We're on a branch, but there is no configuration for
   this branch.

3. We fetched from the configured remote, but the
   configured branch to merge didn't get fetched (either
   it doesn't exist, or wasn't part of the fetch refspec).

4. We fetched from the non-default remote, but didn't
   specify a branch to merge. We can't use the configured
   one because it applies to the default remote.

5. We fetched from a specified remote, and a refspec was
   given, but it ended up not fetching anything.

Implement tests for the above 5 cases to ensure that the correct code
paths are triggered for each of these cases.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

I'm having trouble hitting the 1st case without resorting to the hack below. A
detached HEAD will always have no remote configured, and the code flow would
make it such that case (4) is hit in the detached HEAD case instead of case
(1).

 t/t5520-pull.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 01ae1bf..635ec02 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -122,6 +122,58 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	test `cat file` = modified
 '
 
+test_expect_success 'fail if not on a branch' '
+	cp .git/config .git/config.bak &&
+	test_when_finished "cp .git/config.bak .git/config" &&
+	git remote add test_remote . &&
+	git checkout HEAD^{} &&
+	test_when_finished "git checkout -f copy" &&
+	cat >>.git/config <<-\EOF &&
+	[branch ""]
+	remote = test_remote
+	EOF
+	test_must_fail git pull test_remote 2>out &&
+	test_i18ngrep "You are not currently on a branch" out
+'
+
+test_expect_success 'fail if no configuration for current branch' '
+	git remote add test_remote . &&
+	test_when_finished "git remote remove test_remote" &&
+	git checkout -b test copy &&
+	test_when_finished "git checkout -f copy && git branch -D test" &&
+	test_config branch.test.remote test_remote &&
+	test_must_fail git pull 2>out &&
+	test_i18ngrep "There is no tracking information" out
+'
+
+test_expect_success 'fail if upstream branch does not exist' "
+	git checkout -b test copy &&
+	test_when_finished 'git checkout -f copy && git branch -D test' &&
+	test_config branch.test.remote . &&
+	test_config branch.test.merge refs/heads/nonexisting &&
+	test_must_fail git pull 2>out &&
+	test_i18ngrep \"Your configuration specifies to merge with the ref 'nonexisting'\" out
+"
+
+test_expect_success 'fail if no branches specified with non-default remote' '
+	git clone --bare . test_repo &&
+	test_when_finished "rm -rf test_repo" &&
+	git remote add test_remote test_repo &&
+	test_when_finished "git remote remove test_remote" &&
+	git checkout -b test master &&
+	test_when_finished "git checkout -f master && git branch -D test" &&
+	test_config branch.test.remote . &&
+	test_must_fail git pull test_remote 2>out &&
+	test_i18ngrep "you must specify a branch on the command line" out
+'
+
+test_expect_success 'fail if wildcard spec does not match any refs' "
+	git checkout -b test copy &&
+	test_when_finished 'git checkout -f copy && git branch -D test' &&
+	test_must_fail git pull . 'refs/nonexisting1/*:refs/nonexisting2/*' 2>out &&
+	test_i18ngrep 'There are no candidates for merging' out
+"
+
 test_expect_success '--rebase' '
 	git branch to-rebase &&
 	echo modified again > file &&
-- 
2.1.4
