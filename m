From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 01/14] Add new remote-hg transport helper
Date: Tue, 30 Oct 2012 05:35:23 +0100
Message-ID: <1351571736-4682-2-git-send-email-felipe.contreras@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Oct 30 05:36:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3Yd-0005ey-D8
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab2J3Efy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:35:54 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56861 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab2J3Efx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:35:53 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2268812bkc.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EMMw8UUfDBEVlaK9c2+ZzZ/ZiJGoAX3SBC8h8mVtU8U=;
        b=IdsHWFV4irXQo9Om52sSfKq2kjBNMlEAmi76B6+nmg5znCUDMNFLWYRHm20YwTQWhz
         mFGk/NjD9g/DZ/uvoJgdJIwn3GXZrifNbpx5g1JO8SpnKmoPrTxzQ1RdDrxbcMRFSYm/
         IlPlnonS9asMbHzGLlLE70jZzHM2H9z1oSU2N91T5V/4fJ2c3VKtWKvCTGuHARQ+1zC+
         bD94O7UetZMxeOHRh33IgI7UggJaPD2RfqPWxfIiA/6m88pmc4zpX+UVdNc8Xd3KTAHN
         Uyzf1SRYYNMXvbsiihMc2wt0lOvSHxGxhuM9dDN8g8NkOfcPH952wIDKyt6GQO34L0cZ
         5bFg==
