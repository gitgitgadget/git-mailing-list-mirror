From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 10/21] git p4: scrub crlf for utf16 files on windows
Date: Fri, 28 Sep 2012 08:04:14 -0400
Message-ID: <1348833865-6093-11-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:08:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZMN-0002ff-Fr
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756909Ab2I1MHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:07:50 -0400
Received: from honk.padd.com ([74.3.171.149]:34974 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756391Ab2I1MHu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:07:50 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 875D95AF2;
	Fri, 28 Sep 2012 05:07:49 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E0B1F31413; Fri, 28 Sep 2012 08:07:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206567>

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
index b773b09..5b2f73d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -147,6 +147,22 @@ def p4_system(cmd):
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
 
@@ -1903,7 +1919,6 @@ class P4Sync(Command, P4UserMap):
         self.syncWithOrigin = True
         self.importIntoRemotes = True
         self.maxChanges = ""
-        self.isWindows = (platform.system() == "Windows")
         self.keepRepoPath = False
         self.depotPaths = None
         self.p4BranchesInGit = []
@@ -2048,7 +2063,14 @@ class P4Sync(Command, P4UserMap):
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
1.7.12.1.403.g28165e1
