From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/6] Add new remote-hg transport helper
Date: Sun, 21 Oct 2012 19:48:59 +0200
Message-ID: <1350841744-21564-2-git-send-email-felipe.contreras@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Oct 21 19:49:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPzeY-0002gq-2Q
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 19:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393Ab2JURtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 13:49:20 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58451 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303Ab2JURtT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 13:49:19 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1631487wgb.1
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oToGhOguOfUzca2ZxW83zFDC7HhiSy8X8bRAXEY2njE=;
        b=Agi1+UzCUcT0WZtirv55fKn59DJM7t98iWWQzvgIu11osNdqUQi9Gl3sO10xpYVzbl
         y92plgIOxkG3pwAGYPSZnwuGfxdPKQCDiYs5uRFHpJMKT2FX/ct6dljhOa9gJUX5+hAN
         v/i/2nan2+dBEi8+tKj8LDri+noyoSIXEOaanRtDTRd4nO12sLbut4qRa8MW+at6bnWv
         zTEt/D4g/F2sHhJ1vSPOfL+ebiGCeNNcEuyxl07iCD+Lql0lDxZV0jJ6pl9eGsbAHorZ
         o7RWF6q2Oq9kzD8CVMoNcnerwBCXWzDz3/50qNCOela120gbmOwNE7mp5YtmgWOZVgqD
         B+nw==
Received: by 10.180.8.134 with SMTP id r6mr31590840wia.18.1350841758375;
        Sun, 21 Oct 2012 10:49:18 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id gg4sm17148918wib.6.2012.10.21.10.49.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 10:49:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc2.7.g0961fdf.dirty
