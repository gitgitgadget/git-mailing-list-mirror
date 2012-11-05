From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/5] remote-bzr: add support for pushing
Date: Mon,  5 Nov 2012 16:56:18 +0100
Message-ID: <1352130980-3998-4-git-send-email-felipe.contreras@gmail.com>
References: <1352130980-3998-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 16:57:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVP2s-0007CB-Jm
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 16:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465Ab2KEP4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 10:56:52 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38101 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab2KEP4t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 10:56:49 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2063229bkc.19
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 07:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TBTYCTg4vl6IaSUAq8n+mZ+f3JLby2GZqEOmVUOuuKk=;
        b=CjCBVqllF4qHPJK/70JJwK45CzVY4KgBfSxzTHl6JnCbqsKYsHZWGVvZoMiF/W+Ibg
         y9lHVVX4oODcPgIFjbbZ5v4d1FVU8R/jfwBJ4I0qVvAvXAFLyRBpyGcCMsX2//IIkZkF
         Bs1BE4U7VviYzIngZHCMzfCjXIWgZxBiqDqPtFH6vUVrhozHu6oHR0vmjHWUbN2fioFM
         o0wSAwTdzkxaVKNg59SHIk+sKRvP4Ikw0VOlMuDYH7Mtml0yGOtVODCeQilu4+84Oam6
         ncULEsgBYHO16zk0bvHF6svQGfG80lkvprsXgM5vkt6Je3hxAWC/ETHO/QiylH6ClLs6
         DQ3Q==
Received: by 10.204.149.135 with SMTP id t7mr2394309bkv.103.1352131009088;
        Mon, 05 Nov 2012 07:56:49 -0800 (PST)
Received: from localhost (ip-109-43-0-76.web.vodafone.de. [109.43.0.76])
        by mx.google.com with ESMTPS id v14sm10143046bkv.10.2012.11.05.07.56.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 07:56:48 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352130980-3998-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209066>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 295 ++++++++++++++++++++++++++++++++++
 1 file changed, 295 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index ed893b0..9e0062f 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -22,13 +22,17 @@ bzrlib.initialize()
 import bzrlib.plugin
 bzrlib.plugin.load_plugins()
 
+import bzrlib.generate_ids
+
 import sys
 import os
 import json
 import re
+import StringIO
 
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]*)>$')
+RAW_AUTHOR_RE = re.compile('^(\w+) (.+)? <(.*)> (\d+) ([+-]\d+)')
 
 def die(msg, *args):
     sys.stderr.write('ERROR: %s\n' % (msg % args))
@@ -46,6 +50,7 @@ class Marks:
         self.path = path
         self.tips = {}
         self.marks = {}
+        self.rev_marks = {}
         self.last_mark = 0
         self.load()
 
@@ -58,6 +63,9 @@ class Marks:
         self.marks = tmp['marks']
         self.last_mark = tmp['last-mark']
 
+        for rev, mark in self.marks.iteritems():
+            self.rev_marks[mark] = rev
+
     def dict(self):
         return { 'tips': self.tips, 'marks': self.marks, 'last-mark' : self.last_mark }
 
@@ -70,6 +78,9 @@ class Marks:
     def from_rev(self, rev):
         return self.marks[rev]
 
+    def to_rev(self, mark):
+        return self.rev_marks[mark]
+
     def next_mark(self):
         self.last_mark += 1
         return self.last_mark
@@ -82,6 +93,11 @@ class Marks:
     def is_marked(self, rev):
         return self.marks.has_key(rev)
 
+    def new_mark(self, rev, mark):
+        self.marks[rev] = mark
+        self.rev_marks[mark] = rev
+        self.last_mark = mark
+
     def get_tip(self, branch):
         return self.tips.get(branch, None)
 
