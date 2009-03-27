From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH v2 8/8] Documentation: option to render literal text as bold
 for manpages
Date: Fri, 27 Mar 2009 01:44:05 -0500
Message-ID: <1238136245-22853-9-git-send-email-chris_johnsen@pobox.com>
References: <1238136245-22853-1-git-send-email-chris_johnsen@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 07:48:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln5rG-0008Hu-R3
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 07:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbZC0GqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 02:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbZC0GqC
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 02:46:02 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbZC0GqA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 02:46:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B3CD49373;
	Fri, 27 Mar 2009 02:45:58 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 D28A19372; Fri, 27 Mar 2009 02:45:53 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.401.gc048
In-Reply-To: <1238136245-22853-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: EDF57864-1A9A-11DE-ADB9-C5D912508E2D-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114861>

This allows manpages viewed on a tty to render inline literal
text in a manner that is distinct from the surrounding text.

The initial implementation (pre-mailing-list) of this patch
included a conditional variant of the XSLT code in
manpage-base.xsl and use xmlto's --stringparam option to
optionally enable the functionality. It turns out that
--stringparam is broken in all versions of xmlto except for the
pre-release, SVN version. Since xmlto is a shell script the patch
to fix it is simple enough, but I instead opted to use xmlto's
"module" functionality.

Testing done with asciidoc 8.3.1 and docbook-xsl 1.74.0.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---

Change since "v1": Move dicussion of --stringparam from patch 2
  to this patch. Deleted a bunch of it in the process. No content
  changes from the first version.

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
index d71760b..1c94531 100644
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
-	xmlto -m $(MANPAGE_XSL) man $<
+	xmlto -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
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
1.6.2.1.401.gc048