In-Reply-To: <1350841744-21564-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208130>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 313 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 313 insertions(+)
 create mode 100755 contrib/remote-hg/git-remote-hg

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
new file mode 100755
index 0000000..f0ce4a4
--- /dev/null
+++ b/contrib/remote-hg/git-remote-hg
@@ -0,0 +1,313 @@
+#!/usr/bin/python
+
+# Inspired by Rocco Rutte's hg-fast-export
+
+# Just copy to your ~/bin, or anywhere in your $PATH.
+# Then you can clone with:
+# git clone hg::/path/to/mercurial/repo/
+
+from mercurial import hg, ui
+
+import re
+import sys
+import os
+import json
+
+first = True
+
+AUTHOR_RE = re.compile('^((.+?) )?(<.+?>)$')
+
+def die(msg, *args):
+    sys.stderr.write('ERROR: %s\n' % (msg % args))
+    sys.exit(1)
+
+def warn(msg, *args):
+    sys.stderr.write('WARNING: %s\n' % (msg % args))
+
+def gitmode(flags):
+    return 'l' in flags and '120000' or 'x' in flags and '100755' or '100644'
+
+class Marks:
+
+    def __init__(self, path):
+        self.path = path
+        self.tips = {}
+        self.marks = {}
+        self.last_mark = 0
+
+        self.load()
+
+    def load(self):
+        if not os.path.exists(self.path):
+            return
+
+        tmp = json.load(open(self.path))
+
+        self.tips = tmp['tips']
+        self.marks = tmp['marks']
+        self.last_mark = tmp['last-mark']
+
+    def dict(self):
+        return { 'tips': self.tips, 'marks': self.marks, 'last-mark' : self.last_mark }
+
+    def store(self):
+        json.dump(self.dict(), open(self.path, 'w'))
+
+    def __str__(self):
+        return str(self.dict())
+
+    def from_rev(self, rev):
+        return self.marks[str(rev)]
+
+    def next_mark(self, rev):
+        self.last_mark += 1
+        self.marks[str(rev)] = self.last_mark
+        return self.last_mark
+
+    def is_marked(self, rev):
+        return self.marks.has_key(str(rev))
+
+    def get_tip(self, branch):
+        return self.tips.get(branch, 0)
+
+    def set_tip(self, branch, tip):
+        self.tips[branch] = tip
+
+class Parser:
+
+    def __init__(self, repo):
+        self.repo = repo
+        self.line = self.get_line()
+
+    def get_line(self):
+        return sys.stdin.readline().strip()
+
+    def __getitem__(self, i):
+        return self.line.split()[i]
+
+    def check(self, word):
+        return self.line.startswith(word)
+
+    def each_block(self, separator):
+        while self.line != separator:
+            yield self.line
+            self.line = self.get_line()
+
+    def __iter__(self):
+        return self.each_block('')
+
+def export_file(fc):
+    if fc.path() == '.hgtags':
+        return
+    d = fc.data()
+    print "M %s inline %s" % (gitmode(fc.flags()), fc.path())
+    print "data %d" % len(d)
+    print d
+
+def get_filechanges(repo, ctx, parents):
+    l = [repo.status(p, ctx)[:3] for p in parents]
+    changed, added, removed = [sum(e, []) for e in zip(*l)]
+    return added + changed, removed
+
+def fixup_user(user):
+    user = user.replace('"', '')
+    m = AUTHOR_RE.match(user)
+    if m:
+        name = m.group(2)
+        mail = m.group(3)
+    else:
+        name = user
+        mail = None
+
+    if not name:
+        name = 'Unknown'
+    if not mail:
+        mail = '<unknown>'
+
+    return '%s %s' % (name, mail)
+
+def get_repo(url, alias):
+    global dirname
+
+    myui = ui.ui()
+    myui.setconfig('ui', 'interactive', 'off')
+
+    if hg.islocal(url):
+        repo = hg.repository(myui, url)
+    else:
+        local_path = os.path.join(dirname, 'clone')
+        if not os.path.exists(local_path):
+            srcpeer, dstpeer = hg.clone(myui, {}, url, local_path, update=False, pull=True)
+            repo = dstpeer.local()
+        else:
+            repo = hg.repository(myui, local_path)
+            peer = hg.peer(myui, {}, url)
+            repo.pull(peer, heads=None, force=True)
+
+    return repo
+
+def rev_to_mark(rev):
+    global marks
+    return marks.from_rev(rev)
+
+def export_tag(repo, tag):
+    global prefix
+    print "reset %s/tags/%s" % (prefix, tag)
+    print "from :%s" % (rev_to_mark(repo[tag].rev()))
+    print
+
+def export_branch(repo, branch):
+    global prefix, marks, branches
+
+    heads = branches[branch]
+
+    # verify there's only one head
+    if (len(heads) > 1):
+        warn("Branch '%s' has more than one head, consider merging" % branch)
+        tip = repo.branchtip(branch)
+        head = repo[tip]
+    else:
+        head = repo[heads[0]]
+
+    tip = marks.get_tip(branch)
+    # mercurial takes too much time checking this
+    if tip and tip == head.rev():
+        # nothing to do
+        return
+    revs = repo.revs('%u:%u' % (tip, head))
+    count = 0
+
+    revs = [rev for rev in revs if not marks.is_marked(rev)]
+
+    for rev in revs:
+
+        c = repo[rev]
+        (manifest, user, (time, tz), files, desc, extra) = repo.changelog.read(c.node())
+        rev_branch = extra['branch']
+
+        tz = '%+03d%02d' % (-tz / 3600, -tz % 3600 / 60)
+
+        print "commit %s/branches/%s" % (prefix, rev_branch)
+        print "mark :%d" % (marks.next_mark(rev))
+        print "committer %s %d %s" % (fixup_user(user), time, tz)
+        print "data %d" % (len(desc) + 1)
+        print desc
+        print
+
+        parents = [p for p in repo.changelog.parentrevs(rev) if p >= 0]
+
+        if len(parents) == 0:
+            modified = c.manifest().keys()
+            removed = []
+        else:
+            added = []
+            changed = []
+            print "from :%s" % (rev_to_mark(parents[0]))
+            if len(parents) > 1:
+                print "merge :%s" % (rev_to_mark(parents[1]))
+            modified, removed = get_filechanges(repo, c, parents)
+
+        for f in removed:
+            print "D %s" % (f)
+        for f in modified:
+            export_file(c.filectx(f))
+        print
+
+        count += 1
+        if (count % 100 == 0):
+            print "progress revision %d '%s' (%d/%d)" % (rev, branch, count, len(revs))
+            print "#############################################################"
+
+    # make sure the ref is updated
+    print "reset %s/branches/%s" % (prefix, branch)
+    print "from :%u" % rev_to_mark(rev)
+    print
+
+    marks.set_tip(branch, rev)
+
+def do_capabilities(parser):
+    global prefix, dirname
+
+    print "import"
+    print "refspec refs/heads/*:%s/branches/*" % prefix
+    print "refspec refs/tags/*:%s/tags/*" % prefix
+    print
+
+def do_list(parser):
+    global branches
+
+    repo = parser.repo
+    head = repo.dirstate.branch()
+    for branch in repo.branchmap():
+        heads = repo.branchheads(branch)
+        if len(heads):
+            branches[branch] = heads
+
+    for branch in branches:
+        print "? refs/heads/%s" % branch
+    for tag, node in repo.tagslist():
+        if tag == 'tip':
+            continue
+        print "? refs/tags/%s" % tag
+    print "@refs/heads/%s HEAD" % head
+    print
+
+def do_import(parser):
+    global first
+
+    repo = parser.repo
+    ref = parser[1]
+
+    if first:
+        path = os.path.join(dirname, 'marks-git')
+
+        if os.path.exists(path):
+            print "feature import-marks=%s" % path
+        print "feature export-marks=%s" % path
+        sys.stdout.flush()
+        first = False
+
+    if (ref == 'HEAD'):
+        return
+
+    if ref.startswith('refs/heads/'):
+        branch = ref[len('refs/heads/'):]
+        export_branch(repo, branch)
+    elif ref.startswith('refs/tags/'):
+        tag = ref[len('refs/tags/'):]
+        export_tag(repo, tag)
+
+def main(args):
+    global prefix, dirname, marks, branches
+
+    alias = args[1]
+    url = args[2]
+
+    gitdir = os.environ['GIT_DIR']
+    dirname = os.path.join(gitdir, 'hg', alias)
+    branches = {}
+
+    repo = get_repo(url, alias)
+    prefix = 'refs/hg/%s' % alias
+
+    if not os.path.exists(dirname):
+        os.makedirs(dirname)
+
+    marks_path = os.path.join(dirname, 'marks-hg')
+    marks = Marks(marks_path)
+
+    parser = Parser(repo)
+    for line in parser:
+        if parser.check('capabilities'):
+            do_capabilities(parser)
+        elif parser.check('list'):
+            do_list(parser)
+        elif parser.check('import'):
+            do_import(parser)
+        elif parser.check('export'):
+            do_export(parser)
+        sys.stdout.flush()
+
+    marks.store()
+
+sys.exit(main(sys.argv))
-- 
1.8.0.rc2.7.g0961fdf.dirty
