From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Subject: [PATCH 2/2] Added test cases for git reset -
Date: Sun,  8 Mar 2015 20:28:40 +0530
Message-ID: <1425826720-5899-2-git-send-email-sudshekhar02@gmail.com>
References: <vpqioeb22y8.fsf@anie.imag.fr>
 <1425826720-5899-1-git-send-email-sudshekhar02@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com,
	Sudhanshu Shekhar <sudshekhar02@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 15:59:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUcgL-0000f2-Vs
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 15:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbbCHO7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 10:59:50 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47078 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbbCHO7t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 10:59:49 -0400
Received: by pabli10 with SMTP id li10so65915894pab.13
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=APO13Z1hzlp+jApc+KgDes23aj8MuGdktxUaDRXHsq8=;
        b=s2DmzxLJI8Edj+El8vSUGrQ7IEIZpv99FfsqAxZRPKCOPlosY4mCnWvN0qTqK+Usj2
         pFwvBvARK8afpkWheh5x3bPdQ3ld5cMUYTI5BCTBQ8hrl/kGMdtYHwc0EjIPeq2uowEo
         m54B4rLax/5L4bVCIVoe4PhvxoPsKJnHBW8WhTNSqdVB4SNJli3QOeDZJAOtnuqyxeup
         xPwYGLKdi15rwKQ1DNb8yu2m4lzNC/noe3lI1iYguBeorRS8eXRWs0PHACimEH2l0GtJ
         jMj96BLLApT3em9jRPAZFyMFE0Ie/jg0zzND2rWa25aw6WNPGktK6e0q+6NDNBul7bJH
         edHg==
X-Received: by 10.66.124.164 with SMTP id mj4mr43610256pab.83.1425826788783;
        Sun, 08 Mar 2015 07:59:48 -0700 (PDT)
Received: from shekhar-Inspiron-N5110.iiit.ac.in ([14.139.82.6])
        by mx.google.com with ESMTPSA id 1sm6975875pdi.38.2015.03.08.07.59.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Mar 2015 07:59:47 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.168.g0c82976.dirty
In-Reply-To: <1425826720-5899-1-git-send-email-sudshekhar02@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265091>

Four test cases have been added

1) when user does reset - without any previous branch => Leads to error
2) when user does reset - with a previous branch      => Ensure it
behaves like  <at> {-1}

Other two deal with the situation when we have a file named '-'. We
ignore such a file and - is always treated either as a previous branch
or a bad filename. Users who wish to reset a file named '-' should
specify
it as './-'

Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
---
I have created test cases for git reset -. @Junio, I tried incorporating your suggestions while developing these test cases.
However, since the verify_filename function ignores files starting with "-", git reset - will always refer to the branch only. Kindly let me know your thoughts and views on this and also your reviews about the test cases I have created.

Regards,
Sudhanshu

 t/t7102-reset.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 98bcfe2..ade3d6a 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -568,4 +568,66 @@ test_expect_success 'reset --mixed sets up work tree' '
 	test_cmp expect actual
 '
 
+cat > expect << EOF
+fatal: bad flag '-' used after filename
+EOF
+
+test_expect_success 'reset - with no previous branch' '
+	git init no_previous --quiet &&
+	(
+	cd no_previous
+	) &&
+	test_must_fail git reset - 2>output &&
+	test_cmp expect output
+'
+
+test_expect_success 'reset - while having file named - and no previous branch' '
+	git init no_previous --quiet &&
+	(
+	cd no_previous &&
+	touch ./-
+	) &&
+	test_must_fail git reset - 2>output &&
+	test_cmp expect output
+'
+
+cat > expect << EOF
+Unstaged changes after reset:
+M	-
+M	1
+EOF
+
+test_expect_success 'reset - in the prescence of file named - with previou branch' '
+	git init no_previous --quiet &&
+	cd no_previous &&
+	touch ./- 1 &&
+	git add 1 - &&
+	git commit -m "add base files" &&
+	git checkout -b new_branch &&
+	echo "random" >./- &&
+	echo "wow" >1 &&
+	git add 1 - &&
+	git reset - >output &&
+	test_cmp output ../expect
+'
+test_expect_success 'reset - works same as reset @{-1}' '
+	git init no_previous --quiet &&
+	cd no_previous &&
+	echo "random" >random &&
+	git add random &&
+	git commit -m "base commit" &&
+	git checkout -b temp &&
+	echo new-file >new-file &&
+	git add new-file &&
+	git commit -m "added new-file" &&
+	git reset - &&
+
+	git status >../first &&
+	git add new-file &&
+	git commit -m "added new-file" &&
+	git reset @{-1} &&
+	git status >../second &&
+	test_cmp ../first ../second
+'
+
 test_done
-- 
2.3.1.168.g0c82976.dirty
