From: Karl Wiberg <kha@virtutech.com>
Subject: [PATCH] Work around performance bug in subprocess.Popen.communicate()
Date: Fri, 31 Jul 2009 11:36:32 +0200
Message-ID: <20090731093632.7018.24435.stgit@october.e.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: mandolaerik@gmail.com, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 12:10:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWp22-00021R-TT
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 12:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbZGaKID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 06:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbZGaKID
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 06:08:03 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:51346 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbZGaKIC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 06:08:02 -0400
X-Greylist: delayed 1885 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jul 2009 06:08:02 EDT
Received: from localhost ([127.0.0.1] helo=october.e.vtech)
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1MWoXU-0004h6-00; Fri, 31 Jul 2009 10:36:36 +0100
User-Agent: StGit/0.15-rc1-43-ga884
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124535>

From: Karl Wiberg <kha@treskal.com>

In Python 2.4 (specifically, I tested with 2.4.6 on Ubuntu 9.04),
subprocess.Popen.communicate() seems to take time proportional to the
square of the size of the indata, which makes it ridiculously
expensive to write stack log entries when the diffs are large. Work
around the bug by calling subprocess.Popen.stdin.write() manually
instead of letting communicate() handle the indata.

The performance bug has been fixed in Python 2.6 (I tested with
2.6.2), so with that version this workaround doesn't affect the run
time. I haven't tested with Python 2.5.

This fixes bug 13319.

Signed-off-by: Karl Wiberg <kha@treskal.com>

---

 stgit/run.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)


diff --git a/stgit/run.py b/stgit/run.py
index 7493ed3..311d12f 100644
--- a/stgit/run.py
+++ b/stgit/run.py
@@ -110,7 +110,9 @@ class Run:
                                  stdin = subprocess.PIPE,
                                  stdout = subprocess.PIPE,
                                  stderr = subprocess.PIPE)
-            outdata, errdata = p.communicate(self.__indata)
+            if self.__indata:
+                p.stdin.write(self.__indata)
+            outdata, errdata = p.communicate()
             self.exitcode = p.returncode
         except OSError, e:
             raise self.exc('%s failed: %s' % (self.__cmd[0], e))
