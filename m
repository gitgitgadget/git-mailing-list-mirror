From: Simon Hausmann <simon@lst.de>
Subject: [PATCH] git-p4: Fix support for symlinks.
Date: Tue, 7 Aug 2007 12:28:00 +0200
Message-ID: <200708071228.07645.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 12:28:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIMIl-0007cu-3T
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 12:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930AbXHGK2Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 06:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755952AbXHGK2Y
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 06:28:24 -0400
Received: from verein.lst.de ([213.95.11.210]:36549 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459AbXHGK2X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 06:28:23 -0400
Received: from rhea.troll.no (nat0.troll.no [62.70.27.100])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l77ARYA5001560
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Tue, 7 Aug 2007 12:27:35 +0200
User-Agent: KMail/1.9.7
Content-Disposition: inline
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55240>

Detect symlinks as file type, set the git file mode accordingly and strip off the trailing newline in the p4 print output.
Make the mode handling a bit more readable at the same time.

Signed-off-by: Simon Hausmann <simon@lst.de>
Acked-by: Brian Swetland <swetland@google.com>
---
 contrib/fast-import/git-p4 |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 41e86e7..3cbb2da 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -839,16 +839,20 @@ class P4Sync(Command):
             if file["action"] == "delete":
                 self.gitStream.write("D %s\n" % relPath)
             else:
-                mode = 644
-                if file["type"].startswith("x"):
-                    mode = 755
-
                 data = file['data']
 
+                mode = "644"
+                if file["type"].startswith("x"):
+                    mode = "755"
+                elif file["type"] == "symlink":
+                    mode = "120000"
+                    # p4 print on a symlink contains "target\n", so strip it off
+                    data = data[:-1]
+
                 if self.isWindows and file["type"].endswith("text"):
                     data = data.replace("\r\n", "\n")
 
-                self.gitStream.write("M %d inline %s\n" % (mode, relPath))
+                self.gitStream.write("M %s inline %s\n" % (mode, relPath))
                 self.gitStream.write("data %s\n" % len(data))
                 self.gitStream.write(data)
                 self.gitStream.write("\n")
-- 
1.5.3.rc3.91.g5c75
