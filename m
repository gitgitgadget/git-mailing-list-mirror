From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 31/47] remote-hg: add test for diverged push
Date: Mon, 13 May 2013 23:36:54 -0500
Message-ID: <1368506230-19614-32-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:40:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc72i-0004oJ-B0
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880Ab3ENEkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:40:23 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:58610 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863Ab3ENEkV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:21 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so102601oag.31
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=sy4943a/MZ0WYMLnxe43ZZoSxvLQJ746OX+m2kRWSzk=;
        b=h93R/9bwP5mwL5ShtyjdIMoJTwdo95W6wuo2JrMcbHNI+dpa6XlAnHDCkT1bZeZxew
         BJYYGhn7uCkJ/UQJW4TlpL9OtYpdg/NmmSx7F6zA0TkzUnXh0lyNWpkcvHSTfd8SGPM7
         9pGOBVDiE9BhMTFOnPRUKOOHU6rBLxEG1lave1prKnVv3Wv27Q/NJkqhbb2MfCgyj5dq
         vH/kC6FmqP0p37mNSsYW69MR21P/qyfDSNDhIBvle7Yoaw+Hi53eH9IKpXtPL073ubiV
         o+zDerwEDKfWPXXCvilosflQmEZ6JuKygy2fsumeKna8pWD3VGM02+Iwe9sVYuWsw11A
         nxuw==
X-Received: by 10.60.85.42 with SMTP id e10mr9738116oez.111.1368506421091;
        Mon, 13 May 2013 21:40:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n5sm19990504obi.8.2013.05.13.21.40.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224263>

Neither mercurial nor git allows pushing to a remote when it's a
non-fast-forward push. We should be able to detect theses errors and
report them properly.

As opposed to throwing an exception stack-trace.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 5e4f53f..06700a8 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -32,6 +32,12 @@ check_bookmark () {
 	test_cmp expected actual
 }
 
+check_branch () {
+	echo $3 > expected &&
+	hg -R $1 log -r $2 --template '{desc}\n' > actual &&
+	test_cmp expected actual
+}
+
 setup () {
 	(
 	echo "[ui]"
@@ -252,4 +258,27 @@ test_expect_success 'remote new bookmark' '
 	check_bookmark hgrepo feature-b feature-b
 '
 
+test_expect_failure 'remote push diverged' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	git clone "hg::hgrepo" gitrepo &&
+
+	(
+	cd hgrepo &&
+	hg checkout default &&
+	echo bump > content &&
+	hg commit -m bump
+	) &&
+
+	(
+	cd gitrepo &&
+	echo diverge > content &&
+	git commit -a -m diverged &&
+	test_expect_code 1 git push 2> error &&
+	grep "^ ! \[rejected\] *master -> master (non-fast-forward)$" error
+	) &&
+
+	check_branch hgrepo default bump
+'
+
 test_done
-- 
1.8.3.rc1.579.g184e698
