From: Sundararajan R <dyoucme@gmail.com>
Subject: [v3 PATCH 2/2] reset: add tests for git reset -
Date: Wed, 18 Mar 2015 14:05:09 +0530
Message-ID: <1426667709-26698-1-git-send-email-dyoucme@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sundararajan R <dyoucme@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 09:35:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY9Ru-0000lT-Jm
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 09:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbbCRIf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 04:35:29 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36703 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbbCRIf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 04:35:27 -0400
Received: by pdbcz9 with SMTP id cz9so36445299pdb.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Bij0B7BlYQp8iIIxonmRf9e2h+H4zw8m5xwWL/pzm18=;
        b=wdckfmbEq0iWhoZBcBq4KsX7k3KkUsIZ13BYgULN2cmBuyAs3ixMgH3+5n8j/F2Dcq
         sGlomVmM/M6CTsn/3bn4vyzhkJjHknT/Zwmk4186YIy5DaAm0keBueGJJm6BgHBkY5hN
         PqVl/7/Fmz0U3xkKp9C3hTI4Ov+rwLZhotj1jVt4dBtSitpYv+EzA6lh8auRyT9q0H+J
         YOh/ikQxCVfE0B0RltD6/1oqgAZpMI8pIbSgQrrSCXrCUbhsLHPO0tD8xxcbuf2f36lV
         xB6IwLE6PxyUfYQib1jbjYb1o0FCXnUwaUcsOxMa9TqVf76anjJ+8/f61pb/DFAE6cX4
         aYjA==
X-Received: by 10.70.102.8 with SMTP id fk8mr38820569pdb.141.1426667727151;
        Wed, 18 Mar 2015 01:35:27 -0700 (PDT)
Received: from work.localdomain ([210.212.66.19])
        by mx.google.com with ESMTPSA id qm6sm26280241pac.14.2015.03.18.01.35.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 01:35:26 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265696>

The failure case which occurs on teaching git is taught the '-' shorthand
is when there exists no branch pointed to by '@{-1}'. But, if there is a file
named - in the working tree, the user can be unambiguously assumed to be 
referring to it while issuing this command.

The ambiguous case occurs when the @{-1} branch exists and file named '-' also
exists in the working tree. This are also treated as a failure case but here 
the user is given advice as to how he can proceed.

Another potentially tricky case is when the file '@{-1}' exists. In this case,
the command should succeed as the user doesn't mention the file '@{-1}' and can
be safely assumed to be referring to the @{-1} branch.

Add tests to check the handling of these cases.
Also add a test to verify that reset - behaves like reset @{-1} when none
of the above cases are true.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Sundararajan R <dyoucme@gmail.com>
---
Thank you for your feedback Torsten and Eric. I have made modifications suggested 
by you. I have also acted on Matthieu's suggestions on the archive.
Please let me know if there is something else I should add.
I have also removed one irrelevant test from  which we come to know of nothing new.

 t/t7102-reset.sh | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 98bcfe2..f5a8e76 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -568,4 +568,79 @@ test_expect_success 'reset --mixed sets up work tree' '
 	test_cmp expect actual
 '
 
+test_expect_success 'reset - with no @{-1} branch should fail' '
+	test_when_finished rm -rf new &&
+	git init new &&
+	(
+		cd new &&
+		test_must_fail git reset - 2>../actual
+	) && 
+	test_i18ngrep "bad flag" actual 
+'
+
+test_expect_success 'reset - with no @{-1} branch and file named - should succeed' '
+	test_when_finished rm -rf new &&
+	>expected &&
+	git init new &&
+	(
+		cd new &&
+		echo "Hello" >- &&
+		git add - &&
+		git reset - >../actual 
+	) &&
+	test_cmp expected actual
+'
+
+test_expect_success 'reset - with @{-1} branch and file named - should fail' '
+	test_when_finished rm -rf new &&
+	git init new &&
+	(
+		cd new && 
+		echo "Hello" >- &&
+		git add - &&
+		git commit -m "first_commit" &&
+		git checkout -b new_branch &&
+		>- &&
+		git add - &&
+		test_must_fail git reset - 2>../actual 
+	) &&
+	test_i18ngrep "ambiguous argument" actual 
+'
+
+test_expect_success 'reset - with @{-1} branch and file named @{-1} should succeed' '
+	test_when_finished rm -rf new &&
+	git init new &&
+	(
+		cd new && 
+		echo "Hello" >@{-1} &&
+		git add @{-1} &&
+		git commit -m "first_commit" &&
+		git checkout -b new_branch &&
+		>@{-1} &&
+		git add @{-1} &&
+		git reset - >../actual 
+	) &&
+	test_i18ngrep "Unstaged" actual 
+'
+
+test_expect_success 'reset - with @{-1} branch and no file named - should succeed' '
+	test_when_finished rm -rf new &&
+	git init new &&
+	(
+		cd new &&
+		echo "Hey" >new_file &&
+		git add new_file &&
+		git commit -m "first_commit" &&
+		git checkout -b new_branch &&
+		>new_file &&
+		git add new_file &&
+		git reset - &&
+		git status -uno >actual &&
+		git add new_file &&
+		git reset @{-1} &&
+		git status -uno >expected &&
+		test_cmp actual expected 
+	)
+'
+
 test_done
-- 
2.1.0
