From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] Makefile: Avoid multi-line sed when building python scripts
Date: Fri,  9 Apr 2010 01:42:39 -0700
Message-ID: <1270802559-14791-1-git-send-email-davvid@gmail.com>
References: <20100409080256.GA12527@gmail.com>
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 10:42:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O09ng-00043M-72
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 10:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756749Ab0DIImq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 04:42:46 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39644 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756772Ab0DIImp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 04:42:45 -0400
Received: by gwb19 with SMTP id 19so1664649gwb.19
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UgS6hjtevT+x5jh3ChDFT6xDNAAkBbVTT/GSXfvYY5k=;
        b=TIjcTx89KDE1vGNZDoLBGXkMb8IieXFb5eFmvi5LLDVES3LSio1ACjvAnq1gWHZdct
         xK5zLymu2glY4RZH0suK7+JApRK0EfkQRr7OewtLdNq0qt9J1+P6hUnRBLpzozI/y1+l
         5UadtdMywlVlC0aeJ58Fl7qrzc0oT9qbQdQxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LRTRz5oJGmP2pjcCErtzfFVmcnoM5vRK3qrpEsWFTggChHcQHAAKEz+PCgWJreHwqK
         tc3lotbSDLeRfalmvSeoHTXzToHyDT4PIxP08kVRmOCtFS3GnMInQLj+1FtS3OPsIJZv
         S3EspxtOsRsDfIoIMf6NpPVpio0LLmZNDFqnI=
Received: by 10.101.163.26 with SMTP id q26mr2171909ano.185.1270802564225;
        Fri, 09 Apr 2010 01:42:44 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 7sm265763ywc.49.2010.04.09.01.42.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 01:42:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.313.g87b3c
In-Reply-To: <20100409080256.GA12527@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144418>

Instead of requiring scripts to start with "import sys",
install the sys.path initialization code immediately
after each script's new shebang line.

This works around portability issues with multi-line sed and
simplifies the work for contributors.  There is no longer
the requirement that every script must "import sys" before
importing git-provided modules.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Makefile |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 956e781..b763947 100644
--- a/Makefile
+++ b/Makefile
@@ -1608,12 +1608,10 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
 		--no-print-directory prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' \
 		instlibdir` && \
 	sed -e '1{' \
-	    -e '	s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
+	    -e '	s|#!.*python|#!$(PYTHON_PATH_SQ)\n@@STARTUP@@|' \
 	    -e '}' \
-	    -e 's|^import sys.*|&; \\\
-	           import os; \\\
-	           sys.path.insert(0, os.getenv("GITPYTHONLIB",\
-	                                        "@@INSTLIBDIR@@"));|' \
+	    -e 's|@@STARTUP@@|import os, sys; sys.path.insert(0, @@ENV@@)|' \
+	    -e 's|@@ENV@@|os.getenv("GITPYTHONLIB", "@@INSTLIBDIR@@")|' \
 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
 	    $@.py >$@+ && \
 	chmod +x $@+ && \
-- 
1.7.0.3.313.g87b3c
