From: Sundararajan R <dyoucme@gmail.com>
Subject: [v2 PATCH 2/2] reset: add tests for git reset -
Date: Tue, 10 Mar 2015 21:08:03 +0530
Message-ID: <1426001883-6423-2-git-send-email-dyoucme@gmail.com>
References: <1426001883-6423-1-git-send-email-dyoucme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sundararajan R <dyoucme@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 16:38:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVMF4-00049x-8O
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 16:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbbCJPim convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 11:38:42 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:40957 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbbCJPij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 11:38:39 -0400
Received: by padfb1 with SMTP id fb1so3173808pad.7
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5qMO162i9y9+AgQc/SZLGlfK7Vgp67je27bCzaArK8I=;
        b=oluVJ1HWh7fEhZpk/K0bFOt0aIJIHvWludFQMtl07MrlX6ySGzh2WssRPEOsT0MIFN
         M+ZrMnOdsAY9BpGq0opwdeUgIzqNFkcL4NCgolkGvktVgGDul889n4lMi0Z+JsBylFvH
         vx78d7uCi9yrVBmmniB2sWqBrPShM55JzowE/1ZaqY3yYaEPpKiWWMAkgQ+CRnkPb2vt
         rVCgxH7F/Z7883Yh3xD5JaYViSrp5IKLXki7Eqat1kWa3uySQx7tNz/C3WvPCWxK8RSx
         golgVhVaDPNN00TjqRNL0ZJSP292V3rGQKyEQgrgpB3QEysPxqoXoA/vC4mMMpR7/z9H
         tBPw==
X-Received: by 10.66.216.40 with SMTP id on8mr19863084pac.27.1426001919031;
        Tue, 10 Mar 2015 08:38:39 -0700 (PDT)
Received: from work.localdomain ([210.212.66.19])
        by mx.google.com with ESMTPSA id g11sm1641012pat.24.2015.03.10.08.38.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2015 08:38:38 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1426001883-6423-1-git-send-email-dyoucme@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265241>

The failure case which occurs on teaching git is taught the '-' shortha=
nd
is when there exists no branch pointed to by '@{-1}'.

The ambiguous cases occur when there exist files named '-' or '@{-1}' i=
n=20
the work tree. These are also treated as failure cases but here the use=
r
is given advice as to how he can proceed.

Add tests to check the handling of these cases.=20
Also add a test to verify that reset - behaves like reset @{-1} when no=
ne
of the above cases are true.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Torsten B=C3=83=C2=B6gershausen <tboegi@web.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Sundararajan R <dyoucme@gmail.com>
---
Thank you for your feedback Torsten and Eric.
I have now made the modifications suggested by you.
I have also incorporated the suggestions given by Matthieu on the archi=
ve.
Please let me know if there is something else I should add.

 t/t7102-reset.sh | 90 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 90 insertions(+)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 98bcfe2..c05dab0 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -568,4 +568,94 @@ test_expect_success 'reset --mixed sets up work tr=
ee' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'reset - with no @{-1} should fail' '
+	git init new &&
+	(
+		cd new &&
+		test_must_fail git reset - 2>actual
+	) &&
+	test_i18ngrep "unknown revision" new/actual=20
+	test_when_finished rm -rf new
+'
+
+test_expect_success 'reset - with no @{-1} and file named - should fai=
l' '
+	git init new &&
+	(
+		cd new &&
+		echo "Hello" >- &&
+		git add - &&
+		test_must_fail git reset - 2>actual=20
+	) &&
+	test_i18ngrep "both revision and filename" new/actual=20
+	test_when_finished rm -rf new
+'
+
+test_expect_success 'reset - with @{-1} and file named @{-1} should fa=
il' '
+	git init new &&
+	(
+		cd new &&=20
+		echo "Hello" >@{-1} &&
+		git add @{-1} &&
+		git commit -m "first_commit" &&
+		git checkout -b new_branch &&
+		>@{-1} &&
+		git add @{-1} &&
+		test_must_fail git reset - 2>actual=20
+	) &&
+	test_i18ngrep "both revision and filename" new/actual=20
+	test_when_finished rm -rf new
+'
+
+test_expect_success 'reset - with @{-1} and file named - should fail' =
'
+	git init new &&
+	(
+		cd new &&=20
+		echo "Hello" >- &&
+		git add - &&
+		git commit -m "first_commit" &&
+		git checkout -b new_branch &&
+		>- &&
+		git add - &&
+		test_must_fail git reset - 2>actual=20
+	) &&
+	test_i18ngrep "both revision and filename" new/actual=20
+	test_when_finished rm -rf new
+'
+
+test_expect_success 'reset - with @{-1} and file named @{-1} and - sho=
uld fail' '
+	git init new &&
+	(
+		cd new &&
+		>- &&
+		git add - &&
+		git commit -m "first_commit" &&
+		git checkout -b new_branch
+		>@{-1} &&
+		git add @{-1} &&
+		test_must_fail git reset - 2>actual
+	) &&
+ 	test_i18ngrep "both revision and filename" new/actual=20
+	test_when_finished rm -rf new
+'
+
+test_expect_success 'reset - with @{-1} and no file named - or @{-1} s=
hould succeed' '
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
+		git status -uno >file1 &&
+		git add new_file &&
+		git reset @{-1} &&
+		git status -uno >file2=20
+	) &&
+	test_cmp new/file1 new/file2=20
+	test_when_finished rm -rf new
+'
+
 test_done
--=20
2.1.0
