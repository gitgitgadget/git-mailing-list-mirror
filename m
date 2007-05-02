From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Makefile: use --unsafe option under Cygwin with asciidoc
Date: Wed, 02 May 2007 14:49:58 +0300
Organization: Private
Message-ID: <ejlze97d.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 14:40:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjE8R-0005VY-D2
	for gcvg-git@gmane.org; Wed, 02 May 2007 14:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993089AbXEBMkh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 08:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993093AbXEBMkh
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 08:40:37 -0400
Received: from main.gmane.org ([80.91.229.2]:34224 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993089AbXEBMkf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 08:40:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HjDfS-0000Dt-25
	for git@vger.kernel.org; Wed, 02 May 2007 14:10:46 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 May 2007 14:10:46 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 May 2007 14:10:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:/Do8sArh/hDUeI8cdyiy9pd22IU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46016>

New: variable ASCIIDOC_FLAGS was introduced. It was also added to two
new targets. The old ASCIIDOC_EXTRA is set to --unsafe under Cygwin to
ignore asciidoc error about unsafe include.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/Makefile |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3f92783..399ff12 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -37,6 +37,14 @@ man7dir=$(mandir)/man7
 
 ASCIIDOC=asciidoc
 ASCIIDOC_EXTRA =
+
+ifneq (,$(CYGWIN))
+# Ignore 'include' call errors
+ASCIIDOC_EXTRA = --unsafe
+endif
+
+ASCIIDOC_FLAGS += $(ASCIIDOC_EXTRA)
+
 INSTALL?=install
 DOC_REF = origin/man
 
@@ -112,7 +120,7 @@ clean:
 %.html : %.txt
 	rm -f $@+ $@
 	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
-		$(ASCIIDOC_EXTRA) -o - $< | \
+		$(ASCIIDOC_FLAGS) -o - $< | \
 		sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' >$@+
 	mv $@+ $@
 
@@ -122,12 +130,12 @@ clean:
 %.xml : %.txt
 	rm -f $@+ $@
 	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
-		$(ASCIIDOC_EXTRA) -o - $< | \
+		$(ASCIIDOC_FLAGS) -o - $< | \
 		sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' >$@+
 	mv $@+ $@
 
 user-manual.xml: user-manual.txt user-manual.conf
-	$(ASCIIDOC) -b docbook -d book $<
+	$(ASCIIDOC) -b docbook -d book $(ASCIIDOC_FLAGS) $<
 
 XSLT = http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl
 XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
@@ -141,13 +149,13 @@ howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
-	$(ASCIIDOC) -b xhtml11 $*.txt
+	$(ASCIIDOC) -b xhtml11 $(ASCIIDOC_FLAGS) $*.txt
 
 WEBDOC_DEST = /pub/software/scm/git/docs
 
 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 	rm -f $@+ $@
-	sed -e '1,/^$$/d' $< | $(ASCIIDOC) -b xhtml11 - >$@+
+	sed -e '1,/^$$/d' $< | $(ASCIIDOC) -b xhtml11 $(ASCIIDOC_FLAGS) - >$@+
 	mv $@+ $@
 
 install-webdoc : html
-- 
1.5.1.3
