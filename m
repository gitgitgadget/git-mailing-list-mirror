From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH v2 1/2] Documentation/Makefile: make most operations "quiet"
Date: Fri, 27 Mar 2009 01:49:38 -0500
Message-ID: <1238136579-23166-1-git-send-email-chris_johnsen@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 07:51:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln5uB-0000Z3-Em
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 07:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbZC0Gtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 02:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbZC0Gtc
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 02:49:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZC0Gtc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 02:49:32 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1BE00A544F;
	Fri, 27 Mar 2009 02:49:29 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 EDC22A544C; Fri, 27 Mar 2009 02:49:20 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.401.gc048
X-Pobox-Relay-ID: 6B55127E-1A9B-11DE-969A-32B0EBB1AA3C-07245699!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114862>

This adapts the "quiet make" implementation from the main
Makefile.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---

"v1" of this series can be found here: <http://thread.gmane.org/gmane.comp.version-control.git/114417/focus=114557>.

Changes since "v1": Fixed broken technical/api-index.txt target
  (thanks, Peff). Extended error propagation across calls to
  DOCBOOK2X_TEXI for gitman.texi. Added QUIET_XSLTPROC for
  "one-off" user-manual.html.
---
 Documentation/Makefile |   84 +++++++++++++++++++++++++++++++----------------
 1 files changed, 55 insertions(+), 29 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 144ec32..3e1d175 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -76,6 +76,32 @@ endif
 # yourself - yes, all 6 characters of it!
 #
 
+QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
+QUIET_SUBDIR1  =
+
+ifneq ($(findstring $(MAKEFLAGS),w),w)
+PRINT_DIR = --no-print-directory
+else # "make -w"
+NO_SUBDIR = :
+endif
+
+ifneq ($(findstring $(MAKEFLAGS),s),s)
+ifndef V
+	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
+	QUIET_XMLTO	= @echo '   ' XMLTO $@;
+	QUIET_DB2TEXI	= @echo '   ' DB2TEXI $@;
+	QUIET_MAKEINFO	= @echo '   ' MAKEINFO $@;
+	QUIET_DBLATEX	= @echo '   ' DBLATEX $@;
+	QUIET_XSLTPROC	= @echo '   ' XSLTPROC $@;
+	QUIET_GEN	= @echo '   ' GEN $@;
+	QUIET_STDERR	= 2> /dev/null
+	QUIET_SUBDIR0	= +@subdir=
+	QUIET_SUBDIR1	= ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
+			  $(MAKE) $(PRINT_DIR) -C $$subdir
+	export V
+endif
+endif
+
 all: html man
 
 html: $(DOC_HTML)
@@ -119,7 +145,7 @@ install-html: html
 	sh ./install-webdoc.sh $(DESTDIR)$(htmldir)
 
 ../GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
-	$(MAKE) -C ../ GIT-VERSION-FILE
+	$(QUIET_SUBDIR0)../ $(QUIET_SUBDIR1) GIT-VERSION-FILE
 
 -include ../GIT-VERSION-FILE
 
@@ -127,8 +153,8 @@ install-html: html
 # Determine "include::" file references in asciidoc files.
 #
 doc.dep : $(wildcard *.txt) build-docdep.perl
-	$(RM) $@+ $@
-	$(PERL_PATH) ./build-docdep.perl >$@+
+	$(QUIET_GEN)$(RM) $@+ $@ && \
+	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
 	mv $@+ $@
 
 -include doc.dep
@@ -146,8 +172,8 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
 $(cmds_txt): cmd-list.made
 
 cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
-	$(RM) $@
-	$(PERL_PATH) ./cmd-list.perl ../command-list.txt
+	$(QUIET_GEN)$(RM) $@ && \
+	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(QUIET_STDERR) && \
 	date >$@
 
 clean:
@@ -158,79 +184,79 @@ clean:
 	$(RM) $(cmds_txt) *.made
 
 $(MAN_HTML): %.html : %.txt
-	$(RM) $@+ $@
+	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
-		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $<
+		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
 	mv $@+ $@
 
 %.1 %.5 %.7 : %.xml
-	$(RM) $@
+	$(QUIET_XMLTO)$(RM) $@ && \
 	xmlto -m $(MANPAGE_XSL) man $<
 
 %.xml : %.txt
-	$(RM) $@+ $@
+	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
-		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $<
+		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
 	mv $@+ $@
 
 user-manual.xml: user-manual.txt user-manual.conf
-	$(ASCIIDOC) -b docbook -d book $<
+	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b docbook -d book $<
 
 technical/api-index.txt: technical/api-index-skel.txt \
 	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
-	cd technical && sh ./api-index.sh
+	$(QUIET_GEN)cd technical && sh ./api-index.sh
 
 $(patsubst %,%.html,$(API_DOCS) technical/api-index): %.html : %.txt
-	$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
+	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) $*.txt
 
 XSLT = docbook.xsl
 XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
 
 user-manual.html: user-manual.xml
-	xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
+	$(QUIET_XSLTPROC)xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
 
 git.info: user-manual.texi
-	$(MAKEINFO) --no-split -o $@ user-manual.texi
+	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split -o $@ user-manual.texi
 
 user-manual.texi: user-manual.xml
-	$(RM) $@+ $@
+	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
 	$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout | \
-		$(PERL_PATH) fix-texi.perl >$@+
+		$(PERL_PATH) fix-texi.perl >$@+ && \
 	mv $@+ $@
 
 user-manual.pdf: user-manual.xml
-	$(RM) $@+ $@
-	$(DBLATEX) -o $@+ -p /etc/asciidoc/dblatex/asciidoc-dblatex.xsl -s /etc/asciidoc/dblatex/asciidoc-dblatex.sty $<
+	$(QUIET_DBLATEX)$(RM) $@+ $@ && \
+	$(DBLATEX) -o $@+ -p /etc/asciidoc/dblatex/asciidoc-dblatex.xsl -s /etc/asciidoc/dblatex/asciidoc-dblatex.sty $< && \
 	mv $@+ $@
 
 gitman.texi: $(MAN_XML) cat-texi.perl
-	$(RM) $@+ $@
+	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
 	($(foreach xml,$(MAN_XML),$(DOCBOOK2X_TEXI) --encoding=UTF-8 \
-		--to-stdout $(xml);)) | $(PERL_PATH) cat-texi.perl $@ >$@+
+		--to-stdout $(xml) &&) true) | $(PERL_PATH) cat-texi.perl $@ >$@+ && \
 	mv $@+ $@
 
 gitman.info: gitman.texi
-	$(MAKEINFO) --no-split --no-validate $*.texi
+	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split --no-validate $*.texi
 
 $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
-	$(RM) $@+ $@
-	$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@+
+	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
+	$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@+ && \
 	mv $@+ $@
 
 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
-	$(RM) $@+ $@
-	sh ./howto-index.sh $(wildcard howto/*.txt) >$@+
+	$(QUIET_GEN)$(RM) $@+ $@ && \
+	sh ./howto-index.sh $(wildcard howto/*.txt) >$@+ && \
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
-	$(ASCIIDOC) -b xhtml11 $*.txt
+	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 $*.txt
 
 WEBDOC_DEST = /pub/software/scm/git/docs
 
 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
-	$(RM) $@+ $@
-	sed -e '1,/^$$/d' $< | $(ASCIIDOC) -b xhtml11 - >$@+
+	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
+	sed -e '1,/^$$/d' $< | $(ASCIIDOC) -b xhtml11 - >$@+ && \
 	mv $@+ $@
 
 install-webdoc : html
-- 
1.6.2.1.401.gc048
