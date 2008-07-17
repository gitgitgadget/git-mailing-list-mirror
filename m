From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 4/5] Log subprocess calls during performance testing
Date: Thu, 17 Jul 2008 22:42:44 +0200
Message-ID: <20080717204244.23407.16332.stgit@yoghurt>
References: <20080717204133.23407.34264.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 22:44:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJaKX-00084y-BG
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 22:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbYGQUms convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 16:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbYGQUms
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 16:42:48 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1863 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213AbYGQUms (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 16:42:48 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KJaJJ-0008HO-00; Thu, 17 Jul 2008 21:42:45 +0100
In-Reply-To: <20080717204133.23407.34264.stgit@yoghurt>
User-Agent: StGIT/0.14.3.197.gba718
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88919>

Log each command's subprocess calls to a separate file.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 perf/perftest.py |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)


diff --git a/perf/perftest.py b/perf/perftest.py
index 7072772..e5ed04b 100644
--- a/perf/perftest.py
+++ b/perf/perftest.py
@@ -1,4 +1,4 @@
-import datetime, subprocess, sys
+import datetime, os, os.path, subprocess, sys
=20
 def duration(t1, t2):
     d =3D t2 - t1
@@ -8,8 +8,16 @@ class Run(object):
     def __init__(self):
         self.__cwd =3D None
         self.__log =3D []
+    def __logfile(self, cmd):
+        fn =3D os.path.join(os.getcwd(), '%04d.log' % len(self.__log))
+        f =3D open(fn, 'w')
+        f.write(' '.join(cmd) + '\n' + '-'*70 + '\n\n')
+        f.close()
+        return fn
     def __call__(self, *cmd, **args):
-        kwargs =3D { 'cwd': self.__cwd }
+        env =3D dict(os.environ)
+        env['STGIT_SUBPROCESS_LOG'] =3D 'profile:' + self.__logfile(cm=
d)
+        kwargs =3D { 'cwd': self.__cwd, 'env': env }
         if args.get('capture_stdout', False):
             kwargs['stdout'] =3D subprocess.PIPE
         start =3D datetime.datetime.now()
