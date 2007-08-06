From: David Kastrup <dak@gnu.org>
Subject: [install info (using perl) 1/2] Add support for an info version of the user manual
Date: Mon, 6 Aug 2007 12:22:57 +0200
Message-ID: <591c5679ea79b76cd5db57443b1d691bde842351.1186484406.git.dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 13:06:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIMsE-00023G-9b
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 13:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759085AbXHGLFL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 07:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759029AbXHGLFL
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 07:05:11 -0400
Received: from main.gmane.org ([80.91.229.2]:56897 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758741AbXHGLFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 07:05:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IIMs2-00087r-C1
	for git@vger.kernel.org; Tue, 07 Aug 2007 13:05:02 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 13:05:02 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 13:05:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
X-From-Line: 591c5679ea79b76cd5db57443b1d691bde842351 Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:1EhJyRtZNkCxLQafi/OR5vSrI4s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55246>

These patches use docbook2x in order to create an info version of the
git user manual.  No existing Makefile targets (including "all") are
touched, so you need to explicitly say

make info
sudo make install-info

to get git.info created and installed.  If the info target directory
does not already contain a "dir" file, no directory entry is created.
This facilitates $(DESTDIR)-based installations.  The same could be
achieved with

sudo make INSTALL_INFO=: install-info

explicitly.

perl is used for patching up sub-par file and directory information in
the Texinfo file.  It would be cleaner to place the respective info
straight into user-manual.txt or the conversion configurations, but I
find myself unable to find out how to do this with Asciidoc/Texinfo.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 Documentation/Makefile |   27 +++++++++++++++++++++++++++
 Makefile               |    6 ++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 91a437d..71b7056 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -44,6 +44,11 @@ INSTALL?=install
 RM ?= rm -f
 DOC_REF = origin/man
 
+infodir?=$(prefix)/share/info
+MAKEINFO=makeinfo
+INSTALL_INFO=install-info
+DOCBOOK2X_TEXI=docbook2x-texi
+
 -include ../config.mak.autogen
 -include ../config.mak
 
@@ -67,6 +72,8 @@ man1: $(DOC_MAN1)
 man5: $(DOC_MAN5)
 man7: $(DOC_MAN7)
 
+info: git.info
+
 install: man
 	$(INSTALL) -d -m755 $(DESTDIR)$(man1dir)
 	$(INSTALL) -d -m755 $(DESTDIR)$(man5dir)
@@ -75,6 +82,14 @@ install: man
 	$(INSTALL) -m644 $(DOC_MAN5) $(DESTDIR)$(man5dir)
 	$(INSTALL) -m644 $(DOC_MAN7) $(DESTDIR)$(man7dir)
 
+install-info: info
+	$(INSTALL) -d -m755 $(DESTDIR)$(infodir)
+	$(INSTALL) -m644 git.info $(DESTDIR)$(infodir)
+	if test -r $(DESTDIR)$(infodir)/dir; then \
+	  $(INSTALL_INFO) --info-dir=$(DESTDIR)$(infodir) git.info ;\
+	else \
+	  echo "No directory found in $(DESTDIR)$(infodir)" >&2 ; \
+	fi
 
 ../GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	$(MAKE) -C ../ GIT-VERSION-FILE
@@ -139,6 +154,18 @@ XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
 user-manual.html: user-manual.xml
 	xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
 
+git.info: user-manual.xml
+	$(RM) $@ $*.texi
+	$(DOCBOOK2X_TEXI) user-manual.xml --to-stdout | \
+	perl -ne 'if (/^\@setfilename/) {$$_="\@setfilename git.info\
+"} elsif (/^\@direntry/) {print "\@dircategory Development\
+\@direntry\
+* Git: (git).           A fast distributed revision control system\
+\@end direntry\
+"} print unless (/^\@direntry/ .. /^\@end direntry/)' > $*.texi
+	$(MAKEINFO) --no-split $*.texi
+	$(RM) $*.texi
+
 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	$(RM) $@+ $@
 	sh ./howto-index.sh $(wildcard howto/*.txt) >$@+
diff --git a/Makefile b/Makefile
index 2f3b9b2..b685c7e 100644
--- a/Makefile
+++ b/Makefile
@@ -913,6 +913,9 @@ perl/Makefile: perl/Git.pm perl/Makefile.PL GIT-CFLAGS
 doc:
 	$(MAKE) -C Documentation all
 
+info:
+	$(MAKE) -C Documentation info
+
 TAGS:
 	$(RM) TAGS
 	$(FIND) . -name '*.[hcS]' -print | xargs etags -a
@@ -1005,6 +1008,9 @@ endif
 install-doc:
 	$(MAKE) -C Documentation install
 
+install-info:
+	$(MAKE) -C Documentation install-info
+
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
-- 
1.5.3.rc4.21.ga63eb
