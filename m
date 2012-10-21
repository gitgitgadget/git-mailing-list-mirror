From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/6] remote-hg: add support for pushing
Date: Sun, 21 Oct 2012 19:49:00 +0200
Message-ID: <1350841744-21564-3-git-send-email-felipe.contreras@gmail.com>
References: <1350841744-21564-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 19:49:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPzeY-0002gq-Py
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 19:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402Ab2JURtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 13:49:25 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35579 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303Ab2JURtY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 13:49:24 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1757274wib.1
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 10:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Fi8Ichx+k99oCmbIl2RjEGTivwe7Sv+GpvNqygXkt5g=;
        b=g+NriQ8DqpkDEQy0gdI+Dxu86rw/YfjM5+NPY81IKrvBGosYPfuepas4uOSF1yqmj1
         ppZ15ym9TTGbet5p44YjEuPXo8EUYjd1VH/QfgKvKCZMX9ii4L8iiE+J0OxerXEYhq1z
         PVaIlchP1/BMO7/RMdW9GoRl/d/SSmD633L0/jmWhOJHw9oDQ0TRvCSYU2PyZcv05ait
         2Wie7uNEo6r3lGweZN8cNDqcdyqdn9EQ0kES4XqvJvcXhDyw//ud6Ssv2tMg9XHkfkdf
         TnOiUKPy2mLTL020hjBc1Ek0rS5n/xXnBFvjXBBJ3QaEIDTSFCsQqU4cdXZpvqRqYsbe
         cCIQ==
Received: by 10.180.87.74 with SMTP id v10mr15820793wiz.21.1350841762755;
        Sun, 21 Oct 2012 10:49:22 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id az2sm8539817wib.10.2012.10.21.10.49.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 10:49:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc2.7.g0961fdf.dirty
In-Reply-To: <1350841744-21564-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208129>

Some parsing of fast-export parsing might be missing, but I couldn't find any.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 156 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index f0ce4a4..fc4510c 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -6,7 +6,7 @@
 # Then you can clone with:
 # git clone hg::/path/to/mercurial/repo/
 
-from mercurial import hg, ui
+from mercurial import hg, ui, context
 
 import re
 import sys
@@ -16,6 +16,7 @@ import json
 first = True
 
 AUTHOR_RE = re.compile('^((.+?) )?(<.+?>)$')
+RAW_AUTHOR_RE = re.compile('^(\w+) (.+) <(.+)> (\d+) ([+-]\d+)')
 
 def die(msg, *args):
     sys.stderr.write('ERROR: %s\n' % (msg % args))
@@ -27,12 +28,17 @@ def warn(msg, *args):
 def gitmode(flags):
     return 'l' in flags and '120000' or 'x' in flags and '100755' or '100644'
 
+def hgmode(mode):
+    m = { '0100755': 'x', '0120000': 'l' }
+    return m.get(mode, '')
+
 class Marks:
 
     def __init__(self, path):
         self.path = path
         self.tips = {}
         self.marks = {}
+        self.rev_hgmarks = {}
         self.last_mark = 0
 
         self.load()
@@ -47,6 +53,9 @@ class Marks:
         self.marks = tmp['marks']
         self.last_mark = tmp['last-mark']
 
+        for rev, mark in self.marks.iteritems():
+            self.rev_hgmarks[mark] = int(rev)
+
     def dict(self):
         return { 'tips': self.tips, 'marks': self.marks, 'last-mark' : self.last_mark }
 
@@ -59,11 +68,19 @@ class Marks:
     def from_rev(self, rev):
         return self.marks[str(rev)]
 
+    def to_rev(self, mark):
+        return self.rev_hgmarks[mark]
+
     def next_mark(self, rev):
         self.last_mark += 1
         self.marks[str(rev)] = self.last_mark
         return self.last_mark
 
+    def new_mark(self, rev, mark):
+        self.marks[str(rev)] = mark
+        self.rev_hgmarks[mark] = rev
+        self.last_mark = mark
+
     def is_marked(self, rev):
         return self.marks.has_key(str(rev))
 
@@ -96,6 +113,28 @@ class Parser:
     def __iter__(self):
         return self.each_block('')
 
+    def next(self):
+        self.line = self.get_line()
+        if self.line == 'done':
+            self.line = None
+
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
+        return list(m.groups())[1:]
+
 def export_file(fc):
     if fc.path() == '.hgtags':
         return
@@ -150,6 +189,10 @@ def rev_to_mark(rev):
     global marks
     return marks.from_rev(rev)
 
+def mark_to_rev(mark):
+    global marks
+    return marks.to_rev(mark)
+
 def export_tag(repo, tag):
     global prefix
     print "reset %s/tags/%s" % (prefix, tag)
@@ -229,8 +272,16 @@ def do_capabilities(parser):
     global prefix, dirname
 
     print "import"
+    print "export"
     print "refspec refs/heads/*:%s/branches/*" % prefix
     print "refspec refs/tags/*:%s/tags/*" % prefix
+
+    path = os.path.join(dirname, 'marks-git')
+
+    if os.path.exists(path):
+        print "*import-marks %s" % path
+    print "*export-marks %s" % path
+
     print
 
 def do_list(parser):
@@ -277,8 +328,108 @@ def do_import(parser):
         tag = ref[len('refs/tags/'):]
         export_tag(repo, tag)
 
+def parse_blob(parser):
+    global blob_marks
+
+    parser.next()
+    if parser.check('mark'):
+        mark = parser.get_mark()
+        parser.next()
+    data = parser.get_data()
+    blob_marks[mark] = data
+    return
+
+def parse_commit(parser):
+    global marks, blob_marks
+
+    from_mark = merge_mark = None
+
+    a = parser.line.split(' ')
+    ref = a[1]
+    if ref.startswith('refs/heads/'):
+        branch = ref[len('refs/heads/'):]
+    parser.next()
+
+    if parser.check('mark'):
+        commit_mark = parser.get_mark()
+        parser.next()
+    if parser.check('author'):
+        author = parser.get_author()
+        parser.next()
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
+            t, mode, mark_ref, path = line.split(' ')
+            mark = int(mark_ref[1:])
+            f = { 'mode' : hgmode(mode), 'data' : blob_marks[mark] }
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
+        return context.memfilectx(f, of['data'], False, False, None)
+
+    repo = parser.repo
+
+    committer_name, committer_email, date, tz = committer
+    date = int(date)
+    tz = int(tz)
+    tz = ((tz / 100) * 3600) + ((tz % 100) * 60)
+    extra = {}
+    extra['branch'] = branch
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
+            '%s <%s>' % (committer_name, committer_email), (date, -tz), extra)
+
+    node = repo.commitctx(ctx)
+    rev = repo[node].rev()
+
+    marks.new_mark(rev, commit_mark)
+
+    print "ok %s" % ref
+
+def do_export(parser):
+    for line in parser.each_block('done'):
+        if parser.check('blob'):
+            parse_blob(parser)
+        elif parser.check('commit'):
+            parse_commit(parser)
+    print
+
 def main(args):
-    global prefix, dirname, marks, branches
+    global prefix, dirname, branches
+    global marks, blob_marks
 
     alias = args[1]
     url = args[2]
@@ -286,6 +437,7 @@ def main(args):
     gitdir = os.environ['GIT_DIR']
     dirname = os.path.join(gitdir, 'hg', alias)
     branches = {}
+    blob_marks = {}
 
     repo = get_repo(url, alias)
     prefix = 'refs/hg/%s' % alias
-- 
1.8.0.rc2.7.g0961fdf.dirty
