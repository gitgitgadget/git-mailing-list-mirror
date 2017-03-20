Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60AFB2090A
	for <e@80x24.org>; Mon, 20 Mar 2017 21:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755172AbdCTVEB (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 17:04:01 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:15068 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754024AbdCTVD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 17:03:59 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 1C3712003F0;
        Mon, 20 Mar 2017 22:02:42 +0100 (CET)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH v3 1/2] l10n: Introduce framework for localizing man pages
Date:   Mon, 20 Mar 2017 22:02:24 +0100
Message-Id: <20170320210225.13046-2-jn.avila@free.fr>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170320210225.13046-1-jn.avila@free.fr>
References: <20170312200248.3610-1-jn.avila@free.fr>
 <20170320210225.13046-1-jn.avila@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Providing git in localized version is a good step for general adoption
of the tool. But as of now, if one needs to refer to the manual pages,
they are still confronted to english. The aim is to provide
documentation to users in their own language.

The translation of the source asciidoc files is managed via po4a
driven by the conf file Documentation/po4a.conf.

Only the manpages are generated and installed by using the
`install-man-l10n` target of the Makefile. The localized manpages for
all the translated languages are installed in the man path in their
own language folder, so that they can be accessed by man.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 Documentation/Makefile  | 21 ++++++++++++++++++++-
 Documentation/po4a.conf |  5 +++++
 2 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/po4a.conf

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b5be2e2d3..e721c7149 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,4 +1,5 @@
 # Guard against environment variables
+MAN1_L10N_TXT =
 MAN1_TXT =
 MAN5_TXT =
 MAN7_TXT =
@@ -10,6 +11,7 @@ OBSOLETE_HTML =
 MAN1_TXT += $(filter-out \
 		$(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt))
+MAN1_L10N_TXT += $(wildcard po/*/man1/git-*.txt)
 MAN1_TXT += git.txt
 MAN1_TXT += gitk.txt
 MAN1_TXT += gitremote-helpers.txt
@@ -86,6 +88,7 @@ DOC_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
 DOC_MAN1 = $(patsubst %.txt,%.1,$(MAN1_TXT))
 DOC_MAN5 = $(patsubst %.txt,%.5,$(MAN5_TXT))
 DOC_MAN7 = $(patsubst %.txt,%.7,$(MAN7_TXT))
+DOC_MAN1_L10N = $(patsubst %.txt,%.1,$(MAN1_L10N_TXT))
 
 prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
@@ -209,6 +212,7 @@ endif
 
 ifneq ($(findstring $(MAKEFLAGS),s),s)
 ifndef V
+	QUIET_PO4A      = @echo '   ' PO4A $@;
 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
 	QUIET_XMLTO	= @echo '   ' XMLTO $@;
 	QUIET_DB2TEXI	= @echo '   ' DB2TEXI $@;
@@ -234,6 +238,15 @@ man1: $(DOC_MAN1)
 man5: $(DOC_MAN5)
 man7: $(DOC_MAN7)
 
+man_l10n: po4a man1_p_l10n
+po4a: po4a.conf
+	$(QUIET_PO4A)po4a po4a.conf
+
+man1_p_l10n: po4a
+	$(MAKE) man1_l10n
+
+man1_l10n: $(DOC_MAN1_L10N)
+
 info: git.info gitman.info
 
 pdf: user-manual.pdf
@@ -247,6 +260,11 @@ install-man: man
 	$(INSTALL) -m 644 $(DOC_MAN1) $(DESTDIR)$(man1dir)
 	$(INSTALL) -m 644 $(DOC_MAN5) $(DESTDIR)$(man5dir)
 	$(INSTALL) -m 644 $(DOC_MAN7) $(DESTDIR)$(man7dir)
+	$(MAKE) install-man-l10n
+
+install-man-l10n: $(DOC_MAN1_L10N)
+	$(INSTALL) -d -m 755 $(DESTDIR)$(mandir)/$(firstword $(subst /man1/, ,$(subst po/,,$<)))/man1
+	$(INSTALL) -m 644 $< $(DESTDIR)$(mandir)$(subst po,,$<)
 
 install-info: info
 	$(INSTALL) -d -m 755 $(DESTDIR)$(infodir)
@@ -323,6 +341,7 @@ clean:
 	$(RM) technical/*.html technical/api-index.txt
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) manpage-base-url.xsl
+	$(RM) po/*/*.1 po/*/*.txt
 
 $(MAN_HTML): %.html : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
@@ -339,7 +358,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 
 %.1 %.5 %.7 : %.xml manpage-base-url.xsl
 	$(QUIET_XMLTO)$(RM) $@ && \
-	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) -o $(dir $<) man $<
 
 %.xml : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
diff --git a/Documentation/po4a.conf b/Documentation/po4a.conf
new file mode 100644
index 000000000..b6ee8b4a6
--- /dev/null
+++ b/Documentation/po4a.conf
@@ -0,0 +1,5 @@
+[po4a_langs] fr
+[po4a_paths] po/documentation.pot $lang:po/documentation.$lang.po
+[options] opt: " -k 80"
+
+[type: asciidoc] ./git-add.txt $lang:./po/$lang/man1/git-add.txt
-- 
2.12.0

