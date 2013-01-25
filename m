From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 2/2] git-p4.py: support Python 2.4
Date: Fri, 25 Jan 2013 12:44:01 -0800
Message-ID: <1359146641-27810-3-git-send-email-drafnel@gmail.com>
References: <1359146641-27810-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <pw@padd.com>, <esr@thyrsus.com>, <john@keeping.me.uk>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 21:44:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyq8h-0006Cl-Mv
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 21:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455Ab3AYUoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 15:44:23 -0500
Received: from hqemgate03.nvidia.com ([216.228.121.140]:8960 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab3AYUoU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 15:44:20 -0500
Received: from hqnvupgp06.nvidia.com (Not Verified[216.228.121.13]) by hqemgate03.nvidia.com
	id <B5102efa50000>; Fri, 25 Jan 2013 12:48:37 -0800
Received: from hqemhub01.nvidia.com ([172.17.108.22])
  by hqnvupgp06.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2013 12:42:39 -0800
X-PGP-Universal: processed;
	by hqnvupgp06.nvidia.com on Fri, 25 Jan 2013 12:42:39 -0800
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.297.1; Fri, 25 Jan 2013
 12:44:18 -0800
X-Mailer: git-send-email 1.8.1.1.297.gad3d74e
In-Reply-To: <1359146641-27810-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214580>

Python 2.4 lacks the following features:

   subprocess.check_call
   struct.pack_into

Take a cue from 460d1026 and provide an implementation of the
CalledProcessError exception.  Then replace the calls to
subproccess.check_call with calls to subprocess.call that check the return
status and raise a CalledProcessError exception if necessary.

The struct.pack_into in t/9802 can be converted into a single struct.pack
call which is available in Python 2.4.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 INSTALL                    |  2 +-
 git-p4.py                  | 27 ++++++++++++++++++++++++---
 t/t9802-git-p4-filetype.sh | 11 ++++++-----
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/INSTALL b/INSTALL
index fc723b3..b96e16d 100644
--- a/INSTALL
+++ b/INSTALL
@@ -131,7 +131,7 @@ Issues of note:
 	  use English. Under autoconf the configure script will do this
 	  automatically if it can't find libintl on the system.
 
-	- Python version 2.5 or later is needed to use the git-p4
+	- Python version 2.4 or later is needed to use the git-p4
 	  interface to Perforce.
 
  - Some platform specific issues are dealt with Makefile rules,
diff --git a/git-p4.py b/git-p4.py
index 4f95d7a..faec09d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -18,6 +18,21 @@ import optparse, os, marshal, subprocess, shelve
 import tempfile, getopt, os.path, time, platform
 import re, shutil
 
+try:
+    from subprocess import CalledProcessError
+except ImportError:
+    # from python2.7:subprocess.py
+    # Exception classes used by this module.
+    class CalledProcessError(Exception):
+        """This exception is raised when a process run by check_call() returns
+        a non-zero exit status.  The exit status will be stored in the
+        returncode attribute."""
+        def __init__(self, returncode, cmd):
+            self.returncode = returncode
+            self.cmd = cmd
+        def __str__(self):
+            return "Command '%s' returned non-zero exit status %d" % (self.cmd, self.returncode)
+
 verbose = False
 
 # Only labels/tags matching this will be imported/exported
@@ -158,13 +173,17 @@ def system(cmd):
     expand = isinstance(cmd,basestring)
     if verbose:
         sys.stderr.write("executing %s\n" % str(cmd))
-    subprocess.check_call(cmd, shell=expand)
+    retcode = subprocess.call(cmd, shell=expand)
+    if retcode:
+        raise CalledProcessError(retcode, cmd)
 
 def p4_system(cmd):
     """Specifically invoke p4 as the system command. """
     real_cmd = p4_build_cmd(cmd)
     expand = isinstance(real_cmd, basestring)
-    subprocess.check_call(real_cmd, shell=expand)
+    retcode = subprocess.call(real_cmd, shell=expand)
+    if retcode:
+        raise CalledProcessError(retcode, real_cmd)
 
 def p4_integrate(src, dest):
     p4_system(["integrate", "-Dt", wildcard_encode(src), wildcard_encode(dest)])
@@ -3174,7 +3193,9 @@ class P4Clone(P4Sync):
         init_cmd = [ "git", "init" ]
         if self.cloneBare:
             init_cmd.append("--bare")
-        subprocess.check_call(init_cmd)
+        retcode = subprocess.call(init_cmd)
+        if retcode:
+            raise CalledProcessError(retcode, init_cmd)
 
         if not P4Sync.run(self, depotPaths):
             return False
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index 21924df..be299dc 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -105,12 +105,13 @@ build_gendouble() {
 	cat >gendouble.py <<-\EOF
 	import sys
 	import struct
-	import array
 
-	s = array.array("c", '\0' * 26)
-	struct.pack_into(">L", s,  0, 0x00051607)  # AppleDouble
-	struct.pack_into(">L", s,  4, 0x00020000)  # version 2
-	s.tofile(sys.stdout)
+	s = struct.pack(">LL18s",
+			0x00051607,  # AppleDouble
+			0x00020000,  # version 2
+			""           # pad to 26 bytes
+	)
+	sys.stdout.write(s);
 	EOF
 }
 
-- 
1.8.1.1.297.gad3d74e


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
