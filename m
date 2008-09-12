From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH] Do not crash if a patch log ref is missing
Date: Fri, 12 Sep 2008 22:54:58 +0100
Message-ID: <20080912215449.10270.38860.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 23:56:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeGcf-0008HW-AH
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 23:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756803AbYILVzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 17:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756809AbYILVzD
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 17:55:03 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:6762 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755580AbYILVzC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2008 17:55:02 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080912215500.DVNJ10791.mtaout03-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Fri, 12 Sep 2008 22:55:00 +0100
Received: from localhost.localdomain ([86.9.203.187])
          by aamtaout04-winn.ispmail.ntl.com with ESMTP
          id <20080912215500.WUTH18637.aamtaout04-winn.ispmail.ntl.com@localhost.localdomain>;
          Fri, 12 Sep 2008 22:55:00 +0100
User-Agent: StGIT/0.14.3.225.g09cf8
X-Cloudmark-Analysis: v=1.0 c=1 a=X-nQFFInS0kA:10 a=G-V-mANZjMIA:10 a=LQhEnYBEfCixTyh8Bx0A:9 a=YEwWjwM9rLThzjvi2VYA:7 a=XBOE74XKqa2WIHzRUyXx7aDwyCIA:4 a=MSl-tDqOz04A:10 a=JcB9aHnUDh0A:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95774>

Since we'll get rid of the individual patch logs, StGit should ignore if
such a ref is missing when deleting the compatibility patch files.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/lib/stack.py |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index 9cb3967..1059955 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -68,7 +68,11 @@ class Patch(object):
             for f in os.listdir(self.__compat_dir):
                 os.remove(os.path.join(self.__compat_dir, f))
             os.rmdir(self.__compat_dir)
-        self.__stack.repository.refs.delete(self.__log_ref)
+        try:
+            # this compatibility log ref might not exist
+            self.__stack.repository.refs.delete(self.__log_ref)
+        except KeyError:
+            pass
     def set_commit(self, commit, msg):
         self.__write_compat_files(commit, msg)
         self.__stack.repository.refs.set(self.__ref, commit, msg)
