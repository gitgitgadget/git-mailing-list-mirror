From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Read several objects at once with git cat-file --batch
Date: Fri, 08 Aug 2008 10:07:04 +0200
Message-ID: <20080808080614.23424.28169.stgit@yoghurt>
References: <20080808082728.GA24017@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 10:08:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRN1C-0007gd-0p
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 10:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbYHHIHL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 04:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753544AbYHHIHL
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 04:07:11 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2775 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbYHHIHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 04:07:09 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KRNLd-0006K0-00; Fri, 08 Aug 2008 09:29:21 +0100
In-Reply-To: <20080808082728.GA24017@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.3.222.g9ef2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91632>

Instead of spawning a separate cat-file process for every blob and
commit we want to read. This speeds things up slightly: about 6-8%
when uncommitting and rebasing 1470 linux-kernel patches (perftest.py
rebase-newrebase-add-file-linux).

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/git.py |   34 +++++++++++++++++++++++++++++++++-
 stgit/run.py     |   17 +++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 648e190..95efd9a 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -520,6 +520,37 @@ class RunWithEnvCwd(RunWithEnv):
         @param args: Command and argument vector"""
         return RunWithEnv.run(self, args, self.env_in_cwd)
=20
+class CatFileProcess(object):
+    def __init__(self, repo):
+        self.__repo =3D repo
+        self.__proc =3D None
+    def __get_process(self):
+        if not self.__proc:
+            self.__proc =3D self.__repo.run(['git', 'cat-file', '--bat=
ch']
+                                          ).run_background()
+        return self.__proc
+    def cat_file(self, sha1):
+        p =3D self.__get_process()
+        p.stdin.write('%s\n' % sha1)
+        p.stdin.flush()
+
+        # Read until we have the entire status line.
+        s =3D ''
+        while not '\n' in s:
+            s +=3D os.read(p.stdout.fileno(), 4096)
+        h, b =3D s.split('\n', 1)
+        if h =3D=3D '%s missing' % sha1:
+            raise SomeException()
+        hash, type, length =3D h.split()
+        assert hash =3D=3D sha1
+        length =3D int(length)
+
+        # Read until we have the entire object plus the trailing
+        # newline.
+        while len(b) < length + 1:
+            b +=3D os.read(p.stdout.fileno(), 4096)
+        return type, b[:-1]
+
 class Repository(RunWithEnv):
     """Represents a git repository."""
     def __init__(self, directory):
@@ -531,6 +562,7 @@ class Repository(RunWithEnv):
         self.__default_index =3D None
         self.__default_worktree =3D None
         self.__default_iw =3D None
+        self.__catfile =3D CatFileProcess(self)
     env =3D property(lambda self: { 'GIT_DIR': self.__git_dir })
     @classmethod
     def default(cls):
@@ -580,7 +612,7 @@ class Repository(RunWithEnv):
     directory =3D property(lambda self: self.__git_dir)
     refs =3D property(lambda self: self.__refs)
     def cat_object(self, sha1):
-        return self.run(['git', 'cat-file', '-p', sha1]).raw_output()
+        return self.__catfile.cat_file(sha1)[1]
     def rev_parse(self, rev):
         try:
             return self.get_commit(self.run(
diff --git a/stgit/run.py b/stgit/run.py
index 7493ed3..ccca059 100644
--- a/stgit/run.py
+++ b/stgit/run.py
@@ -130,6 +130,19 @@ class Run:
             raise self.exc('%s failed: %s' % (self.__cmd[0], e))
         self.__log_end(self.exitcode)
         self.__check_exitcode()
+    def __run_background(self):
+        """Run in background."""
+        assert self.__indata =3D=3D None
+        try:
+            p =3D subprocess.Popen(self.__cmd, env =3D self.__env, cwd=
 =3D self.__cwd,
+                                 stdin =3D subprocess.PIPE,
+                                 stdout =3D subprocess.PIPE,
+                                 stderr =3D subprocess.PIPE)
+        except OSError, e:
+            raise self.exc('%s failed: %s' % (self.__cmd[0], e))
+        self.stdin =3D p.stdin
+        self.stdout =3D p.stdout
+        self.stderr =3D p.stderr
     def returns(self, retvals):
         self.__good_retvals =3D retvals
         return self
@@ -181,6 +194,10 @@ class Run:
     def run(self):
         """Just run, with no IO redirection."""
         self.__run_noio()
+    def run_background(self):
+        """Run as a background process."""
+        self.__run_background()
+        return self
     def xargs(self, xargs):
         """Just run, with no IO redirection. The extra arguments are
         appended to the command line a few at a time; the command is
