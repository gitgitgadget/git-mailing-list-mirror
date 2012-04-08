From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/12] tests: add more bash completion tests
Date: Sun,  8 Apr 2012 06:07:53 +0300
Message-ID: <1333854479-23260-7-git-send-email-felipe.contreras@gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 05:09:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGiVQ-0007R6-Ty
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 05:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467Ab2DHDIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 23:08:54 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54731 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210Ab2DHDI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 23:08:29 -0400
Received: by mail-lb0-f174.google.com with SMTP id gg6so1342002lbb.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 20:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mVsjrqwjbhZVN3rd7S7ONO2TrIgTmgS6fNPvusM/I7c=;
        b=pxhkc53LAsCoJsvLMZqC1sv5B8+fTfMVzVDADkni7smNBHa/Olz7eN4pJ8eOGQe/Ml
         G8krFCGdgmAEV+VkAKyJ5G+mAIcYdzo+yO18ks0SwnoctfCLMLyNa9SjYthHlEx+TnQ+
         cXv3Vf5vAqxiI8FUugStBXvGZIv5iBvOa/u/taXbBMgaHVDlT1aZzFJA0NGcrXLYNyf0
         pj6DUiy7kt76AF/4Qq8xx/LokVocLPJQcyYaiZpEYE0EuTEsJUGe/lo93pSGGhKZqFEB
         fejdfky9G6jc74BCG6konG9HfMysO+kkxWXku7snxld2k06CVACZwng2hglYPsfW9usn
         2G0w==
Received: by 10.152.111.164 with SMTP id ij4mr2571724lab.19.1333854508681;
        Sat, 07 Apr 2012 20:08:28 -0700 (PDT)
Received: from localhost (84-231-195-184.elisa-mobile.fi. [84.231.195.184])
        by mx.google.com with ESMTPS id o6sm15521778lbo.4.2012.04.07.20.08.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 20:08:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.3.g5a738d
In-Reply-To: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194968>

These tests try to excercise code that deals with 'words' and 'cword'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh |   55 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index ee5654d..f1b660f 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -62,6 +62,22 @@ test_completion ()
 	test_cmp expected out
 }
 
+setup_repository ()
+{
+	mkdir "$1" && (
+	cd "$1" &&
+	git init &&
+	test_tick &&
+	git commit --allow-empty -m "Initial"
+	)
+}
+
+test_expect_success 'prepare' '
+	setup_repository one &&
+	git clone one test &&
+	cd test
+'
+
 test_expect_success 'basic' '
 	cat >expected <<-\EOF &&
 	help 
@@ -229,4 +245,43 @@ test_expect_success 'general options plus command' '
 	test_completion "git --no-replace-objects check" "checkout "
 '
 
+test_expect_success 'remote or refspec' '
+	test_completion "git fetch o" "origin " &&
+	test_completion "git fetch origin m" "master:master " &&
+	test_completion "git pull o" "origin " &&
+	test_completion "git pull origin m" "master " &&
+	test_completion "git push o" "origin " &&
+	test_completion "git push origin m" "master "
+'
+
+test_expect_success 'subcomands' '
+	test_completion "git bisect st" "start "
+'
+
+test_expect_success 'has double dash' '
+	test_completion "git add -- foo" ""
+'
+
+test_expect_success 'config' '
+	git config --file=foo color.ui auto &&
+	test_completion "git config --file=foo --get c" "color.ui "
+'
+
+test_expect_success 'other' '
+	cat >expected <<-\EOF &&
+	origin/HEAD 
+	origin/master 
+	EOF
+	test_completion "git branch -r o" &&
+	test_completion "git bundle cr" "create " &&
+
+	echo foobar > tags &&
+	test_completion "git grep f" "foobar " &&
+
+	test_completion "git notes --ref m" "master " &&
+
+	git tag v0.1 &&
+	test_completion "git tag -d v" "v0.1 "
+'
+
 test_done
-- 
1.7.10.3.g5a738d
