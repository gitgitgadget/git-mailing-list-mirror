From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 11/18] remote-bzr: add support for shared repo
Date: Tue, 30 Apr 2013 20:10:03 -0500
Message-ID: <1367370610-14250-12-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:12:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLb7-0007lg-PY
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934140Ab3EABMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:12:31 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:44132 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934128Ab3EABM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:12:27 -0400
Received: by mail-yh0-f50.google.com with SMTP id b20so214227yha.37
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=PBrsUoiKDSMn8NU6GvmhSU7jRgACtG/UULKDgkn7vYo=;
        b=j2bTTI+wjDBv2A+Ch4ibhntcgwU4TUEosSI8nQoe7vB3dzcUtsN5YppVGRxPKZv7WI
         wNnVCBo04MgWUMOXp6bKO/1Ckb8ON+WdJ85xfWx0rIrfZOWFGztofnenHs3b0T9GqGoI
         mSdAwtxFoMokIL2HljeNeYbOv7NNQ8e1xVi1PMG+D0Hnuzc3Ze4F0gTS4OCe5+9Ky4G6
         yL6sS0baCDqEaDL1wJC0EVJBPe41TCrweYRehF5dklndXhUINJG+BuXY9oupQzVZtzab
         BoRda3MrQfkde5cn+EXPe+07qEEDIgcnBuyVDYgxx/RKHVLuaW0R2j4TVaIuis/9JkCS
         IQhg==
X-Received: by 10.236.143.130 with SMTP id l2mr646911yhj.100.1367370745084;
        Tue, 30 Apr 2013 18:12:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i21sm1579925yhl.15.2013.04.30.18.12.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:12:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223055>

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
1.8.3.rc0.399.gc96a135
