From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 19/48] remote-hg: add tests for 'master' bookmark
Date: Fri, 24 May 2013 21:29:35 -0500
Message-ID: <1369449004-17981-20-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Hr-00022Y-SD
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755247Ab3EYCcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:42 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:34065 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068Ab3EYCcl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:41 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so6813558oag.25
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gyuu+SZWJnhUnBcwfqK6cp7hWUtUJ0PJXkDQ7sAKQpw=;
        b=T7w/y2wawMTo554GkRHE1tXUzbPP6fVX24lRaMgNmkVcTXY38kKhgS2N4+AcDaXiwl
         RltKAtnZeQVN+Vy8qXwF1R/UOTIUVrLtNwM95qoH89sQf0jFmWWy0qpyeJsGW0Ui0H6P
         RUtG/lhwL22a4Gk4RfH5M1ZY+9uF1nQSzSsp15AAhYCe4fitlSaZ87p91Y95WqEymwTU
         e8rX8GBQL8oVZfxFsjKi0TdF7MnNectFwyW7lRwOsUVJ3DMP+FygAMk7rA2IvNqY8vf+
         iYZKpm+Xsc8UEUrA/ZmllGWboxobAquyVk9o3G5I5wJBr5G1oRe4/k6+sqFS3xPqSnuh
         w5lA==
X-Received: by 10.182.105.6 with SMTP id gi6mr13398882obb.18.1369449160876;
        Fri, 24 May 2013 19:32:40 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w7sm20053413obx.9.2013.05.24.19.32.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225433>

We want to make sure everything works correctly, even if there's a
'master' bookmark in Mercurial.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 68 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 78af45d..943371a 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -26,13 +26,23 @@ check () {
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
 	echo "username = H G Wells <wells@example.com>"
 	echo "[extensions]"
 	echo "mq ="
-	) >> "$HOME"/.hgrc
+	) >> "$HOME"/.hgrc &&
+
+	GIT_AUTHOR_DATE="2007-01-01 00:00:00 +0230" &&
+	GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE" &&
+	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 }
 
 setup
@@ -178,4 +188,60 @@ test_expect_success 'strip' '
 	test_cmp actual expected
 '
 
+test_expect_success 'remote push with master bookmark' '
+	test_when_finished "rm -rf hgrepo gitrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo zero > content &&
+	hg add content &&
+	hg commit -m zero &&
+	hg bookmark master &&
+	echo one > content &&
+	hg commit -m one
+	) &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	echo two > content &&
+	git commit -a -m two &&
+	git push
+	) &&
+
+	check_branch hgrepo default two
+'
+
+cat > expected <<EOF
+changeset:   0:6e2126489d3d
+tag:         tip
+user:        A U Thor <author@example.com>
+date:        Mon Jan 01 00:00:00 2007 +0230
+summary:     one
+
+EOF
+
+test_expect_success 'remote push from master branch' '
+	test_when_finished "rm -rf hgrepo gitrepo*" &&
+
+	hg init hgrepo &&
+
+	(
+	git init gitrepo &&
+	cd gitrepo &&
+	git remote add origin "hg::../hgrepo" &&
+	echo one > content &&
+	git add content &&
+	git commit -a -m one &&
+	git push origin master
+	) &&
+
+	hg -R hgrepo log > actual &&
+	cat actual &&
+	test_cmp expected actual &&
+
+	check_branch hgrepo default one
+'
+
 test_done
-- 
1.8.3.rc3.312.g47657de
