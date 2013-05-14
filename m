From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 23/47] remote-hg: ensure remote rebasing works
Date: Mon, 13 May 2013 23:36:46 -0500
Message-ID: <1368506230-19614-24-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:40:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc72C-0004WY-SX
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022Ab3ENEjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:39:55 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:55422 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474Ab3ENEjy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:39:54 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so100212oag.23
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Ud/Ygt71+l7LyUzeW7qlcrUTBqVOmgWAY7V723QRioI=;
        b=SWXnlmWKG3U1+sI4OhepMh2P5X20xopWQFb5hc5U3nBC7uGqgB2AGUy6Gg3Uc8CbWV
         QKZa3M8F5uV4NtBMWnKq0fETpCJtaHmB+5fG5vZrUvCYpvlMNUvkgzrH7uaij/By2kAC
         +tXFav3PKxoSh7o2QR2QjA6LeXN66rpN6hyApVpjwRvlUU5a9XMRt7J7dmF6enfKK6Mh
         UthohDjVMpA4ryK15B7SNgjx46D4f7x6Lxz55gRVGQrPJMQEC0IxKX0gIpvz/oWAu87N
         vbgrNCMPYAm/EzrpeXTOUQPy8E5jqpMJyDiaxsObGV0TYLgvytTLibE3VaSvddpnbqP5
         3l1g==
X-Received: by 10.60.33.167 with SMTP id s7mr4100636oei.86.1368506394330;
        Mon, 13 May 2013 21:39:54 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ri8sm20547447oeb.0.2013.05.13.21.39.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:39:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224259>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg |  1 +
 contrib/remote-helpers/test-hg.sh    | 40 ++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 6cad5cd..bc6e8fa 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -624,6 +624,7 @@ def do_import(parser):
     if os.path.exists(path):
         print "feature import-marks=%s" % path
     print "feature export-marks=%s" % path
+    print "feature force"
     sys.stdout.flush()
 
     tmp = encoding.encoding
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 4bd7584..23ff0db 100755
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
+	hg strip -r 1 &&
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
1.8.3.rc1.579.g184e698
