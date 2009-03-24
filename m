From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH 8/8] Documentation: option to render literal text as bold for
 manpages
Date: Tue, 24 Mar 2009 03:04:26 -0500
Message-ID: <1237881866-5497-9-git-send-email-chris_johnsen@pobox.com>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Chris Johnsen <chris_johnsen@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 09:09:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1h2-00072O-39
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756772AbZCXIFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbZCXIFn
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:05:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbZCXIFl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:05:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7977EA4BE8;
	Tue, 24 Mar 2009 04:05:39 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 C65CEA4BE4; Tue, 24 Mar 2009 04:05:33 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.214.ge986c
In-Reply-To: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: 90448CFC-184A-11DE-8414-32B0EBB1AA3C-07245699!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114421>

This allows manpages viewed on a tty to render inline literal
text in a manner that is distinct from the surrounding text.

Testing done with asciidoc 8.3.1 and docbook-xsl 1.74.0.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---

Since dobcook-xsl 1.74.0 seems to introduce using a monospace
font for literal text (asciidoc backticks), this patch may not be
so important for end users that can install their own
docbook-xsl.

But this patch, or something like it, might be useful for
introducing some kind of typesetting for literal text in the
official manpages (since it would not require upgrading
docbook-xsl). It could probably even be changed/extended to
provide monospacing without using a new docbook-xsl.

The functionality is optional and defaults to "off", so there
probably is not too much harm in including it, even if it is not
used for the official manpages.
---
 Documentation/Makefile                 |    6 +++++-
 Documentation/manpage-bold-literal.xsl |   17 +++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/manpage-bold-literal.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 11b26aa..238ff83 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -42,6 +42,7 @@ man7dir=$(mandir)/man7
 ASCIIDOC=asciidoc
 ASCIIDOC_EXTRA =
 MANPAGE_XSL = manpage-normal.xsl
+XMLTO_EXTRA =
 INSTALL?=install
 RM ?= rm -f
 DOC_REF = origin/man
@@ -93,6 +94,9 @@ else
 	ASCIIDOC_EXTRA += -a git-asciidoc-no-roff
 	endif
 endif
+ifdef MAN_BOLD_LITERAL
+XMLTO_EXTRA += -m manpage-bold-literal.xsl
+endif
 
 #
 # Please note that there is a minor bug in asciidoc.
@@ -192,7 +196,7 @@ $(MAN_HTML): %.html : %.txt
 
 %.1 %.5 %.7 : %.xml
 	$(RM) $@
-	xmlto -m $(MANPAGE_XSL) -m manpage-base.xsl man $<
+	xmlto -m $(MANPAGE_XSL) $(XMLTO_EXTRA) -m manpage-base.xsl man $<
 
 %.xml : %.txt
 	$(RM) $@+ $@
diff --git a/Documentation/manpage-bold-literal.xsl b/Documentation/manpage-bold-literal.xsl
new file mode 100644
index 0000000..608eb5d
--- /dev/null
+++ b/Documentation/manpage-bold-literal.xsl
@@ -0,0 +1,17 @@
+<!-- manpage-bold-literal.xsl:
+     special formatting for manpages rendered from asciidoc+docbook -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		version="1.0">
+
+<!-- render literal text as bold (instead of plain or monospace);
+     this makes literal text easier to distinguish in manpages
+     viewed on a tty -->
+<xsl:template match="literal">
+	<xsl:value-of select="$git.docbook.backslash"/>
+	<xsl:text>fB</xsl:text>
+	<xsl:apply-templates/>
+	<xsl:value-of select="$git.docbook.backslash"/>
+	<xsl:text>fR</xsl:text>
+</xsl:template>
+
+</xsl:stylesheet>
-- 
1.6.2.1.214.ge986c
