Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714991F89C
	for <e@80x24.org>; Sun, 22 Jan 2017 02:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751083AbdAVCmZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 21:42:25 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39236 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750943AbdAVCmK (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Jan 2017 21:42:10 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6A589280B1;
        Sun, 22 Jan 2017 02:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485052926;
        bh=EsrSQmtbPhyio8QoF5MFlxL7MU/lcw4OpIoak/9VpQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZaAi/UQvPQ8/rkDgkim+VdkSAMgvion5QLNHQYzbj5iUR0/BD7M1vr4qqA+feYPT
         vWzpzy9D4d2WNqwAM8Pz98+9md1QWPLHw1Te+3nTQYO5S2VELosIDHU/U2uuXXvwH3
         X4nLw8IbdrMAmc+hA+lLqY1Sd2m3nrViA4b1tgXgzJEBXV55WSe87P0/4oUMdpBSHz
         6TE9fSPVg0LJUKmzYKkWS+ql9/skPTJdTLfV0Yu7dQB3feYSn8maJdqLXCvlmUgYRy
         8mnI8nh2ixdn0eohnBeVLHJDoVLk6KHpy7PpD8LeglhAe34zr6CIzpwpb1ubdlBUSr
         UxnMn+w6Ukxflpb7wKVXXtMBgvaCPcQstSWXo3Kb8y7SfMa4Hp8/uut2qs3Cia/Zm1
         dfaQCijIMN0MI+pFNppkwVfUFCp8Q+ZLqGgj4eaIS5W0QxE7vFhgRY5K6jtGbXZiBB
         TF4xaWY3bwh2XAQZlbl0ObuPDi8jTGMw5eOacy85omI7MiCAETy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 5/7] Documentation: add XSLT to fix DocBook for Texinfo
Date:   Sun, 22 Jan 2017 02:41:54 +0000
Message-Id: <20170122024156.284180-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170122024156.284180-1-sandals@crustytoothpaste.net>
References: <20170122024156.284180-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two ways to create a section in a reference document (i.e.,
manpage) in DocBook 4: refsection elements and refsect, refsect2, and
refsect3 elements.  Either form is acceptable as of DocBook 4.2, but
they cannot be mixed.  Prior to DocBook 4.2, only the numbered forms
were acceptable.

docbook2texi only accepts the numbered forms, and this has not generally
been a problem, since AsciiDoc produces the numbered forms.
Asciidoctor, on the other hand, uses a shared backend for DocBook 4 and
5, and uses the unnumbered refsection elements instead.

If we don't convert the unnumbered form to the numbered form,
docbook2texi omits section headings, which is undesirable.  Add an XSLT
stylesheet to transform the unnumbered forms to the numbered forms
automatically, and preprocess the DocBook XML as part of the
transformation to Texinfo format.

Note that this transformation is only necessary for Texinfo, since
docbook2texi provides its own stylesheets.  The DocBook stylesheets,
which we use for other formats, provide the full range of DocBook 4 and
5 compatibility, and don't have this issue.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/Makefile |  7 ++++---
 Documentation/texi.xsl | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/texi.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6e6c82409..76be7017c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -371,10 +371,11 @@ user-manual.pdf: user-manual.xml
 	$(DBLATEX) -o $@+ -p $(ASCIIDOC_DBLATEX_DIR)/asciidoc-dblatex.xsl -s $(ASCIIDOC_DBLATEX_DIR)/asciidoc-dblatex.sty $< && \
 	mv $@+ $@
 
-gitman.texi: $(MAN_XML) cat-texi.perl
+gitman.texi: $(MAN_XML) cat-texi.perl texi.xsl
 	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
-	($(foreach xml,$(sort $(MAN_XML)),$(DOCBOOK2X_TEXI) --encoding=UTF-8 \
-		--to-stdout $(xml) &&) true) > $@++ && \
+	($(foreach xml,$(sort $(MAN_XML)),xsltproc -o $(xml)+ texi.xsl $(xml) && \
+		$(DOCBOOK2X_TEXI) --encoding=UTF-8 --to-stdout $(xml)+ && \
+		rm $(xml)+ &&) true) > $@++ && \
 	$(PERL_PATH) cat-texi.perl $@ <$@++ >$@+ && \
 	rm $@++ && \
 	mv $@+ $@
diff --git a/Documentation/texi.xsl b/Documentation/texi.xsl
new file mode 100644
index 000000000..0f8ff07ec
--- /dev/null
+++ b/Documentation/texi.xsl
@@ -0,0 +1,26 @@
+<!-- texi.xsl:
+     convert refsection elements into refsect elements that docbook2texi can
+     understand -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		version="1.0">
+
+<xsl:output method="xml"
+	    encoding="UTF-8"
+	    doctype-public="-//OASIS//DTD DocBook XML V4.5//EN"
+	    doctype-system="http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd" />
+
+<xsl:template match="//refsection">
+	<xsl:variable name="element">refsect<xsl:value-of select="count(ancestor-or-self::refsection)" /></xsl:variable>
+	<xsl:element name="{$element}">
+		<xsl:apply-templates select="@*|node()" />
+	</xsl:element>
+</xsl:template>
+
+<!-- Copy all other nodes through. -->
+<xsl:template match="node()|@*">
+	<xsl:copy>
+		<xsl:apply-templates select="@*|node()" />
+	</xsl:copy>
+</xsl:template>
+
+</xsl:stylesheet>
