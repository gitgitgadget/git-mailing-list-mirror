From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 05/18] remote-bzr: add support to push merges
Date: Tue, 30 Apr 2013 20:09:57 -0500
Message-ID: <1367370610-14250-6-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:12:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLaZ-0007D6-Vb
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934075Ab3EABMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:12:03 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:43823 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934056Ab3EABMB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:12:01 -0400
Received: by mail-yh0-f48.google.com with SMTP id z12so212289yhz.21
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=o2xzXvGt4cELE4Pvcd649Oo16wqg2zIznqMgKqHYDRA=;
        b=ogUOCrP/clpaXEt5Jk3d2hkCH+eCznoLcVAOI5mQ+9hEzkxkjUc4wFFecz3oeL660u
         I+Pi8pXFY2mh+LPacpCnVSAPwb8FfpDHpwHDaN3KD4q0aZRLn74z/ZdwXXIvFWY33EjV
         SApqOEbjQyuk4DdtLXwy1ErH4h35KJAqgrxnubS6mItK0P9mfBENYqtrZYvS1HN0MC0L
         fgLqD3Iv41pZnqf71R2LSI9iXMIKJa0bUUas7uKflLbLvIZbBgX3EIpJ9msym7X08FWK
         Ggc7ChSeRih1QJOhsfpIU+XlOBblrO8AmWFNGey7rfTAIdybOPN1rs3LkAjgNwJ8TZeM
         jwRA==
X-Received: by 10.236.206.226 with SMTP id l62mr138998yho.189.1367370720678;
        Tue, 30 Apr 2013 18:12:00 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id p31sm1606688yhm.10.2013.04.30.18.11.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:11:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223049>

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
1.8.3.rc0.399.gc96a135
