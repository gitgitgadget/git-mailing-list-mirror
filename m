From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 8/8] remote-hg: support for notes
Date: Wed, 28 Aug 2013 14:23:13 -0500
Message-ID: <1377717793-27170-9-git-send-email-felipe.contreras@gmail.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 28 21:28:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VElQ2-0003rw-Te
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 21:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133Ab3H1T2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 15:28:38 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:65432 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755101Ab3H1T2h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 15:28:37 -0400
Received: by mail-oa0-f45.google.com with SMTP id m1so4615100oag.4
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 12:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zdA38czxOHHx/UfSrajXlnIodqu6aW6heXrW88LWkqU=;
        b=iPNjZwTNOQ6KRRyStiWeDQtRXRQINtpUsOg2pxXtyFguTBBtSroEvI86NVTqMXEqa+
         3JdTBKGylXqnZXEgCgpz/x31JxYBOQ11U2k4BPmdYPo4lhRTyrOnTBz5wADtIDPKNAZm
         6iMDtnLzUVtlLs6z5CIqqdwKvkLanO0vFEHhV+w5ZfYsRacBAZqhUH/XZMU4fHzobeMU
         lanGLktFDJwBw6Mrb/oKxsoqfXikablfHF+j/HnGjHZox6q/7zzs+sLPw4FEXAaglxGo
         JTg/dD+clSBf5IYFcAUSohX0EZ/8SArSv8+nJTWB7y5Dy38zGPbtcI05ZKIbbb9C4+/H
         YTTg==
X-Received: by 10.182.199.74 with SMTP id ji10mr7771715obc.69.1377718117144;
        Wed, 28 Aug 2013 12:28:37 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm24219522obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Aug 2013 12:28:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233202>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 307d82c..0dbda75 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -23,6 +23,7 @@ import subprocess
 import urllib
 import atexit
 import urlparse, hashlib
+import time as ptime
 
 #
 # If you are not in hg-git-compat mode and want to disable the tracking of
@@ -126,6 +127,7 @@ class Marks:
         self.rev_marks = {}
         self.last_mark = 0
         self.version = 0
+        self.last_note = 0
 
     def load(self):
         if not os.path.exists(self.path):
@@ -137,6 +139,7 @@ class Marks:
         self.marks = tmp['marks']
         self.last_mark = tmp['last-mark']
         self.version = tmp.get('version', 1)
+        self.last_note = tmp.get('last-note', 0)
 
         for rev, mark in self.marks.iteritems():
             self.rev_marks[mark] = rev
@@ -150,7 +153,7 @@ class Marks:
         self.version = 2
 
     def dict(self):
-        return { 'tips': self.tips, 'marks': self.marks, 'last-mark' : self.last_mark, 'version' : self.version }
+        return { 'tips': self.tips, 'marks': self.marks, 'last-mark' : self.last_mark, 'version' : self.version, 'last-note' : self.last_note }
 
     def store(self):
         json.dump(self.dict(), open(self.path, 'w'))
@@ -525,6 +528,31 @@ def export_ref(repo, name, kind, head):
     print "from :%u" % rev_to_mark(head)
     print
 
+    pending_revs = set(revs) - notes
+    if pending_revs:
+        note_mark = marks.next_mark()
+        ref = "refs/notes/hg"
+
+        print "commit %s" % ref
+        print "mark :%d" % (note_mark)
+        print "committer remote-hg <> %s" % (ptime.strftime('%s %z'))
+        desc = "Notes for %s\n" % (name)
+        print "data %d" % (len(desc))
+        print desc
+        if marks.last_note:
+            print "from :%u" % marks.last_note
+
+        for rev in pending_revs:
+            notes.add(rev)
+            c = repo[rev]
+            print "N inline :%u" % rev_to_mark(c)
+            msg = c.hex()
+            print "data %d" % (len(msg))
+            print msg
+        print
+
+        marks.last_note = note_mark
+
     marks.set_tip(ename, head.hex())
 
 def export_tag(repo, tag):
@@ -629,6 +657,7 @@ def do_import(parser):
         print "feature import-marks=%s" % path
     print "feature export-marks=%s" % path
     print "feature force"
+    print "feature notes"
     sys.stdout.flush()
 
     tmp = encoding.encoding
@@ -1126,6 +1155,7 @@ def main(args):
     global filenodes
     global fake_bmark, hg_version
     global dry_run
+    global notes, alias
 
     alias = args[1]
     url = args[2]
@@ -1165,6 +1195,7 @@ def main(args):
     except:
         hg_version = None
     dry_run = False
+    notes = set()
 
     repo = get_repo(url, alias)
     prefix = 'refs/hg/%s' % alias
-- 
1.8.4-fc
