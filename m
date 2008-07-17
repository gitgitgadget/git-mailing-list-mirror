From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/5] Log subproces activity to a file
Date: Thu, 17 Jul 2008 22:42:33 +0200
Message-ID: <20080717204233.23407.59842.stgit@yoghurt>
References: <20080717204133.23407.34264.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 22:44:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJaKW-00084y-0t
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 22:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbYGQUmj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 16:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbYGQUmi
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 16:42:38 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1857 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760238AbYGQUmh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 16:42:37 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KJaJ7-0008Gy-00; Thu, 17 Jul 2008 21:42:33 +0100
In-Reply-To: <20080717204133.23407.34264.stgit@yoghurt>
User-Agent: StGIT/0.14.3.197.gba718
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88916>

If the user sets $STGIT_SUBPROCESS_LOG to a log mode followed by a
colon and a file name, append the log to that file instead of writing
it to stdout.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/out.py |   11 +++++++----
 stgit/run.py |   35 +++++++++++++++++++++++------------
 2 files changed, 30 insertions(+), 16 deletions(-)


diff --git a/stgit/out.py b/stgit/out.py
index 485b830..753c176 100644
--- a/stgit/out.py
+++ b/stgit/out.py
@@ -20,7 +20,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston,=
 MA 02111-1307 USA
 import sys, textwrap
=20
 class MessagePrinter(object):
-    def __init__(self):
+    def __init__(self, file =3D None):
         class Output(object):
             def __init__(self, write, flush):
                 self.write =3D write
@@ -68,9 +68,12 @@ class MessagePrinter(object):
                 self.new_line()
                 self.write(string)
                 self.at_start_of_line =3D string.endswith('\n')
-        self.__stderr =3D Output(sys.stderr.write, sys.stderr.flush)
-        self.__stdout =3D Output(sys.stdout.write, sys.stdout.flush)
-        if sys.stdout.isatty():
+        if file:
+            self.__stdout =3D self.__stderr =3D Output(file.write, fil=
e.flush)
+        else:
+            self.__stdout =3D Output(sys.stdout.write, sys.stdout.flus=
h)
+            self.__stderr =3D Output(sys.stdout.write, sys.stdout.flus=
h)
+        if file or sys.stdout.isatty():
             self.__out =3D self.__stdout
             self.__err =3D self.__stdout
         else:
diff --git a/stgit/run.py b/stgit/run.py
index 0b79729..9d50e43 100644
--- a/stgit/run.py
+++ b/stgit/run.py
@@ -27,12 +27,22 @@ class RunException(StgException):
     subprocess."""
     pass
=20
-_all_log_modes =3D ['debug', 'profile']
-_log_mode =3D os.environ.get('STGIT_SUBPROCESS_LOG', '')
-if _log_mode and not _log_mode in _all_log_modes:
-    out.warn(('Unknown log mode "%s" specified in $STGIT_SUBPROCESS_LO=
G.'
-              % _log_mode),
-             'Valid values are: %s' % ', '.join(_all_log_modes))
+def get_log_mode(spec):
+    if not ':' in spec:
+        spec +=3D ':'
+    (log_mode, outfile) =3D spec.split(':', 1)
+    all_log_modes =3D ['debug', 'profile']
+    if log_mode and not log_mode in all_log_modes:
+        out.warn(('Unknown log mode "%s" specified in $STGIT_SUBPROCES=
S_LOG.'
+                  % log_mode),
+                 'Valid values are: %s' % ', '.join(all_log_modes))
+    if outfile:
+        f =3D MessagePrinter(open(outfile, 'a'))
+    else:
+        f =3D out
+    return (log_mode, f)
+
+(_log_mode, _logfile) =3D get_log_mode(os.environ.get('STGIT_SUBPROCES=
S_LOG', ''))
=20
 class Run:
     exc =3D RunException
@@ -47,22 +57,23 @@ class Run:
         self.__discard_stderr =3D False
     def __log_start(self):
         if _log_mode =3D=3D 'debug':
-            out.start('Running subprocess %s' % self.__cmd)
+            _logfile.start('Running subprocess %s' % self.__cmd)
             if self.__cwd !=3D None:
-                out.info('cwd: %s' % self.__cwd)
+                _logfile.info('cwd: %s' % self.__cwd)
             if self.__env !=3D None:
                 for k in sorted(self.__env.iterkeys()):
                     if k not in os.environ or os.environ[k] !=3D self.=
__env[k]:
-                        out.info('%s: %s' % (k, self.__env[k]))
+                        _logfile.info('%s: %s' % (k, self.__env[k]))
         elif _log_mode =3D=3D 'profile':
-            out.start('Running subprocess %s' % self.__cmd[0])
+            _logfile.start('Running subprocess %s' % self.__cmd[0])
             self.__starttime =3D datetime.datetime.now()
     def __log_end(self, retcode):
         if _log_mode =3D=3D 'debug':
-            out.done('return code: %d' % retcode)
+            _logfile.done('return code: %d' % retcode)
         elif _log_mode =3D=3D 'profile':
             duration =3D datetime.datetime.now() - self.__starttime
-            out.done('%1.3f s' % (duration.microseconds/1e6 + duration=
=2Eseconds))
+            _logfile.done('%1.3f s' % (duration.microseconds/1e6
+                                       + duration.seconds))
     def __check_exitcode(self):
         if self.__good_retvals =3D=3D None:
             return
