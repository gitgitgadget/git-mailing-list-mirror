From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [RFC/PATCH] Add support for a pdf version of the user manual
Date: Wed, 10 Dec 2008 23:44:50 +0100
Message-ID: <1228949090-22475-1-git-send-email-vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 23:44:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAXnJ-0000uJ-65
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 23:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbYLJWnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 17:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752934AbYLJWnT
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 17:43:19 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:52589 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbYLJWnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 17:43:19 -0500
Received: from vmobile.example.net (dsl5401CC70.pool.t-online.hu [84.1.204.112])
	by yugo.frugalware.org (Postfix) with ESMTPA id 356D9446CDE
	for <git@vger.kernel.org>; Wed, 10 Dec 2008 23:43:16 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id C96CF19DC9B; Wed, 10 Dec 2008 23:44:50 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.35.gae26e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102733>

Use dblatex in order to create a pdf version of the git user manual.  No
existing Makefile targets (including "all") are touched, so you need to
explicitly say

make pdf
sudo make install-pdf

to get user-manual.pdf created and installed.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Hi,

It turns out that people prefer reading long documents (such as the User
Manual) in a pdf reader, rather then in a web browser. This patch makes
them happy.

I marked it RFC as I'm not sure if using the asciidoc dblatex sty and
xsl file is a good idea or not.

(Oh and because we are in the rc period and this is not a bugfix.)

The other (info/man/html) formats do not make use of the config files in
/etc/asciidoc, so maybe it would be better to just copy them in the
Documentation dir. OTOH I did not want to cause a duplication without a
good reason.

Opinions?

Thanks.

 Documentation/Makefile |   13 +++++++++++++
 INSTALL                |    3 +++
 Makefile               |    6 ++++++
 3 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c34c1ca..69f4ade 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -32,6 +32,7 @@ DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
 prefix?=$(HOME)
 bindir?=$(prefix)/bin
 htmldir?=$(prefix)/share/doc/git-doc
+pdfdir?=$(prefix)/share/doc/git-doc
 mandir?=$(prefix)/share/man
 man1dir=$(mandir)/man1
 man5dir=$(mandir)/man5
@@ -50,6 +51,7 @@ infodir?=$(prefix)/share/info
 MAKEINFO=makeinfo
 INSTALL_INFO=install-info
 DOCBOOK2X_TEXI=docbook2x-texi
+DBLATEX=dblatex
 ifndef PERL_PATH
 	PERL_PATH = /usr/bin/perl
 endif
@@ -87,6 +89,8 @@ man7: $(DOC_MAN7)
 
 info: git.info gitman.info
 
+pdf: user-manual.pdf
+
 install: install-man
 
 install-man: man
@@ -107,6 +111,10 @@ install-info: info
 	  echo "No directory found in $(DESTDIR)$(infodir)" >&2 ; \
 	fi
 
+install-pdf: pdf
+	$(INSTALL) -d -m 755 $(DESTDIR)$(pdfdir)
+	$(INSTALL) -m 644 user-manual.pdf $(DESTDIR)$(pdfdir)
+
 install-html: html
 	sh ./install-webdoc.sh $(DESTDIR)$(htmldir)
 
@@ -190,6 +198,11 @@ user-manual.texi: user-manual.xml
 	$(DOCBOOK2X_TEXI) user-manual.xml --to-stdout | $(PERL_PATH) fix-texi.perl >$@+
 	mv $@+ $@
 
+user-manual.pdf: user-manual.xml
+	$(RM) $@+ $@
+	$(DBLATEX) -o $@+ -p /etc/asciidoc/dblatex/asciidoc-dblatex.xsl -s /etc/asciidoc/dblatex/asciidoc-dblatex.sty $<
+	mv $@+ $@
+
 gitman.texi: $(MAN_XML) cat-texi.perl
 	$(RM) $@+ $@
 	($(foreach xml,$(MAN_XML),$(DOCBOOK2X_TEXI) --to-stdout $(xml);)) | \
diff --git a/INSTALL b/INSTALL
index d1deb0b..ae7f750 100644
--- a/INSTALL
+++ b/INSTALL
@@ -101,6 +101,9 @@ Issues of note:
    Building and installing the info file additionally requires
    makeinfo and docbook2X.  Version 0.8.3 is known to work.
 
+   Building and installing the pdf file additionally requires
+   dblatex.  Version 0.2.7 with asciidoc >= 8.2.7 is known to work.
+
    The documentation is written for AsciiDoc 7, but "make
    ASCIIDOC8=YesPlease doc" will let you format with AsciiDoc 8.
 
diff --git a/Makefile b/Makefile
index 5158197..b1456a2 100644
--- a/Makefile
+++ b/Makefile
@@ -1306,6 +1306,9 @@ html:
 info:
 	$(MAKE) -C Documentation info
 
+pdf:
+	$(MAKE) -C Documentation pdf
+
 TAGS:
 	$(RM) TAGS
 	$(FIND) . -name '*.[hcS]' -print | xargs etags -a
@@ -1448,6 +1451,9 @@ install-html:
 install-info:
 	$(MAKE) -C Documentation install-info
 
+install-pdf:
+	$(MAKE) -C Documentation install-pdf
+
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
-- 
1.6.1.rc1.35.gae26e.dirty
