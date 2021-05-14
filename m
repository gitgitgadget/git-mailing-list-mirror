Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0276C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 00:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C81613BC
	for <git@archiver.kernel.org>; Fri, 14 May 2021 00:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhENAcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 20:32:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47194 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231687AbhENAcX (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 May 2021 20:32:23 -0400
Received: from camp.crustytoothpaste.net (unknown [138.237.15.37])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9348E60B17;
        Fri, 14 May 2021 00:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620952272;
        bh=I2edNYb1MKhaMYCayqACpYkiQ/TVOUiUXOO9Bp3GhrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=szCaSQGDmW3cDGLF6Vz7g/gT9GOWet8icgSfbvfz9qQzckDmS0Gvdnc//hvPKtUo3
         aOq4nYE0txbdWl2MwhzABCS05KJPg0r7hpGuXZtbspWBSFr9b0TZnk5xV4ZNag66dA
         tscUQDlkaROnFc5c8JZPrKpQN/ZRbmGdDJj0SRPKNv9EyRJTudemyjrO56aLlGz58j
         s3ZkEzjWydYOtBD0PCby/8ETW6xU4bQsiX05wRJKCFl4TMkedFwJhVHEwXBc1cN+A7
         FFCX9Ttb/l+f8yhKpVG5WETf4YsjINvoafIpTr8sG06lGzFy1mA6Chtti4cu17roRG
         pHyB0k9gYMOF3I56HhTUeYTrQaiuNu7MryvrXk6bi69w6QGrmWd2T0OEW50zfNSK30
         JfFqIivBifs2jEfsizUKJSP5u9/mp9uMG3OFlf/WkyhUSrSt3BbQ/kMiR0v2W1yb2g
         u3ZFoXxOfr6gSZBQTjAGQbkBSF8d8L7stQUSKk7gpoFA59j02f6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 1/2] doc: add an option to have Asciidoctor build man pages directly
Date:   Fri, 14 May 2021 00:31:03 +0000
Message-Id: <20210514003104.94644-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d
In-Reply-To: <20210514003104.94644-1-sandals@crustytoothpaste.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210514003104.94644-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
commands easier.  These newer versions of Asciidoctor (1.5.3 and above)
detect groff and do the right thing in all cases, so the GNU_ROFF option
is obsolete in this case.

We also need to update the code that tells Asciidoctor how to format our
linkgit macros so that it can output proper code for man pages.  Be
careful to reset the font to the previous after the change.  In order to
do so, we must reset to the previous after each font change so the
previous state at the end is the state before our inserted text, since
troff only remembers one previous font.  We insert \e before each
font-change backslash so Asciidoctor doesn't convert them into \*(rs,
the reverse solidus character, and instead leaves them as we wanted
them.

Additionally, we don't want to use XML-style escapes for the litdd and
plus macros, so let's only use the XML-style escapes in HTML and XML and
use something different for our man pages.

Because Asciidoctor versions before 2.0 had a few problems with man page
output, let's default this to off for now, since some common distros are
still on 1.5.  If users are using a more modern toolchain or don't care
about the rendering issues, they can enable the option.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/Makefile                  | 17 +++++++++++++++--
 Documentation/asciidoctor-extensions.rb |  2 ++
 Makefile                                |  4 ++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2aae4c9cbb..891181c0f3 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -192,10 +192,16 @@ ASCIIDOC_HTML = xhtml5
 ASCIIDOC_DOCBOOK = docbook5
 ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
-ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
+TXT_TO_HTML += -alitdd='&\#x2d;&\#x2d;'
+TXT_TO_XML  += -alitdd='&\#x2d;&\#x2d;'
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
+ifdef USE_ASCIIDOCTOR_MANPAGE
+TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
+TXT_TO_MAN += -aplus='+'
+TXT_TO_MAN += -alitdd='\--'
+endif
 endif
 
 SHELL_PATH ?= $(SHELL)
@@ -334,7 +340,7 @@ mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
 		show_tool_names can_merge "* " || :' >mergetools-merge.txt && \
 	date >$@
 
-TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK))
+TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK):$(USE_ASCIIDOCTOR_MANPAGE))
 
 GIT-ASCIIDOCFLAGS: FORCE
 	@FLAGS='$(TRACK_ASCIIDOCFLAGS)'; \
@@ -367,9 +373,16 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf asciidoctor-extensions.rb GIT-AS
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
index d906a00803..620b3d7a88 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -15,6 +15,8 @@ module Git
           "#{target}(#{attrs[1]})</ulink>"
         elsif parent.document.basebackend? 'html'
           %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
+        elsif parent.document.basebackend? 'manpage'
+          %(\e\\fB#{target}\e\\fP\e\\fR(#{attrs[1]})\e\\fP)
         elsif parent.document.basebackend? 'docbook'
           "<citerefentry>\n" \
             "<refentrytitle>#{target}</refentrytitle>" \
diff --git a/Makefile b/Makefile
index 93664d6714..e499152ba2 100644
--- a/Makefile
+++ b/Makefile
@@ -285,6 +285,10 @@ all::
 # Define USE_ASCIIDOCTOR to use Asciidoctor instead of AsciiDoc to build the
 # documentation.
 #
+# Define USE_ASCIIDOCTOR_MANPAGE to use Asciidoctor's manual page backend
+# instead of building manual pages from DocBook (using xmlto).  Has no effect
+# unless USE_ASCIIDOCTOR is set.
+#
 # Define ASCIIDOCTOR_EXTENSIONS_LAB to point to the location of the Asciidoctor
 # Extensions Lab if you have it available.
 #
