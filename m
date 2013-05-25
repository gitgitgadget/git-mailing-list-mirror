From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/8] remote-bzr: delay cloning/pulling
Date: Fri, 24 May 2013 21:24:22 -0500
Message-ID: <1369448666-17515-5-git-send-email-felipe.contreras@gmail.com>
References: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:26:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Bj-0006XS-Ao
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717Ab3EYC0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:26:19 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:45616 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab3EYC0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:26:16 -0400
Received: by mail-ob0-f169.google.com with SMTP id 16so5885053obc.14
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LaNoziBjBRDG+PFy7cx4icasMX/lPSBetqqwm2Oa9S8=;
        b=cLCFL2hC6jqoQAYbKoeb7/ecM9dAmVMFx/hFRnvxy+nhWuziAjEN2tD+kcbiIU0GRj
         D7SGWOR7raG/lCGuWDUcLh+qUtEnse8TfTQt8AauWxoLhaQWIiDRZbQ9TS+khx3C8Uga
         VQNCjoFxlkHDNvew55BfkYDo5Vf5axZE+/dlm5hmVqmEE7s06VlOrlUHTYgJx1AKY2GG
         bksPp7oY62lM1bqXUsCI8n1cYYhjr3iI0WAnNpzQjPHtHjnw/M/devYduhyQURJorvU8
         d/mDbHYbfCK2U4dZCM/tYeWvn5PQgphVfw/2DaVO+5sCCqCFtsDmPkpWq56p/snFn9mv
         18Uw==
X-Received: by 10.60.33.4 with SMTP id n4mr5787618oei.49.1369448776121;
        Fri, 24 May 2013 19:26:16 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id hv3sm20047034obb.7.2013.05.24.19.26.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:26:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225409>

Until the branch is actually going to be used.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 5c4201a..202a4f7 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -278,7 +278,7 @@ def export_branch(repo, name):
     ref = '%s/heads/%s' % (prefix, name)
     tip = marks.get_tip(name)
 
-    branch = bzrlib.branch.Branch.open(branches[name])
+    branch = get_remote_branch(name)
     repo = branch.repository
 
     branch.lock_read()
@@ -590,7 +590,7 @@ def parse_commit(parser):
 
     if ref.startswith('refs/heads/'):
         name = ref[len('refs/heads/'):]
-        branch = bzrlib.branch.Branch.open(branches[name])
+        branch = get_remote_branch(name)
     else:
         die('unknown ref')
 
@@ -692,7 +692,7 @@ def do_export(parser):
     for ref, revid in parsed_refs.iteritems():
         if ref.startswith('refs/heads/'):
             name = ref[len('refs/heads/'):]
-            branch = bzrlib.branch.Branch.open(branches[name])
+            branch = get_remote_branch(name)
             branch.generate_revision_history(revid, marks.get_tip(name))
 
             if name in peers:
@@ -749,7 +749,7 @@ def do_list(parser):
             master_branch = name
         print "? refs/heads/%s" % name
 
-    branch = bzrlib.branch.Branch.open(branches[master_branch])
+    branch = get_remote_branch(master_branch)
     branch.lock_read()
     for tag, revid in branch.tags.get_tag_dict().items():
         try:
@@ -771,8 +771,12 @@ def clone(path, remote_branch):
     repo.fetch(remote_branch.repository)
     return remote_branch.sprout(bdir, repository=repo)
 
-def get_remote_branch(remote_branch, name):
-    global dirname, peers
+def get_remote_branch(name):
+    global dirname, branches
+
+    remote_branch = bzrlib.branch.Branch.open(branches[name])
+    if isinstance(remote_branch.user_transport, bzrlib.transport.local.LocalTransport):
+        return remote_branch
 
     branch_path = os.path.join(dirname, 'clone', name)
 
@@ -857,13 +861,10 @@ def get_repo(url, alias):
 
         if not is_local:
             peers[name] = remote_branch.base
-            branch = get_remote_branch(remote_branch, name)
-        else:
-            branch = remote_branch
 
-        branches[name] = branch.base
+        branches[name] = remote_branch.base
 
-        return branch.repository
+        return remote_branch.repository
     else:
         # repository
 
@@ -875,11 +876,8 @@ def get_repo(url, alias):
 
             if not is_local:
                 peers[name] = remote_branch.base
-                branch = get_remote_branch(remote_branch, name)
-            else:
-                branch = remote_branch
 
-            branches[name] = branch.base
+            branches[name] = remote_branch.base
 
         return repo
 
-- 
1.8.3.rc3.312.g47657de
