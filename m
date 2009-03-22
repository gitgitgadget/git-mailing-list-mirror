From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] documentation: Makefile accounts for SHELL_PATH setting
Date: Sun, 22 Mar 2009 09:20:44 -0400
Message-ID: <1237728044-15651-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 14:22:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlNd4-0001F9-Gp
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 14:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbZCVNUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 09:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbZCVNUt
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 09:20:49 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:58030 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbZCVNUs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 09:20:48 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1LlNba-0000Y7-6E; Sun, 22 Mar 2009 09:20:46 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1LlNba-00044z-3l; Sun, 22 Mar 2009 09:20:46 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n2MDKirj015681;
	Sun, 22 Mar 2009 09:20:44 -0400
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114139>

Ensure that the Makefile that generates and installs the Documentation
is aware of any SHELL_PATH setting.  Use this value if found or the
current setting for SHELL if not.  This is an accommodation for systems
where sh is not bash.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 Documentation/Makefile |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 144ec32..0353690 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -67,6 +67,10 @@ ASCIIDOC_EXTRA += -a docbook-xsl-172
 MANPAGE_XSL = manpage-1.72.xsl
 endif
 
+SHELL_PATH ?= $(SHELL)
+# Shell quote;
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+
 #
 # Please note that there is a minor bug in asciidoc.
 # The version after 6.0.3 _will_ include the patch found here:
@@ -116,7 +120,7 @@ install-pdf: pdf
 	$(INSTALL) -m 644 user-manual.pdf $(DESTDIR)$(pdfdir)
 
 install-html: html
-	sh ./install-webdoc.sh $(DESTDIR)$(htmldir)
+	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(htmldir)
 
 ../GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	$(MAKE) -C ../ GIT-VERSION-FILE
@@ -178,7 +182,7 @@ user-manual.xml: user-manual.txt user-manual.conf
 
 technical/api-index.txt: technical/api-index-skel.txt \
 	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
-	cd technical && sh ./api-index.sh
+	cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
 
 $(patsubst %,%.html,$(API_DOCS) technical/api-index): %.html : %.txt
 	$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
@@ -220,7 +224,7 @@ $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
 
 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	$(RM) $@+ $@
-	sh ./howto-index.sh $(wildcard howto/*.txt) >$@+
+	'$(SHELL_PATH_SQ)' ./howto-index.sh $(wildcard howto/*.txt) >$@+
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
@@ -234,14 +238,14 @@ $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 	mv $@+ $@
 
 install-webdoc : html
-	sh ./install-webdoc.sh $(WEBDOC_DEST)
+	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(WEBDOC_DEST)
 
 quick-install: quick-install-man
 
 quick-install-man:
-	sh ./install-doc-quick.sh $(DOC_REF) $(DESTDIR)$(mandir)
+	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(DOC_REF) $(DESTDIR)$(mandir)
 
 quick-install-html:
-	sh ./install-doc-quick.sh $(HTML_REF) $(DESTDIR)$(htmldir)
+	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REF) $(DESTDIR)$(htmldir)
 
 .PHONY: .FORCE-GIT-VERSION-FILE
-- 
1.6.0.4
