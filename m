From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/2] Documentation: refactor common operations into variables
Date: Mon, 27 Oct 2014 00:13:42 +0000
Message-ID: <1414368823-427216-2-git-send-email-sandals@crustytoothpaste.net>
References: <1414368823-427216-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 01:13:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiXwY-0008Qq-JJ
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 01:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbaJ0ANu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 20:13:50 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49583 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751722AbaJ0ANt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Oct 2014 20:13:49 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 309CA28090;
	Mon, 27 Oct 2014 00:13:48 +0000 (UTC)
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414368823-427216-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Makefile performs several very similar tasks to convert AsciiDoc
files into either HTML or DocBook.  Move these items into variables to
reduce the duplication.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/Makefile | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4cdef45..2f6b6aa 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -102,6 +102,10 @@ ASCIIDOC_EXTRA =
 ASCIIDOC_HTML = xhtml11
 ASCIIDOC_DOCBOOK = docbook
 ASCIIDOC_CONF = -f asciidoc.conf
+ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
+		-agit-version=$(GIT_VERSION)
+TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
+TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
 MANPAGE_XSL = manpage-normal.xsl
 XMLTO = xmlto
 XMLTO_EXTRA =
@@ -309,14 +313,12 @@ clean:
 
 $(MAN_HTML): %.html : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(ASCIIDOC) -b $(ASCIIDOC_HTML) -d manpage $(ASCIIDOC_CONF) \
-		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
+	$(TXT_TO_HTML) -d manpage -o $@+ $< && \
 	mv $@+ $@
 
 $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(ASCIIDOC) -b $(ASCIIDOC_HTML) $(ASCIIDOC_CONF) \
-		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
+	$(TXT_TO_HTML) -o $@+ $< && \
 	mv $@+ $@
 
 manpage-base-url.xsl: manpage-base-url.xsl.in
@@ -328,13 +330,12 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 
 %.xml : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(ASCIIDOC) -b $(ASCIIDOC_DOCBOOK) -d manpage $(ASCIIDOC_CONF) \
-		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
+	$(TXT_TO_XML) -d manpage -o $@+ $< && \
 	mv $@+ $@
 
 user-manual.xml: user-manual.txt user-manual.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b $(ASCIIDOC_DOCBOOK) -d article -o $@+ $< && \
+	$(TXT_TO_XML) -d article -o $@+ $< && \
 	mv $@+ $@
 
 technical/api-index.txt: technical/api-index-skel.txt \
@@ -343,8 +344,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
 
 technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt asciidoc.conf
-	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b $(ASCIIDOC_HTML) $(ASCIIDOC_CONF) \
-		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) $*.txt
+	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
 
 XSLT = docbook.xsl
 XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
@@ -391,7 +391,7 @@ howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
-	$(QUIET_ASCIIDOC)$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b $(ASCIIDOC_HTML) $*.txt
+	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
 
 WEBDOC_DEST = /pub/software/scm/git/docs
 
@@ -399,7 +399,7 @@ howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	sed -e '1,/^$$/d' $< | \
-	$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b $(ASCIIDOC_HTML) - >$@+ && \
+	$(TXT_TO_HTML) - >$@+ && \
 	mv $@+ $@
 
 install-webdoc : html
-- 
2.1.1
