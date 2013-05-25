From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 15/48] remote-hg: ensure remote rebasing works
Date: Fri, 24 May 2013 21:29:31 -0500
Message-ID: <1369449004-17981-16-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Hf-0001rE-L2
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087Ab3EYCcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:33 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:49445 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab3EYCc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:28 -0400
Received: by mail-oa0-f51.google.com with SMTP id f4so6960607oah.38
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=E4/ToX1xsOe6oZGdY+bsNliNI9qpmUAzMR+w4LF3SMs=;
        b=ie2j0daHKCB+tYkmcJvwOmCpg3YMMk7FGehjKnoDq7pAL4u1xXnsZ86s2py8js+lq0
         2hoqAtyOCqwPnjjLKvsQl1vD8D0xHKiTDtQMcsoSJdn9lwiI8SoFGPh9snHqJ7b5Z3fT
         8xV3KA7to+YgpJ/6YgNPQiA5g7WScZYTS4LCpc9DS92ARtTIGkcDSGCAt4yClGpas241
         wMBQWpYo385eA0FoX9yroYn+uoUwKvDrXoY9xCC7CM3J2tIeCAAPjBv03M3L60VbyqEt
         XqRCeJ4F6waXSbXgRwwY/AZHn7KSmfS9FchUQk9ggDxR05a+tLCCmBIvOR1xPOOpLIPt
         7CwA==
X-Received: by 10.182.226.136 with SMTP id rs8mr13794665obc.50.1369449148365;
        Fri, 24 May 2013 19:32:28 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id kd10sm20548335oeb.7.2013.05.24.19.32.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225431>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg |  1 +
 contrib/remote-helpers/test-hg.sh    | 40 ++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 2e4f7ca..e0e68ef 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -621,6 +621,7 @@ def do_import(parser):
     if os.path.exists(path):
         print "feature import-marks=%s" % path
     print "feature export-marks=%s" % path
+    print "feature force"
     sys.stdout.flush()
 
     tmp = encoding.encoding
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 4bd7584..431a5d1 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -37,6 +37,8 @@ setup () {
 	(
 	echo "[ui]"
 	echo "username = H G Wells <wells@example.com>"
+	echo "[extensions]"
+	echo "mq ="
 	) >> "$HOME"/.hgrc
 }
 
@@ -161,4 +163,42 @@ test_expect_success 'authors' '
 	test_cmp expected actual
 '
 
+test_expect_success 'strip' '
+	test_when_finished "rm -rf hgrepo gitrepo" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+
+	echo one >> content &&
+	hg add content &&
+	hg commit -m one &&
+
+	echo two >> content &&
+	hg commit -m two
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+
+	(
+	cd hgrepo &&
+	hg strip 1 &&
+
+	echo three >> content &&
+	hg commit -m three &&
+
+	echo four >> content &&
+	hg commit -m four
+	) &&
+
+	(
+	cd gitrepo &&
+	git fetch &&
+	git log --format="%s" origin/master > ../actual
+	) &&
+
+	hg -R hgrepo log --template "{desc}\n" > expected &&
+	test_cmp actual expected
+'
+
 test_done
-- 
1.8.3.rc3.312.g47657de
