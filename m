From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 02/16] remote-hg: add support for pushing
Date: Sun,  4 Nov 2012 03:13:24 +0100
Message-ID: <1351995218-19889-3-git-send-email-felipe.contreras@gmail.com>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:14:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpj9-0002ES-2h
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824Ab2KDCN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:13:59 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62548 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab2KDCNz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:13:55 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1657497bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CIIfc7C4cjIfTahdFnwuVhgUIc5kjHcksonw6x0jRck=;
        b=kToazib93FUj8NsBGP6FURjq+f6BHL8h4M7XCqh40n+KtE4EnlQi7wZr5eYI6vayuG
         uwL8NzQgu+Ht60Be73Oz+geXinZgN6ZYbZ3MnVzsghK58iAytXgy5B3knq5Y3deEYUOo
         P2XAPQbOwd4x7kYSOeZflKnzU6aIWR4mpjirqvay5QFov121oNXw06HB672LgI4tyN9D
         PZRBGn/KLoxwVijpIcS7MsKkCHcZbuHVBdaqg7MU+0GaJ0I0+17EF5FTQEORI41Yx16R
         LTmLvsA80CNX7K6VfgejKNig3rYB8iYTG17z5qBGacCylxTdJQ6u5oLLqypVT+dloAHR
         t6Sw==
Received: by 10.204.150.141 with SMTP id y13mr1393947bkv.1.1351995235059;
        Sat, 03 Nov 2012 19:13:55 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id gy18sm7942197bkc.4.2012.11.03.19.13.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:13:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208989>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 217 ++++++++++++++++++++++++++++++++++-
 1 file changed, 215 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index e37e278..fcceede 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
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
     def get_mark(self, rev):
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
@@ -174,6 +220,10 @@ def rev_to_mark(rev):
     global marks
     return marks.from_rev(rev)
 
+def mark_to_rev(mark):
+    global marks
+    return marks.to_rev(mark)
+
 def export_ref(repo, name, kind, head):
     global prefix, marks
 
@@ -263,9 +313,17 @@ def do_capabilities(parser):
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
@@ -352,8 +410,161 @@ def do_import(parser):
 
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
+    ref = parser[1]
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
+    ref = parser[1]
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
+    name = parser[1]
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
+    global parsed_refs, bmarks
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
+            if bmark in bmarks:
+                old = bmarks[bmark].hex()
+            else:
+                old = ''
+            if not bookmarks.pushbookmark(parser.repo, bmark, old, node):
+                continue
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
@@ -362,6 +573,8 @@ def main(args):
     dirname = os.path.join(gitdir, 'hg', alias)
     branches = {}
     bmarks = {}
+    blob_marks = {}
+    parsed_refs = {}
 
     repo = get_repo(url, alias)
     prefix = 'refs/hg/%s' % alias
-- 
1.8.0
