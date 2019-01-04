Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 249061F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 16:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfADQyg (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 11:54:36 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:59711 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbfADQyf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 11:54:35 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 2FEE7200342;
        Fri,  4 Jan 2019 17:54:32 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH 1/1] Add optional targets for documentation l10n
Date:   Fri,  4 Jan 2019 17:54:06 +0100
Message-Id: <20190104165406.22358-2-jn.avila@free.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104165406.22358-1-jn.avila@free.fr>
References: <20190104165406.22358-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jean-Noel Avila <jn.avila@free.fr>

The standard doc lists can be filtered to allow using the compilation
rules with translated manpages where all the pages of the original
version may not be present.

The install variable are reused in the secondary repo so that the
configured paths can be used for translated manpages too.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/Makefile | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b5be2e2d3f..1f61a1fe86 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -35,13 +35,18 @@ MAN7_TXT += gittutorial-2.txt
 MAN7_TXT += gittutorial.txt
 MAN7_TXT += gitworkflows.txt
 
-MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
+TMP_MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
+MAN_FILTER ?= $(TMP_MAN_TXT)
+MAN_TXT = $(filter $(TMP_MAN_TXT), $(MAN_FILTER))
+undefine TMP_MAN_TXT
+
 MAN_XML = $(patsubst %.txt,%.xml,$(MAN_TXT))
 MAN_HTML = $(patsubst %.txt,%.html,$(MAN_TXT))
 
 OBSOLETE_HTML += everyday.html
 OBSOLETE_HTML += git-remote-helpers.html
-DOC_HTML = $(MAN_HTML) $(OBSOLETE_HTML)
+
+TMP_DOC_HTML = $(MAN_HTML) $(OBSOLETE_HTML)
 
 ARTICLES += howto-index
 ARTICLES += git-tools
@@ -81,11 +86,14 @@ TECH_DOCS += technical/trivial-merge
 SP_ARTICLES += $(TECH_DOCS)
 SP_ARTICLES += technical/api-index
 
-DOC_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
+TMP_DOC_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
+HTML_FILTER ?= $(TMP_DOC_HTML)
+DOC_HTML = $(filter $(HTML_FILTER),$(TMP_DOC_HTML))
+undefine TMP_DOC_HTML
 
-DOC_MAN1 = $(patsubst %.txt,%.1,$(MAN1_TXT))
-DOC_MAN5 = $(patsubst %.txt,%.5,$(MAN5_TXT))
-DOC_MAN7 = $(patsubst %.txt,%.7,$(MAN7_TXT))
+DOC_MAN1 = $(patsubst %.txt,%.1,$(filter $(MAN_FILTER), $(MAN1_TXT)))
+DOC_MAN5 = $(patsubst %.txt,%.5,$(filter $(MAN_FILTER), $(MAN5_TXT)))
+DOC_MAN7 = $(patsubst %.txt,%.7,$(filter $(MAN_FILTER), $(MAN7_TXT)))
 
 prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
@@ -444,4 +452,9 @@ print-man1:
 lint-docs::
 	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl
 
+ifeq ($(wildcard po/Makefile),po/Makefile)
+doc-l10n install-l10n::
+	$(MAKE) -C po $@
+endif
+
 .PHONY: FORCE
-- 
2.20.1

