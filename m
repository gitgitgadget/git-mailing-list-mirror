From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] remote-hg: support for notes
Date: Thu, 29 Aug 2013 16:50:00 -0500
Message-ID: <1377813000-24465-1-git-send-email-felipe.contreras@gmail.com>
References: <xmqqa9k049qc.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 23:54:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFAAy-0004uC-Pb
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 23:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065Ab3H2Vym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 17:54:42 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:59704 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab3H2Vyl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 17:54:41 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so1377336oag.7
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 14:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iwc8dJOapLcu2nOEQlfk2ZagFbYY+DNUItAIed4d7XM=;
        b=Teko1zMuBAtakHuYNu6VkJfJrsPzM2hfHMiDUO4icIwWI8kbXSJcOkYoclT2k25BVl
         GbHpOD6Qb9IbfcWrdaamU6zcQdaIEl7KYanE9Bdx4LtgYYbB/Est+vKUfKVnLfmrhOPp
         UMUA2uoIGEg2pzH5O+2GSGtAq0Tk7htSrtTnmEoSc7ZcFCpmnqfpaBEQQ++cK7aDPzG+
         Dm2eK8P6vGzUKB2nCqtNYliNomLnVMpE69hc7AwiW6lDeewi2M+QCySjPANtlxgh7G1T
         ltis5E7O3b10Ci4EjEm1zbV3pEFacjRsb3TU5eosgG/ibo9xMulYh8V9GY103XSpJTdN
         Q+EQ==
X-Received: by 10.182.61.19 with SMTP id l19mr4244648obr.55.1377813281085;
        Thu, 29 Aug 2013 14:54:41 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z2sm33702876obi.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 14:54:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <xmqqa9k049qc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233371>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 307d82c..e49fcfa 100755
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
@@ -1126,6 +1154,7 @@ def main(args):
     global filenodes
     global fake_bmark, hg_version
     global dry_run
+    global notes, alias
 
     alias = args[1]
     url = args[2]
@@ -1165,6 +1194,7 @@ def main(args):
     except:
         hg_version = None
     dry_run = False
+    notes = set()
 
     repo = get_repo(url, alias)
     prefix = 'refs/hg/%s' % alias
-- 
1.8.4-fc
