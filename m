From: David Kastrup <dak@gnu.org>
Subject: [PATCH] Add support for an info version of the user manual
Date: Mon, 6 Aug 2007 12:22:57 +0200
Message-ID: <86ir7tc5xk.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 12:29:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHzqD-0005uc-I8
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 12:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbXHFK3d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 06:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762674AbXHFK3d
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 06:29:33 -0400
Received: from main.gmane.org ([80.91.229.2]:55640 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762658AbXHFK3c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 06:29:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IHzq0-0001ZY-7O
	for git@vger.kernel.org; Mon, 06 Aug 2007 12:29:24 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 12:29:24 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 12:29:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:9dQNewMF0+oaM7zAiy8+JpnAuqY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55138>


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

awk is used for patching up sub-par file and directory information in
the Texinfo file.  It would be cleaner to place the respective info
straight into user-manual.txt or the conversion configurations, but I
find myself unable to find out how to do this with Asciidoc/Texinfo.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 Documentation/Makefile |   28 ++++++++++++++++++++++++++++
 Makefile               |    6 ++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 443114b..97ee067 100644
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
@@ -138,6 +153,19 @@ XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
 user-manual.html: user-manual.xml
 	xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
 
+git.info: user-manual.xml
+	$(RM) $@ $*.texi
+	$(DOCBOOK2X_TEXI) user-manual.xml --to-stdout | \
+	awk '/^@setfilename/{$$2="git.info"};\
+	     /^@direntry/{print "@dircategory Development"; \
+	                  print "@direntry"; \
+	                  print "* Git: (git).           A fast distributed revision control system"; \
+			  print "@end direntry"}; \
+	     /^@direntry/,/^@end direntry/ { next }; \
+	     {print}' > $*.texi
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
