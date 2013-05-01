From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 18/18] remote-bzr: access branches only when needed
Date: Tue, 30 Apr 2013 20:10:10 -0500
Message-ID: <1367370610-14250-19-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:13:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLbU-00087G-Bo
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934201Ab3EABM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:12:58 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:54345 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934200Ab3EABM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:12:56 -0400
Received: by mail-yh0-f45.google.com with SMTP id f43so209895yha.32
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XOK9+fGthJpYGJ2PI1kARf2wgpenoHWoKbELgXPV0Ws=;
        b=XV5PgzHBn4pgeGMFVX56uoy2fhiym15XK7oBDqAUBzoHpL06wl/WwxzDxFejfikq7a
         KDkQdRIKKRw4u8hvJkU8EWGADdSiPp/G3LRInGmp4T3pFkZrPqFsBd5idpENVthQmxn8
         K9TOuuK3jv+k7CN7v+U3JvEdM/1Cx+ZKhDk3RtVHugaDPaTn15d9OYFEKKoq1plgafLE
         H30IxqepCG2EcLZTaa2BA7B9X1LiyzMyO/GtqXEJPPchSVVvwRq63CPgA70YaHIHnPp0
         XSExxNfpSZqzNRgPsgvZEw7mfaS9NnPFP4qRXoUyVRZbTZ9b57SzBYkLiWs/yJxpJ23z
         YTcw==
X-Received: by 10.236.53.68 with SMTP id f44mr578639yhc.169.1367370775537;
        Tue, 30 Apr 2013 18:12:55 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id o49sm1665724yhj.3.2013.04.30.18.12.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:12:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223061>

Bazaar doesn't seem to be tested for multiple usage of branches, so
resources seem to be leaked all over. Let's try to minimize this by
accessing the Branch objects only when needed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index b2d67f7..161f831 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -277,7 +277,7 @@ def export_branch(repo, name):
     ref = '%s/heads/%s' % (prefix, name)
     tip = marks.get_tip(name)
 
-    branch = branches[name]
+    branch = bzrlib.branch.Branch.open(branches[name])
     repo = branch.repository
 
     branch.lock_read()
@@ -582,7 +582,7 @@ def parse_commit(parser):
 
     if ref.startswith('refs/heads/'):
         name = ref[len('refs/heads/'):]
-        branch = branches[name]
+        branch = bzrlib.branch.Branch.open(branches[name])
     else:
         die('unknown ref')
 
@@ -683,7 +683,7 @@ def do_export(parser):
 
     for ref, revid in parsed_refs.iteritems():
         name = ref[len('refs/heads/'):]
-        branch = branches[name]
+        branch = bzrlib.branch.Branch.open(branches[name])
         branch.generate_revision_history(revid, marks.get_tip(name))
 
         if name in peers:
@@ -733,7 +733,7 @@ def do_list(parser):
             master_branch = name
         print "? refs/heads/%s" % name
 
-    branch = branches[master_branch]
+    branch = bzrlib.branch.Branch.open(branches[master_branch])
     branch.lock_read()
     for tag, revid in branch.tags.get_tag_dict().items():
         try:
@@ -822,13 +822,15 @@ def get_repo(url, alias):
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
@@ -838,13 +840,15 @@ def get_repo(url, alias):
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
1.8.3.rc0.399.gc96a135
