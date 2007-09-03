From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Use subprocess.Popen to call git executables
Date: Mon, 03 Sep 2007 23:48:45 +0200
Message-ID: <20070903214845.18057.26023.stgit@yoghurt>
References: <20070903214545.18057.79301.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 23:49:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISJnA-00080I-G9
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 23:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbXICVsv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 3 Sep 2007 17:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754258AbXICVsv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 17:48:51 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2699 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887AbXICVsu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 17:48:50 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1ISJmo-0004Ju-00; Mon, 03 Sep 2007 22:48:46 +0100
In-Reply-To: <20070903214545.18057.79301.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57507>

Replace popen2.Popen3 and os.spawn* with the superior
subprocess.Popen. Now we can pass a modified environment to any
subprocess, redirect input and output as we please, and the shell is
no longer involved, meaning we don't have to worry about argument
quoting. (We could already do all of that, just not at the same time.)

This is a Python 2.4 library, so StGit now officially requires Python
2.4 or later.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/run.py |   89 ++++++++++++++++++++++++++------------------------=
--------
 1 files changed, 40 insertions(+), 49 deletions(-)


diff --git a/stgit/run.py b/stgit/run.py
index 94dd98e..29f8f71 100644
--- a/stgit/run.py
+++ b/stgit/run.py
@@ -17,12 +17,7 @@ along with this program; if not, write to the Free S=
oftware
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
-# popen2 and os.spawn* suck. We should really use subprocess instead,
-# but that's only available in Python 2.4 and up, and we try our best
-# to stay Python 2.3 compatible.
-import popen2, os
-
-import datetime
+import datetime, os, subprocess
=20
 from  stgit.out import *
=20
@@ -48,11 +43,11 @@ class Run:
         self.__good_retvals =3D [0]
         self.__env =3D None
         self.__indata =3D None
-    def __log_start(self, cmd):
+    def __log_start(self):
         if _log_mode =3D=3D 'debug':
-            out.start('Running subprocess %s' % cmd)
+            out.start('Running subprocess %s' % self.__cmd)
         elif _log_mode =3D=3D 'profile':
-            out.start('Running subprocess %s' % cmd[0])
+            out.start('Running subprocess %s' % self.__cmd[0])
             self.__starttime =3D datetime.datetime.now()
     def __log_end(self, retcode):
         if _log_mode =3D=3D 'debug':
@@ -60,48 +55,41 @@ class Run:
         elif _log_mode =3D=3D 'profile':
             duration =3D datetime.datetime.now() - self.__starttime
             out.done('%1.3f s' % (duration.microseconds/1e6 + duration=
=2Eseconds))
-    def __run_io(self, cmd):
-        """Run with captured IO. Note: arguments are parsed by the
-        shell. We single-quote them, so don't use anything with single
-        quotes in it."""
-        if self.__env =3D=3D None:
-            ecmd =3D cmd
-        else:
-            ecmd =3D (['env'] + ['%s=3D%s' % (key, val)
-                               for key, val in self.__env.iteritems()]
-                    + cmd)
-        self.__log_start(ecmd)
-        p =3D popen2.Popen3(' '.join(["'%s'" % c for c in ecmd]), True=
)
-        if self.__indata !=3D None:
-            p.tochild.write(self.__indata)
-        p.tochild.close()
-        outdata =3D p.fromchild.read()
-        errdata =3D p.childerr.read()
-        self.exitcode =3D p.wait() >> 8
-        self.__log_end(self.exitcode)
+    def __check_exitcode(self):
         if self.exitcode not in self.__good_retvals:
-            raise self.exc('%s failed with code %d:\n%s'
-                           % (cmd[0], self.exitcode, errdata))
-        if errdata:
-            out.warn('call to %s succeeded, but generated a warning:' =
% cmd[0])
-            out.err_raw(errdata)
+            raise self.exc('%s failed with code %d'
+                           % (self.__cmd[0], self.exitcode))
+    def __run_io(self):
+        """Run with captured IO."""
+        self.__log_start()
+        try:
+            p =3D subprocess.Popen(self.__cmd, env =3D self.__env,
+                                 stdin =3D subprocess.PIPE,
+                                 stdout =3D subprocess.PIPE)
+            outdata, errdata =3D p.communicate(self.__indata)
+            self.exitcode =3D p.returncode
+        except OSError, e:
+            raise self.exc('%s failed: %s' % (self.__cmd[0], e))
+        self.__log_end(self.exitcode)
+        self.__check_exitcode()
         return outdata
-    def __run_noshell(self, cmd):
-        """Run without captured IO. Note: arguments are not parsed by
-        the shell."""
-        assert self.__env =3D=3D None
+    def __run_noio(self):
+        """Run without captured IO."""
         assert self.__indata =3D=3D None
-        self.__log_start(cmd)
-        self.exitcode =3D os.spawnvp(os.P_WAIT, cmd[0], cmd)
+        self.__log_start()
+        try:
+            p =3D subprocess.Popen(self.__cmd, env =3D self.__env)
+            self.exitcode =3D p.wait()
+        except OSError, e:
+            raise self.exc('%s failed: %s' % (self.__cmd[0], e))
         self.__log_end(self.exitcode)
-        if not self.exitcode in self.__good_retvals:
-            raise self.exc('%s failed with code %d'
-                           % (cmd[0], self.exitcode))
+        self.__check_exitcode()
     def returns(self, retvals):
         self.__good_retvals =3D retvals
         return self
     def env(self, env):
-        self.__env =3D env
+        self.__env =3D dict(os.environ)
+        self.__env.update(env)
         return self
     def raw_input(self, indata):
         self.__indata =3D indata
@@ -110,15 +98,15 @@ class Run:
         self.__indata =3D ''.join(['%s\n' % line for line in lines])
         return self
     def no_output(self):
-        outdata =3D self.__run_io(self.__cmd)
+        outdata =3D self.__run_io()
         if outdata:
             raise self.exc, '%s produced output' % self.__cmd[0]
     def discard_output(self):
-        self.__run_io(self.__cmd)
+        self.__run_io()
     def raw_output(self):
-        return self.__run_io(self.__cmd)
+        return self.__run_io()
     def output_lines(self):
-        outdata =3D self.__run_io(self.__cmd)
+        outdata =3D self.__run_io()
         if outdata.endswith('\n'):
             outdata =3D outdata[:-1]
         if outdata:
@@ -134,11 +122,14 @@ class Run:
                            % (self.__cmd[0], len(outlines)))
     def run(self):
         """Just run, with no IO redirection."""
-        self.__run_noshell(self.__cmd)
+        self.__run_noio()
     def xargs(self, xargs):
         """Just run, with no IO redirection. The extra arguments are
         appended to the command line a few at a time; the command is
         run as many times as needed to consume them all."""
         step =3D 100
+        basecmd =3D self.__cmd
         for i in xrange(0, len(xargs), step):
-            self.__run_noshell(self.__cmd + xargs[i:i+step])
+            self.__cmd =3D basecmd + xargs[i:i+step]
+            self.__run_noio()
+        self.__cmd =3D basecmd
