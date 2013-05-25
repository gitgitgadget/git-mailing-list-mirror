From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/8] remote-bzr: simplify get_remote_branch()
Date: Fri, 24 May 2013 21:24:21 -0500
Message-ID: <1369448666-17515-4-git-send-email-felipe.contreras@gmail.com>
References: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:26:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4BZ-0006Rq-Pr
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546Ab3EYC0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:26:16 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:64060 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483Ab3EYC0N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:26:13 -0400
Received: by mail-oa0-f51.google.com with SMTP id f4so6892923oah.24
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=o2oCAf1IepBmN3wqeTo8v4GOBl521PRXFDnHyEQLt8s=;
        b=vFilCCNJELi5TSkg2s01d6BFB+1lkTZ5bGSqQy+L0lfJTa64XjKm016j0yqjQpby/H
         3bud5wM8CiuJ8HSUBCb9JChO4o2aMs47PWcq8b3Io33xoiQ91TR2/R0tTmZk8+5HxQn2
         EEzzLT4IejlMpdM1g4mu5BvLypxsm1XY1t5JhyqRMFXfoLtgbhflU3AyHQBmrA0dkmUG
         gwfD63hRL8ROe81t5w01M3SwW+ILCsxU8NkeJtU1uxIfcSZBp88YfU5ea93qvZ6o7i6i
         4Fi+S/fZc80Cnf4WHFJ5DfcEMfDGjfBfB3Pk5RWxKtsxo79sGo3hOKSgcVNrtpY7hXJA
         unyA==
X-Received: by 10.182.125.164 with SMTP id mr4mr13619224obb.94.1369448773193;
        Fri, 24 May 2013 19:26:13 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wz1sm6600140obc.3.2013.05.24.19.26.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:26:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225407>

No need for 'origin', it's only needed for the bzrdir 'sprout' method,
which can be greatly simplified.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 35664c6..5c4201a 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -765,25 +765,26 @@ def do_list(parser):
     print "@refs/heads/%s HEAD" % master_branch
     print
 
-def get_remote_branch(origin, remote_branch, name):
+def clone(path, remote_branch):
+    bdir = bzrlib.bzrdir.BzrDir.create(path)
+    repo = bdir.find_repository()
+    repo.fetch(remote_branch.repository)
+    return remote_branch.sprout(bdir, repository=repo)
+
+def get_remote_branch(remote_branch, name):
     global dirname, peers
 
     branch_path = os.path.join(dirname, 'clone', name)
 
     try:
-        d = bzrlib.bzrdir.BzrDir.open(branch_path)
-        branch = d.open_branch()
+        branch = bzrlib.branch.Branch.open(branch_path)
     except bzrlib.errors.NotBranchError:
         # clone
-        d = origin.sprout(branch_path, None,
-                hardlink=True, create_tree_if_local=False,
-                force_new_repo=False,
-                source_branch=remote_branch)
-        branch = d.open_branch()
+        branch = clone(branch_path, remote_branch)
     else:
         # pull
         try:
-            branch.pull(remote_branch, [], None, False)
+            branch.pull(remote_branch, overwrite=True)
         except bzrlib.errors.DivergedBranches:
             # use remote branch for now
             return remote_branch
@@ -856,7 +857,7 @@ def get_repo(url, alias):
 
         if not is_local:
             peers[name] = remote_branch.base
-            branch = get_remote_branch(origin, remote_branch, name)
+            branch = get_remote_branch(remote_branch, name)
         else:
             branch = remote_branch
 
@@ -874,7 +875,7 @@ def get_repo(url, alias):
 
             if not is_local:
                 peers[name] = remote_branch.base
-                branch = get_remote_branch(origin, remote_branch, name)
+                branch = get_remote_branch(remote_branch, name)
             else:
                 branch = remote_branch
 
-- 
1.8.3.rc3.312.g47657de
