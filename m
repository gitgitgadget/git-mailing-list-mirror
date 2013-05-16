From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/8] remote-bzr: delay cloning/pulling
Date: Thu, 16 May 2013 03:36:43 -0500
Message-ID: <1368693407-21267-5-git-send-email-felipe.contreras@gmail.com>
References: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 10:38:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucthz-0000N5-7B
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567Ab3EPIik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:38:40 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:49819 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756783Ab3EPIii (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:38:38 -0400
Received: by mail-oa0-f41.google.com with SMTP id n9so3375745oag.28
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=u/rQf9WRQ8beTXdqW95azn0Q1o63092lsORxy3zMw/I=;
        b=IG2x/046l3/1kn9mb0mrHDq29JxhZ6UGdE65/68RoTZpwh9RvyEosIv7syOhapPVOu
         b9UqCacMAzEx5mTH9rBOmuIOjIIbBiK3rkw7RF/HMu61t5R3BS5wvlPAOyAYLvg82b8W
         xGqTYubMVbk1C/6st6W3ohyIV2WcOIWlowJPWvQALeFc6KpJ/SJrAZgTeVIEw+TNHcYO
         bbXwYq0IdqBae7qVirPzOm2h73z55VSaZvNAoLHxlhabf8FTfsFQOHPkYlhOm+BqsFxc
         jjzky3uvbg/kprgtyyZwMH127Wtgv1AoPc/egYfJiAAyETybSiixYWYnBD0Dqf6GBbD4
         /8SQ==
X-Received: by 10.60.17.231 with SMTP id r7mr6139537oed.13.1368693517658;
        Thu, 16 May 2013 01:38:37 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm7129861oez.4.2013.05.16.01.38.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 01:38:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224504>

Until the branch is actually going to be used.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index b7656df..2ba49ff 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -277,7 +277,7 @@ def export_branch(repo, name):
     ref = '%s/heads/%s' % (prefix, name)
     tip = marks.get_tip(name)
 
-    branch = bzrlib.branch.Branch.open(branches[name])
+    branch = get_remote_branch(name)
     repo = branch.repository
 
     branch.lock_read()
@@ -589,7 +589,7 @@ def parse_commit(parser):
 
     if ref.startswith('refs/heads/'):
         name = ref[len('refs/heads/'):]
-        branch = bzrlib.branch.Branch.open(branches[name])
+        branch = get_remote_branch(name)
     else:
         die('unknown ref')
 
@@ -691,7 +691,7 @@ def do_export(parser):
     for ref, revid in parsed_refs.iteritems():
         if ref.startswith('refs/heads/'):
             name = ref[len('refs/heads/'):]
-            branch = bzrlib.branch.Branch.open(branches[name])
+            branch = get_remote_branch(name)
             branch.generate_revision_history(revid, marks.get_tip(name))
 
             if name in peers:
@@ -748,7 +748,7 @@ def do_list(parser):
             master_branch = name
         print "? refs/heads/%s" % name
 
-    branch = bzrlib.branch.Branch.open(branches[master_branch])
+    branch = get_remote_branch(master_branch)
     branch.lock_read()
     for tag, revid in branch.tags.get_tag_dict().items():
         try:
@@ -770,8 +770,12 @@ def clone(path, remote_branch):
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
 
@@ -851,13 +855,10 @@ def get_repo(url, alias):
 
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
 
@@ -869,11 +870,8 @@ def get_repo(url, alias):
 
             if not is_local:
                 peers[name] = remote_branch.base
-                branch = get_remote_branch(remote_branch, name)
-            else:
-                branch = remote_branch
 
-            branches[name] = branch.base
+            branches[name] = remote_branch.base
 
         return repo
 
-- 
1.8.3.rc2.542.g24820ba
