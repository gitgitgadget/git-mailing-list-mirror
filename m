From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] Add new remote-hg transport helper
Date: Sat, 20 Oct 2012 17:00:06 +0200
Message-ID: <1350745206-28955-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 20 17:00:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPaXV-0007Mw-5g
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 17:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066Ab2JTPAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 11:00:16 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51053 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab2JTPAP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 11:00:15 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1159036wib.1
        for <git@vger.kernel.org>; Sat, 20 Oct 2012 08:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=b53RClhAkoWvx6s98LgPIoL67P3BGReZnt9G503KNBs=;
        b=mby5bcpzCQ0uZggVNutx1BH369mPXaTytt6vnqChtp21O5EZeMnONcouAcMqrckMNQ
         bJEX1F4VPtn6CiGUgZ5QNWeWOFSMpWDb3e+9bvK5CF702xPes6MjZp+IzMdKPbYECcBx
         zBcuJVbV9ou847LXjSvFmhS4yi95OUToYB+JqpbDIjtijSnFnYpi/ymI3gsA0stD+ZBA
         N1eXKsLQphcWWU8w026543pQ7AqJN8/j8pUiu7wV34dw8s5lwXEG559ttDmZ3wdjiSrS
         UKzj1TOctzepK0nibv2D+ydSWxKQnw4XBfeU6ib2Ot4qvvvya1M9OTGJus2I4zPWhw0D
         +q6w==
Received: by 10.216.141.14 with SMTP id f14mr2576827wej.208.1350745213359;
        Sat, 20 Oct 2012 08:00:13 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id dm3sm10036679wib.3.2012.10.20.08.00.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 20 Oct 2012 08:00:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc2.7.g0961fdf.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208087>

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

One important remote-hg alternative is the one written by Sverre Rabbelier that
is now maintained and distributed in msysgit, however, in my opinion the code
is bloated, and there isn't even a standalone branch to take a look at the
patches, and give them a try.

This version has some features that Sverre's version doesn't:

 * Support for tags
 * Support to specify branchesto pull

Sverre's version has some features this one doesn't:

 * Support for pushing
 * Tests

[1] http://repo.or.cz/w/fast-export.git

Changes since v1:

 * Improved documentation
 * Use more common 'python' binary
 * Warn, don't barf when a branch has multiple heads
 * Fixed marks to fetch after cloned
 * Support for cloning/pulling remote repositories
 * Use a more appropriate internal directory (e.g. .git/hg/origin)
 * Fixes for python3

 contrib/remote-hg/git-remote-hg | 254 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 254 insertions(+)
 create mode 100755 contrib/remote-hg/git-remote-hg

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
new file mode 100755
index 0000000..cc53091
--- /dev/null
+++ b/contrib/remote-hg/git-remote-hg
@@ -0,0 +1,254 @@
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
+    global dirname
+
+    myui = ui.ui()
+    myui.setconfig('ui', 'interactive', 'off')
+
+    if hg.islocal(path):
+        repo = hg.repository(myui, path)
+    else:
+        local_path = os.path.join(dirname, 'clone')
+        if not os.path.exists(local_path):
+            srcpeer, dstpeer = hg.clone(myui, {}, path, local_path, update=False, pull=True)
+            repo = dstpeer.local()
+        else:
+            repo = hg.repository(myui, local_path)
+            peer = hg.peer(myui, {}, path)
+            repo.pull(peer, heads=None, force=True)
+
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
+        warn("Branch '%s' has more than one head, consider merging" % hg_branch(branch))
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
+    global first
+
+    ref = args[1]
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
+    global prefix, dirname, marks, cache, branches
+
+    alias = args[1]
+    url = args[2]
+
+    gitdir = os.environ['GIT_DIR']
+    dirname = os.path.join(gitdir, 'hg', alias)
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
1.8.0.rc2.7.g0961fdf.dirty
