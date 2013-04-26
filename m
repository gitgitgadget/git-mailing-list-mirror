From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 15/20] remote-bzr: add option to specify branches
Date: Thu, 25 Apr 2013 20:08:03 -0500
Message-ID: <1366938488-25425-16-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:10:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXBT-0004aO-U3
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932965Ab3DZBKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:10:38 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:60779 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932672Ab3DZBKG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:10:06 -0400
Received: by mail-ob0-f179.google.com with SMTP id oi10so3017595obb.38
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=J9++4BaOoLBAMJE6LWiYTawIR0lDDricnmExmv11Qx4=;
        b=xDGA9r7V9iiRG5950Sqidi6KznE9pRE7uRH3GBy4AdnBg3yTPzZZSjQVF+T5Y1mM1q
         mtZxhwCA1cbZJOdm1lLSNgSiMrnyE3VT8bCTBqoEs9GRVvBXh+cZ6soSfSpny0eY1xa6
         RSygi7ehaRQnYx6KqrQ4IuOGsiPbAfVd/NqjOEln/X0k91TeCnVfy2vtjVT3dIht91r0
         vVp1qMl8gLOvTAS6N5fW1tEGIiiJKuLKaT+3i/cTbf3NzOYE5IMJUzRjcCQcLf9AUokL
         WkZg36o+7hgMCS3MkiqJ9H/blLCV9v2NcYRtvIbYo1f52/tEMp+DklWZHsmvkO5TABGO
         dsSQ==
X-Received: by 10.60.169.212 with SMTP id ag20mr6011935oec.102.1366938606302;
        Thu, 25 Apr 2013 18:10:06 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jv10sm6106835oeb.3.2013.04.25.18.10.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:10:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222502>

We might not want all the branches. And branch handling in bazaar is
rather tricky, so it's safer to simply specify them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 5155b93..06d9d24 100755
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
 
     def __init__(self, gitdir, dirname):
@@ -779,7 +788,7 @@ def get_remote_branch(origin, remote_branch, name):
 
     return branch
 
-def find_branches(repo):
+def find_branches(repo, wanted):
     transport = repo.user_transport
 
     for fn in transport.iter_files_recursive():
@@ -790,6 +799,9 @@ def find_branches(repo):
         name = name if name != '' else 'master'
         name = name.replace('/', '+')
 
+        if wanted and not name in wanted:
+            continue
+
         try:
             cur = transport.clone(subdir)
             branch = bzrlib.branch.Branch.open_from_transport(cur)
@@ -838,7 +850,11 @@ def get_repo(url, alias):
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
1.8.2.1.884.g3532a8d
