From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] t7610-mergetool: add test cases for tempfile behavior
Date: Tue,  8 Mar 2016 21:36:54 -0800
Message-ID: <1457501814-10599-1-git-send-email-davvid@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Charles Bailey <cbailey32@bloomberg.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 06:37:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adWoE-0005aH-9W
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 06:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbcCIFhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 00:37:18 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34328 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbcCIFg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 00:36:58 -0500
Received: by mail-pf0-f171.google.com with SMTP id 129so31043311pfw.1
        for <git@vger.kernel.org>; Tue, 08 Mar 2016 21:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0paLVGPwlag5/g9O+uQicoZmeOVkwlpT+WYWVOZnr7Y=;
        b=jEWNlsHFvgyhQtrtwz2XdkT0CS4+xeGzG9m1Ct3Whd8PryFikZCLFpRWygyJ8zKvWm
         6qw7Uq0xO7Grm0+kqAvPJUdMsjvw8BNFMR3I8S+hVrbpkt0/LPpkMuNu79gLhLlSUZdQ
         N+NAsSaZABJkKcOMuQKSMvEcfcXJ62J73ZtSpga8zurM9OD9NoC7sQDZ1rffm8ukGCQv
         Eehe6qX0f/vSOJvJyA/tN/jQC7Ouk0ZBLKcrkbWHHtxWRV35/cantuoov5wrzrbRMzIL
         Vc5ytKxpjufBgG9IygUx/WoL+zCF9fGMK0BXpvc26TKI3xFQ/MBCjbtWA1QaJsMGtxxg
         ppZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0paLVGPwlag5/g9O+uQicoZmeOVkwlpT+WYWVOZnr7Y=;
        b=hK1afsVSeb8PrOa/ZJL6uoLA3RAfh+hUCLR3MRIMe2ORgtZpbCiMZ7xwJYYjDz83Qq
         8/JMBLwQGfqNskIy2wk4rp+spcap3Vg3RSBWBSrrooMh3zjXCZV7H+hWnD+hnLgA8nba
         P+lGTI5bBpBFRr2efDSv83iU6tahBXY7cSbM6CoLfeCdYY/+xfgVn8VvtOS7cHa2E0+f
         sIpUWtWIo3VOlsieZxRi5MkyJPM0ci+mZ7mCNiwoisipJ8063Fq3dZxFMcfbNeDnX4RH
         QM+s0atxeHkbtHpC2PQ8px0MFEw5lraVoUa9R+xqLqxaFoS4ME9Iz2oEa9ZTgx4PEDmG
         1AJA==
X-Gm-Message-State: AD7BkJIE9S68Vi4DmRlo8zCv6poWcRdViaWnF8SBj7Ozbek8sYl2bLNtaMXmQ3dBSOugNQ==
X-Received: by 10.98.16.12 with SMTP id y12mr47941823pfi.6.1457501817335;
        Tue, 08 Mar 2016 21:36:57 -0800 (PST)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id 195sm8849186pfa.5.2016.03.08.21.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Mar 2016 21:36:56 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc1.3.g475af66.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288475>

Ensure that mergetool.keepTemporaries is honored when resolving
delete/delete conflicts.

Ensure that stderr stays empty, and that worktree directories
created by mergetool to are removed.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7610-mergetool.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index f1668be..cf2eceb 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -273,6 +273,40 @@ test_expect_success 'mergetool delete/delete conflict' '
 	git reset --hard HEAD
 '
 
+test_expect_success 'mergetool honors tempfile config for deleted files' '
+	test_config mergetool.keepTemporaries false &&
+	! git merge move-to-b &&
+	echo d | git mergetool a/a/file.txt &&
+	! test -d a &&
+	git reset --hard HEAD
+'
+
+test_expect_success 'mergetool produces no errors when keepBackup is used' '
+	test_config mergetool.keepBackup true &&
+	! git merge move-to-b &&
+	: >expect &&
+	echo d | git mergetool a/a/file.txt 2>actual &&
+	test_cmp expect actual &&
+	! test -d a &&
+	git reset --hard HEAD
+'
+
+test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
+	test_config mergetool.keepTemporaries true &&
+	! git merge move-to-b &&
+	! (echo a; echo n) | git mergetool a/a/file.txt &&
+	test -d a/a &&
+	cat  >expect <<\-EOF &&
+file_BASE_.txt
+file_LOCAL_.txt
+file_REMOTE_.txt
+-EOF
+	ls -1 a/a | sed -e "s/[0-9]*//g" >actual &&
+	test_cmp expect actual &&
+	git clean -fdx &&
+	git reset --hard HEAD
+'
+
 test_expect_success 'deleted vs modified submodule' '
 	git checkout -b test6 branch1 &&
 	git submodule update -N &&
-- 
2.8.0.rc1.3.g475af66.dirty
