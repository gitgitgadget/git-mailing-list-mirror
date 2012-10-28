From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 03/13] remote-hg: add support for pushing
Date: Sun, 28 Oct 2012 04:54:03 +0100
Message-ID: <1351396453-29042-4-git-send-email-felipe.contreras@gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 04:54:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSJxa-0002qk-OQ
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 04:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838Ab2J1Dyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 23:54:36 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:62048 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab2J1Dyf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 23:54:35 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1289746eaa.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 20:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EcnrtVQFWQ6Xu+6LzkwYqlNzMh+0Sl9j/d1lPikNpjA=;
        b=fCZI/y0N99fVVqui0mNV7Yvk+4Tnh7RT6W1XsI9DBb1k7uCMbyrJfzfb4muGVn3T5h
         4AnKI6u5QUiRCldCLVtIUY6DaDEqRV0/jlmpHbuQQJEechqqPAm41iwoUvEAWDCX+Qur
         1hHQg0zXHvwZ8wObpgxegXOpEeew9i4hs2825BJVjnbF2xBWaG5zbxYApjj3jQz/HL4F
         9JFGLo+x36bezda3bAxX1qy4yVkAzCqfWGymsZcsG2/uG1fTROAVm7ddIl11f81cKcfO
         7aBCjOD9w/h8PHZ0zUL5v4oaX1mrkOeLdA/p4Yn+/+EBXrWAQu37vKBrp+Me1rjC5pBu
         yLNg==
Received: by 10.14.179.69 with SMTP id g45mr38441509eem.42.1351396475286;
        Sat, 27 Oct 2012 20:54:35 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id e1sm13232522eem.3.2012.10.27.20.54.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2012 20:54:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208518>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 215 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 213 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index 4ba9ee6..4021a7d 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -6,7 +6,7 @@
 # Then you can clone with:
 # git clone hg::/path/to/mercurial/repo/
 
-from mercurial import hg, ui, bookmarks
+from mercurial import hg, ui, bookmarks, context
 
 import re
 import sys
@@ -15,6 +15,7 @@ import json
 
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]+)>$')
+RAW_AUTHOR_RE = re.compile('^(\w+) (?:(.+)? )?<(.+)> (\d+) ([+-]\d+)')
 
 def die(msg, *args):
     sys.stderr.write('ERROR: %s\n' % (msg % args))
@@ -29,12 +30,17 @@ def gitmode(flags):
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
@@ -49,6 +55,9 @@ class Marks:
         self.marks = tmp['marks']
         self.last_mark = tmp['last-mark']
 
+        for rev, mark in self.marks.iteritems():
+            self.rev_marks[mark] = int(rev)
+
     def dict(self):
         return { 'tips': self.tips, 'marks': self.marks, 'last-mark' : self.last_mark }
 
@@ -61,11 +70,19 @@ class Marks:
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
 
@@ -103,6 +120,35 @@ class Parser:
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
@@ -157,6 +203,10 @@ def rev_to_mark(rev):
     global marks
     return marks.from_rev(rev)
 
+def mark_to_rev(mark):
+    global marks
+    return marks.to_rev(mark)
+
 def export_ref(repo, name, kind, head):
     global prefix, marks
 
@@ -246,9 +296,17 @@ def do_capabilities(parser):
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
@@ -331,8 +389,159 @@ def do_import(parser):
 
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
@@ -341,6 +550,8 @@ def main(args):
     dirname = os.path.join(gitdir, 'hg', alias)
     branches = {}
     bmarks = {}
+    blob_marks = {}
+    parsed_refs = {}
 
     repo = get_repo(url, alias)
     prefix = 'refs/hg/%s' % alias
-- 
1.8.0
