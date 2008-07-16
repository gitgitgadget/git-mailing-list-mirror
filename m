From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Add some performance testing scripts
Date: Wed, 16 Jul 2008 21:35:49 +0200
Message-ID: <20080716193549.3467.13072.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 21:38:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJCoY-0004UT-SK
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755816AbYGPTg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jul 2008 15:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755631AbYGPTg1
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 15:36:27 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3585 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324AbYGPTg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 15:36:26 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KJCn0-00030Z-00; Wed, 16 Jul 2008 20:35:50 +0100
User-Agent: StGIT/0.14.3.197.gba718
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88735>

find_patchbomb.py: Given a git repo, finds the longest linear sequence
  of commits. Useful for testing StGit on a real repository.

setup.sh: Creates two test repositories, one synthetic and one based
  on the Linux kernel repo, with strategically placed tags.

create_synthetic_repo.py: Helper script for setup.sh; it produces
  output that is to be fed to git fast-import.

perftest.py: Runs one of a (small) number of hard-coded performance
  tests against a copy of one of the repos created by setup.sh. The
  initial testcases all involve uncommitting a large number of patches
  and then rebasing them.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 perf/.gitignore               |    2 +
 perf/create_synthetic_repo.py |   61 ++++++++++++++++++++++++++++
 perf/find_patchbomb.py        |   31 ++++++++++++++
 perf/perftest.py              |   89 +++++++++++++++++++++++++++++++++=
++++++++
 perf/setup.sh                 |   52 ++++++++++++++++++++++++
 5 files changed, 235 insertions(+), 0 deletions(-)
 create mode 100644 perf/.gitignore
 create mode 100644 perf/create_synthetic_repo.py
 create mode 100644 perf/find_patchbomb.py
 create mode 100644 perf/perftest.py
 create mode 100644 perf/setup.sh


