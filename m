Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6879FC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C23601FA
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhELCM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 22:12:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52452 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhELCM5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 May 2021 22:12:57 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2BAF860749;
        Wed, 12 May 2021 02:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620785509;
        bh=LAb8ZQwfRofJhBwd0dRvblHHbInNnw8A6cUSFSOwRVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=F0lFWvwxfhpNFeV4cGr0mg8TJueCLkhGldBcfrw4j3A7l2mSBifyUqbHmBbUwt0r9
         /zYQze2WDRMbIBtIL3lpPjWhzLxPNueZuIujtibPWoanZvBWQgbOqVkcz+6MsoroNn
         L8JesipdCIfnQMRRgWZFL9cF/+hOhTAzzj/lpFaxhDqNwdiBR8emyLzS26D+SVtNlM
         cQS+sPrDvCv8cD5ahs2OB2q8SS/l31pHFF9mVbWuNZkKgpKFM1bP2wC5Cf2pN//1m9
         eto5pu/4FLfatz8Kh7SYvg7gHxxvEOrbNDuKXkXqbRi/J6qzGPkrZmoqkIIS6t0G79
         xQp53lidBjqRzgwmsDJ7uIjUE+wMdeLoUx2vJMejwyGtrSi12dAWZaZJkV2ruI/8Tw
         IzyyER/mP762woXQbS5CkICCFo89cv7tPIUvDkAxaWY439NPBS+WsmQHbYpF5vXDGu
         oEemmQtBki/35P3Tpn7RUm9n5BNDK7qZ5BYWO9FiilnK7we13ZL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 1/2] doc: add an option to have Asciidoctor build man pages directly
Date:   Wed, 12 May 2021 02:11:37 +0000
Message-Id: <20210512021138.63598-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d
In-Reply-To: <609b2828309fc_678ff2082@natae.notmuch>
References: <609b2828309fc_678ff2082@natae.notmuch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Felipe Contreras <felipe.contreras@gmail.com>

Asciidoctor contains a converter to generate man pages.  In some
environments, where building only the manual pages and not the other
documentation is desired, installing a toolchain for building
DocBook-based manual pages may be burdensome, and using Asciidoctor
directly may be easier, so let's add an option to build manual pages
using Asciidoctor without the DocBook toolchain.

We generally require Asciidoctor 1.5, but versions before 1.5.3 didn't
contain proper handling of the apostrophe, which is controlled normally
by the GNU_ROFF option.  This option for the DocBook toolchain, as well
as newer versions of Asciidoctor, makes groff output an ASCII apostrophe
instead of a Unicode apostrophe in text, so as to make copy and pasting
commands easier.  These newer versions of Asciidoctor detect groff and
do the right thing in all cases, so the GNU_ROFF option is obsolete in
this case.

We also need to update the code that tells Asciidoctor how to format our
linkgit macros so that it can output proper code for man pages.  Be
careful to reset the font to the previous after the change.  In order to
do so, we must reset to the previous after each font change so the
previous state at the end is the state before our inserted text, since
troff only remembers one previous font.

Because Asciidoctor versions before 2.0 had a few problems with man page
output, let's default this to off for now, since some common distros are
still on 1.5.  If users are using a more modern toolchain or don't care
about the rendering issues, they can enable the option.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I've preserved Felipe's authorship on this patch because much of it is
his work.  However, I have made some substantial changes here with which
I suspect he will disagree, in addition to expanding on the commit
message, so if he would prefer, I can reroll with the authorship
changed.  I have no preference myself.

 Documentation/Makefile                  | 10 ++++++++++
 Documentation/asciidoctor-extensions.rb |  2 ++
 Makefile                                |  3 +++
 3 files changed, 15 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2aae4c9cbb..536d9a5f3d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -196,6 +196,9 @@ ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
+ifdef USE_ASCIIDOCTOR_MANPAGE
+TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
+endif
 endif
 
 SHELL_PATH ?= $(SHELL)
@@ -367,9 +370,16 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf asciidoctor-extensions.rb GIT-AS
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
+ifdef TXT_TO_MAN
+%.1 %.5 %.7 : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
+	$(TXT_TO_MAN) -o $@+ $< && \
+	mv $@+ $@
+else
 %.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+endif
 
 %.xml : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index d906a00803..40fa87b121 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -15,6 +15,8 @@ module Git
           "#{target}(#{attrs[1]})</ulink>"
         elsif parent.document.basebackend? 'html'
           %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
+        elsif parent.document.basebackend? 'manpage'
+          %(\\fB#{target}\\fP\\fR(#{attrs[1]})\\fP)
         elsif parent.document.basebackend? 'docbook'
           "<citerefentry>\n" \
             "<refentrytitle>#{target}</refentrytitle>" \
diff --git a/Makefile b/Makefile
index 93664d6714..cb75dec314 100644
--- a/Makefile
+++ b/Makefile
@@ -285,6 +285,9 @@ all::
 # Define USE_ASCIIDOCTOR to use Asciidoctor instead of AsciiDoc to build the
 # documentation.
 #
+# Define USE_ASCIIDOCTOR_MANPAGE to use Asciidoctor's manual page backend
+# instead of building manual pages from DocBook.
+#
 # Define ASCIIDOCTOR_EXTENSIONS_LAB to point to the location of the Asciidoctor
 # Extensions Lab if you have it available.
 #
