From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] t: remote-hg: add file operation tests
Date: Sat,  3 May 2014 21:16:52 -0500
Message-ID: <1399169814-20201-3-git-send-email-felipe.contreras@gmail.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 04:27:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgm9k-0005zA-LL
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 04:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbaEDC1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 22:27:42 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51636 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbaEDC1l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 22:27:41 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so178554obc.33
        for <git@vger.kernel.org>; Sat, 03 May 2014 19:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FrzIcScTjMICnIKbZasvcRZuIbntZ44Q6f7a6UB6j/U=;
        b=Iw6QKmb31D3LAqTTA6FfIbyJvrRf60PZNa2E0YbF0xFRBZrGLNaGeUnxhtzwwKWTZU
         scN3kVu2qMs74oJvwNNoNVWTJ+Ne0DQwZTUoBFeMxYpXvd3FqPdjcLIaPTI6G6/pQlas
         ldaiHjJ/O9I17Itg+kIrsyNjMVTUcJLN6/BPc4Tm5geYhrkWw+OWevDy1vMPpzahwLOZ
         tsMNLrd3/ZhZhjkv1WCFXPNH/zecyz3vHSK1BB3mJroBKqwu/UiD5iYNMm10BP1JjjC3
         he1VjKA1qem6TJhqyf2Mpg/2hTAepOEs30DKhdy4btJAwOtTUb9DrsSNNq818gA8IGzC
         pn3g==
X-Received: by 10.60.93.168 with SMTP id cv8mr25364598oeb.21.1399170460968;
        Sat, 03 May 2014 19:27:40 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ub1sm17512396oeb.9.2014.05.03.19.27.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 May 2014 19:27:40 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.20.g204a630
In-Reply-To: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248066>

Inspired by gitifyhg.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 76 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 33a434d..df09966 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -53,6 +53,17 @@ check_bookmark () {
 	fi
 }
 
+check_files () {
+	git --git-dir=$1/.git ls-files > actual &&
+	if test $# -gt 1
+	then
+		printf "%s\n" "$2" > expected
+	else
+		> expected
+	fi &&
+	test_cmp expected actual
+}
+
 check_push () {
 	expected_ret=$1 ret=0 ref_ret=0
 
@@ -995,4 +1006,69 @@ test_expect_success 'push tag different branch' '
 	test_cmp expected actual
 '
 
+test_expect_success 'cloning a removed file works' '
+	test_when_finished "rm -rf hgrepo gitrepo" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+
+	echo test > test_file &&
+	hg add test_file &&
+	hg commit -m add &&
+
+	hg rm test_file &&
+	hg commit -m remove
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+	check_files gitrepo
+'
+
+test_expect_success 'cloning a file replaced with a directory' '
+	test_when_finished "rm -rf hgrepo gitrepo" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+
+	echo test > dir_or_file &&
+	hg add dir_or_file &&
+	hg commit -m add &&
+
+	hg rm dir_or_file &&
+	mkdir dir_or_file &&
+	echo test > dir_or_file/test_file &&
+	hg add dir_or_file/test_file &&
+	hg commit -m replase
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+	check_files gitrepo "dir_or_file/test_file"
+'
+
+test_expect_success 'clone replace directory with a file' '
+	test_when_finished "rm -rf hgrepo gitrepo" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+
+	mkdir dir_or_file &&
+	echo test > dir_or_file/test_file &&
+	hg add dir_or_file/test_file &&
+	hg commit -m add &&
+
+	hg rm dir_or_file/test_file &&
+	echo test > dir_or_file &&
+	hg add dir_or_file &&
+	hg commit -m add &&
+
+	hg rm dir_or_file
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+	check_files gitrepo "dir_or_file"
+'
+
 test_done
-- 
1.9.2+fc1.20.g204a630
