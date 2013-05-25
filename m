From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 14/48] remote-hg: upgrade version 1 marks
Date: Fri, 24 May 2013 21:29:30 -0500
Message-ID: <1369449004-17981-15-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jed Brown <jed@59a2.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Hb-0001p1-O7
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033Ab3EYCc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:27 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:42694 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab3EYCcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:25 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so6813436oag.25
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gy2cgwRxFGKfDAlK+gvwNP1+ebV0QC8WRS7Lc4T0zP0=;
        b=a9/ERJYYl/PF2Dv+OSX9eY6GyoK9p9h7D9qmN8psj9lpmbsG0PhKFwp0IYYCi1g1IQ
         4rdlrgRAlV9HoEdV7l9X8uxBAWluKX6oRL3MOarMXbBAEgfMN31uh4UgGm4DPWkSFNbZ
         TYuMfvaB/4z2laUWrWeTVEW+DUIW3HDz6mVSwkhmpXRAyi1ARJIBOIQX8F2bCPkNxXUk
         3jDK+9q0zQ4JgaKqe8+9LJiD+3czgzeshTXpnPSvQmAq5DApdfvry68AaXocSx0YsUFn
         HJkZK634ClkOXTvBz43Byya8R3hqbENVYGlt2/W4xkf7D3MbbUUR7YT1sqPyVQEaFfnC
         xEcA==
X-Received: by 10.182.129.101 with SMTP id nv5mr13238516obb.56.1369449145160;
        Fri, 24 May 2013 19:32:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm20008573obb.14.2013.05.24.19.32.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225428>

As suggested by Jed Brown; there's no need to re-import all the commits.

Cc: Jed Brown <jed@59a2.org>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index ae7699c..2e4f7ca 100755
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
 
@@ -973,7 +987,7 @@ def main(args):
         fix_path(alias, peer or repo, url)
 
     marks_path = os.path.join(dirname, 'marks-hg')
-    marks = Marks(marks_path)
+    marks = Marks(marks_path, repo)
 
     if sys.platform == 'win32':
         import msvcrt
-- 
1.8.3.rc3.312.g47657de
