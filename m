From: Sundararajan R <dyoucme@gmail.com>
Subject: [PATCH v4 2/2] reset: add tests for git reset -
Date: Fri, 27 Mar 2015 14:34:55 +0530
Message-ID: <1427447095-22851-2-git-send-email-dyoucme@gmail.com>
References: <1427447095-22851-1-git-send-email-dyoucme@gmail.com>
Cc: Sundararajan R <dyoucme@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 10:05:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbQCs-0004j2-9f
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 10:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbbC0JFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 05:05:30 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36742 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172AbbC0JF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 05:05:27 -0400
Received: by pdbcz9 with SMTP id cz9so90489269pdb.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 02:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=21Q35AgdYP8VHvqqtb88MAPRJ1M9c2dXTSBFapnxjyU=;
        b=lCjOn+DpVhfFagU0Q2gnO3qLTc3uKGbTdO83/QhK03Nh2T7SanBwMe1FYP2eXktxqa
         OHsaJ39YznKOAt4j4z+NN4WXYoUInS4XuLMS3fusG5jpEkhFit2xm1WGIzIEGVj7ZIEU
         yUKyc+zlYMEzLG+Is00L0+MWsI+udqrsP8JUUnVkulbNWq88xiJKRiEiq2UvqalvQKjG
         jvT6b5QOuJoI8CFuv2chG/Go2Bje+o5B7q+tOz++YhJ3xz5QLKxfSWNWIjBoY9zq5ziq
         xaHhJnqZZS+TDOnpcE+3rVabtbnXn4ZDKrVKLSJEEHP+2uOoLma38CaR+w6Lgql9VMtW
         aTlQ==
X-Received: by 10.66.102.99 with SMTP id fn3mr33817481pab.118.1427447126261;
        Fri, 27 Mar 2015 02:05:26 -0700 (PDT)
Received: from work.localdomain ([210.212.66.19])
        by mx.google.com with ESMTPSA id fm3sm1463962pdb.73.2015.03.27.02.05.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2015 02:05:25 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1427447095-22851-1-git-send-email-dyoucme@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266365>

The failure case which occurs on teaching git the '-' shorthand
is when there exists no branch pointed to by '@{-1}'. In this case, if there 
is a file named - in the working tree, the user can be unambiguously 
assumed to be referring to it while issuing this command.

The ambiguous case occurs when the @{-1} branch exists and file named '-' also
exists in the working tree. This are also treated as a failure case but here 
the user is given advice as to how he can proceed.

Another potentially tricky case is when the file '@{-1}' exists. In this case,
the command should succeed as the user hasn't mentioned the file '@{-1}' and can
be safely assumed to be referring to the @{-1} branch.

Add tests to check the handling of these cases.
Also add a test to verify that reset - behaves like reset @{-1} when none
of the above cases are true.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Sundararajan R <dyoucme@gmail.com>
---
Have made the edits suggested by Matthew and Kevin.

 t/t7102-reset.sh | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 98bcfe2..a605c32 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -568,4 +568,78 @@ test_expect_success 'reset --mixed sets up work tree' '
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
+	git init new &&
+	(
+		cd new &&
+		echo "Hello" >- &&
+		git add - &&
+		git reset - >../actual 
+	) &&
+	test_must_be_empty actual
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
+		git status -uno --porcelain >actual &&
+		git add new_file &&
+		git reset @{-1} &&
+		git status -uno --porcelain >expected &&
+		test_cmp actual expected 
+	)
+'
+
 test_done
-- 
2.1.0
