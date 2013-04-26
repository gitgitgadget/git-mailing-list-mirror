From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/20] remote-bzr: add support for shared repo
Date: Thu, 25 Apr 2013 20:07:59 -0500
Message-ID: <1366938488-25425-12-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:10:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXAs-0003xY-Qq
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932826Ab3DZBJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:09:57 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:63192 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932730Ab3DZBJz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:09:55 -0400
Received: by mail-oa0-f48.google.com with SMTP id f4so3415064oah.7
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Y2VKz0DeRH0LSMaAXvz6qitMYvzlPiWSKpn9mSnS3f8=;
        b=PbFvBeMBsUAAiSrToMabnsVi80AYkPTFtnJ1CXABYw1U/HwUetcc2pWBpBek+xvuo7
         aGGwOGtIs+VCh0KNKRukJKN7XSeMkPLGV+4HO1b16ZI9QeW83HvOS83XKD+QSSDge4It
         EBhfI9NFsCtxus3txZrZIUiPji0EwH+guyZ5/7abckF0W8rV682ZkQ+aRHG8RholTW4y
         gnBozlAmdtr9A/qGJREKnkeR5Fhi2uNAOSs2fHAaxZ5ppLaNg4Ji9ooMJ1cjxNGRFnu0
         mjuJv4fZ1DVq7Q3c2lHm1Ojy5DFlxFEWp2zcI3Dz67wnxSecGI906K5LNnfRV/BuTy2r
         m1aw==
X-Received: by 10.60.54.163 with SMTP id k3mr17580831oep.139.1366938594928;
        Thu, 25 Apr 2013 18:09:54 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wl10sm5863729obc.1.2013.04.25.18.09.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:09:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222492>

This way all the remotes share the same data, so adding multiple
remotes, or renaming them doesn't create extra overhead.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 38cec07..9fe830e 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -752,7 +752,20 @@ def get_repo(url, alias):
     origin = bzrlib.bzrdir.BzrDir.open(url)
     is_local = isinstance(origin.transport, bzrlib.transport.local.LocalTransport)
 
-    clone_path = os.path.join(dirname, 'clone')
+    shared_path = os.path.join(gitdir, 'bzr')
+    try:
+        shared_dir = bzrlib.bzrdir.BzrDir.open(shared_path)
+    except bzrlib.errors.NotBranchError:
+        shared_dir = bzrlib.bzrdir.BzrDir.create(shared_path)
+    try:
+        shared_repo = shared_dir.open_repository()
+    except bzrlib.errors.NoRepositoryPresent:
+        shared_repo = shared_dir.create_repository(shared=True)
+
+    if not is_local:
+        clone_path = os.path.join(dirname, 'clone')
+        if not os.path.exists(clone_path):
+            os.mkdir(clone_path)
 
     try:
         repo = origin.open_repository()
@@ -763,8 +776,6 @@ def get_repo(url, alias):
         branch = origin.open_branch()
 
         if not is_local:
-            if not os.path.exists(clone_path):
-                os.mkdir(clone_path)
             peers[name] = branch
             branches[name] = get_remote_branch(origin, branch, name)
         else:
@@ -774,9 +785,6 @@ def get_repo(url, alias):
     else:
         # repository
 
-        if not is_local and not os.path.exists(clone_path):
-            clonedir = bzrlib.bzrdir.BzrDir.create(clone_path)
-
         for branch in repo.find_branches():
 
             name = repo.user_transport.relpath(branch.base)
@@ -800,7 +808,7 @@ def fix_path(alias, orig_url):
     subprocess.call(cmd)
 
 def main(args):
-    global marks, prefix, dirname
+    global marks, prefix, gitdir, dirname
     global tags, filenodes
     global blob_marks
     global parsed_refs
-- 
1.8.2.1.884.g3532a8d
