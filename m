From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 3/3] Documentation: move some AsciiDoc parameters into variables
Date: Mon, 20 Oct 2014 00:20:38 +0000
Message-ID: <1413764438-297386-4-git-send-email-sandals@crustytoothpaste.net>
References: <1413764438-297386-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 02:21:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xg0il-0006xT-Op
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 02:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbaJTAVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 20:21:07 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49408 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752038AbaJTAUt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Oct 2014 20:20:49 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E2BE128093;
	Mon, 20 Oct 2014 00:20:46 +0000 (UTC)
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413764438-297386-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Asciidoctor takes slightly different arguments from AsciiDoc in some
cases.  It has a different name for the HTML backend and the "docbook"
backend produces DocBook 5, not DocBook 4.5.  Also, Asciidoctor does not
accept the -f option.  Move these values into variables so that they can
be overridden by users wishing to use Asciidoctor instead of Asciidoc,
and simplify several redundant rules.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/Makefile | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index cea0e7a..5952cc2 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -97,6 +97,13 @@ man7dir = $(mandir)/man7
 
 ASCIIDOC = asciidoc
 ASCIIDOC_EXTRA =
+ASCIIDOC_HTML = xhtml11
+ASCIIDOC_DOCBOOK = docbook
+ASCIIDOC_CONF = -f asciidoc.conf
+ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
+		-agit-version=$(GIT_VERSION)
+TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
+TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
 MANPAGE_XSL = manpage-normal.xsl
 XMLTO = xmlto
 XMLTO_EXTRA =
@@ -304,14 +311,12 @@ clean:
 
 $(MAN_HTML): %.html : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
-		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
+	$(TXT_TO_HTML) -d manpage -o $@+ $< && \
 	mv $@+ $@
 
 $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
-		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
+	$(TXT_TO_HTML) -o $@+ $< && \
 	mv $@+ $@
 
 manpage-base-url.xsl: manpage-base-url.xsl.in
@@ -323,13 +328,12 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 
 %.xml : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
-		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
+	$(TXT_TO_XML) -d manpage -o $@+ $< && \
 	mv $@+ $@
 
 user-manual.xml: user-manual.txt user-manual.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b docbook -d article -o $@+ $< && \
+	$(TXT_TO_XML) -d article -o $@+ $< && \
 	mv $@+ $@
 
 technical/api-index.txt: technical/api-index-skel.txt \
@@ -338,8 +342,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
 
 technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt asciidoc.conf
-	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
-		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) $*.txt
+	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
 
 XSLT = docbook.xsl
 XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
@@ -386,14 +389,15 @@ howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
-	$(QUIET_ASCIIDOC)$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 $*.txt
+	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
 
 WEBDOC_DEST = /pub/software/scm/git/docs
 
 howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	sed -e '1,/^$$/d' $< | $(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 - >$@+ && \
+	sed -e '1,/^$$/d' $< | \
+	$(TXT_TO_HTML) - >$@+ && \
 	mv $@+ $@
 
 install-webdoc : html
-- 
2.1.1
