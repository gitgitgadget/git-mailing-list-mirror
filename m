From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 2/2] git-p4.py: support Python 2.4
Date: Sat, 26 Jan 2013 11:14:33 -0800
Message-ID: <1359227673-5673-2-git-send-email-bcasey@nvidia.com>
References: <1359227673-5673-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <pw@padd.com>, <git@vger.kernel.org>, <esr@thyrsus.com>,
	<john@keeping.me.uk>, Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 20:15:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzBDa-000824-Qe
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 20:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730Ab3AZTOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 14:14:45 -0500
Received: from hqemgate03.nvidia.com ([216.228.121.140]:8869 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700Ab3AZTOo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 14:14:44 -0500
Received: from hqnvupgp06.nvidia.com (Not Verified[216.228.121.13]) by hqemgate03.nvidia.com
	id <B51042c220000>; Sat, 26 Jan 2013 11:18:58 -0800
Received: from hqemhub01.nvidia.com ([172.17.108.22])
  by hqnvupgp06.nvidia.com (PGP Universal service);
  Sat, 26 Jan 2013 11:12:56 -0800
X-PGP-Universal: processed;
	by hqnvupgp06.nvidia.com on Sat, 26 Jan 2013 11:12:56 -0800
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.297.1; Sat, 26 Jan 2013
 11:14:37 -0800
X-Mailer: git-send-email 1.8.1.1.442.g413e803
In-Reply-To: <1359227673-5673-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214634>

From: Brandon Casey <drafnel@gmail.com>

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
Acked-by: Pete Wyckoff <pw@padd.com>
---

On 1/26/2013 4:48 AM, Pete Wyckoff wrote:
> One stray semicolon.

Fixed.

-Brandon

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
index de1a0b9..625a396 100755
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
index 21924df..aae1a3f 100755
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
+	sys.stdout.write(s)
 	EOF
 }
 
-- 
1.8.1.1.442.g413e803


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
