From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 01/12] t5520: implement tests for no merge candidates cases
Date: Thu,  7 May 2015 16:43:57 +0800
Message-ID: <1430988248-18285-2-git-send-email-pyokagan@gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 10:44:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqHPv-0005P8-QE
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 10:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbbEGIoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 04:44:21 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36388 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbbEGIoT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 04:44:19 -0400
Received: by pdea3 with SMTP id a3so35369206pde.3
        for <git@vger.kernel.org>; Thu, 07 May 2015 01:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4MKC1YjAilTfKUKqFkKhGRXBnVgpbQHZ/n4ghOAIIzk=;
        b=0e9GibA/XWe+aoUXZk7ENzUPyCpEHxhidJKfGKp4b8SGxkPU00sS0xp60S8Ck1OXQ+
         zRUKVTAq8PvXbRuwfz2EEGIGhornoyv80gS8OiAkiWPGsd6LED5YVCWG3VuXx+0fpCwA
         WOEt1ZNTkZ1uN1yojYQCOYojvLxCaNUAp6/Pi4qAHmcSHomE/loh0XEL22CLrBZ//Ph8
         mayNvKHUuNRgJJl6Or1LN8tg+VJGYRHkaqjh3Jj7C4A0KALG7O/1owMnUpQ5hnGMkznt
         yqCOVMlPjaKeLvXqy//zwzVRJBj4zoim1EPaaJa/5kvD9lHS2yiL6plsfmhYJ7+JEQwO
         udbA==
X-Received: by 10.70.129.106 with SMTP id nv10mr5146917pdb.160.1430988258623;
        Thu, 07 May 2015 01:44:18 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id wh6sm1369308pbc.96.2015.05.07.01.44.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 01:44:17 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268513>

Commit a8c9bef4 fully established the current advices given by git-pull
for the different cases where git-fetch will not have anything marked
for merge:

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

Notes:
    * Re-worded commit message to match the logic used in git-pull.sh's
      error_on_no_merge_candidates().
    
    * The tests have thus also been reordered to match the commit message.
    
    * Non-hackish solution for case 3a.
    
    * Add more checks to ensure that git-pull does not touch any files it
      should not be touching on failure.

 t/t5520-pull.sh | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 7efd45b..5add900 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -109,6 +109,61 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	test `cat file` = modified
 '
 
+test_expect_success 'fail if wildcard spec does not match any refs' '
+	git checkout -b test copy^ &&
+	test_when_finished "git checkout -f copy && git branch -D test" &&
+	test `cat file` = file &&
+	test_must_fail git pull . "refs/nonexisting1/*:refs/nonexisting2/*" 2>out &&
+	test_i18ngrep "no candidates for merging" out &&
+	test `cat file` = file
+'
+
+test_expect_success 'fail if no branches specified with non-default remote' '
+	git remote add test_remote . &&
+	test_when_finished "git remote remove test_remote" &&
+	git checkout -b test copy^ &&
+	test_when_finished "git checkout -f copy && git branch -D test" &&
+	test `cat file` = file &&
+	test_config branch.test.remote origin &&
+	test_must_fail git pull test_remote 2>out &&
+	test_i18ngrep "specify a branch on the command line" out &&
+	test `cat file` = file
+'
+
+test_expect_success 'fail if not on a branch' '
+	git remote add origin . &&
+	test_when_finished "git remote remove origin" &&
+	git checkout HEAD^ &&
+	test_when_finished "git checkout -f copy" &&
+	test `cat file` = file &&
+	test_must_fail git pull 2>out &&
+	test_i18ngrep "not currently on a branch" out &&
+	test `cat file` = file
+'
+
+test_expect_success 'fail if no configuration for current branch' '
+	git remote add test_remote . &&
+	test_when_finished "git remote remove test_remote" &&
+	git checkout -b test copy^ &&
+	test_when_finished "git checkout -f copy && git branch -D test" &&
+	test_config branch.test.remote test_remote &&
+	test `cat file` = file &&
+	test_must_fail git pull 2>out &&
+	test_i18ngrep "no tracking information" out &&
+	test `cat file` = file
+'
+
+test_expect_success 'fail if upstream branch does not exist' '
+	git checkout -b test copy^ &&
+	test_when_finished "git checkout -f copy && git branch -D test" &&
+	test_config branch.test.remote . &&
+	test_config branch.test.merge refs/heads/nonexisting &&
+	test `cat file` = file &&
+	test_must_fail git pull 2>out &&
+	test_i18ngrep "no such ref was fetched" out &&
+	test `cat file` = file
+'
+
 test_expect_success '--rebase' '
 	git branch to-rebase &&
 	echo modified again > file &&
-- 
2.1.4
