From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 8/8] remote-hg: trivial cleanups
Date: Tue, 29 Apr 2014 04:04:35 -0500
Message-ID: <1398762275-346-9-git-send-email-felipe.contreras@gmail.com>
References: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 11:15:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf48i-0000GG-Sg
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933292AbaD2JPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:15:39 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:58222 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933279AbaD2JPi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:15:38 -0400
Received: by mail-ob0-f169.google.com with SMTP id uz6so8692217obc.0
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 02:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5CF4NP3LCajmEIGTjWvNU8HLbLSISAU8XnTi40K8hP4=;
        b=OJy1Bau16T6nGCHX0Zftnekgk/WnsOEC0MkMs1896FSMF3K9hlO2dn8FTAOe6lb3VG
         /Q38CXTnJSDDjAteXwJ3L8Rr1lknvmvqN+cyLmEI7wvyAe4YucdZX2jAhHkQocTnvJEs
         3IIEOVtrzXsmm+VmXLKcuqVz6rIfUQfONW+R+2oDWM6KIjKgfW5K9IkIZ5gmWRd9gsbY
         UcmhX36Mw07zUNgPdkm+qNS95WzVd+4/wF1zhpT7T0Y/r1wy7kmtHmoJ0o86F0hMK5EN
         z7u9DptUdZ6pC06SZM04dZuIfd9WkW//ZUbArA7zuvbVjK8UuzGrc9TuK+1KDf+1+Cgr
         ijew==
X-Received: by 10.182.225.163 with SMTP id rl3mr5621obc.79.1398762937735;
        Tue, 29 Apr 2014 02:15:37 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id oz15sm85257550oeb.13.2014.04.29.02.15.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 02:15:36 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247552>

Cleanup 51be46e (remote-hg: do not fail on invalid bookmarks).

Having a 40-characters string is not ideal, and having three tests for
basically the same relatively rare situation is overkill.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-hg.py     |  2 +-
 t/t5810-remote-hg.sh | 56 ++++------------------------------------------------
 2 files changed, 5 insertions(+), 53 deletions(-)

diff --git a/git-remote-hg.py b/git-remote-hg.py
index 402b92f..74f2a2e 100755
--- a/git-remote-hg.py
+++ b/git-remote-hg.py
@@ -677,7 +677,7 @@ def do_list(parser):
             print "? refs/heads/branches/%s" % gitref(branch)
 
     for bmark in bmarks:
-        if  bmarks[bmark].hex() == '0000000000000000000000000000000000000000':
+        if  bmarks[bmark].hex() == '0' * 40:
             warn("Ignoring invalid bookmark '%s'", bmark)
         else:
             print "? refs/heads/%s" % gitref(bmark)
diff --git a/t/t5810-remote-hg.sh b/t/t5810-remote-hg.sh
index ba8b2d8..9946f57 100755
--- a/t/t5810-remote-hg.sh
+++ b/t/t5810-remote-hg.sh
@@ -772,7 +772,7 @@ test_expect_success 'remote double failed push' '
 	)
 '
 
-test_expect_success 'clone remote with master null bookmark, then push to the bookmark' '
+test_expect_success 'clone remote with null bookmark, then push' '
 	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	hg init hgrepo &&
@@ -781,67 +781,19 @@ test_expect_success 'clone remote with master null bookmark, then push to the bo
 		echo a >a &&
 		hg add a &&
 		hg commit -m a &&
-		hg bookmark -r null master
+		hg bookmark -r null bookmark
 	) &&
 
 	git clone "hg::hgrepo" gitrepo &&
 	check gitrepo HEAD a &&
 	(
 		cd gitrepo &&
-		git checkout --quiet -b master &&
-		echo b >b &&
-		git add b &&
-		git commit -m b &&
-		git push origin master
-	)
-'
-
-test_expect_success 'clone remote with default null bookmark, then push to the bookmark' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	hg init hgrepo &&
-	(
-		cd hgrepo &&
-		echo a >a &&
-		hg add a &&
-		hg commit -m a &&
-		hg bookmark -r null -f default
-	) &&
-
-	git clone "hg::hgrepo" gitrepo &&
-	check gitrepo HEAD a &&
-	(
-		cd gitrepo &&
-		git checkout --quiet -b default &&
-		echo b >b &&
-		git add b &&
-		git commit -m b &&
-		git push origin default
-	)
-'
-
-test_expect_success 'clone remote with generic null bookmark, then push to the bookmark' '
-	test_when_finished "rm -rf gitrepo* hgrepo*" &&
-
-	hg init hgrepo &&
-	(
-		cd hgrepo &&
-		echo a >a &&
-		hg add a &&
-		hg commit -m a &&
-		hg bookmark -r null bmark
-	) &&
-
-	git clone "hg::hgrepo" gitrepo &&
-	check gitrepo HEAD a &&
-	(
-		cd gitrepo &&
-		git checkout --quiet -b bmark &&
+		git checkout --quiet -b bookmark &&
 		git remote -v &&
 		echo b >b &&
 		git add b &&
 		git commit -m b &&
-		git push origin bmark
+		git push origin bookmark
 	)
 '
 
-- 
1.9.2+fc1.3.gade8541
