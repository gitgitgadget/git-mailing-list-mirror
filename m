From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATH 4/4] remote-hg: switch from revisions to SHA-1 noteids
Date: Fri,  5 Apr 2013 05:36:19 -0600
Message-ID: <1365161779-32170-5-git-send-email-felipe.contreras@gmail.com>
References: <1365161779-32170-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 18:56:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWFZ-0002u6-RG
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765121Ab3DELha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 07:37:30 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:65472 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab3DELh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 07:37:28 -0400
Received: by mail-ob0-f171.google.com with SMTP id v19so437736obq.30
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 04:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=lB1uyIlsDJcc3rjrOBLFQlTEJYQZb0SbwpMldY7HxLk=;
        b=0vCRNAe/rlvcYSZLJG/gUziXl/KU6+Of2hTrCYEsp9iKWr8ry1tsalaxdmNCLc4Fy8
         9aXaWv4NRSkMr9+BeQLDfbH+Ke9E8cVVs4mAy7bYak74Fc1/fVW7+goiBE0WBV8xN/CB
         g1e0mBQBj2muDi1m2uLKabjNrlzhFvTLHsvgOUsXFnfwy21m0/cXz26MMZeQU7jlRmrR
         cZpg0CgrxTlkhh3uB8a93OZjxA/2Ufcc6/ipqgFaW6ZnDqKgBe8QdjhYoSNbjxyt551O
         KPfoJymHjOy1+6MM9lIeQ3WHhBXHXcZ6nYfo+Wmi8QvXiM7SFx/QePGCbe4Xj6kB4j+j
         cjIw==
X-Received: by 10.182.235.49 with SMTP id uj17mr7662380obc.18.1365161847642;
        Fri, 05 Apr 2013 04:37:27 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id do4sm7753842oeb.0.2013.04.05.04.37.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 04:37:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365161779-32170-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220173>

Otherwise we won't know if revisions are replaced.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 40 +++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 9e124e1..162dabc 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -43,7 +43,7 @@ AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]*)>$')
 AUTHOR_HG_RE = re.compile('^(.*?) ?<(.*?)(?:>(.+)?)?$')
 RAW_AUTHOR_RE = re.compile('^(\w+) (?:(.+)? )?<(.*)> (\d+) ([+-]\d+)')
 
-VERSION = 1
+VERSION = 2
 
 def die(msg, *args):
     sys.stderr.write('ERROR: %s\n' % (msg % args))
@@ -104,7 +104,7 @@ class Marks:
         self.version = tmp.get('version', 1)
 
         for rev, mark in self.marks.iteritems():
-            self.rev_marks[mark] = int(rev)
+            self.rev_marks[mark] = rev
 
     def dict(self):
         return { 'tips': self.tips, 'marks': self.marks, 'last-mark' : self.last_mark, 'version' : self.version }
@@ -116,23 +116,23 @@ class Marks:
         return str(self.dict())
 
     def from_rev(self, rev):
-        return self.marks[str(rev)]
+        return self.marks[rev]
 
     def to_rev(self, mark):
         return self.rev_marks[mark]
 
     def get_mark(self, rev):
         self.last_mark += 1
-        self.marks[str(rev)] = self.last_mark
+        self.marks[rev] = self.last_mark
         return self.last_mark
 
     def new_mark(self, rev, mark):
-        self.marks[str(rev)] = mark
+        self.marks[rev] = mark
         self.rev_marks[mark] = rev
         self.last_mark = mark
 
     def is_marked(self, rev):
-        return self.marks.has_key(str(rev))
+        return self.marks.has_key(rev)
 
     def get_tip(self, branch):
         return self.tips.get(branch, 0)
@@ -305,7 +305,7 @@ def get_repo(url, alias):
 
 def rev_to_mark(rev):
     global marks
-    return marks.from_rev(rev)
+    return marks.from_rev(rev.hex())
 
 def mark_to_rev(mark):
     global marks
@@ -316,6 +316,10 @@ def export_ref(repo, name, kind, head):
 
     ename = '%s/%s' % (kind, name)
     tip = marks.get_tip(ename)
+    if tip in repo:
+        tip = repo[tip].rev()
+    else:
+        tip = 0
 
     # mercurial takes too much time checking this
     if tip and tip == head.rev():
@@ -382,16 +386,16 @@ def export_ref(repo, name, kind, head):
             print 'reset %s/%s' % (prefix, ename)
 
         print "commit %s/%s" % (prefix, ename)
-        print "mark :%d" % (marks.get_mark(rev))
+        print "mark :%d" % (marks.get_mark(c.hex()))
         print "author %s" % (author)
         print "committer %s" % (committer)
         print "data %d" % (len(desc))
         print desc
 
         if len(parents) > 0:
-            print "from :%s" % (rev_to_mark(parents[0].rev()))
+            print "from :%s" % (rev_to_mark(parents[0]))
             if len(parents) > 1:
-                print "merge :%s" % (rev_to_mark(parents[1].rev()))
+                print "merge :%s" % (rev_to_mark(parents[1]))
 
         for f in modified:
             export_file(c.filectx(f))
@@ -406,10 +410,10 @@ def export_ref(repo, name, kind, head):
 
     # make sure the ref is updated
     print "reset %s/%s" % (prefix, ename)
-    print "from :%u" % rev_to_mark(head.rev())
+    print "from :%u" % rev_to_mark(head)
     print
 
-    marks.set_tip(ename, head.rev())
+    marks.set_tip(ename, head.hex())
 
 def export_tag(repo, tag):
     export_ref(repo, tag, 'tags', repo[tag])
@@ -626,12 +630,12 @@ def parse_commit(parser):
         extra['committer'] = "%s %u %u" % committer
 
     if from_mark:
-        p1 = repo.changelog.node(mark_to_rev(from_mark))
+        p1 = mark_to_rev(from_mark)
     else:
         p1 = '\0' * 20
 
     if merge_mark:
-        p2 = repo.changelog.node(mark_to_rev(merge_mark))
+        p2 = mark_to_rev(merge_mark)
     else:
         p2 = '\0' * 20
 
@@ -672,10 +676,8 @@ def parse_commit(parser):
 
     encoding.encoding = tmp
 
-    rev = repo[node].rev()
-
     parsed_refs[ref] = node
-    marks.new_mark(rev, commit_mark)
+    marks.new_mark(node, commit_mark)
 
 def parse_reset(parser):
     global parsed_refs
@@ -691,8 +693,8 @@ def parse_reset(parser):
     from_mark = parser.get_mark()
     parser.next()
 
-    node = parser.repo.changelog.node(mark_to_rev(from_mark))
-    parsed_refs[ref] = hghex(node)
+    rev = mark_to_rev(from_mark)
+    parsed_refs[ref] = rev
 
 def parse_tag(parser):
     name = parser[1]
-- 
1.8.2
