From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 03/14] remote-hg: add support for pushing
Date: Tue, 30 Oct 2012 05:35:25 +0100
Message-ID: <1351571736-4682-4-git-send-email-felipe.contreras@gmail.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 05:36:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3Yn-0005qh-Da
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab2J3EgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:36:03 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56861 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab2J3EgB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:36:01 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2268812bkc.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=41v+WPlRk/Wy4EsLJT/EGTHIFPoraafedPSO2GY+uD8=;
        b=bH7jOZUIfYj17wDQE9wav6cspYDOqLD2KnUfYEtQtMpHgQprwOzVEwNgCtY/7J3RsH
         EtWXhccHVlF27U5fuVJ0q4XOlWrmY89YufrBjw2wMMoCtX7SUf4S16hRhFaLJm5InwGi
         ks3Jn8u4ln5Kjq+aLKE0CxGgJP5N7zqct3Fq0Om971onM01iZkNH2kifNoDznyGky0rb
         Pg6E6vNwzlUf1yn8BA8qVrq+hAH6pHq/ad/XX3bWjQ59TykKdKskd2prOijsBUvrlTzo
         X5QalOZd8mRXCpTafNDDPmhSaBgEO3MtVz4yb9dCrr0R00CNAAWL94EoIGAwmmx900ZJ
         iHyg==
Received: by 10.204.8.196 with SMTP id i4mr9702949bki.74.1351571761038;
        Mon, 29 Oct 2012 21:36:01 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id r15sm5164681bkw.9.2012.10.29.21.35.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 21:36:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208666>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 215 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 213 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index 9e29daa..337ba40 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -9,7 +9,7 @@
 # Then you can clone with:
 # git clone hg::/path/to/mercurial/repo/
 
-from mercurial import hg, ui, bookmarks
+from mercurial import hg, ui, bookmarks, context
 
 import re
 import sys
@@ -18,6 +18,7 @@ import json
 
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]+)>$')
+RAW_AUTHOR_RE = re.compile('^(\w+) (?:(.+)? )?<(.+)> (\d+) ([+-]\d+)')
 
 def die(msg, *args):
     sys.stderr.write('ERROR: %s\n' % (msg % args))
@@ -32,12 +33,17 @@ def gitmode(flags):
 def gittz(tz):
     return '%+03d%02d' % (-tz / 3600, -tz % 3600 / 60)
 
+def hgmode(mode):
+    m = { '0100755': 'x', '0120000': 'l' }
+    return m.get(mode, '')
+
 class Marks:
 
     def __init__(self, path):
         self.path = path
         self.tips = {}
         self.marks = {}
+        self.rev_marks = {}
         self.last_mark = 0
 
         self.load()
@@ -52,6 +58,9 @@ class Marks:
         self.marks = tmp['marks']
         self.last_mark = tmp['last-mark']
 
+        for rev, mark in self.marks.iteritems():
+            self.rev_marks[mark] = int(rev)
+
     def dict(self):
         return { 'tips': self.tips, 'marks': self.marks, 'last-mark' : self.last_mark }
 
@@ -64,11 +73,19 @@ class Marks:
     def from_rev(self, rev):
         return self.marks[str(rev)]
 
+    def to_rev(self, mark):
+        return self.rev_marks[mark]
+
     def next_mark(self, rev):
         self.last_mark += 1
         self.marks[str(rev)] = self.last_mark
         return self.last_mark
 
+    def new_mark(self, rev, mark):
+        self.marks[str(rev)] = mark
+        self.rev_marks[mark] = rev
+        self.last_mark = mark
+
     def is_marked(self, rev):
         return self.marks.has_key(str(rev))
 
@@ -106,6 +123,35 @@ class Parser:
         if self.line == 'done':
             self.line = None
 
+    def get_mark(self):
+        i = self.line.index(':') + 1
+        return int(self.line[i:])
+
+    def get_data(self):
+        if not self.check('data'):
+            return None
+        i = self.line.index(' ') + 1
+        size = int(self.line[i:])
+        return sys.stdin.read(size)
+
+    def get_author(self):
+        m = RAW_AUTHOR_RE.match(self.line)
+        if not m:
+            return None
+        _, name, email, date, tz = m.groups()
+
+        if email != 'unknown':
+            if name:
+                user = '%s <%s>' % (name, email)
+            else:
+                user = '<%s>' % (email)
+        else:
+            user = name
+
+        tz = int(tz)
+        tz = ((tz / 100) * 3600) + ((tz % 100) * 60)
+        return (user, int(date), -tz)
+
 def export_file(fc):
     d = fc.data()
     print "M %s inline %s" % (gitmode(fc.flags()), fc.path())
@@ -160,6 +206,10 @@ def rev_to_mark(rev):
     global marks
     return marks.from_rev(rev)
 
+def mark_to_rev(mark):
+    global marks
+    return marks.to_rev(mark)
+
 def export_ref(repo, name, kind, head):
     global prefix, marks
 
@@ -249,9 +299,17 @@ def do_capabilities(parser):
     global prefix, dirname
 
     print "import"
+    print "export"
     print "refspec refs/heads/branches/*:%s/branches/*" % prefix
     print "refspec refs/heads/*:%s/bookmarks/*" % prefix
     print "refspec refs/tags/*:%s/tags/*" % prefix
