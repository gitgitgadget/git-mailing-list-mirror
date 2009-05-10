From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit] Immediately evaluate the ProgramFiles environment variable
Date: Sun, 10 May 2009 11:53:45 +0200
Message-ID: <1241949225-10046-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 10 11:57:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M35mK-0007Sr-TU
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 11:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755435AbZEJJ4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 05:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755226AbZEJJ4z
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 05:56:55 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:52182 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbZEJJ4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 05:56:54 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 8CBC0FEAFE16;
	Sun, 10 May 2009 11:56:54 +0200 (CEST)
Received: from [89.59.125.79] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M35jG-0001Ir-00; Sun, 10 May 2009 11:53:54 +0200
X-Mailer: git-send-email 1.6.3.20.g687dc
X-Provags-ID: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118713>

Commit 50d839b (Don't hardcode GIT_EXEC_DIR for Windows so much,
2009-04-18) broke 'make install' on Windows. Somehow the current working
directory was prepended to the install path given with target.path, when
$(ProgramFiles) should be evaluated during the call of 'make'.
This seems to be a qmake bug with generating the Makefile.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

For clarification:
$ cd C:\projects\qgit4\src
$ qmake src.pro -win32 -o Makefile

Now the install_target and uninstall_target targets in Makefile.{Debug,Release}
are wrong, for example

uninstall_target:  FORCE
	-$(DEL_FILE) "c:$(INSTALL_ROOT)\projects\qgit\src\$(ProgramFiles)\Git\bin\$(TARGET)"
	-$(DEL_DIR) $(INSTALL_ROOT)"c:\projects\qgit\src\$(ProgramFiles)\Git\bin\" 

instead of

uninstall_target:  FORCE
	-$(DEL_FILE) "c:$(INSTALL_ROOT)\Programme\Git\bin\$(TARGET)"
	-$(DEL_DIR) c:$(INSTALL_ROOT)\Programme\Git\bin 

Hmm, seems as if there is another bug:
$(INSTALL_ROOT)"c:  vs.  c:$(INSTALL_ROOT)

Sorry for this and for noticing it just a bit too late. I haven't called 'make
install' before.

 src/src.pro |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/src.pro b/src/src.pro
index 619a9a8..133e64c 100644
--- a/src/src.pro
+++ b/src/src.pro
@@ -1,6 +1,6 @@
 # Under Windows launch script start_qgit.bat needs the
 # value GIT_EXEC_DIR to be set to the git bin directory
-GIT_EXEC_DIR = "$(ProgramFiles)\\Git\\bin"
+GIT_EXEC_DIR = "$$(ProgramFiles)\\Git\\bin"
 
 # Under Windows uncomment following line to enable console messages
 #CONFIG += ENABLE_CONSOLE_MSG
-- 
1.6.3.20.g687dc
