Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A88120209
	for <e@80x24.org>; Wed, 28 Jun 2017 02:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbdF1C4R (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 22:56:17 -0400
Received: from mail.wilcox-tech.com ([45.32.83.9]:56246 "EHLO
        mail.wilcox-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbdF1C4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 22:56:16 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Jun 2017 22:56:16 EDT
Received: (qmail 12343 invoked from network); 28 Jun 2017 02:49:31 -0000
Received: from ip68-13-242-69.ok.ok.cox.net (HELO localhost.localdomain) (awilcox@wilcox-tech.com@68.13.242.69)
  by mail.wilcox-tech.com with ESMTPA; 28 Jun 2017 02:49:31 -0000
From:   "A. Wilcox" <AWilcox@Wilcox-Tech.com>
To:     git@vger.kernel.org
Cc:     apenwarr@gmail.com, "A. Wilcox" <AWilcox@Wilcox-Tech.com>
Subject: [PATCH] subtree: Obey USE_ASCIIDOCTOR when present
Date:   Tue, 27 Jun 2017 21:49:16 -0500
Message-Id: <20170628024916.32235-1-AWilcox@Wilcox-Tech.com>
X-Mailer: git-send-email 2.10.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Defining USE_ASCIIDOCTOR=1 when building Git uses asciidoctor over
asciidoc when generating DocBook and man page documentation.  However,
the contrib/subtree module does not presently honour that flag.

This causes a build failure when asciidoc is not present on the build
system.  Instead, adapt the main Documentation/Makefile logic to use
asciidoctor when requested.

Signed-off-by: A. Wilcox <AWilcox@Wilcox-Tech.com>
---
 contrib/subtree/Makefile | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 6afa9aa..1b8fcd1 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -19,15 +19,27 @@ htmldir ?= $(prefix)/share/doc/git-doc
 INSTALL  ?= install
 RM       ?= rm -f
 
-ASCIIDOC = asciidoc
-XMLTO    = xmlto
+ASCIIDOC         = asciidoc
+ASCIIDOC_CONF    = -f ../../Documentation/asciidoc.conf
+ASCIIDOC_HTML    = xhtml11
+ASCIIDOC_DOCBOOK = docbook
+ASCIIDOC_EXTRA   = 
+XMLTO            = xmlto
+
+ifdef USE_ASCIIDOCTOR
+ASCIIDOC         = asciidoctor
+ASCIIDOC_CONF    =
+ASCIIDOC_HTML    = xhtml5
+ASCIIDOC_DOCBOOK = docbook45
+ASCIIDOC_EXTRA  += -I../../Documentation -rasciidoctor-extensions
+ASCIIDOC_EXTRA  += -alitdd='&\#x2d;&\#x2d;'
+endif
 
 ifndef SHELL_PATH
 	SHELL_PATH = /bin/sh
 endif
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 
-ASCIIDOC_CONF = ../../Documentation/asciidoc.conf
 MANPAGE_XSL   = ../../Documentation/manpage-normal.xsl
 
 GIT_SUBTREE_SH := git-subtree.sh
@@ -65,12 +77,12 @@ $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
 	$(XMLTO) -m $(MANPAGE_XSL) man $^
 
 $(GIT_SUBTREE_XML): $(GIT_SUBTREE_TXT)
-	$(ASCIIDOC) -b docbook -d manpage -f $(ASCIIDOC_CONF) \
-		-agit_version=$(GIT_VERSION) $^
+	$(ASCIIDOC) -b $(ASCIIDOC_DOCBOOK) -d manpage $(ASCIIDOC_CONF) \
+		-agit_version=$(GIT_VERSION) $(ASCIIDOC_EXTRA) $^
 
 $(GIT_SUBTREE_HTML): $(GIT_SUBTREE_TXT)
-	$(ASCIIDOC) -b xhtml11 -d manpage -f $(ASCIIDOC_CONF) \
-		-agit_version=$(GIT_VERSION) $^
+	$(ASCIIDOC) -b $(ASCIIDOC_HTML) -d manpage $(ASCIIDOC_CONF) \
+		-agit_version=$(GIT_VERSION) $(ASCIIDOC_EXTRA) $^
 
 $(GIT_SUBTREE_TEST): $(GIT_SUBTREE)
 	cp $< $@
-- 
2.10.0