+
+    path = os.path.join(dirname, 'marks-git')
+
+    if os.path.exists(path):
+        print "*import-marks %s" % path
+    print "*export-marks %s" % path
+
     print
 
 def get_branch_tip(repo, branch):
@@ -334,8 +392,159 @@ def do_import(parser):
 
     print 'done'
 
+def parse_blob(parser):
+    global blob_marks
+
+    parser.next()
+    mark = parser.get_mark()
+    parser.next()
+    data = parser.get_data()
+    blob_marks[mark] = data
+    parser.next()
+    return
+
+def parse_commit(parser):
+    global marks, blob_marks, bmarks, parsed_refs
+
+    from_mark = merge_mark = None
+
+    a = parser.line.split(' ')
+    ref = a[1]
+    parser.next()
+
+    commit_mark = parser.get_mark()
+    parser.next()
+    author = parser.get_author()
+    parser.next()
+    committer = parser.get_author()
+    parser.next()
+    data = parser.get_data()
+    parser.next()
+    if parser.check('from'):
+        from_mark = parser.get_mark()
+        parser.next()
+    if parser.check('merge'):
+        merge_mark = parser.get_mark()
+        parser.next()
+        if parser.check('merge'):
+            die('octopus merges are not supported yet')
+
+    files = {}
+
+    for line in parser:
+        if parser.check('M'):
+            t, m, mark_ref, path = line.split(' ')
+            mark = int(mark_ref[1:])
+            f = { 'mode' : hgmode(m), 'data' : blob_marks[mark] }
+        elif parser.check('D'):
+            t, path = line.split(' ')
+            f = { 'deleted' : True }
+        else:
+            die('Unknown file command: %s' % line)
+        files[path] = f
+
+    def getfilectx(repo, memctx, f):
+        of = files[f]
+        if 'deleted' in of:
+            raise IOError
+        is_exec = of['mode'] == 'x'
+        is_link = of['mode'] == 'l'
+        return context.memfilectx(f, of['data'], is_link, is_exec, None)
+
+    repo = parser.repo
+
+    user, date, tz = author
+    extra = {}
+
+    if committer != author:
+        extra['committer'] = "%s %u %u" % committer
+
+    if from_mark:
+        p1 = repo.changelog.node(mark_to_rev(from_mark))
+    else:
+        p1 = '\0' * 20
+
+    if merge_mark:
+        p2 = repo.changelog.node(mark_to_rev(merge_mark))
+    else:
+        p2 = '\0' * 20
+
+    ctx = context.memctx(repo, (p1, p2), data,
+            files.keys(), getfilectx,
+            user, (date, tz), extra)
+
+    node = repo.commitctx(ctx)
+
+    rev = repo[node].rev()
+
+    parsed_refs[ref] = node
+
+    marks.new_mark(rev, commit_mark)
+
+def parse_reset(parser):
+    a = parser.line.split(' ')
+    ref = a[1]
+    parser.next()
+    # ugh
+    if parser.check('commit'):
+        parse_commit(parser)
+        return
+    if not parser.check('from'):
+        return
+    from_mark = parser.get_mark()
+    parser.next()
+
+    node = parser.repo.changelog.node(mark_to_rev(from_mark))
+    parsed_refs[ref] = node
+
+def parse_tag(parser):
+    a = parser.line.split(' ')
+    name = a[1]
+    parser.next()
+    from_mark = parser.get_mark()
+    parser.next()
+    tagger = parser.get_author()
+    parser.next()
+    data = parser.get_data()
+    parser.next()
+
+    # nothing to do
+
+def do_export(parser):
+    global parsed_refs
+
+    parser.next()
+
+    for line in parser.each_block('done'):
+        if parser.check('blob'):
+            parse_blob(parser)
+        elif parser.check('commit'):
+            parse_commit(parser)
+        elif parser.check('reset'):
+            parse_reset(parser)
+        elif parser.check('tag'):
+            parse_tag(parser)
+        elif parser.check('feature'):
+            pass
+        else:
+            die('unhandled export command: %s' % line)
+
+    for ref, node in parsed_refs.iteritems():
+        if ref.startswith('refs/heads/branches'):
+            pass
+        elif ref.startswith('refs/heads/'):
+            bmark = ref[len('refs/heads/'):]
+            bookmarks.pushbookmark(parser.repo, bmark, '', node)
+        elif ref.startswith('refs/tags/'):
+            tag = ref[len('refs/tags/'):]
+            parser.repo.tag([tag], node, None, True, None, {})
+        print "ok %s" % ref
+
+    print
+
 def main(args):
-    global prefix, dirname, marks, branches, bmarks
+    global prefix, dirname, branches, bmarks
+    global marks, blob_marks, parsed_refs
 
     alias = args[1]
     url = args[2]
@@ -344,6 +553,8 @@ def main(args):
     dirname = os.path.join(gitdir, 'hg', alias)
     branches = {}
     bmarks = {}
+    blob_marks = {}
+    parsed_refs = {}
 
     repo = get_repo(url, alias)
     prefix = 'refs/hg/%s' % alias
-- 
1.8.0
