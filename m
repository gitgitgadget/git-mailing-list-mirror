From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 16/21] git p4: disable read-only attribute before deleting
Date: Fri, 28 Sep 2012 08:04:20 -0400
Message-ID: <1348833865-6093-17-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:10:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZOJ-0003q2-Pf
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757555Ab2I1MJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:09:50 -0400
Received: from honk.padd.com ([74.3.171.149]:58378 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab2I1MJu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:09:50 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id DF2C25AF2;
	Fri, 28 Sep 2012 05:09:49 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6791D31413; Fri, 28 Sep 2012 08:09:47 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206574>

On windows, p4 marks un-edited files as read-only.  Not only are
they read-only, but also they cannot be deleted.  Remove the
read-only attribute before deleting in both the copy and rename
cases.

This also happens in the RCS cleanup code, where a file is marked
to be deleted, but must first be edited to remove adjust the
keyword lines.  Make sure it is editable before patching.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 5b2f73d..a6806bc 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -17,6 +17,7 @@ import time
 import platform
 import re
 import shutil
+import stat
 
 verbose = False
 
@@ -1163,6 +1164,9 @@ class P4Submit(Command, P4UserMap):
                     p4_edit(dest)
                     pureRenameCopy.discard(dest)
                     filesToChangeExecBit[dest] = diff['dst_mode']
+                if self.isWindows:
+                    # turn off read-only attribute
+                    os.chmod(dest, stat.S_IWRITE)
                 os.unlink(dest)
                 editedFiles.add(dest)
             elif modifier == "R":
@@ -1181,6 +1185,8 @@ class P4Submit(Command, P4UserMap):
                         p4_edit(dest)   # with move: already open, writable
                     filesToChangeExecBit[dest] = diff['dst_mode']
                 if not self.p4HasMoveCommand:
+                    if self.isWindows:
+                        os.chmod(dest, stat.S_IWRITE)
                     os.unlink(dest)
                     filesToDelete.add(src)
                 editedFiles.add(dest)
@@ -1221,6 +1227,10 @@ class P4Submit(Command, P4UserMap):
                 for file in kwfiles:
                     if verbose:
                         print "zapping %s with %s" % (line,pattern)
+                    # File is being deleted, so not open in p4.  Must
+                    # disable the read-only bit on windows.
+                    if self.isWindows and file not in editedFiles:
+                        os.chmod(file, stat.S_IWRITE)
                     self.patchRCSKeywords(file, kwfiles[file])
                     fixed_rcs_keywords = True
 
-- 
1.7.12.1.403.g28165e1
