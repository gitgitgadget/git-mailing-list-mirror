From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 16/21] git p4: disable read-only attribute before deleting
Date: Sat, 26 Jan 2013 22:11:19 -0500
Message-ID: <1359256284-5660-17-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:17:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIk7-0006kr-7j
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab3A0DQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:16:49 -0500
Received: from honk.padd.com ([74.3.171.149]:44470 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755549Ab3A0DQs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:16:48 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 01F1D2F3F;
	Sat, 26 Jan 2013 19:16:48 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id DD55822838; Sat, 26 Jan 2013 22:16:44 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214667>

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
index c62b2ca..a989704 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -21,6 +21,7 @@ import time
 import platform
 import re
 import shutil
+import stat
 
 verbose = False
 
@@ -1231,6 +1232,9 @@ class P4Submit(Command, P4UserMap):
                     p4_edit(dest)
                     pureRenameCopy.discard(dest)
                     filesToChangeExecBit[dest] = diff['dst_mode']
+                if self.isWindows:
+                    # turn off read-only attribute
+                    os.chmod(dest, stat.S_IWRITE)
                 os.unlink(dest)
                 editedFiles.add(dest)
             elif modifier == "R":
@@ -1249,6 +1253,8 @@ class P4Submit(Command, P4UserMap):
                         p4_edit(dest)   # with move: already open, writable
                     filesToChangeExecBit[dest] = diff['dst_mode']
                 if not self.p4HasMoveCommand:
+                    if self.isWindows:
+                        os.chmod(dest, stat.S_IWRITE)
                     os.unlink(dest)
                     filesToDelete.add(src)
                 editedFiles.add(dest)
@@ -1289,6 +1295,10 @@ class P4Submit(Command, P4UserMap):
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
1.8.1.1.460.g6fa8886
