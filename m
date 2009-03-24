From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH 1/8] Documentation: move callouts.xsl to
 manpage-{base,normal}.xsl
Date: Tue, 24 Mar 2009 03:04:19 -0500
Message-ID: <1237881866-5497-2-git-send-email-chris_johnsen@pobox.com>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Chris Johnsen <chris_johnsen@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 09:06:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1eq-0006ZF-8z
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631AbZCXIFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756597AbZCXIFG
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:05:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63852 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756522AbZCXIFB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:05:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AB5A5A4BCC;
	Tue, 24 Mar 2009 04:04:59 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 62A20A4BC7; Tue, 24 Mar 2009 04:04:54 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.214.ge986c
In-Reply-To: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: 788BC9D6-184A-11DE-B776-32B0EBB1AA3C-07245699!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114413>

Each of manpage-base.xsl and manpage-normal.xsl gets a copy of
the contents of callouts.xsl and the original is removed. The
Makefile is adjusted to refer to manpage-normal.xsl instead of
callouts.xsl. manpage-base.xsl will be later made into a common
base for -normal and -1.72.

Testing done with asciidoc 8.3.1 and docbook-xsl 1.74.0.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---

This duplication is in preparation for refactoring. It should
make it easier to keep track of the source of the various XSL
constructs while reviewing.
---
 Documentation/Makefile           |    2 +-
 Documentation/callouts.xsl       |   30 ------------------------------
 Documentation/manpage-base.xsl   |   30 ++++++++++++++++++++++++++++++
 Documentation/manpage-normal.xsl |   30 ++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/callouts.xsl
 create mode 100644 Documentation/manpage-base.xsl
 create mode 100644 Documentation/manpage-normal.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 144ec32..e1562e3 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -41,7 +41,7 @@ man7dir=$(mandir)/man7
 
 ASCIIDOC=asciidoc
 ASCIIDOC_EXTRA =
-MANPAGE_XSL = callouts.xsl
+MANPAGE_XSL = manpage-normal.xsl
 INSTALL?=install
 RM ?= rm -f
 DOC_REF = origin/man
diff --git a/Documentation/callouts.xsl b/Documentation/callouts.xsl
deleted file mode 100644
index 6a361a2..0000000
--- a/Documentation/callouts.xsl
+++ /dev/null
@@ -1,30 +0,0 @@
-<!-- callout.xsl: converts asciidoc callouts to man page format -->
-<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
-<xsl:template match="co">
-	<xsl:value-of select="concat('\fB(',substring-after(@id,'-'),')\fR')"/>
-</xsl:template>
-<xsl:template match="calloutlist">
-	<xsl:text>.sp&#10;</xsl:text>
-	<xsl:apply-templates/>
-	<xsl:text>&#10;</xsl:text>
-</xsl:template>
-<xsl:template match="callout">
-	<xsl:value-of select="concat('\fB',substring-after(@arearefs,'-'),'. \fR')"/>
-	<xsl:apply-templates/>
-	<xsl:text>.br&#10;</xsl:text>
-</xsl:template>
-
-<!-- sorry, this is not about callouts, but attempts to work around
- spurious .sp at the tail of the line docbook stylesheets seem to add -->
-<xsl:template match="simpara">
-  <xsl:variable name="content">
-    <xsl:apply-templates/>
-  </xsl:variable>
-  <xsl:value-of select="normalize-space($content)"/>
-  <xsl:if test="not(ancestor::authorblurb) and
-                not(ancestor::personblurb)">
-    <xsl:text>&#10;&#10;</xsl:text>
-  </xsl:if>
-</xsl:template>
-
-</xsl:stylesheet>
diff --git a/Documentation/manpage-base.xsl b/Documentation/manpage-base.xsl
new file mode 100644
index 0000000..6a361a2
--- /dev/null
+++ b/Documentation/manpage-base.xsl
@@ -0,0 +1,30 @@
+<!-- callout.xsl: converts asciidoc callouts to man page format -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
+<xsl:template match="co">
+	<xsl:value-of select="concat('\fB(',substring-after(@id,'-'),')\fR')"/>
+</xsl:template>
+<xsl:template match="calloutlist">
+	<xsl:text>.sp&#10;</xsl:text>
+	<xsl:apply-templates/>
+	<xsl:text>&#10;</xsl:text>
+</xsl:template>
+<xsl:template match="callout">
+	<xsl:value-of select="concat('\fB',substring-after(@arearefs,'-'),'. \fR')"/>
+	<xsl:apply-templates/>
+	<xsl:text>.br&#10;</xsl:text>
+</xsl:template>
+
+<!-- sorry, this is not about callouts, but attempts to work around
+ spurious .sp at the tail of the line docbook stylesheets seem to add -->
+<xsl:template match="simpara">
+  <xsl:variable name="content">
+    <xsl:apply-templates/>
+  </xsl:variable>
+  <xsl:value-of select="normalize-space($content)"/>
+  <xsl:if test="not(ancestor::authorblurb) and
+                not(ancestor::personblurb)">
+    <xsl:text>&#10;&#10;</xsl:text>
+  </xsl:if>
+</xsl:template>
+
+</xsl:stylesheet>
diff --git a/Documentation/manpage-normal.xsl b/Documentation/manpage-normal.xsl
new file mode 100644
index 0000000..6a361a2
--- /dev/null
+++ b/Documentation/manpage-normal.xsl
@@ -0,0 +1,30 @@
+<!-- callout.xsl: converts asciidoc callouts to man page format -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
+<xsl:template match="co">
+	<xsl:value-of select="concat('\fB(',substring-after(@id,'-'),')\fR')"/>
+</xsl:template>
+<xsl:template match="calloutlist">
+	<xsl:text>.sp&#10;</xsl:text>
+	<xsl:apply-templates/>
+	<xsl:text>&#10;</xsl:text>
+</xsl:template>
+<xsl:template match="callout">
+	<xsl:value-of select="concat('\fB',substring-after(@arearefs,'-'),'. \fR')"/>
+	<xsl:apply-templates/>
+	<xsl:text>.br&#10;</xsl:text>
+</xsl:template>
+
+<!-- sorry, this is not about callouts, but attempts to work around
+ spurious .sp at the tail of the line docbook stylesheets seem to add -->
+<xsl:template match="simpara">
+  <xsl:variable name="content">
+    <xsl:apply-templates/>
+  </xsl:variable>
+  <xsl:value-of select="normalize-space($content)"/>
+  <xsl:if test="not(ancestor::authorblurb) and
+                not(ancestor::personblurb)">
+    <xsl:text>&#10;&#10;</xsl:text>
+  </xsl:if>
+</xsl:template>
+
+</xsl:stylesheet>
-- 
1.6.2.1.214.ge986c
