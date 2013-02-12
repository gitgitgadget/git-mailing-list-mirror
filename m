From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 3/3] Documentation/Makefile: fix inherited {html,info,man}dir
Date: Tue, 12 Feb 2013 20:17:50 +0000
Message-ID: <60caa0f956179b0396614afd83e133198e9b4430.1360700102.git.john@keeping.me.uk>
References: <cover.1360700102.git.john@keeping.me.uk>
Cc: Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 21:24:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5MPE-0000Ma-PV
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 21:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781Ab3BLUYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 15:24:21 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:47154 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab3BLUYS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 15:24:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 0E7E1161E4EA;
	Tue, 12 Feb 2013 20:18:40 +0000 (GMT)
X-Quarantine-ID: <ICbCN+YvEA7c>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ICbCN+YvEA7c; Tue, 12 Feb 2013 20:18:38 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 2AC70161E3D3;
	Tue, 12 Feb 2013 20:18:31 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1360700102.git.john@keeping.me.uk>
In-Reply-To: <cover.1360700102.git.john@keeping.me.uk>
References: <cover.1360700102.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216188>

Commit e14421b (Allow INSTALL, bindir, mandir to be set in main Makefile
- 2006-06-29) changed Documentation/Makefile to inherit the value of
mandir from the top-level Makefile when invoked as "make install-doc" at
the top-level.  This was inherited by infodir and htmldir when they were
added.

This was broken by commit 026fa0d (Move computation of absolute paths
from Makefile to runtime (in preparation for RUNTIME_PREFIX) -
2009-01-18) which changed these variables to have relative paths in the
top-level Makefile, causing the documentation to be installed into the
path without $(prefix) prepended.

Fix this by changing the defaults to be paths relative to $(prefix) and
introducing new variables {html,info,man}_instdir which contain the full
installation paths.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
I'm not sure if this is the best approach - the alternative would be to
change the top-level Makefile to use {html,info,man}dir_relative and
derive the {html,info,man}dir variables from that.

The top-level Makefile is inconsistent in the approach it takes - bindir
is derived from bindir_relative but gitexecdir and template_dir have
gitexec_instdir and template_instdir derived from them.

 Documentation/Makefile | 56 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 0cfdc36..34cd9f2 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -78,15 +78,21 @@ DOC_MAN1 = $(patsubst %.txt,%.1,$(MAN1_TXT))
 DOC_MAN5 = $(patsubst %.txt,%.5,$(MAN5_TXT))
 DOC_MAN7 = $(patsubst %.txt,%.7,$(MAN7_TXT))
 
+# The following variables can be relative paths due to the way they can be
+# inherited from the top-level Makefile:
+#   htmldir
+#   infodir
+#   mandir
+# Note that pdfdir is an exception to this since it is not used by git-help.
 prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
-htmldir ?= $(prefix)/share/doc/git-doc
-infodir ?= $(prefix)/share/info
 pdfdir ?= $(prefix)/share/doc/git-doc
-mandir ?= $(prefix)/share/man
-man1dir = $(mandir)/man1
-man5dir = $(mandir)/man5
-man7dir = $(mandir)/man7
+htmldir ?= share/doc/git-doc
+infodir ?= share/info
+mandir ?= share/man
+man1dir = $(man_instdir)/man1
+man5dir = $(man_instdir)/man5
+man7dir = $(man_instdir)/man7
 # DESTDIR =
 
 ASCIIDOC = asciidoc
@@ -110,6 +116,24 @@ endif
 -include ../config.mak.autogen
 -include ../config.mak
 
+ifneq ($(filter /%,$(firstword $(htmldir))),)
+html_instdir = $(htmldir)
+else
+html_instdir = $(prefix)/$(htmldir)
+endif
+
+ifneq ($(filter /%,$(firstword $(infodir))),)
+info_instdir = $(infodir)
+else
+info_instdir = $(prefix)/$(infodir)
+endif
+
+ifneq ($(filter /%,$(firstword $(mandir))),)
+man_instdir = $(mandir)
+else
+man_instdir = $(prefix)/$(mandir)
+endif
+
 #
 # For docbook-xsl ...
 #	-1.68.1,	no extra settings are needed?
@@ -144,7 +168,7 @@ endif
 # Distros may want to use MAN_BASE_URL=file:///path/to/git/docs/
 # or similar.
 ifndef MAN_BASE_URL
-MAN_BASE_URL = file://$(htmldir)/
+MAN_BASE_URL = file://$(html_instdir)/
 endif
 XMLTO_EXTRA += -m manpage-base-url.xsl
 
@@ -220,13 +244,13 @@ install-man: man
 	$(INSTALL) -m 644 $(DOC_MAN7) $(DESTDIR)$(man7dir)
 
 install-info: info
-	$(INSTALL) -d -m 755 $(DESTDIR)$(infodir)
-	$(INSTALL) -m 644 git.info gitman.info $(DESTDIR)$(infodir)
-	if test -r $(DESTDIR)$(infodir)/dir; then \
-	  $(INSTALL_INFO) --info-dir=$(DESTDIR)$(infodir) git.info ;\
-	  $(INSTALL_INFO) --info-dir=$(DESTDIR)$(infodir) gitman.info ;\
+	$(INSTALL) -d -m 755 $(DESTDIR)$(info_instdir)
+	$(INSTALL) -m 644 git.info gitman.info $(DESTDIR)$(info_instdir)
+	if test -r $(DESTDIR)$(info_instdir)/dir; then \
+	  $(INSTALL_INFO) --info-dir=$(DESTDIR)$(info_instdir) git.info ;\
+	  $(INSTALL_INFO) --info-dir=$(DESTDIR)$(info_instdir) gitman.info ;\
 	else \
-	  echo "No directory found in $(DESTDIR)$(infodir)" >&2 ; \
+	  echo "No directory found in $(DESTDIR)$(info_instdir)" >&2 ; \
 	fi
 
 install-pdf: pdf
@@ -234,7 +258,7 @@ install-pdf: pdf
 	$(INSTALL) -m 644 user-manual.pdf $(DESTDIR)$(pdfdir)
 
 install-html: html
-	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(htmldir)
+	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(html_instdir)
 
 ../GIT-VERSION-FILE: FORCE
 	$(QUIET_SUBDIR0)../ $(QUIET_SUBDIR1) GIT-VERSION-FILE
@@ -402,14 +426,14 @@ require-manrepo::
 	then echo "git-manpages repository must exist at $(MAN_REPO)"; exit 1; fi
 
 quick-install-man: require-manrepo
-	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO) $(DESTDIR)$(mandir)
+	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO) $(DESTDIR)$(man_instdir)
 
 require-htmlrepo::
 	@if test ! -d $(HTML_REPO); \
 	then echo "git-htmldocs repository must exist at $(HTML_REPO)"; exit 1; fi
 
 quick-install-html: require-htmlrepo
-	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO) $(DESTDIR)$(htmldir)
+	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO) $(DESTDIR)$(html_instdir)
 
 print-man1:
 	@for i in $(MAN1_TXT); do echo $$i; done
-- 
1.8.1.2
