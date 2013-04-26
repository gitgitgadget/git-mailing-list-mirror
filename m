From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 12/20] remote-bzr: split marks file
Date: Thu, 25 Apr 2013 20:08:00 -0500
Message-ID: <1366938488-25425-13-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:10:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXAt-0003xY-AD
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833Ab3DZBKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:10:00 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:48181 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932672Ab3DZBJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:09:58 -0400
Received: by mail-oa0-f43.google.com with SMTP id k7so3479760oag.16
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=SxIyrynL7LlleirW2u2+wPleOX84QXb7xFlUotb8P/8=;
        b=0jEYbtQp4BrzayLH3De2eQ+73vv8IanlAt5YOMBpQw7mc5yIzqARgpwBsix+Iaa/tn
         0TOy0DlA5UJ9jz8S8POvz3m4HsNzz0GQor4Hrl/bSkZoK8ZBL5j82yZeoqB5swgfeLEA
         OKVmMGS1GyFydG3Wfy+DkUZ3XZoqr45ROjHmMBldjgvx+lfqnIUSPSkLXTen1xKVe6aP
         D5ZQBqUrKXeAAir7+cG5n8i6vyseRGOihxkEpx5cQv9e5TFMamCWqJv538mMcf947t05
         3pQr5DnGIlMM8uEUmzacQPCeLrZ83vXTLpS83l/6MOTUT3gewkgmrhTtx3aS6ofOlQqH
         FGIQ==
X-Received: by 10.60.133.112 with SMTP id pb16mr21786117oeb.93.1366938597607;
        Thu, 25 Apr 2013 18:09:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id xz9sm6104368oeb.5.2013.04.25.18.09.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:09:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222494>

This way all the remotes can share the same git objects, and the same
marks. The information we want to store per remote is very small.

The code transparently converts from one organization of marks, to the
other. It's rather smooth and there shouldn't be any issues.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 58 ++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 9fe830e..fcd8e41 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -52,22 +52,42 @@ def gittz(tz):
 
 class Marks:
 
-    def __init__(self, path):
-        self.path = path
+    def __init__(self, gitdir, dirname):
+        self.marks_path = os.path.join(gitdir, 'bzr', '.marks-bzr')
+        self.remote_path = os.path.join(dirname, '.marks-bzr')
+        old_path = os.path.join(dirname, 'marks-int')
+
         self.tips = {}
         self.marks = {}
         self.rev_marks = {}
         self.last_mark = 0
-        self.load()
+
+        if not os.path.exists(old_path):
+            self.load()
+        else:
+            self.old_load(old_path)
+            os.remove(old_path)
 
     def load(self):
-        if not os.path.exists(self.path):
-            return
 
-        tmp = json.load(open(self.path))
+        if os.path.exists(self.marks_path):
+            tmp = json.load(open(self.marks_path))
+            self.marks = tmp['marks']
+            self.last_mark = tmp['last-mark']
+
+            for rev, mark in self.marks.iteritems():
+                self.rev_marks[mark] = rev
+
+        if os.path.exists(self.remote_path):
+            tmp = json.load(open(self.remote_path))
+            self.tips = tmp['tips']
+
+    def old_load(self, path):
+
+        tmp = json.load(open(path))
         self.tips = tmp['tips']
-        self.marks = tmp['marks']
-        self.last_mark = tmp['last-mark']
+        self.marks = tmp['marks'] # TODO remove
+        self.last_mark = tmp['last-mark'] # TODO remove
 
         for rev, mark in self.marks.iteritems():
             self.rev_marks[mark] = rev
@@ -76,7 +96,10 @@ class Marks:
         return { 'tips': self.tips, 'marks': self.marks, 'last-mark' : self.last_mark }
 
     def store(self):
-        json.dump(self.dict(), open(self.path, 'w'))
+        d = { 'marks': self.marks, 'last-mark' : self.last_mark }
+        json.dump(d, open(self.marks_path, 'w'))
+        d = { 'tips': self.tips }
+        json.dump(d, open(self.remote_path, 'w'))
 
     def __str__(self):
         return str(self.dict())
@@ -348,10 +371,10 @@ def export_tag(repo, name):
     print
 
 def do_import(parser):
-    global dirname
+    global gitdir
 
     repo = parser.repo
-    path = os.path.join(dirname, 'marks-git')
+    path = os.path.join(gitdir, 'bzr', '.marks-git')
 
     print "feature done"
     if os.path.exists(path):
@@ -678,14 +701,14 @@ def do_export(parser):
     print
 
 def do_capabilities(parser):
-    global dirname
+    global gitdir
 
     print "import"
     print "export"
     print "refspec refs/heads/*:%s/heads/*" % prefix
     print "refspec refs/tags/*:%s/tags/*" % prefix
 
-    path = os.path.join(dirname, 'marks-git')
+    path = os.path.join(gitdir, 'bzr', '.marks-git')
 
     if os.path.exists(path):
         print "*import-marks %s" % path
@@ -848,8 +871,13 @@ def main(args):
 
     repo = get_repo(url, alias)
 
-    marks_path = os.path.join(dirname, 'marks-int')
-    marks = Marks(marks_path)
+    marks = Marks(gitdir, dirname)
+
+    # move old marks
+    old_gitmarks = os.path.join(dirname, 'marks-git')
+    new_gitmarks = os.path.join(gitdir, 'bzr', '.marks-git')
+    if os.path.exists(old_gitmarks):
+        os.rename(old_gitmarks, new_gitmarks)
 
     parser = Parser(repo)
     for line in parser:
-- 
1.8.2.1.884.g3532a8d
