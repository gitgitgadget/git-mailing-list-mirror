From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 5/5] Global performance logging
Date: Thu, 17 Jul 2008 22:42:50 +0200
Message-ID: <20080717204250.23407.39304.stgit@yoghurt>
References: <20080717204133.23407.34264.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 22:44:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJaKY-00084y-0E
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 22:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbYGQUmy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 16:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758343AbYGQUmy
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 16:42:54 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1866 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758648AbYGQUmx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 16:42:53 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KJaJO-0008Hb-00; Thu, 17 Jul 2008 21:42:51 +0100
In-Reply-To: <20080717204133.23407.34264.stgit@yoghurt>
User-Agent: StGIT/0.14.3.197.gba718
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88918>

Measure the time for the whole program, and how much of that was
subprocess calls.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/main.py |   11 +++++++++--
 stgit/run.py  |   32 ++++++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 6 deletions(-)


diff --git a/stgit/main.py b/stgit/main.py
index aa1f8ef..64cff30 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -23,7 +23,7 @@ from optparse import OptionParser
=20
 import stgit.commands
 from stgit.out import *
-from stgit import utils
+from stgit import run, utils
=20
 #
 # The commands map
@@ -192,7 +192,7 @@ def print_help():
 #
 # The main function (command dispatcher)
 #
-def main():
+def _main():
     """The main function
     """
     global prog
@@ -293,3 +293,10 @@ def main():
         sys.exit(utils.STGIT_BUG_ERROR)
=20
     sys.exit(ret or utils.STGIT_SUCCESS)
+
+def main():
+    run.start_logging()
+    try:
+        _main()
+    finally:
+        run.stop_logging()
diff --git a/stgit/run.py b/stgit/run.py
index befd3c1..e46836b 100644
--- a/stgit/run.py
+++ b/stgit/run.py
@@ -42,7 +42,27 @@ def get_log_mode(spec):
         f =3D out
     return (log_mode, f)
=20
-(_log_mode, _logfile) =3D get_log_mode(os.environ.get('STGIT_SUBPROCES=
S_LOG', ''))
+def start_logging():
+    global _log_mode, _logfile, _log_starttime, _log_subproctime
+    (_log_mode, _logfile) =3D get_log_mode(
+        os.environ.get('STGIT_SUBPROCESS_LOG', ''))
+    _log_starttime =3D datetime.datetime.now()
+    _log_subproctime =3D 0.0
+
+def duration(t1, t2):
+    d =3D t2 - t1
+    return 86400*d.days + d.seconds + 1e-6*d.microseconds
+
+def stop_logging():
+    if _log_mode !=3D 'profile':
+        return
+    ttime =3D duration(_log_starttime, datetime.datetime.now())
+    rtime =3D ttime - _log_subproctime
+    _logfile.info('Total time: %1.3f s' % ttime,
+                  'Time spent in subprocess calls: %1.3f s (%1.1f%%)'
+                  % (_log_subproctime, 100*_log_subproctime/ttime),
+                  'Remaining time: %1.3f s (%1.1f%%)'
+                  % (rtime, 100*rtime/ttime))
=20
 class Run:
     exc =3D RunException
@@ -68,12 +88,16 @@ class Run:
             _logfile.start('Running subprocess %s' % self.__cmd)
             self.__starttime =3D datetime.datetime.now()
     def __log_end(self, retcode):
+        global _log_subproctime, _log_starttime
         if _log_mode =3D=3D 'debug':
             _logfile.done('return code: %d' % retcode)
         elif _log_mode =3D=3D 'profile':
-            duration =3D datetime.datetime.now() - self.__starttime
-            _logfile.done('%1.3f s' % (duration.microseconds/1e6
-                                       + duration.seconds))
+            n =3D datetime.datetime.now()
+            d =3D duration(self.__starttime, n)
+            _logfile.done('%1.3f s' % d)
+            _log_subproctime +=3D d
+            _logfile.info('Time since program start: %1.3f s'
+                          % duration(_log_starttime, n))
     def __check_exitcode(self):
         if self.__good_retvals =3D=3D None:
             return
