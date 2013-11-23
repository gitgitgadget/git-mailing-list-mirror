From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] remote-hg: fix hg sharedpath when git clone is moved
Date: Sat, 23 Nov 2013 13:38:22 +0100
Message-ID: <1385210302-25518-1-git-send-email-apelisse@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 23 13:38:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkCU2-0007Dp-LV
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 13:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755684Ab3KWMim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 07:38:42 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:46881 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539Ab3KWMil (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 07:38:41 -0500
Received: by mail-we0-f174.google.com with SMTP id q58so2184962wes.33
        for <git@vger.kernel.org>; Sat, 23 Nov 2013 04:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0Civa/R4WR7ZYD00BOgaiONxlfsjOAXCDNfSYzDX+oY=;
        b=CcIuopXYcqT0+a6jdBQNDCT2aQvNT5Y8KjqY7sykjygUkfh/oA/+hN2++1yh9Bmwyc
         w2ZkQ9MCfsNOtacQskWb+1xxBGGNfmF0zGlOBTn/BXlvmZMTXx1//MoqbxJxIIvzHkLx
         lQSGlfXTKULN6Idn9NaRRUngL5ByZAXrtCTwWuUlVt25sPLJK7aolADsin5yFRN14+Av
         CaRPqeWCf0ZnacEjJcx3W/6IOCIBV0gUld+AWoVObAsz90UQVLnMppimpvgmVUMmNQh8
         OianojaI4nZIIbsmYUDGqzU6KI7L584yBGCyrws6rCFvsRaBqZENTlWfiNh4+boP7wNA
         mZWA==
X-Received: by 10.180.14.134 with SMTP id p6mr5777453wic.6.1385210320479;
        Sat, 23 Nov 2013 04:38:40 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPSA id pi6sm26029133wic.3.2013.11.23.04.38.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Nov 2013 04:38:39 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc1.30.g02973b8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238231>

remote-hg is using a mercurial shared clone to store all remotes objects
in one place. Unfortunately, the sharedpath is stored as an absolute
path by mercurial, creating a dependency on the location of the git
repository. Whenever the git repository is moved, the sharedpath must
be updated to reflect the new absolute path.

Check mercurial sharedpath file when getting the local hg repository,
and update it manually with the new path if necessary.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 contrib/remote-helpers/git-remote-hg |  4 ++++
 contrib/remote-helpers/test-hg.sh    | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index c6026b9..576f094 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -416,6 +416,10 @@ def get_repo(url, alias):
         local_path = os.path.join(dirname, 'clone')
         if not os.path.exists(local_path):
             hg.share(myui, shared_path, local_path, update=False)
+        else:
+            sharedpath_file = os.path.join(local_path, '.hg', 'sharedpath')
+            if hg_path != open(sharedpath_file, 'r').read():
+                open(sharedpath_file, 'w').write(hg_path)
 
         repo = hg.repository(myui, local_path)
         try:
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 72f745d..2477540 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -335,6 +335,17 @@ test_expect_success 'remote cloning' '
 	check gitrepo HEAD zero
 '
 
+test_expect_success 'moving remote clone' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	mv gitrepo gitrepo2 &&
+	cd gitrepo2 &&
+	git fetch
+	)
+'
+
 test_expect_success 'remote update bookmark' '
 	test_when_finished "rm -rf gitrepo*" &&
 
-- 
1.8.5.rc1.30.g02973b8.dirty
