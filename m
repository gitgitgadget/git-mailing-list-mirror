From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 19/20] remote-bzr: access branches only when needed
Date: Thu, 25 Apr 2013 20:08:07 -0500
Message-ID: <1366938488-25425-20-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:10:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXBG-0004N5-Ok
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932952Ab3DZBKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:10:20 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:44392 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932853Ab3DZBKS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:10:18 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so3126685obb.29
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=CJPdrv/PVPuLl7SDe75l2HHMEkec4ii02zeHvhiyq50=;
        b=cAPKCYEQCp2X23yDimGKON+qrvtKz4b29B6X2GaUWZy5j9SVOrpr2hqD+E3e3QH6bL
         kaanNqShL5Qr6jr5PF8sTydGeiD0KbpdjhUAL7MZpcHP+MJoLn/DaKs51M6SMkyAbNPF
         FYyP28fNoMkoFC+6qFAVNV2NiSc8E+oqw2SxXBDYndXG587FFwIbJaDyfEG37PqSTTIe
         0ndGzIQMfbj/2O+wVfFyUeTPZf/OXrrvnZBaOseHNGEo7Amg3btv7SRNVrWDceDLUp/Y
         kBfVirZnntwLnTASVX9C8fA4ynGMYWvXU6OlJ0wMi28aD8sUIR0jl6l47as6J1BVVgLd
         DDag==
X-Received: by 10.182.160.106 with SMTP id xj10mr20966835obb.98.1366938618235;
        Thu, 25 Apr 2013 18:10:18 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id fl7sm5866602obb.0.2013.04.25.18.10.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:10:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222500>

Bazaar doesn't seem to be tested for multiple usage of branches, so
resources seem to be leaked all over. Let's try to minimize this by
accessing the Branch objects only when needed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 7517645..3c59a18 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -300,7 +300,7 @@ def export_branch(repo, name):
     ref = '%s/heads/%s' % (prefix, name)
     tip = marks.get_tip(name)
 
-    branch = branches[name]
+    branch = bzrlib.branch.Branch.open(branches[name])
     repo = branch.repository
 
     branch.lock_read()
@@ -605,7 +605,7 @@ def parse_commit(parser):
 
     if ref.startswith('refs/heads/'):
         name = ref[len('refs/heads/'):]
-        branch = branches[name]
+        branch = bzrlib.branch.Branch.open(branches[name])
     else:
         die('unknown ref')
 
@@ -706,7 +706,7 @@ def do_export(parser):
 
     for ref, revid in parsed_refs.iteritems():
         name = ref[len('refs/heads/'):]
-        branch = branches[name]
+        branch = bzrlib.branch.Branch.open(branches[name])
         branch.generate_revision_history(revid, marks.get_tip(name))
 
         if name in peers:
@@ -756,7 +756,7 @@ def do_list(parser):
             master_branch = name
         print "? refs/heads/%s" % name
 
-    branch = branches[master_branch]
+    branch = bzrlib.branch.Branch.open(branches[master_branch])
     branch.lock_read()
     for tag, revid in branch.tags.get_tag_dict().items():
         try:
@@ -845,13 +845,15 @@ def get_repo(url, alias):
         # branch
 
         name = 'master'
-        branch = origin.open_branch()
+        remote_branch = origin.open_branch()
 
         if not is_local:
-            peers[name] = branch.base
-            branches[name] = get_remote_branch(origin, branch, name)
+            peers[name] = remote_branch.base
+            branch = get_remote_branch(origin, remote_branch, name)
         else:
-            branches[name] = branch
+            branch = remote_branch
+
+        branches[name] = branch.base
 
         return branch.repository
     else:
@@ -861,13 +863,15 @@ def get_repo(url, alias):
         # stupid python
         wanted = [e for e in wanted if e]
 
-        for name, branch in find_branches(repo, wanted):
+        for name, remote_branch in find_branches(repo, wanted):
 
             if not is_local:
-                peers[name] = branch.base
-                branches[name] = get_remote_branch(origin, branch, name)
+                peers[name] = remote_branch.base
+                branch = get_remote_branch(origin, remote_branch, name)
             else:
-                branches[name] = branch
+                branch = remote_branch
+
+            branches[name] = branch.base
 
         return repo
 
-- 
1.8.2.1.884.g3532a8d
