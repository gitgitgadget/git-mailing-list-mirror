From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 21/47] remote-hg: switch from revisions to SHA-1 noteids
Date: Mon, 13 May 2013 23:36:44 -0500
Message-ID: <1368506230-19614-22-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:40:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc72B-0004WY-Qo
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233Ab3ENEjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:39:49 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:40629 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474Ab3ENEjs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:39:48 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so100340oag.37
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=MHoEMxUk5bE1DxliZKoByhbayOtwNpJ1vykiULBbsdE=;
        b=TQZSd6Of38XhuFNq4cL7sMH/r5BlVaavw521IDUbtPhs3iQtdi8ff8q6pzgzuqCoSk
         TBgHHggQEfWhGx0Aog/BzdeeyCLi2WLWhe1Jo9gfBEq/+RuVo0BSkFXMcLKT1AIVWp+L
         aU3tsXJSzWgWwhOfE9Rxg4sljWtYEsKbx2M2Fe/J98ajCyHTfS2d6MCTn2uLaHJXqTML
         tijdhcehKhpFAvk4LyzCy2mQ4SmiakSosUGVUduvTUGrb0ZvRNeWiKhasvvsSR+NSVUJ
         fHaxWUdk1w5loT2JUPjh5Qd8XkHkGTiA7moYME/Hy579V2J6C+6ydqJ+lOvH5NNCRBpE
         d9EA==
X-Received: by 10.60.97.4 with SMTP id dw4mr15330597oeb.75.1368506387576;
        Mon, 13 May 2013 21:39:47 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id pm16sm4950886oeb.3.2013.05.13.21.39.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:39:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224260>

Otherwise we won't know if revisions are replaced.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 42 +++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 36b8fd4..fbd70ef 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -55,7 +55,7 @@ EMAIL_RE = re.compile('^([^<>]+[^ \\\t<>])?\\b(?:[ \\t<>]*?)\\b([^ \\t<>]+@[^ \\
 AUTHOR_HG_RE = re.compile('^(.*?) ?<(.*?)(?:>(.+)?)?$')
 RAW_AUTHOR_RE = re.compile('^(\w+) (?:(.+)? )?<(.*)> (\d+) ([+-]\d+)')
 
-VERSION = 1
+VERSION = 2
 
 def die(msg, *args):
     sys.stderr.write('ERROR: %s\n' % (msg % args))
@@ -131,7 +131,7 @@ class Marks:
         self.version = tmp.get('version', 1)
 
         for rev, mark in self.marks.iteritems():
-            self.rev_marks[mark] = int(rev)
+            self.rev_marks[mark] = rev
 
     def dict(self):
         return { 'tips': self.tips, 'marks': self.marks, 'last-mark' : self.last_mark, 'version' : self.version }
@@ -143,7 +143,7 @@ class Marks:
         return str(self.dict())
 
     def from_rev(self, rev):
-        return self.marks[str(rev)]
+        return self.marks[rev]
 
     def to_rev(self, mark):
         return self.rev_marks[mark]
@@ -154,19 +154,19 @@ class Marks:
 
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
-        return str(rev) in self.marks
+        return rev in self.marks
 
     def get_tip(self, branch):
-        return self.tips.get(branch, 0)
+        return self.tips.get(branch, None)
 
     def set_tip(self, branch, tip):
         self.tips[branch] = tip
@@ -387,7 +387,7 @@ def get_repo(url, alias):
 
 def rev_to_mark(rev):
     global marks
-    return marks.from_rev(rev)
+    return marks.from_rev(rev.hex())
 
 def mark_to_rev(mark):
     global marks
@@ -398,6 +398,10 @@ def export_ref(repo, name, kind, head):
 
     ename = '%s/%s' % (kind, name)
     tip = marks.get_tip(ename)
+    if tip in repo:
+        tip = repo[tip].rev()
+    else:
+        tip = 0
 
     revs = xrange(tip, head.rev() + 1)
     count = 0
@@ -463,16 +467,16 @@ def export_ref(repo, name, kind, head):
         modified_final = export_files(c.filectx(f) for f in modified)
 
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
 
         for f in modified_final:
             print "M %s :%u %s" % f
@@ -486,10 +490,10 @@ def export_ref(repo, name, kind, head):
 
     # make sure the ref is updated
     print "reset %s/%s" % (prefix, ename)
-    print "from :%u" % rev_to_mark(head.rev())
+    print "from :%u" % rev_to_mark(head)
     print
 
-    marks.set_tip(ename, head.rev())
+    marks.set_tip(ename, head.hex())
 
 def export_tag(repo, tag):
     export_ref(repo, tag, 'tags', repo[hgref(tag)])
@@ -716,12 +720,12 @@ def parse_commit(parser):
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
 
@@ -763,10 +767,8 @@ def parse_commit(parser):
 
     encoding.encoding = tmp
 
-    rev = repo[node].rev()
-
     parsed_refs[ref] = node
-    marks.new_mark(rev, commit_mark)
+    marks.new_mark(node, commit_mark)
 
 def parse_reset(parser):
     global parsed_refs
@@ -782,8 +784,8 @@ def parse_reset(parser):
     from_mark = parser.get_mark()
     parser.next()
 
-    node = parser.repo.changelog.node(mark_to_rev(from_mark))
-    parsed_refs[ref] = hghex(node)
+    rev = mark_to_rev(from_mark)
+    parsed_refs[ref] = rev
 
 def parse_tag(parser):
     name = parser[1]
-- 
1.8.3.rc1.579.g184e698
