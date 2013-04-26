From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/20] remote-bzr: add support to push merges
Date: Thu, 25 Apr 2013 20:07:53 -0500
Message-ID: <1366938488-25425-6-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:09:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXAW-0003Zu-TQ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758493Ab3DZBJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:09:39 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:53896 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758382Ab3DZBJi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:09:38 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so3508242oag.15
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=AZn/aYM11n7Ir9RHu2DMESU3X7kpVMmJyFXbcxgnGPY=;
        b=jllukWLs+YVlVKG4B/l8WiMpqk4KFBjcRyWA1/EfeBM7gRNL/ZiSuD9SEPCMQVaGW4
         chGeIKicn+mrTl+Df5wv/AcA3feoiyL2jb7fJlbxr//rthI8EnhvpnXk9TZJVdsCeVDx
         3rGxpl4QHZiFdjxIyY6qyhcbSpyjBPwNa0JkOFMWiF6xef0b9NpJvy2rVuG/vu/klovc
         HIeqVG+YufQLiNC0tc+64Z2DpGQBSrIgQML1KoD41FWyEnvMC4EagITNTBVxRXcjK/4p
         JogXpL+K+5Fbs+1rqcgPEv2PdmoGZJ7KbubkS5XLw06ax+C3O+VEwHANkx0se3dmrV7h
         Kflg==
X-Received: by 10.182.44.227 with SMTP id h3mr19193063obm.16.1366938577650;
        Thu, 25 Apr 2013 18:09:37 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id rn6sm2566841oeb.0.2013.04.25.18.09.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:09:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222487>

In order to do that, we need to store the marks of every file, so that
they can be fetched when needed. Unfortunately we can't tell bazaar that
nothing changed, we need to send the data so that it can figure it out
by itself.

And since it will be requesting a bunch of information by the file_id,
it's better to have a helper dict (rev_files), so that we can fetch it
quickly.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 29 ++++++++++++++++++++--------
 contrib/remote-helpers/test-bzr.sh    | 36 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index eb91d28..6a7f836 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -393,7 +393,7 @@ class CustomTree():
             tree = repo.repository.revision_tree(revid)
             try:
                 for path, entry in tree.iter_entries_by_dir():
-                    files[path] = entry.file_id
+                    files[path] = [entry.file_id, None]
             finally:
                 repo.unlock()
             return files
@@ -408,12 +408,18 @@ class CustomTree():
                 self.base_files = copy_tree(self.base_id)
 
         self.files = files_cache[revid] = self.base_files.copy()
+        self.rev_files = {}
+
+        for path, data in self.files.iteritems():
+            fid, mark = data
+            self.rev_files[fid] = [path, mark]
 
         for path, f in files.iteritems():
-            fid = self.files.get(path, None)
+            fid, mark = self.files.get(path, [None, None])
             if not fid:
                 fid = bzrlib.generate_ids.gen_file_id(path)
             f['path'] = path
+            self.rev_files[fid] = [path, mark]
             self.updates[fid] = f
 
     def last_revision(self):
@@ -423,10 +429,10 @@ class CustomTree():
         changes = []
 
         def get_parent(dirname, basename):
-            parent_fid = self.base_files.get(dirname, None)
+            parent_fid, mark = self.base_files.get(dirname, [None, None])
             if parent_fid:
                 return parent_fid
-            parent_fid = self.files.get(dirname, None)
+            parent_fid, mark = self.files.get(dirname, [None, None])
             if parent_fid:
                 return parent_fid
             if basename == '':
@@ -453,7 +459,7 @@ class CustomTree():
                     (None, basename),
                     (None, kind),
                     (None, executable))
-            self.files[path] = change[0]
+            self.files[path] = [change[0], None]
             changes.append(change)
 
         def update_entry(fid, path, kind, mode = None):
@@ -474,7 +480,7 @@ class CustomTree():
                     (None, basename),
                     (None, kind),
                     (None, executable))
-            self.files[path] = change[0]
+            self.files[path] = [change[0], None]
             changes.append(change)
 
         def remove_entry(fid, path, kind):
@@ -503,16 +509,23 @@ class CustomTree():
             else:
                 add_entry(fid, path, 'file', f['mode'])
 
+            self.files[path][1] = f['mark']
+            self.rev_files[fid][1] = f['mark']
+
         return changes
 
     def get_file_with_stat(self, file_id, path=None):
-        mark = self.updates[file_id]['mark']
+        path, mark = self.rev_files[file_id]
         return (StringIO.StringIO(blob_marks[mark]), None)
 
     def get_symlink_target(self, file_id):
-        mark = self.updates[file_id]['mark']
+        path, mark = self.rev_files[file_id]
         return blob_marks[mark]
 
+    def id2path(self, file_id):
+        path, mark = self.rev_files[file_id]
+        return path
+
 def c_style_unescape(string):
     if string[0] == string[-1] == '"':
         return string.decode('string-escape')[1:-1]
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 34666e1..eca3476 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -228,4 +228,40 @@ test_expect_success 'push utf-8 filenames' '
   test_cmp expected actual
 '
 
+test_expect_success 'pushing a merge' '
+  mkdir -p tmp && cd tmp &&
+  test_when_finished "cd .. && rm -rf tmp" &&
+
+  (
+  bzr init bzrrepo &&
+  cd bzrrepo &&
+  echo one > content &&
+  bzr add content &&
+  bzr commit -m one
+  ) &&
+
+  git clone "bzr::$PWD/bzrrepo" gitrepo &&
+
+  (
+  cd bzrrepo &&
+  echo two > content &&
+  bzr commit -m two
+  ) &&
+
+  (
+  cd gitrepo &&
+  echo three > content &&
+  git commit -a -m three &&
+  git fetch &&
+  git merge origin/master || true &&
+  echo three > content &&
+  git commit -a --no-edit &&
+  git push
+  ) &&
+
+  echo three > expected &&
+  cat bzrrepo/content > actual &&
+  test_cmp expected actual
+'
+
 test_done
-- 
1.8.2.1.884.g3532a8d