@@ -116,10 +132,35 @@ class Parser:
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
+        committer = '%s <%s>' % (name, email)
+        tz = int(tz)
+        tz = ((tz / 100) * 3600) + ((tz % 100) * 60)
+        return (committer, int(date), tz)
+
 def rev_to_mark(rev):
     global marks
     return marks.from_rev(rev)
 
+def mark_to_rev(mark):
+    global marks
+    return marks.to_rev(mark)
+
 def fixup_user(user):
     name = mail = None
     user = user.replace('"', '')
@@ -296,9 +337,255 @@ def do_import(parser):
 
     sys.stdout.flush()
 
+def parse_blob(parser):
+    global blob_marks
+
+    parser.next()
+    mark = parser.get_mark()
+    parser.next()
+    data = parser.get_data()
+    blob_marks[mark] = data
+    parser.next()
+
+class CustomTree():
+
+    def __init__(self, repo, revid, parents, files):
+        global files_cache
+
+        self.repo = repo
+        self.revid = revid
+        self.parents = parents
+        self.updates = files
+
+        def copy_tree(revid):
+            files = files_cache[revid] = {}
+            tree = repo.repository.revision_tree(revid)
+            repo.lock_read()
+            try:
+                for path, entry in tree.iter_entries_by_dir():
+                    files[path] = entry.file_id
+            finally:
+                repo.unlock()
+            return files
+
+        if len(parents) == 0:
+            self.base_id = bzrlib.revision.NULL_REVISION
+            self.base_files = {}
+        else:
+            self.base_id = parents[0]
+            self.base_files = files_cache.get(self.base_id, None)
+            if not self.base_files:
+                self.base_files = copy_tree(self.base_id)
+
+        self.files = files_cache[revid] = self.base_files.copy()
+
+    def last_revision(self):
+        return self.base_id
+
+    def iter_changes(self):
+        changes = []
+
+        def get_parent(dirname, basename):
+            parent_fid = self.base_files.get(dirname, None)
+            if parent_fid:
+                return parent_fid
+            parent_fid = self.files.get(dirname, None)
+            if parent_fid:
+                return parent_fid
+            if basename == '':
+                return None
+            d = add_entry(dirname, 'directory')
+            return d[0]
+
+        def add_entry(path, kind):
+            dirname, basename = os.path.split(path)
+            parent_fid = get_parent(dirname, basename)
+            fid = bzrlib.generate_ids.gen_file_id(path)
+            change = (fid,
+                    (None, path),
+                    True,
+                    (False, True),
+                    (None, parent_fid),
+                    (None, basename),
+                    (None, kind),
+                    (None, False))
+            self.files[path] = change[0]
+            changes.append(change)
+            return change
+
+        def update_entry(path, kind):
+            dirname, basename = os.path.split(path)
+            fid = self.base_files[path]
+            parent_fid = get_parent(dirname, basename)
+            change = (fid,
+                    (path, path),
+                    True,
+                    (True, True),
+                    (parent_fid, parent_fid),
+                    (basename, basename),
+                    (kind, kind),
+                    (False, False))
+            self.files[path] = change[0]
+            changes.append(change)
+            return change
+
+        def remove_entry(path, kind):
+            dirname, basename = os.path.split(path)
+            fid = self.base_files[path]
+            parent_fid = get_parent(dirname, basename)
+            change = (fid,
+                    (path, None),
+                    True,
+                    (True, False),
+                    (parent_fid, None),
+                    (basename, None),
+                    (kind, None),
+                    (False, None))
+            del self.files[path]
+            changes.append(change)
+            return change
+
+        for path, f in self.updates.iteritems():
+            if 'deleted' in f:
+                remove_entry(path, 'file')
+            elif path in self.base_files:
+                update_entry(path, 'file')
+            else:
+                add_entry(path, 'file')
+
+        return changes
+
+    def get_file_with_stat(self, file_id, path=None):
+        return (StringIO.StringIO(self.updates[path]['data']), None)
+
+def parse_commit(parser):
+    global marks, blob_marks, bmarks, parsed_refs
+    global mode
+
+    parents = []
+
+    ref = parser[1]
+    parser.next()
+
+    if ref != 'refs/heads/master':
+        die("bzr doesn't support multiple branches; use 'master'")
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
+        parents.append(parser.get_mark())
+        parser.next()
+    while parser.check('merge'):
+        parents.append(parser.get_mark())
+        parser.next()
+
+    files = {}
+
+    for line in parser:
+        if parser.check('M'):
+            t, m, mark_ref, path = line.split(' ', 3)
+            mark = int(mark_ref[1:])
+            f = { 'mode' : m, 'data' : blob_marks[mark] }
+        elif parser.check('D'):
+            t, path = line.split(' ')
+            f = { 'deleted' : True }
+        else:
+            die('Unknown file command: %s' % line)
+        files[path] = f
+
+    repo = parser.repo
+
+    committer, date, tz = committer
+    parents = [str(mark_to_rev(p)) for p in parents]
+    revid = bzrlib.generate_ids.gen_revision_id(committer, date)
+    props = {}
+    props['branch-nick'] = repo.nick
+
+    mtree = CustomTree(repo, revid, parents, files)
+    changes = mtree.iter_changes()
+
+    repo.lock_write()
+    try:
+        builder = repo.get_commit_builder(parents, None, date, tz, committer, props, revid, False)
+        try:
+            list(builder.record_iter_changes(mtree, mtree.last_revision(), changes))
+            builder.finish_inventory()
+            builder.commit(data.decode('utf-8', 'replace'))
+        except Exception, e:
+            builder.abort()
+            raise
+    finally:
+        repo.unlock()
+
+    parsed_refs[ref] = revid
+    marks.new_mark(revid, commit_mark)
+
+def parse_reset(parser):
+    global parsed_refs
+
+    ref = parser[1]
+    parser.next()
+
+    if ref != 'refs/heads/master':
+        die("bzr doesn't support multiple branches; use 'master'")
+
+    # ugh
+    if parser.check('commit'):
+        parse_commit(parser)
+        return
+    if not parser.check('from'):
+        return
+    from_mark = parser.get_mark()
+    parser.next()
+
+    parsed_refs[ref] = mark_to_rev(from_mark)
+
+def do_export(parser):
+    global parsed_refs, dirname
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
+            pass
+        elif parser.check('feature'):
+            pass
+        else:
+            die('unhandled export command: %s' % line)
+
+    repo = parser.repo
+
+    for ref, revid in parsed_refs.iteritems():
+        if ref == 'refs/heads/master':
+            repo.generate_revision_history(revid, marks.get_tip('master'))
+        print "ok %s" % ref
+    print
+
 def do_capabilities(parser):
+    global dirname
+
     print "import"
+    print "export"
     print "refspec refs/heads/*:%s/heads/*" % prefix
+
+    path = os.path.join(dirname, 'marks-git')
+
+    if os.path.exists(path):
+        print "*import-marks %s" % path
+    print "*export-marks %s" % path
+
     print
 
 def do_list(parser):
@@ -317,6 +604,9 @@ def get_repo(url, alias):
 def main(args):
     global marks, prefix, dirname
     global tags, filenodes
+    global blob_marks
+    global parsed_refs
+    global files_cache
 
     alias = args[1]
     url = args[2]
@@ -324,6 +614,9 @@ def main(args):
     prefix = 'refs/bzr/%s' % alias
     tags = {}
     filenodes = {}
+    blob_marks = {}
+    parsed_refs = {}
+    files_cache = {}
 
     gitdir = os.environ['GIT_DIR']
     dirname = os.path.join(gitdir, 'bzr', alias)
@@ -344,6 +637,8 @@ def main(args):
             do_list(parser)
         elif parser.check('import'):
             do_import(parser)
+        elif parser.check('export'):
+            do_export(parser)
         else:
             die('unhandled command: %s' % line)
         sys.stdout.flush()
-- 
1.8.0
