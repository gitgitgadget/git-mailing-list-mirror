From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Subject: [PATCH v3 2/2] t7102: add 'reset -' tests
Date: Wed, 11 Mar 2015 03:40:09 +0530
Message-ID: <1426025409-18758-1-git-send-email-sudshekhar02@gmail.com>
References: <CAPig+cSU7X=1Ket8bAXU2JivaSVWw7C_M9ttAhJ_gQur3utsUA@mail.gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com,
	Matthieu.Moy@grenoble-inp.fr,
	Sudhanshu Shekhar <sudshekhar02@gmail.com>
To: sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Tue Mar 10 23:10:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVSMP-0002mA-HP
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 23:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbbCJWKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 18:10:41 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:44352 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbbCJWKj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 18:10:39 -0400
Received: by pdjz10 with SMTP id z10so5535491pdj.11
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 15:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UMlt3V1/DdAhRDU1zChOpXMhq9MjHgHwBXWTKEv7BjI=;
        b=EWcfQDz2sOKrjnSXAcmM5SbhH+ElQW0mXtst1B1s+QqJzoZ4TP0CkEOThhGqmEz+cJ
         VspG/AuCdFp8fzJFMIYbteQXxIk4xoQpdtH03ZoPZke7gE+LIsO9adxvbeQHf/dDfWKz
         WZ+jPf1qgLzzRy2eImzs5ECWwaT/GoZBjoNvPILtSAAw6h+vDs2qPkUqYsE1JurM2xZK
         dY6HkC4WMWDGyswCJnuILk1Tv0xQK6jDwvK1IfMjeZ69Z8RsCjc8+doNxajN6j4FPsVe
         fRoupJifwoBVjoOkRs1y68auKBbxXtc+7aBjPC5nw77Fj0c+H/8e2Fmj9EjWn5ABkde0
         Jbdw==
X-Received: by 10.70.61.202 with SMTP id s10mr44561383pdr.86.1426025439243;
        Tue, 10 Mar 2015 15:10:39 -0700 (PDT)
Received: from shekhar-Inspiron-N5110.iiit.ac.in ([14.139.82.6])
        by mx.google.com with ESMTPSA id z2sm2474955pde.94.2015.03.10.15.10.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Mar 2015 15:10:38 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.278.ge5c7b1f.dirty
In-Reply-To: <CAPig+cSU7X=1Ket8bAXU2JivaSVWw7C_M9ttAhJ_gQur3utsUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265268>

Add following test cases:

1) Confirm error message when git reset is used with no previous branch
2) Confirm git reset - works like git reset @{-1}
3) Confirm "-" is always treated as a commit unless the -- file option is specified
4) Confirm "git reset -" works normally even when a file named @{-1} is present

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Helped-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
---
First of all, thank you for being so incredibly patient and helpful. I am very grateful for your remarks and reviews. I have implemented your suggestions in this patch. Please let me know if I have missed out on anything else. Also, sorry for sending PATCH 1/2 on the wrong thread, I entered the Message-ID incorrectly (still getting used to send-email :/ ).

Regards,
Sudhanshu

 t/t7102-reset.sh | 159 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 98bcfe2..d3a5874 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -568,4 +568,163 @@ test_expect_success 'reset --mixed sets up work tree' '
 	test_cmp expect actual
 '
 
+test_expect_success 'reset - with no previous branch fails' '
+	git init no_previous &&
+	test_when_finished rm -rf no_previous &&
+	(
+		cd no_previous &&
+		test_must_fail git reset - 2>actual
+	) &&
+	test_i18ngrep "bad flag" no_previous/actual
+'
+
+test_expect_success 'reset - while having file named - and no previous branch fails' '
+	git init no_previous &&
+	test_when_finished rm -rf no_previous &&
+	(
+		cd no_previous &&
+		>- &&
+		test_must_fail git reset - 2>actual
+	) &&
+	test_i18ngrep "bad flag" no_previous/actual
+'
+
+test_expect_success \
+	'reset - in the presence of file named - with previous branch resets commit' '
+	cat >expect <<-\EOF
+	Unstaged changes after reset:
+	M	-
+	M	file
+	EOF &&
+	git init no_previous &&
+	test_when_finished rm -rf no_previous &&
+	(
+		cd no_previous &&
+		>- &&
+		>file &&
+		git add file - &&
+		git commit -m "add base files" &&
+		git checkout -b new_branch &&
+		echo "random" >- &&
+		echo "wow" >file &&
+		git add file - &&
+		git reset - >../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success \
+	'reset - in the presence of file named - with -- option resets commit' '
+	cat >expect <<-\EOF
+	Unstaged changes after reset:
+	M	-
+	M	file
+	EOF &&
+	git init no_previous &&
+	test_when_finished rm -rf no_previous &&
+	(
+		cd no_previous &&
+		>- &&
+		>file &&
+		git add file - &&
+		git commit -m "add base files" &&
+		git checkout -b new_branch &&
+		echo "random" >- &&
+		echo "wow" >file &&
+		git add file - &&
+		git reset - -- >../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success 'reset - in the presence of file named - with -- file option resets file' '
+	cat >expect <<-\EOF
+	Unstaged changes after reset:
+	M	-
+	M	file
+	EOF &&
+	git init no_previous &&
+	test_when_finished rm -rf no_previous &&
+	(
+		cd no_previous &&
+		>- &&
+		>file &&
+		git add file - &&
+		git commit -m "add base files" &&
+		git checkout -b new_branch &&
+		echo "random" >- &&
+		echo "wow" >file &&
+		git add file - &&
+		git reset -- - >../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success \
+	'reset - in the presence of file named - with both pre and post -- option resets file' '
+	cat >expect <<-\EOF
+	Unstaged changes after reset:" >expect &&
+	M	-
+	EOF &&
+	git init no_previous &&
+	test_when_finished rm -rf no_previous &&
+	(
+		cd no_previous &&
+		>- &&
+		>file &&
+		git add file - &&
+		git commit -m "add base files" &&
+		git checkout -b new_branch &&
+		echo "random" >- &&
+		echo "wow" >file &&
+		git add file - &&
+		git reset - -- - >../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success 'reset - works same as reset @{-1}' '
+	git init no_previous &&
+	test_when_finished rm -rf no_previous &&
+	(
+		cd no_previous &&
+		echo "file1" >file1 &&
+		git add file1 &&
+		git commit -m "base commit" &&
+		git checkout -b temp &&
+		echo "new file" >file &&
+		git add file &&
+		git commit -m "added file" &&
+		git reset - &&
+		git status --porcelain >../actual &&
+		git add file &&
+		git commit -m "added file" &&
+		git reset @{-1} &&
+		git status --porcelain >../expect
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success 'reset - with file named @{-1} succeeds' '
+	cat >expect <<EOF
+	Unstaged changes after reset:
+	M	file
+	M	@{-1}
+	EOF &&
+	git init no_previous &&
+	test_when_finished rm -rf no_previous &&
+	(
+		cd no_previous &&
+		echo "random" >@{-1} &&
+		echo "random" >file &&
+		git add @{-1} file &&
+		git commit -m "base commit" &&
+		git checkout -b new_branch &&
+		echo "additional stuff" >>file &&
+		echo "additional stuff" >>@{-1} &&
+		git add file @{-1} &&
+		git reset - >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.3.1.278.ge5c7b1f.dirty
