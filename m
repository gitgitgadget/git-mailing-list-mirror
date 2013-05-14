From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 22/47] remote-hg: upgrade version 1 marks
Date: Mon, 13 May 2013 23:36:45 -0500
Message-ID: <1368506230-19614-23-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jed Brown <jed@59a2.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:40:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc72C-0004WY-BP
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755377Ab3ENEjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:39:54 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:57643 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474Ab3ENEjv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:39:51 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so100392oag.37
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=nJXMKp4AAfJOPKI6AC9GchT3yfXJkGNTmgrXzTOdOg8=;
        b=Zl8sbNsYJpoUmdIehBFPK1QTjRYNVMFNZcfAwwmrkHFfvpZYe8Afy7iZi/vdoUIuAP
         ksFqg54Bfmccduyv3D4jpy5VqV1P6pWBFGuMHDGUOcbffPf7mW8tOwwD3Jj/2tZgHFmM
         6zp1JzAl90i3FCtYtTv7NQmITShqAhuvMBD7gVueT0sqeKwiyriZhAmkbn9bC1FaCcwN
         tFV9vhByIE8E0Ap+CgrijJT2hkV3MawVvF+Q3Pq9+h2ekwCrI+lYqA8njqwVCwMaHk2I
         D/4py4sDkJ+hfQdNqTa9ba+dcptx86ZyfLHMF7+WtJ+QGtdN7JEtTTkhHuswIj0ViT0h
         ijJQ==
X-Received: by 10.60.131.164 with SMTP id on4mr15206435oeb.70.1368506390984;
        Mon, 13 May 2013 21:39:50 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt1sm816059oeb.5.2013.05.13.21.39.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:39:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224261>

As suggested by Jed Brown; there's no need to re-import all the commits.

Cc: Jed Brown <jed@59a2.org>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index fbd70ef..6cad5cd 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -103,14 +103,20 @@ def get_config_bool(config, default=False):
 
 class Marks:
 
-    def __init__(self, path):
+    def __init__(self, path, repo):
         self.path = path
+        self.repo = repo
         self.clear()
         self.load()
 
         if self.version < VERSION:
-            self.clear()
-            self.version = VERSION
+            if self.version == 1:
+                self.upgrade_one()
+
+            # upgraded?
+            if self.version < VERSION:
+                self.clear()
+                self.version = VERSION
 
     def clear(self):
         self.tips = {}
@@ -133,6 +139,14 @@ class Marks:
         for rev, mark in self.marks.iteritems():
             self.rev_marks[mark] = rev
 
+    def upgrade_one(self):
+        def get_id(rev):
+            return hghex(self.repo.changelog.node(int(rev)))
+        self.tips = dict((name, get_id(rev)) for name, rev in self.tips.iteritems())
+        self.marks = dict((get_id(rev), mark) for rev, mark in self.marks.iteritems())
+        self.rev_marks = dict((mark, get_id(rev)) for mark, rev in self.rev_marks.iteritems())
+        self.version = 2
+
     def dict(self):
         return { 'tips': self.tips, 'marks': self.marks, 'last-mark' : self.last_mark, 'version' : self.version }
 
@@ -976,7 +990,7 @@ def main(args):
         fix_path(alias, peer or repo, url)
 
     marks_path = os.path.join(dirname, 'marks-hg')
-    marks = Marks(marks_path)
+    marks = Marks(marks_path, repo)
 
     parser = Parser(repo)
     for line in parser:
-- 
1.8.3.rc1.579.g184e698
