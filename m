From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/9] completion: add file completion tests
Date: Sat, 27 Apr 2013 15:09:59 -0500
Message-ID: <1367093407-8898-2-git-send-email-felipe.contreras@gmail.com>
References: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 22:11:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWBT7-00008y-AR
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 22:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970Ab3D0UL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 16:11:29 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:37821 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835Ab3D0UL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 16:11:28 -0400
Received: by mail-oa0-f45.google.com with SMTP id o17so4915636oag.4
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=wZmq9Cg4/HNNVsMbgB67bVrlBowM861b3aFrvYBA5t4=;
        b=T+DtxMp7x4UUjW0oHmIo6HmYycupLK3caFr08wPFI3WCke0A2kli8+aXzCh9mtEMkC
         f0KdxSlWXDcLA4qFIyd2ODscnIL2uEAAFZt+3AdefEmqfwpQ42Ph7hKzc6O0KLXtcBd1
         fENAGLTAYdd5QRwoDwcRNDiHR37MW9pWFgYnpPovmRpX81umHZlncwffnLBkaQcscPeO
         syueOk6/LrnYiz1hW6c5wwLAfeVwHIFYlXXDhVOT6wmCctLncLbFpaBZlfbiutqRH6J/
         FlZIqycREMpTYe1OyJFDo8f7hdK0NBL6b/ipuDqgIhtDJ/6EBnijWToRfFiMthjDdElK
         iTrA==
X-Received: by 10.60.131.98 with SMTP id ol2mr20434949oeb.37.1367093487880;
        Sat, 27 Apr 2013 13:11:27 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id qt5sm13793871oeb.4.2013.04.27.13.11.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 13:11:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222684>

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
