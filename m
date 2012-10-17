From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] Add new git-remote-hd helper
Date: Wed, 17 Oct 2012 14:58:41 +0200
Message-ID: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 14:59:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOTDY-0004wF-5L
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 14:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561Ab2JQM7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 08:59:12 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61873 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285Ab2JQM7L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 08:59:11 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so3566799bkc.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=9T6pP8E3HF1oBMbR8o4rdtQhRVedeqkKlnPd5eFxOzc=;
        b=w6L0CSn8GL5+OjAzod0Nfe1sgWR3I/3ggHEkT0x3/rfcxJ0GeFKBZuJskNFVmWJO07
         b3cGtdl9TfXnxAvk0LE5vMtYyB30pXqMl7PIafHKy6d2aJWw9/yyk2D6iAyISlhXBCU1
         yt/YjsGd2Gzh3mbRiUmHiUxpZ48ALsQMp8+P9WIM8OS3Jh+KrUXixBFvJfrgKdVps532
         Kwm7ANmviJVNu3TIP2t5jDgs51fzKG6HqbyoOs9LiUH22guEGfRMdeuMS0Y7ipJtTFoZ
         yZlOqpqRMXuX4qjCVA8I89qGdD+C8JiFmtqVNbYINRp5bPaOJ6XYSIFbVvY6SYRvWLtG
         M0uQ==
Received: by 10.204.12.205 with SMTP id y13mr5372934bky.46.1350478750359;
        Wed, 17 Oct 2012 05:59:10 -0700 (PDT)
Received: from localhost (ip-109-43-0-45.web.vodafone.de. [109.43.0.45])
        by mx.google.com with ESMTPS id z22sm12761467bkw.2.2012.10.17.05.58.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Oct 2012 05:59:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc2.5.gccf4c94
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207916>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

I've looked at many hg<->git tools and none satisfy me. Too complicated, or too
slow, or to difficult to setup, etc.

The only one I've liked so far is hg-fast-export[1], which is indeed fast,
relatively simple, and relatively easy to use. But it's not properly maintained
any more.

So, I decided to write my own from scratch, using hg-fast-export as
inspiration, and voila.

This one doesn't have any dependencies, just put it into your $PATH, and you
can clone and fetch hg repositories. More importantly to me; the code is
simple, and easy to maintain.

[1] http://repo.or.cz/w/fast-export.git

 contrib/remote-hd/git-remote-hg | 231 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)
 create mode 100755 contrib/remote-hd/git-remote-hg

diff --git a/contrib/remote-hd/git-remote-hg b/contrib/remote-hd/git-remote-hg
new file mode 100755
index 0000000..9157b30
--- /dev/null
+++ b/contrib/remote-hd/git-remote-hg
@@ -0,0 +1,231 @@
+#!/usr/bin/python2
+
+# Inspired by Rocco Rutte's hg-fast-export
+
+# Just copy to your ~/bin, or anywhere in your $PATH.
+# Then you can clone with:
+# hg::file:///path/to/mercurial/repo/
+
+from mercurial import hg, ui
+
+import re
+import sys
+import os
+import json
+
+def die(msg, *args):
+    print >> sys.stderr, 'ERROR:', msg % args
+    sys.exit(1)
+
+def gitmode(flags):
+    return 'l' in flags and '120000' or 'x' in flags and '100755' or '100644'
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
+author_re = re.compile('^((.+?) )?(<.+?>)$')
+
+def fixup_user(user):
+    user = user.replace('"', '')
+    m = author_re.match(user)
+    if m:
+        name = m.group(1)
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
+def get_repo(path, alias):
+    myui = ui.ui()
+    myui.setconfig('ui', 'interactive', 'off')
+    repo = hg.repository(myui, path)
+    return repo
+
+def hg_branch(b):
+    if b == 'master':
+        return 'default'
+    return b
+
+def git_branch(b):
+    if b == 'default':
+        return 'master'
+    return b
+
+def export_tag(repo, tag):
+    global prefix
+    print "reset %s/tags/%s" % (prefix, tag)
+    print "from :%s" % (repo[tag].rev() + 1)
+    print
+
+def export_branch(repo, branch):
+    global prefix, marks, cache, branches
+
+    heads = branches[hg_branch(branch)]
+
+    # verify there's only one head
+    if (len(heads) > 1):
+        die("Branch '%s' has more than one head" % hg_branch(branch))
+
+    head = repo[heads[0]]
+    tip = marks.get(branch, 0)
+    # mercurial takes too much time checking this
+    if tip == head.rev():
+        # nothing to do
+        return
+    revs = repo.revs('%u:%u' % (tip, head))
+    count = 0
+
+    revs = [rev for rev in revs if not cache.get(rev, False)]
+
+    for rev in revs:
+
+        c = repo[rev]
+        (manifest, user, (time, tz), files, desc, extra) = repo.changelog.read(c.node())
+        rev_branch = git_branch(extra['branch'])
+
+        tz = '%+03d%02d' % (-tz / 3600, -tz % 3600 / 60)
+
+        print "commit %s/branches/%s" % (prefix, rev_branch)
+        print "mark :%d" % (rev + 1)
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
+            print "from :%s" % (parents[0] + 1)
+            if len(parents) > 1:
+                print "merge :%s" % (parents[1] + 1)
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
+        cache[rev] = True
+
+    # store the latest revision
+    marks[branch] = rev
+
+def do_capabilities(repo, args):
+    global prefix, dirname
+
+    print "import"
+    print "refspec refs/heads/*:%s/branches/*" % prefix
+    print "refspec refs/tags/*:%s/tags/*" % prefix
+
+    path = os.path.join(dirname, 'marks-git')
+
+    print "*export-marks %s" % path
+    if os.path.exists(path):
+        print "*import-marks %s" % path
+
+    print
+
+def do_list(repo, args):
+    global branches
+
+    head = repo.dirstate.branch()
+    for branch in repo.branchmap():
+        heads = repo.branchheads(branch)
+        if len(heads):
+            branches[branch] = heads
+
+    for branch in branches:
+        print "? refs/heads/%s" % git_branch(branch)
+    for tag, node in repo.tagslist():
+        if tag == 'tip':
+            continue
+        print "? refs/tags/%s" % tag
+    print "@refs/heads/%s HEAD" % git_branch(head)
+    print
+
+def do_import(repo, args):
+    ref = args[1]
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
+    global prefix, dirname, marks, cache, branches
+
+    alias = args[1]
+    url = args[2]
+
+    gitdir = os.environ['GIT_DIR']
+    dirname = os.path.join(gitdir, 'hg')
+    cache = {}
+    branches = {}
+
+    repo = get_repo(url, alias)
+    prefix = 'refs/hg/%s' % alias
+
+    if not os.path.exists(dirname):
+        os.makedirs(dirname)
+
+    marks_path = os.path.join(dirname, 'marks-hg')
+    try:
+        fp = open(marks_path, 'r')
+        marks = json.load(fp)
+        fp.close()
+    except IOError:
+        marks = {}
+
+    line = True
+    while (line):
+        line = sys.stdin.readline().strip()
+        if line == '':
+            break
+        args = line.split()
+        cmd = args[0]
+        if cmd == 'capabilities':
+            do_capabilities(repo, args)
+        elif cmd == 'list':
+            do_list(repo, args)
+        elif cmd == 'import':
+            do_import(repo, args)
+        sys.stdout.flush()
+
+    fp = open(marks_path, 'w')
+    json.dump(marks, fp)
+    fp.close()
+
+sys.exit(main(sys.argv))
-- 
1.8.0.rc2.5.gccf4c94
