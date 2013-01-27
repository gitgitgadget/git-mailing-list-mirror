From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 10/21] git p4: scrub crlf for utf16 files on windows
Date: Sat, 26 Jan 2013 22:11:13 -0500
Message-ID: <1359256284-5660-11-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:15:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIi5-0005hw-BM
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520Ab3A0DOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:14:49 -0500
Received: from honk.padd.com ([74.3.171.149]:58720 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab3A0DOr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:14:47 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 781952F3F;
	Sat, 26 Jan 2013 19:14:47 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9630122838; Sat, 26 Jan 2013 22:14:44 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214660>

Files of type utf16 are handled with "p4 print" instead of the
normal "p4 -G print" interface due to how the latter does not
produce correct output.  See 55aa571 (git-p4: handle utf16
filetype properly, 2011-09-17) for details.

On windows, though, "p4 print" can not be told which line
endings to use, as there is no underlying client, and always
chooses crlf, even for utf16 files.  Convert the \r\n into \n
when importing utf16 files.

The fix for this is complex, in that the problem is a property
of the NT version of p4.  There are old versions of p4 that
were compiled directly for cygwin that should not be subjected
to text replacement.  The right check here, then, is to look
at the p4 version, not the OS version.  Note also that on cygwin,
platform.system() is "CYGWIN_NT-5.1" or similar, not "Windows".

Add a function to memoize the p4 version string and use it to
check for "/NT", indicating the Windows build of p4.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 445d704..c62b2ca 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -170,6 +170,22 @@ def p4_system(cmd):
     expand = isinstance(real_cmd, basestring)
     subprocess.check_call(real_cmd, shell=expand)
 
+_p4_version_string = None
+def p4_version_string():
+    """Read the version string, showing just the last line, which
+       hopefully is the interesting version bit.
+
+       $ p4 -V
+       Perforce - The Fast Software Configuration Management System.
+       Copyright 1995-2011 Perforce Software.  All rights reserved.
+       Rev. P4/NTX86/2011.1/393975 (2011/12/16).
+    """
+    global _p4_version_string
+    if not _p4_version_string:
+        a = p4_read_pipe_lines(["-V"])
+        _p4_version_string = a[-1].rstrip()
+    return _p4_version_string
+
 def p4_integrate(src, dest):
     p4_system(["integrate", "-Dt", wildcard_encode(src), wildcard_encode(dest)])
 
@@ -1973,7 +1989,6 @@ class P4Sync(Command, P4UserMap):
         self.syncWithOrigin = True
         self.importIntoRemotes = True
         self.maxChanges = ""
-        self.isWindows = (platform.system() == "Windows")
         self.keepRepoPath = False
         self.depotPaths = None
         self.p4BranchesInGit = []
@@ -2118,7 +2133,14 @@ class P4Sync(Command, P4UserMap):
             # operations.  utf16 is converted to ascii or utf8, perhaps.
             # But ascii text saved as -t utf16 is completely mangled.
             # Invoke print -o to get the real contents.
+            #
+            # On windows, the newlines will always be mangled by print, so put
+            # them back too.  This is not needed to the cygwin windows version,
+            # just the native "NT" type.
+            #
             text = p4_read_pipe(['print', '-q', '-o', '-', file['depotFile']])
+            if p4_version_string().find("/NT") >= 0:
+                text = text.replace("\r\n", "\n")
             contents = [ text ]
 
         if type_base == "apple":
-- 
1.8.1.1.460.g6fa8886