Received: by 10.204.145.218 with SMTP id e26mr2245946bkv.95.1351571752252;
        Mon, 29 Oct 2012 21:35:52 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id z22sm5161041bkw.2.2012.10.29.21.35.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 21:35:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208665>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 359 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 359 insertions(+)
 create mode 100755 contrib/remote-hg/git-remote-hg

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
new file mode 100755
index 0000000..67d39fa
--- /dev/null
+++ b/contrib/remote-hg/git-remote-hg
@@ -0,0 +1,359 @@
+#!/usr/bin/env python
+#
+# Copyright (c) 2012 Felipe Contreras
+#
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
+NAME_RE = re.compile('^([^<>]+)')
+AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]+)>$')
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
+def gittz(tz):
+    return '%+03d%02d' % (-tz / 3600, -tz % 3600 / 60)
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
+    def next(self):
+        self.line = self.get_line()
+        if self.line == 'done':
+            self.line = None
+
+def export_file(fc):
+    d = fc.data()
+    print "M %s inline %s" % (gitmode(fc.flags()), fc.path())
+    print "data %d" % len(d)
+    print d
+
+def get_filechanges(repo, ctx, parents):
+    l = [repo.status(p, ctx)[:3] for p in parents]
+    changed, added, removed = [set(sum(e, [])) for e in zip(*l)]
+    return added | changed, removed
+
+def fixup_user(user):
+    user = user.replace('"', '')
+    name = mail = None
+    m = AUTHOR_RE.match(user)
+    if m:
+        name = m.group(1)
+        mail = m.group(2).strip()
+    else:
+        m = NAME_RE.match(user)
+        if m:
+            name = m.group(1).strip()
+
+    if not name:
+        name = 'Unknown'
+    if not mail:
+        mail = 'unknown'
+
+    return '%s <%s>' % (name, mail)
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
+            peer, dstpeer = hg.clone(myui, {}, url, local_path, update=False, pull=True)
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
+def export_ref(repo, name, kind, head):
+    global prefix, marks
+
+    ename = '%s/%s' % (kind, name)
+    tip = marks.get_tip(ename)
+
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
+        author = "%s %d %s" % (fixup_user(user), time, gittz(tz))
+        if 'committer' in extra:
+            user, time, tz = extra['committer'].rsplit(' ', 2)
+            committer = "%s %s %s" % (user, time, gittz(int(tz)))
+        else:
+            committer = author
+
+        parents = [p for p in repo.changelog.parentrevs(rev) if p >= 0]
+
+        if len(parents) == 0:
+            modified = c.manifest().keys()
+            removed = []
+        else:
+            modified, removed = get_filechanges(repo, c, parents)
+
+        if len(parents) == 0 and rev:
+            print 'reset %s/%s' % (prefix, ename)
+
+        print "commit %s/%s" % (prefix, ename)
+        print "mark :%d" % (marks.next_mark(rev))
+        print "author %s" % (author)
+        print "committer %s" % (committer)
+        print "data %d" % (len(desc))
+        print desc
+
+        if len(parents) > 0:
+            print "from :%s" % (rev_to_mark(parents[0]))
+            if len(parents) > 1:
+                print "merge :%s" % (rev_to_mark(parents[1]))
+
+        for f in removed:
+            print "D %s" % (f)
+        for f in modified:
+            export_file(c.filectx(f))
+        print
+
+        count += 1
+        if (count % 100 == 0):
+            print "progress revision %d '%s' (%d/%d)" % (rev, name, count, len(revs))
+            print "#############################################################"
+
+    # make sure the ref is updated
+    print "reset %s/%s" % (prefix, ename)
+    print "from :%u" % rev_to_mark(rev)
+    print
+
+    marks.set_tip(ename, rev)
+
+def export_tag(repo, tag):
+    export_ref(repo, tag, 'tags', repo[tag])
+
+def export_branch(repo, branch):
+    tip = get_branch_tip(repo, branch)
+    head = repo[tip]
+    export_ref(repo, branch, 'branches', head)
+
+def export_head(repo):
+    global g_head
+    export_ref(repo, g_head[0], g_head[1], g_head[2])
+
+def do_capabilities(parser):
+    global prefix, dirname
+
+    print "import"
+    print "refspec refs/heads/branches/*:%s/branches/*" % prefix
+    print "refspec refs/tags/*:%s/tags/*" % prefix
+    print
+
+def get_branch_tip(repo, branch):
+    global branches
+
+    heads = branches.get(branch, None)
+    if not heads:
+        return None
+
+    # verify there's only one head
+    if (len(heads) > 1):
+        warn("Branch '%s' has more than one head, consider merging" % branch)
+        return repo.branchtip(branch)
+
+    return heads[0]
+
+def list_branch_head(repo, cur):
+    global g_head
+
+    tip = get_branch_tip(repo, cur)
+    head = 'branches/' + cur
+    print "@refs/heads/%s HEAD" % head
+    g_head = (head, 'branches', repo[tip])
+
+def do_list(parser):
+    global branches
+
+    repo = parser.repo
+    for branch in repo.branchmap():
+        heads = repo.branchheads(branch)
+        if len(heads):
+            branches[branch] = heads
+
+    cur = repo.dirstate.branch()
+
+    list_branch_head(repo, cur)
+    for branch in branches:
+        print "? refs/heads/branches/%s" % branch
+
+    for tag, node in repo.tagslist():
+        if tag == 'tip':
+            continue
+        print "? refs/tags/%s" % tag
+
+    print
+
+def do_import(parser):
+    repo = parser.repo
+
+    path = os.path.join(dirname, 'marks-git')
+
+    print "feature done"
+    if os.path.exists(path):
+        print "feature import-marks=%s" % path
+    print "feature export-marks=%s" % path
+    sys.stdout.flush()
+
+    # lets get all the import lines
+    while parser.check('import'):
+        ref = parser[1]
+
+        if (ref == 'HEAD'):
+            export_head(repo)
+        elif ref.startswith('refs/heads/branches/'):
+            branch = ref[len('refs/heads/branches/'):]
+            export_branch(repo, branch)
+        elif ref.startswith('refs/tags/'):
+            tag = ref[len('refs/tags/'):]
+            export_tag(repo, tag)
+
+        parser.next()
+
+    print 'done'
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
+        else:
+            die('unhandled command: %s' % line)
+        sys.stdout.flush()
+
+    marks.store()
+
+sys.exit(main(sys.argv))
-- 
1.8.0
