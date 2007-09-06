From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Discard stderr when determining if a patch is already
	applied
Date: Fri, 07 Sep 2007 01:50:48 +0200
Message-ID: <20070906234906.15591.33653.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 01:51:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITR7y-0008JV-EU
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 01:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbXIFXu7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Sep 2007 19:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbXIFXu7
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 19:50:59 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2221 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932638AbXIFXu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 19:50:58 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1ITR7Z-0003Hm-00; Fri, 07 Sep 2007 00:50:50 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57949>

An error from git-apply just means that the patch isn't applied.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

Somewhere in my subprocess refactoring, the discarding of stderr got
lost. This patch adds it back to the only place I have discovered so
far that actually needs it.

 stgit/git.py |    3 ++-
 stgit/run.py |    9 ++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)


diff --git a/stgit/git.py b/stgit/git.py
index f847cce..181e10d 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -628,7 +628,8 @@ def apply_diff(rev1, rev2, check_index =3D True, fi=
les =3D None):
     diff_str =3D diff(files, rev1, rev2)
     if diff_str:
         try:
-            GRun('git-apply', *index_opt).raw_input(diff_str).no_outpu=
t()
+            GRun('git-apply', *index_opt).raw_input(
+                diff_str).discard_stderr().no_output()
         except GitRunException:
             return False
=20
diff --git a/stgit/run.py b/stgit/run.py
index 29f8f71..7986f3b 100644
--- a/stgit/run.py
+++ b/stgit/run.py
@@ -43,6 +43,7 @@ class Run:
         self.__good_retvals =3D [0]
         self.__env =3D None
         self.__indata =3D None
+        self.__discard_stderr =3D False
     def __log_start(self):
         if _log_mode =3D=3D 'debug':
             out.start('Running subprocess %s' % self.__cmd)
@@ -65,11 +66,14 @@ class Run:
         try:
             p =3D subprocess.Popen(self.__cmd, env =3D self.__env,
                                  stdin =3D subprocess.PIPE,
-                                 stdout =3D subprocess.PIPE)
+                                 stdout =3D subprocess.PIPE,
+                                 stderr =3D subprocess.PIPE)
             outdata, errdata =3D p.communicate(self.__indata)
             self.exitcode =3D p.returncode
         except OSError, e:
             raise self.exc('%s failed: %s' % (self.__cmd[0], e))
+        if errdata and not self.__discard_stderr:
+            out.err_raw(errdata)
         self.__log_end(self.exitcode)
         self.__check_exitcode()
         return outdata
@@ -87,6 +91,9 @@ class Run:
     def returns(self, retvals):
         self.__good_retvals =3D retvals
         return self
+    def discard_stderr(self, discard =3D True):
+        self.__discard_stderr =3D discard
+        return self
     def env(self, env):
         self.__env =3D dict(os.environ)
         self.__env.update(env)
