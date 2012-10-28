From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 01/13] Add new remote-hg transport helper
Date: Sun, 28 Oct 2012 04:54:01 +0100
Message-ID: <1351396453-29042-2-git-send-email-felipe.contreras@gmail.com>
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
	id 1TSJxZ-0002qk-Kb
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 04:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab2J1Dy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 23:54:29 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:62048 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab2J1Dy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 23:54:28 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1289746eaa.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 20:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iDiKh2pnY6h39zj9rNSf02Xy6evEDWhAOsMQpIaP+bU=;
        b=aqWZedvwN0hAwpOW0R7R9EtEUuEXaHX/rB/6WYSJnVVDKxEtIxDDbPZUb0UKdpSoMh
         VZja2Jx0u9Dn2O7rU3GFQPA9Uq+7sszK5hlKS0tRRiBAymehRr/notE06EEGRfLDA1HJ
         Ob9DbvlkDmWaFAwhYnfZX2Fa3gUOVFAxLUdgFQfLBwjWdN1T0VCCBIBUvkhdUws8O8Qd
         a2LK1gwB6ud0y3Qs3vjCjEmohuAVXB/+ACs6hYisRK+k9h9md8TUYcR65i0twp6DKdjq
         uHcdjNCnVz1eYI4ZEJyeO3wzqIHBE8WanxOw9FSIqDkdUGplOCSvOM4kVNoFR7QiWqht
         KWMQ==
Received: by 10.14.172.137 with SMTP id t9mr48311986eel.2.1351396467037;
        Sat, 27 Oct 2012 20:54:27 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id c6sm13229687eep.17.2012.10.27.20.54.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2012 20:54:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208519>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 356 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 356 insertions(+)
 create mode 100755 contrib/remote-hg/git-remote-hg

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
new file mode 100755
index 0000000..c771182
--- /dev/null
+++ b/contrib/remote-hg/git-remote-hg
@@ -0,0 +1,356 @@
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
+            print "progress revision %d '%s' (%d/%d)" % (rev, ename, count, len(revs))
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
