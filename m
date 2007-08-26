From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 4/4] Add optional logging of subprocess execution
Date: Sun, 26 Aug 2007 22:33:44 +0200
Message-ID: <20070826203344.16265.66280.stgit@yoghurt>
References: <20070826202724.16265.85821.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOoW-0008Ch-KQ
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbXHZUeD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754387AbXHZUeB
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:34:01 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4764 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220AbXHZUdr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:33:47 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOnp-0005w9-00; Sun, 26 Aug 2007 21:33:45 +0100
In-Reply-To: <20070826202724.16265.85821.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56721>

Now that the subprocess calling has been refactored and is in a nice
shape, it's quite simple to add some logging facilities. This patch
adds two separate log modes, switched by the STG_SUBPROCESS_LOG
environment variable:

  * Setting it to "debug" prints the executable name and all
    arguments, and the subprocess return value.

  * Setting it to "profile" prints just the executable name, and the
    (wallclock) time elapsed during the call.

  * Not setting it will disable logging, of course.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/run.py |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/stgit/run.py b/stgit/run.py
index 1bc4759..719ecb7 100644
--- a/stgit/run.py
+++ b/stgit/run.py
@@ -22,11 +22,22 @@ Foundation, Inc., 59 Temple Place, Suite 330, Bosto=
n, MA 02111-1307 USA
 # to stay Python 2.3 compatible.
 import popen2, os
=20
+import datetime
+
+from  stgit.out import *
+
 class RunException(Exception):
     """Thrown when something bad happened when we tried to run the
     subprocess."""
     pass
=20
+_all_log_modes =3D ['debug', 'profile']
+_log_mode =3D os.environ.get('STG_SUBPROCESS_LOG', '')
+if _log_mode and not _log_mode in _all_log_modes:
+    out.warn(('Unknown log mode "%s" specified in $STG_SUBPROCESS_LOG.=
'
+              % _log_mode),
+             'Valid values are: %s' % ', '.join(_all_log_modes))
+
 class Run:
     exc =3D RunException
     def __init__(self, *cmd):
@@ -37,6 +48,18 @@ class Run:
         self.__good_retvals =3D [0]
         self.__env =3D None
         self.__indata =3D None
+    def __log_start(self, cmd):
+        if _log_mode =3D=3D 'debug':
+            out.start('Running subprocess %s' % cmd)
+        elif _log_mode =3D=3D 'profile':
+            out.start('Running subprocess %s' % cmd[0])
+            self.__starttime =3D datetime.datetime.now()
+    def __log_end(self, retcode):
+        if _log_mode =3D=3D 'debug':
+            out.done('return code: %d' % retcode)
+        elif _log_mode =3D=3D 'profile':
+            duration =3D datetime.datetime.now() - self.__starttime
+            out.done('%1.3f s' % (duration.microseconds/1e6 + duration=
=2Eseconds))
     def __run_io(self, cmd):
         """Run with captured IO. Note: arguments are parsed by the
         shell. We single-quote them, so don't use anything with single
@@ -47,6 +70,7 @@ class Run:
             ecmd =3D (['env'] + ['%s=3D%s' % (key, val)
                                for key, val in self.__env.iteritems()]
                     + cmd)
+        self.__log_start(ecmd)
         p =3D popen2.Popen3(' '.join(["'%s'" % c for c in ecmd]), True=
)
         if self.__indata !=3D None:
             p.tochild.write(self.__indata)
@@ -54,6 +78,7 @@ class Run:
         outdata =3D p.fromchild.read()
         errdata =3D p.childerr.read()
         self.exitcode =3D p.wait() >> 8
+        self.__log_end(self.exitcode)
         if errdata or self.exitcode not in self.__good_retvals:
             raise self.exc('%s failed with code %d:\n%s'
                            % (cmd[0], self.exitcode, errdata))
@@ -63,7 +88,9 @@ class Run:
         the shell."""
         assert self.__env =3D=3D None
         assert self.__indata =3D=3D None
+        self.__log_start(cmd)
         self.exitcode =3D os.spawnvp(os.P_WAIT, cmd[0], cmd)
+        self.__log_end(self.exitcode)
         if not self.exitcode in self.__good_retvals:
             raise self.exc('%s failed with code %d'
                            % (cmd[0], self.exitcode))
