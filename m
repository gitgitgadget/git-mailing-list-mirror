From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 6/7] remote-bzr: add support for fecthing special modes
Date: Sun, 11 Nov 2012 15:19:57 +0100
Message-ID: <1352643598-8500-7-git-send-email-felipe.contreras@gmail.com>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:21:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYPE-0007wm-PJ
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951Ab2KKOUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:20:36 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47320 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab2KKOUe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:20:34 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2064575bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=A10Cvlg2bH/YuJMARJjnCAVqD/pc521hoK98/hZeYoU=;
        b=kROPwTKNZv4CkRla2vUAd9lP2ik4VR2TcnlFyEi6Q+fDjmQ/Gfag+pTWHrCqdX6DO5
         WlBHuEoOko4niqVNKtMgMy2JKHguX+AowJqM6MYitCbqXiYLy+auNYxBRSdPu2YLKQxL
         0F9CdZ/sg7uGGcC0pe+v+5efNJ2DS2BJeqdn37Q/RUnyVPL4eqvuGVfAGXLEyTuJuCeO
         KEUp8+KZyXJixykPLu5IuKjGAn4PFJ0mgPTqcUmMXPGknoi6N7jexJ1/aViu7l4VyrIL
         UIhvGqLjkPkfimmk4bqFfP2j+ntvjY+QYn51ADEYG5HHVr6C3Nmc5D8c1Vj37rsxdBbU
         0cQQ==
Received: by 10.204.145.217 with SMTP id e25mr2420751bkv.123.1352643633698;
        Sun, 11 Nov 2012 06:20:33 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id e3sm1506002bks.7.2012.11.11.06.20.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:20:32 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209380>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 38 +++++++++++++++++++++++++----------
 contrib/remote-helpers/test-bzr.sh    | 32 +++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 5b89a05..2bae5d0 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -198,23 +198,39 @@ def export_files(tree, files):
 
     final = []
     for path, fid in files.iteritems():
+        kind = tree.kind(fid)
+
         h = tree.get_file_sha1(fid)
 
-        mode = '100644'
+        if kind == 'symlink':
+            d = tree.get_symlink_target(fid)
+            mode = '120000'
+        elif kind == 'file':
+
+            if tree.is_executable(fid):
+                mode = '100755'
+            else:
+                mode = '100644'
+
+            # is the blog already exported?
+            if h in filenodes:
+                mark = filenodes[h]
+                final.append((mode, mark, path))
+                continue
 
-        # is the blob already exported?
-        if h in filenodes:
-            mark = filenodes[h]
-        else:
             d = tree.get_file_text(fid)
+        elif kind == 'directory':
+            continue
+        else:
+            die("Unhandled kind '%s' for path '%s'" % (kind, path))
 
-            mark = marks.next_mark()
-            filenodes[h] = mark
+        mark = marks.next_mark()
+        filenodes[h] = mark
 
-            print "blob"
-            print "mark :%u" % mark
-            print "data %d" % len(d)
-            print d
+        print "blob"
+        print "mark :%u" % mark
+        print "data %d" % len(d)
+        print d
 
         final.append((mode, mark, path))
 
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 8594ffc..c92d0c6 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -108,4 +108,36 @@ test_expect_success 'roundtrip' '
   test_cmp expected actual
 '
 
+cat > expected <<EOF
+100644 blob 54f9d6da5c91d556e6b54340b1327573073030af	content
+100755 blob 68769579c3eaadbe555379b9c3538e6628bae1eb	executable
+120000 blob 6b584e8ece562ebffc15d38808cd6b98fc3d97ea	link
+EOF
+
+test_expect_success 'special modes' '
+  (cd bzrrepo &&
+  echo exec > executable
+  chmod +x executable &&
+  bzr add executable
+  bzr commit -m exec &&
+  ln -s content link
+  bzr add link
+  bzr commit -m link &&
+  mkdir dir &&
+  bzr add dir &&
+  bzr commit -m dir) &&
+
+  (cd gitrepo &&
+  git pull
+  git ls-tree HEAD > ../actual) &&
+
+  test_cmp expected actual &&
+
+  (cd gitrepo &&
+  git cat-file -p HEAD:link > ../actual) &&
+
+  echo -n content > expected &&
+  test_cmp expected actual
+'
+
 test_done
-- 
1.8.0
