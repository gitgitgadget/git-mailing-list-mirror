From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 7/7] remote-bzr: add support to push special modes
Date: Sun, 11 Nov 2012 15:19:58 +0100
Message-ID: <1352643598-8500-8-git-send-email-felipe.contreras@gmail.com>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:21:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYPF-0007wm-84
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977Ab2KKOUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:20:38 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47320 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab2KKOUh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:20:37 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2064575bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cqozEE/uR3UffUY+zWZLxszPyGCXDBE64G8y03vjQok=;
        b=Qgt5JZTFaav48OmaSMpKeiO/BxvXtSmVzRxyzpgzLSsAus4Clpn2wUuVESqyOc4Vd7
         rc7LskODwTmSeW8JXbfcaLx7P3TjU756XcvWuwNxWX2ALLn19E6IJpZe/iN8eYRQnJIL
         Wa/T1OxPFdLYRzGOjYvI30oWAE+o6w8d/RWmGCSYqyAY7T/IRZnDiC4dM2n5Bv88GDL9
         H3WMv+qL2N8lB/By9TqjN21d/JOEq7FKV0rcdVxiJn51SYBxWL4YURgFykWS6ZdpGuTj
         iVovXvR2ji5rgkbA6NHGNNe+fKYAVeD+W/paGXrnWe9m09ReubaubNmBh9AaGapxkip+
         GldA==
Received: by 10.204.151.136 with SMTP id c8mr3930635bkw.70.1352643636883;
        Sun, 11 Nov 2012 06:20:36 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id z13sm1505566bkv.8.2012.11.11.06.20.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:20:36 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209381>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 60 +++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 2bae5d0..f8919f4 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -370,7 +370,7 @@ class CustomTree():
         self.repo = repo
         self.revid = revid
         self.parents = parents
-        self.updates = files
+        self.updates = {}
 
         def copy_tree(revid):
             files = files_cache[revid] = {}
@@ -394,6 +394,13 @@ class CustomTree():
 
         self.files = files_cache[revid] = self.base_files.copy()
 
+        for path, f in files.iteritems():
+            fid = self.files.get(path, None)
+            if not fid:
+                fid = bzrlib.generate_ids.gen_file_id(path)
+            f['path'] = path
+            self.updates[fid] = f
+
     def last_revision(self):
         return self.base_id
 
@@ -409,13 +416,20 @@ class CustomTree():
                 return parent_fid
             if basename == '':
                 return None
-            d = add_entry(dirname, 'directory')
-            return d[0]
+            fid = bzrlib.generate_ids.gen_file_id(path)
+            d = add_entry(fid, dirname, 'directory')
+            return fid
 
-        def add_entry(path, kind):
+        def add_entry(fid, path, kind, mode = None):
             dirname, basename = os.path.split(path)
             parent_fid = get_parent(dirname, basename)
-            fid = bzrlib.generate_ids.gen_file_id(path)
+
+            executable = False
+            if mode == '100755':
+                executable = True
+            elif mode == '120000':
+                kind = 'symlink'
+
             change = (fid,
                     (None, path),
                     True,
@@ -423,15 +437,21 @@ class CustomTree():
                     (None, parent_fid),
                     (None, basename),
                     (None, kind),
-                    (None, False))
+                    (None, executable))
             self.files[path] = change[0]
             changes.append(change)
             return change
 
-        def update_entry(path, kind):
+        def update_entry(fid, path, kind, mode = None):
             dirname, basename = os.path.split(path)
-            fid = self.base_files[path]
             parent_fid = get_parent(dirname, basename)
+
+            executable = False
+            if mode == '100755':
+                executable = True
+            elif mode == '120000':
+                kind = 'symlink'
+
             change = (fid,
                     (path, path),
                     True,
@@ -439,14 +459,13 @@ class CustomTree():
                     (None, parent_fid),
                     (None, basename),
                     (None, kind),
-                    (None, False))
+                    (None, executable))
             self.files[path] = change[0]
             changes.append(change)
             return change
 
-        def remove_entry(path, kind):
+        def remove_entry(fid, path, kind):
             dirname, basename = os.path.split(path)
-            fid = self.base_files[path]
             parent_fid = get_parent(dirname, basename)
             change = (fid,
                     (path, None),
@@ -460,18 +479,25 @@ class CustomTree():
             changes.append(change)
             return change
 
-        for path, f in self.updates.iteritems():
+        for fid, f in self.updates.iteritems():
+            path = f['path']
+
             if 'deleted' in f:
-                remove_entry(path, 'file')
-            elif path in self.base_files:
-                update_entry(path, 'file')
+                remove_entry(fid, path, 'file')
+                continue
+
+            if path in self.base_files:
+                update_entry(fid, path, 'file', f['mode'])
             else:
-                add_entry(path, 'file')
+                add_entry(fid, path, 'file', f['mode'])
 
         return changes
 
     def get_file_with_stat(self, file_id, path=None):
-        return (StringIO.StringIO(self.updates[path]['data']), None)
+        return (StringIO.StringIO(self.updates[file_id]['data']), None)
+
+    def get_symlink_target(self, file_id):
+        return self.updates[file_id]['data']
 
 def parse_commit(parser):
     global marks, blob_marks, bmarks, parsed_refs
-- 
1.8.0
