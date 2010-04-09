From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] Makefile: Simplify handling of python scripts
Date: Fri,  9 Apr 2010 11:34:03 -0400
Message-ID: <1270827245-28958-2-git-send-email-brian@gernhardtsoftware.com>
References: <1270827245-28958-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 17:35:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0GEk-0000fO-Hl
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 17:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373Ab0DIPee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 11:34:34 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:53655 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab0DIPeP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 11:34:15 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 4644C1FFC05B; Fri,  9 Apr 2010 15:34:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from Hermes.local.net (unknown [64.134.102.129])
	by silverinsanity.com (Postfix) with ESMTPA id 7C46F1FFC057;
	Fri,  9 Apr 2010 15:34:09 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.rc0.243.g2ce66
In-Reply-To: <1270827245-28958-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144443>

The sed script intended to add a standard opening to python scripts
was non-compatible and overly complex.  Simplifying it down to a set
of one-liners removes the compatibility issues of newlines.  Moving
the environment alterations from the Makefile to the python scripts
makes also makes the scripts easier to run in-place.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 Makefile              |    9 ++-------
 git-remote-testgit.py |    2 ++
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index f0fe351..87c90d6 100644
--- a/Makefile
+++ b/Makefile
@@ -1629,13 +1629,8 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_helpers -s \
 		--no-print-directory prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' \
 		instlibdir` && \
-	sed -e '1{' \
-	    -e '	s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
-	    -e '}' \
-	    -e 's|^import sys.*|&; \\\
-	           import os; \\\
-	           sys.path.insert(0, os.getenv("GITPYTHONLIB",\
-	                                        "@@INSTLIBDIR@@"));|' \
+	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
+	    -e 's|\(os\.getenv("GITPYTHONLIB"\)[^)]*)|\1,"@@INSTLIBDIR@@")|' \
 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
 	    $@.py >$@+ && \
 	chmod +x $@+ && \
diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index f61624e..9253922 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -2,6 +2,8 @@
 
 import hashlib
 import sys
+import os
+sys.path.insert(0, os.getenv("GITPYTHONLIB","."))
 
 from git_remote_helpers.util import die, debug, warn
 from git_remote_helpers.git.repo import GitRepo
-- 
1.7.1.rc0.243.g2ce66
