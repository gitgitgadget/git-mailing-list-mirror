From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/7] remote-bzr: fix directory renaming
Date: Fri,  5 Apr 2013 21:49:17 -0600
Message-ID: <1365220163-13581-2-git-send-email-felipe.contreras@gmail.com>
References: <1365220163-13581-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:22:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWSD-0001b9-06
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756843Ab3DFDvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 23:51:01 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:54871 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756470Ab3DFDvA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 23:51:00 -0400
Received: by mail-oa0-f54.google.com with SMTP id n12so4617903oag.27
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 20:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=fb19jmACJR4S6J6w6MIw6Nb8/FoH8O5i6d3MomJevCc=;
        b=SHlovBgjckQcaMo6vO380mhLFPi+OTaC9P/u4Jane6kFNNlxmnV2pikmJDlUTwfAtl
         mtUvFRUrMehX6apuPcMtHsh8L8ivMLc+sHAee9hW9FZeF/L07FdE+Fz1bTpC7m51WeRn
         Ny1UaGp5cJ2MJLyH1ebRpL3ahZmTBUrTrVXT/LYzZaFPqsfKwwYo6BGzVQWeZekgBfkj
         h4qxWgHiHYCiRiBD3gKx+C4lmjeEOZbt/zD1NC6kTLkynamO6aEhhAwHfgTxI99Ia6zy
         zCKGwPeOZudG2tf4BEYJN95qdxmQgz9TdXXgG4DpIMYhMAq4aVwxU8SucdE8Q1GJrDXV
         XLfA==
X-Received: by 10.60.37.68 with SMTP id w4mr9921741oej.62.1365220260181;
        Fri, 05 Apr 2013 20:51:00 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id a10sm15192349oez.1.2013.04.05.20.50.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 20:50:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365220163-13581-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220205>

From: Christophe Simonis <christophe@kn.gl>

Git does not handle directories, renaming a directory is renaming every
files in this directory.

[fc: added tests]

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr |  8 +++++++-
 contrib/remote-helpers/test-bzr.sh    | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index c5822e4..a7d041b 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -191,7 +191,13 @@ def get_filechanges(cur, prev):
         modified[path] = fid
     for oldpath, newpath, fid, kind, mod, _ in changes.renamed:
         removed[oldpath] = None
-        modified[newpath] = fid
+        if kind == 'directory':
+            lst = cur.list_files(from_dir=newpath, recursive=True)
+            for path, file_class, kind, fid, entry in lst:
+                if kind != 'directory':
+                    modified[newpath + '/' + path] = fid
+        else:
+            modified[newpath] = fid
 
     return modified, removed
 
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 8450432..d26e5c7 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -126,4 +126,28 @@ test_expect_success 'special modes' '
   test_cmp expected actual
 '
 
+cat > expected <<EOF
+100644 blob 54f9d6da5c91d556e6b54340b1327573073030af	content
+100755 blob 68769579c3eaadbe555379b9c3538e6628bae1eb	executable
+120000 blob 6b584e8ece562ebffc15d38808cd6b98fc3d97ea	link
+040000 tree 35c0caa46693cef62247ac89a680f0c5ce32b37b	movedir-new
+EOF
+
+test_expect_success 'moving directory' '
+  (cd bzrrepo &&
+  mkdir movedir &&
+  echo one > movedir/one &&
+  echo two > movedir/two &&
+  bzr add movedir &&
+  bzr commit -m movedir &&
+  bzr mv movedir movedir-new &&
+  bzr commit -m movedir-new) &&
+
+  (cd gitrepo &&
+  git pull &&
+  git ls-tree HEAD > ../actual) &&
+
+  test_cmp expected actual
+'
+
 test_done
-- 
1.8.2
