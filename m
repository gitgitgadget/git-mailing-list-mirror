From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Subject: [PATCH v2 2/2] Added test cases for git reset -
Date: Mon,  9 Mar 2015 13:45:36 +0530
Message-ID: <1425888936-23370-2-git-send-email-sudshekhar02@gmail.com>
References: <1425888936-23370-1-git-send-email-sudshekhar02@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com, davvid@gmail.com,
	sunshine@sunshineco.com, Sudhanshu Shekhar <sudshekhar02@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 09:16:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUsrI-0001Nt-Jh
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 09:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbbCIIQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 04:16:07 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36867 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbbCIIQE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 04:16:04 -0400
Received: by paceu11 with SMTP id eu11so56944723pac.4
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 01:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hXl3pPyEUjIBEcr7qWZBBB0YXrzg4lJIoV425Klh/+Y=;
        b=xs3wa+NfaLWzTG7Wbr0mAc0JITGXaLCNg4ForAQfhEXaek6UEoHP27YGbli3K3nrlw
         Zd1OaUHP2Yy1tSVyDCdefXt0wH6b5npuQ95KpjjJ9aRIChyIejiVj+xHrGwqqb6xWggz
         j4hsEuUFdmDD+CaVIWz1IZi/34/FZKC6SFUYRfUqVpugM/3eWWPHv7JaceIonaEyo301
         4SfYoUTqwUqtIyfjh9GgqkB7CKoke3pNPLRpxqFpMikRNLIOtLO2DZxTS46qGgU4Aod9
         o2/hj+ci/u3VxXWNeT2Gc3PqqaV7Igh4KC/ONseWwanJWF3P9xWDBQpsRag2oFzcoKwp
         /LUQ==
X-Received: by 10.66.100.138 with SMTP id ey10mr46330456pab.142.1425888964030;
        Mon, 09 Mar 2015 01:16:04 -0700 (PDT)
Received: from shekhar-Inspiron-N5110.iiit.ac.in ([14.139.82.6])
        by mx.google.com with ESMTPSA id d4sm17782033pdm.50.2015.03.09.01.16.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Mar 2015 01:16:02 -0700 (PDT)
X-Mailer: git-send-email 2.3.1.168.g0c82976.dirty
In-Reply-To: <1425888936-23370-1-git-send-email-sudshekhar02@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265135>

1) Confirm error message when git reset is used with no previous branch
2) Confirm git reset - works like git reset @{-1}
3) Confirm "-" is always treated as a commit unless the -- file option
is specified

Signed-off-by: Sudhanshu Shekhar<sudshekhar02@gmail.com>
Thanks-to: David Aguilar<davvid@gmail.com>
---
David, thank you for your remarks. I have tried to incorporate your suggestions into this patch.
Please let me know if I have missed out on anything else.

 t/t7102-reset.sh | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 98bcfe2..fe43f64 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -568,4 +568,125 @@ test_expect_success 'reset --mixed sets up work tree' '
 	test_cmp expect actual
 '
 
+cat >expect <<EOF
+fatal: bad flag '-' used after filename
+EOF
+
+test_expect_success 'reset - with no previous branch' '
+	git init no_previous --quiet &&
+	(
+		cd no_previous &&
+		test_must_fail git reset - 2>output
+	) &&
+	test_cmp expect no_previous/output
+'
+
+test_expect_success 'reset - while having file named - and no previous branch' '
+	git init no_previous --quiet &&
+	(
+		cd no_previous &&
+		touch ./- &&
+		test_must_fail git reset - 2>output
+	) &&
+	test_cmp expect no_previous/output
+'
+
+cat >expect <<EOF
+Unstaged changes after reset:
+M	-
+M	1
+EOF
+
+test_expect_success 'reset - in the prescence of file named - with previous branch' '
+	git init no_previous --quiet &&
+	(
+		cd no_previous &&
+		touch ./- 1 &&
+		git add 1 - &&
+		git commit -m "add base files" &&
+		git checkout -b new_branch &&
+		echo "random" >./- &&
+		echo "wow" >1 &&
+		git add 1 - &&
+		git reset - >../output
+	) &&
+	rm -rf no_previous &&
+	test_cmp output expect
+'
+test_expect_success 'reset - in the presence of file named - with -- option' '
+	git init no_previous --quiet &&
+	(
+		cd no_previous &&
+		touch ./- 1 &&
+		git add 1 - &&
+		git commit -m "add base files" &&
+		git checkout -b new_branch &&
+		echo "random" >./- &&
+		echo "wow" >1 &&
+		git add 1 - &&
+		git reset - -- >../output
+	) &&
+	rm -rf no_previous &&
+	test_cmp output expect
+'
+
+cat >expect <<EOF
+Unstaged changes after reset:
+M	-
+EOF
+
+test_expect_success 'reset - in the presence of file named - with -- file option' '
+	git init no_previous --quiet &&
+	(
+		cd no_previous &&
+		touch ./- 1 &&
+		git add 1 - &&
+		git commit -m "add base files" &&
+		git checkout -b new_branch &&
+		echo "random" >./- &&
+		echo "wow" >1 &&
+		git add 1 - &&
+		git reset -- - >../output
+	) &&
+	rm -rf no_previous
+	test_cmp output expect
+'
+test_expect_success 'reset - in the presence of file named - with both pre and post -- option' '
+	git init no_previous --quiet &&
+	(
+		cd no_previous &&
+		touch ./- 1 &&
+		git add 1 - &&
+		git commit -m "add base files" &&
+		git checkout -b new_branch &&
+		echo "random" >./- &&
+		echo "wow" >1 &&
+		git add 1 - &&
+		git reset - -- - >../output
+	) &&
+	rm -rf no_previous
+	test_cmp output expect
+'
+
+test_expect_success 'reset - works same as reset @{-1}' '
+	git init no_previous --quiet &&
+	(
+		cd no_previous &&
+		echo "random" >random &&
+		git add random &&
+		git commit -m "base commit" &&
+		git checkout -b temp &&
+		echo new-file >new-file &&
+		git add new-file &&
+		git commit -m "added new-file" &&
+		git reset - &&
+		git status --porcelain >../first &&
+		git add new-file &&
+		git commit -m "added new-file" &&
+		git reset @{-1} &&
+		git status --porcelain >../second
+	) &&
+	test_cmp first second
+'
+
 test_done
-- 
2.3.1.168.g0c82976.dirty
