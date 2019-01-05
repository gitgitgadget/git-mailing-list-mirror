Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E9141F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 13:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfAENp1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 08:45:27 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:46853 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfAENp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 08:45:27 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 904312003ED;
        Sat,  5 Jan 2019 14:45:24 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH v2] Add optional targets for documentation l10n
Date:   Sat,  5 Jan 2019 14:44:38 +0100
Message-Id: <20190105134438.11271-1-jn.avila@free.fr>
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

The TMP_* dance was removed. The MAN{1,5,7} filtering was preserved, to keep the dispatching policy of manpages in a single place.


Documentation/Makefile | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b5be2e2d3f..c8450d6425 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -35,13 +35,18 @@ MAN7_TXT += gittutorial-2.txt
 MAN7_TXT += gittutorial.txt
 MAN7_TXT += gitworkflows.txt
 
+ifdef MAN_FILTER
+MAN_TXT = $(filter $(MAN_FILTER),$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
+else
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
+MAN_FILTER = $(MAN_TXT)
+endif
+
 MAN_XML = $(patsubst %.txt,%.xml,$(MAN_TXT))
 MAN_HTML = $(patsubst %.txt,%.html,$(MAN_TXT))
 
 OBSOLETE_HTML += everyday.html
 OBSOLETE_HTML += git-remote-helpers.html
-DOC_HTML = $(MAN_HTML) $(OBSOLETE_HTML)
 
 ARTICLES += howto-index
 ARTICLES += git-tools
@@ -81,11 +86,13 @@ TECH_DOCS += technical/trivial-merge
 SP_ARTICLES += $(TECH_DOCS)
 SP_ARTICLES += technical/api-index
 
-DOC_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
+SP_ARTICLES_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
+HTML_FILTER ?= $(SP_ARTICLES_HTML) $(OBSOLETE_HTML)
+DOC_HTML = $(MAN_HTML) $(filter $(HTML_FILTER),$(SP_ARTICLES_HTML) $(OBSOLETE_HTML))
 
-DOC_MAN1 = $(patsubst %.txt,%.1,$(MAN1_TXT))
-DOC_MAN5 = $(patsubst %.txt,%.5,$(MAN5_TXT))
-DOC_MAN7 = $(patsubst %.txt,%.7,$(MAN7_TXT))
+DOC_MAN1 = $(patsubst %.txt,%.1,$(filter $(MAN_FILTER), $(MAN1_TXT)))
+DOC_MAN5 = $(patsubst %.txt,%.5,$(filter $(MAN_FILTER), $(MAN5_TXT)))
+DOC_MAN7 = $(patsubst %.txt,%.7,$(filter $(MAN_FILTER), $(MAN7_TXT)))
 
 prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
@@ -444,4 +451,9 @@ print-man1:
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