diff --git a/perf/.gitignore b/perf/.gitignore
new file mode 100644
index 0000000..dfae110
--- /dev/null
+++ b/perf/.gitignore
@@ -0,0 +1,2 @@
+/*.orig
+/*.trash
diff --git a/perf/create_synthetic_repo.py b/perf/create_synthetic_repo=
=2Epy
new file mode 100644
index 0000000..4d6ef6b
--- /dev/null
+++ b/perf/create_synthetic_repo.py
@@ -0,0 +1,61 @@
+next_mark =3D 1
+def get_mark():
+    global next_mark
+    next_mark +=3D 1
+    return (next_mark - 1)
+
+def write_data(s):
+    print 'data %d' % len(s)
+    print s
+
+def write_blob(s):
+    print 'blob'
+    m =3D get_mark()
+    print 'mark :%d' % m
+    write_data(s)
+    return m
+
+def write_commit(branch, files, msg, parent =3D None):
+    print 'commit %s' % branch
+    m =3D get_mark()
+    print 'mark :%d' % m
+    auth =3D 'X Ample <xa@example.com> %d +0000' % (1000000000 + m)
+    print 'author %s' % auth
+    print 'committer %s' % auth
+    write_data(msg)
+    if parent !=3D None:
+        print 'from :%d' % parent
+    for fn, fm in sorted(files.iteritems()):
+        print 'M 100644 :%d %s' % (fm, fn)
+    return m
+
+def set_ref(ref, mark):
+    print 'reset %s' % ref
+    print 'from :%d' % mark
+
+def stdblob(fn):
+    return ''.join('%d %s\n' % (x, fn) for x in xrange(10))
+
+def iter_paths():
+    for i in xrange(32):
+        for j in xrange(32):
+            for k in xrange(32):
+                yield '%02d/%02d/%02d' % (i, j, k)
+
+def setup():
+    def t(name): return 'refs/tags/%s' % name
+    files =3D dict((fn, write_blob(stdblob(fn))) for fn in iter_paths(=
))
+    initial =3D write_commit(t('bomb-base'), files, 'Initial commit')
+    set_ref(t('bomb-top'), initial)
+    for fn in iter_paths():
+        write_commit(t('bomb-top'),
+                     { fn: write_blob(stdblob(fn) + 'Last line\n') },
+                     'Add last line to %s' % fn)
+    write_commit(t('add-file'), { 'woo-hoo.txt': write_blob('woo-hoo\n=
') },
+                 'Add a new file', parent =3D initial)
+    files =3D dict((fn, write_blob('First line\n' + stdblob(fn)))
+                 for fn in iter_paths())
+    write_commit(t('modify-all'), files, 'Add first line to all files'=
,
+                 parent =3D initial)
+
+setup()
diff --git a/perf/find_patchbomb.py b/perf/find_patchbomb.py
new file mode 100644
index 0000000..69a78c7
--- /dev/null
+++ b/perf/find_patchbomb.py
@@ -0,0 +1,31 @@
+# Feed this with git rev-list HEAD --parents
+
+import sys
+
+parents =3D {}
+for line in sys.stdin.readlines():
+    commits =3D line.split()
+    parents[commits[0]] =3D commits[1:]
+
+sequence_num =3D {}
+stack =3D []
+for commit in parents.keys():
+    stack.append(commit)
+    while stack:
+        c =3D stack.pop()
+        if c in sequence_num:
+            continue
+        ps =3D parents[c]
+        if len(ps) =3D=3D 1:
+            p =3D ps[0]
+            if p in sequence_num:
+                sequence_num[c] =3D 1 + sequence_num[p]
+            else:
+                stack.append(c)
+                stack.append(p)
+        else:
+            sequence_num[c] =3D 0
+
+(num, commit) =3D max((num, commit) for (commit, num)
+                    in sequence_num.iteritems())
+print '%s is a sequence of %d patches' % (commit, num)
diff --git a/perf/perftest.py b/perf/perftest.py
new file mode 100644
index 0000000..2655869
--- /dev/null
+++ b/perf/perftest.py
@@ -0,0 +1,89 @@
+import datetime, subprocess, sys
+
+def duration(t1, t2):
+    d =3D t2 - t1
+    return 86400*d.days + d.seconds + 1e-6*d.microseconds
+
+class Run(object):
+    def __init__(self):
+        self.__cwd =3D None
+        self.__log =3D []
+    def __call__(self, *cmd, **args):
+        kwargs =3D { 'cwd': self.__cwd }
+        if args.get('capture_stdout', False):
+            kwargs['stdout'] =3D subprocess.PIPE
+        start =3D datetime.datetime.now()
+        p =3D subprocess.Popen(cmd, **kwargs)
+        (out, err) =3D p.communicate()
+        stop =3D datetime.datetime.now()
+        self.__log.append((cmd, duration(start, stop)))
+        return out
+    def cd(self, dir):
+        self.__cwd =3D dir
+    def summary(self):
+        def pcmd(c): return ' '.join(c)
+        def ptime(t): return '%.3f' % t
+        (cs, times) =3D zip(*self.__log)
+        ttime =3D sum(times)
+        cl =3D max(len(pcmd(c)) for c in cs)
+        tl =3D max(len(ptime(t)) for t in list(times) + [ttime])
+        for (c, t) in self.__log:
+            print '%*s  %*s' % (tl, ptime(t), -cl, pcmd(c))
+        print '%*s' % (tl, ptime(ttime))
+
+perftests =3D {}
+perftestdesc =3D {}
+def perftest(desc, name =3D None):
+    def decorator(f):
+        def g():
+            r =3D Run()
+            f(r)
+            r.summary()
+        perftests[name or f.__name__] =3D g
+        perftestdesc[name or f.__name__] =3D desc
+        return g
+    return decorator
+
+def copy_testdir(dir):
+    dir =3D dir.rstrip('/')
+    tmp =3D dir + '.trash'
+    r =3D Run()
+    r('rsync', '-a', '--delete', dir + '/', tmp)
+    return tmp
+
+def new_rebase(r, ref):
+    top =3D r('stg', 'top', capture_stdout =3D True)
+    r('stg', 'pop', '-a')
+    r('git', 'reset', '--hard', ref)
+    r('stg', 'goto', top.strip())
+
+def old_rebase(r, ref):
+    r('stg', 'rebase', ref)
+
+def def_rebasetest(rebase, dir, tag):
+    @perftest('%s rebase onto %s in %s' % (rebase, tag, dir),
+              'rebase-%srebase-%s-%s' % (rebase, tag, dir))
+    def rebasetest(r):
+        r.cd(copy_testdir(dir))
+        r('stg', 'init')
+        if dir =3D=3D 'synt':
+            r('stg', 'uncommit', '-n', '500')
+        else:
+            r('stg', 'uncommit', '-x', '-t', 'bomb-base')
+        if rebase =3D=3D 'new':
+            new_rebase(r, tag)
+        else:
+            old_rebase(r, tag)
+for rebase in ['old', 'new']:
+    for (dir, tag) in [('synt', 'add-file'),
+                       ('synt', 'modify-all'),
+                       ('linux', 'add-file')]:
+        def_rebasetest(rebase, dir, tag)
+
+args =3D sys.argv[1:]
+if len(args) =3D=3D 0:
+    for (fun, desc) in sorted(perftestdesc.iteritems()):
+        print '%s: %s' % (fun, desc)
+else:
+    for test in args:
+        perftests[test]()
diff --git a/perf/setup.sh b/perf/setup.sh
new file mode 100644
index 0000000..b92ddfc
--- /dev/null
+++ b/perf/setup.sh
@@ -0,0 +1,52 @@
+krepo=3D'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-=
2.6.git'
+
+get_linux() {
+    rm -rf linux.orig
+    git clone "$krepo" linux.orig
+}
+
+mod_linux() {
+    # Tag the top and base of a very long linear sequence of commits.
+    git tag bomb-top 85040bcb4643cba578839e953f25e2d1965d83d0
+    git tag bomb-base bomb-top~1470
+
+    # Add a file at the base of the linear sequence.
+    git checkout bomb-base
+    echo "woo-hoo" > woo-hoo.txt
+    git add woo-hoo.txt
+    git commit -m "Add a file"
+    git tag add-file
+
+    # Clean up and go to start position.
+    git gc
+    git update-ref refs/heads/master bomb-top
+    git checkout master
+}
+
+setup_linux () {
+    get_linux
+    ( cd linux.orig && mod_linux )
+}
+
+create_empty () {
+    dir=3D"$1"
+    rm -rf $dir
+    mkdir $dir
+    ( cd $dir && git init )
+}
+
+fill_synthetic () {
+    python ../create_synthetic_repo.py | git fast-import
+    git gc --aggressive
+    git update-ref refs/heads/master bomb-top
+    git checkout master
+}
+
+setup_synthetic()
+{
+    create_empty synt.orig
+    ( cd synt.orig && fill_synthetic )
+}
+
+setup_linux
+setup_synthetic
