From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 14/18] remote-bzr: add option to specify branches
Date: Tue, 30 Apr 2013 20:10:06 -0500
Message-ID: <1367370610-14250-15-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:12:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLb9-0007lg-74
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934165Ab3EABMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:12:40 -0400
Received: from mail-gg0-f170.google.com ([209.85.161.170]:57450 "EHLO
	mail-gg0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934111Ab3EABMg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:12:36 -0400
Received: by mail-gg0-f170.google.com with SMTP id u1so197194ggl.1
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=qiQtE84444OYzt5bg/yw9synVUdLcBAbfLbnvvRLBho=;
        b=K6qfEnEkLetiMAOYIXY/X+VMPbdX+3u10AFB7n5PC4QGfFPJTW/F5jcujQyAr1WccL
         YuNXtr2xTLK9h8vTZ7BWGM+ncQQKnv1jaf3WBtBWwsg/RsPc/vBmla3VyR87BXR/Ry+8
         XTSPMeyDfs/Vsws5FyPaJO3SGxKlIU3PyqlO+s8gVAuEs0ayGKf1ABdzg9Lybe5yAGPy
         GlZU8Mpnp2Ox+p5w3gtHkTaz87XVS8otWchM/her1/YFGPFjMYf68DIAcW95J7Ye5dJl
         28TApNeyYS3LcEn0fpnfrlQTE1GEYyvPgkxVHJQgOB6FaGnr2tp5pE4kJd2e7PPLq+mW
         j/JQ==
X-Received: by 10.236.16.202 with SMTP id h50mr706597yhh.39.1367370755674;
        Tue, 30 Apr 2013 18:12:35 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id v27sm1595235yhj.12.2013.04.30.18.12.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:12:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223057>

We might not want all the branches. And branch handling in bazaar is
rather tricky, so it's safer to simply specify them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 11f2415..d284afc 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -13,6 +13,9 @@
 # or
 # % git clone bzr::lp:myrepo
 #
+# If you want to specify which branches you want track (per repo):
+# git config remote-bzr.branches 'trunk, devel, test'
+#
 
 import sys
 
@@ -51,6 +54,12 @@ def warn(msg, *args):
 def gittz(tz):
     return '%+03d%02d' % (tz / 3600, tz % 3600 / 60)
 
+def get_config(config):
+    cmd = ['git', 'config', '--get', config]
+    process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
+    output, _ = process.communicate()
+    return output
+
 class Marks:
 
     def __init__(self, path):
@@ -756,7 +765,7 @@ def get_remote_branch(origin, remote_branch, name):
 
     return branch
 
-def find_branches(repo):
+def find_branches(repo, wanted):
     transport = repo.user_transport
 
     for fn in transport.iter_files_recursive():
@@ -767,6 +776,9 @@ def find_branches(repo):
         name = name if name != '' else 'master'
         name = name.replace('/', '+')
 
+        if wanted and not name in wanted:
+            continue
+
         try:
             cur = transport.clone(subdir)
             branch = bzrlib.branch.Branch.open_from_transport(cur)
@@ -815,7 +827,11 @@ def get_repo(url, alias):
     else:
         # repository
 
-        for name, branch in find_branches(repo):
+        wanted = get_config('remote-bzr.branches').rstrip().split(', ')
+        # stupid python
+        wanted = [e for e in wanted if e]
+
+        for name, branch in find_branches(repo, wanted):
 
             if not is_local:
                 peers[name] = branch
-- 
1.8.3.rc0.399.gc96a135
