From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/11] completion: add file completion tests
Date: Sat, 27 Apr 2013 05:19:44 -0500
Message-ID: <1367057994-19887-2-git-send-email-felipe.contreras@gmail.com>
References: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 12:21:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW2Fy-0002wJ-An
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 12:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab3D0KVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 06:21:16 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:57392 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985Ab3D0KVP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 06:21:15 -0400
Received: by mail-oa0-f45.google.com with SMTP id o17so4779157oag.18
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 03:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=wZmq9Cg4/HNNVsMbgB67bVrlBowM861b3aFrvYBA5t4=;
        b=tXZmzcmLewlK2yzr/I1lSIzty6xYUDvA70dEuUXFNdn4IPvIdfsg2DSvtB4syCgpa8
         7aQgGiVBDyrgIat1kWM1/OrEsCod34x2zJgMGcCUnMReJgq4yd8EVqcVZHJj4OPV2d6x
         yHXUNIjsgNgtmIqGvz387qsgKQ89FzixepC1nY/3vzvyDf3U7UbT1RA/s3F0QrfKJymn
         tRY+qYxSe7Q+Z3x6TXkzPs6TA+G0jLoPC6vRiHoPoi66ihXPL8rL9khaNj1v3o9ydJU7
         jWEKcO70TDRGCecg5ZxSgC7zTKJC7KUzaHd1WveBozz4syYkfPYoBAL0A3TftvegKsN1
         cH2w==
X-Received: by 10.60.136.234 with SMTP id qd10mr4962431oeb.15.1367058074587;
        Sat, 27 Apr 2013 03:21:14 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id bh8sm4561470obb.11.2013.04.27.03.21.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 03:21:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222626>

The commit fea16b4 (git-completion.bash: add support for path
completion) introduced quite a few changes, without the usual tests.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 6d9d141..385e1e4 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -347,4 +347,72 @@ test_expect_success 'send-email' '
 	test_completion "git send-email ma" "master "
 '
 
+test_expect_success 'complete files' '
+	git init tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	echo "expected" > .gitignore &&
+	echo "out" >> .gitignore &&
+
+	git add .gitignore &&
+	test_completion "git commit " ".gitignore" &&
+
+	git commit -m ignore &&
+
+	touch new &&
+	test_completion "git add " "new" &&
+
+	git add new &&
+	git commit -a -m new &&
+	test_completion "git add " "" &&
+
+	git mv new modified &&
+	echo modify > modified &&
+	test_completion "git add " "modified" &&
+
+	touch untracked &&
+
+	: TODO .gitignore should not be here &&
+	test_completion "git rm " <<-\EOF &&
+	.gitignore
+	modified
+	EOF
+
+	test_completion "git clean " "untracked" &&
+
+	: TODO .gitignore should not be here &&
+	test_completion "git mv " <<-\EOF &&
+	.gitignore
+	modified
+	EOF
+
+	mkdir dir &&
+	touch dir/file-in-dir &&
+	git add dir/file-in-dir &&
+	git commit -m dir &&
+
+	mkdir untracked-dir &&
+
+	: TODO .gitignore should not be here &&
+	test_completion "git mv modified " <<-\EOF &&
+	.gitignore
+	dir
+	modified
+	untracked
+	untracked-dir
+	EOF
+
+	test_completion "git commit " "modified" &&
+
+	: TODO .gitignore should not be here &&
+	test_completion "git ls-files " <<-\EOF
+	.gitignore
+	dir
+	modified
+	EOF
+
+	touch momified &&
+	test_completion "git add mom" "momified"
+'
+
 test_done
-- 
1.8.2.1.1031.g2ee5873
