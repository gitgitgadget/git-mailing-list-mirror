From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH 2/8] Documentation: use parametrized manpage-base.xsl with
 manpage-{1.72,normal}.xsl
Date: Tue, 24 Mar 2009 03:04:20 -0500
Message-ID: <1237881866-5497-3-git-send-email-chris_johnsen@pobox.com>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Chris Johnsen <chris_johnsen@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 09:06:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1er-0006ZF-Pv
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756724AbZCXIFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756655AbZCXIFL
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:05:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756591AbZCXIFH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:05:07 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3CD54A4BCF;
	Tue, 24 Mar 2009 04:05:05 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 DDAE1A4BCD; Tue, 24 Mar 2009 04:04:59 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.214.ge986c
In-Reply-To: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: 7BDA27FE-184A-11DE-BE4E-32B0EBB1AA3C-07245699!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114414>

Parametrize the backslash and dot characters that are used to
generate roff control sequences in manpage-base.xsl.

The code reuse is achieved through the Makefile's invocation of
xmlto, where the -base and either -normal or -1.72 "modules" are
combined to render the manpages. xmlto's module system works by
constructing a temporary XSLT stylesheet that <xsl:import>s the
main docbook-xsl file and then <xsl:includes> all the modules
specified on the command line. Because of a technical detail of
XSLT (<http://www.w3.org/TR/xslt#top-level-variables>), we need
to be sure that each param is bound only once across all the
modules that will be used in a single xmlto invocation.

The initial implementation used an explicit <xsl:import> to
achieve a layering effect that allowed default param values and
override param values. That worked fine until one of the final
features of this series needed to supply override param values
via  the --stringparam option of xmlto. It turns out that
--stringparam is broken in all but the pre-release version of
xmlto. Since xmlto is a shell script the patch to fix it is
simple enough, but I instead opted to use xmlto's "module"
functionality to achieve the XSLT stylesheet reuse.

Testing done with asciidoc 8.3.1 and docbook-xsl 1.74.0.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---

Still no change in behavior. Just refactoring here.
---
 Documentation/Makefile           |    2 +-
 Documentation/manpage-1.72.xsl   |   28 +++++++++++---------------
 Documentation/manpage-base.xsl   |   39 +++++++++++++++++++------------------
 Documentation/manpage-normal.xsl |   29 +++++++++++----------------
 4 files changed, 45 insertions(+), 53 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e1562e3..1b5ff36 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -165,7 +165,7 @@ $(MAN_HTML): %.html : %.txt
 
 %.1 %.5 %.7 : %.xml
 	$(RM) $@
-	xmlto -m $(MANPAGE_XSL) man $<
+	xmlto -m $(MANPAGE_XSL) -m manpage-base.xsl man $<
 
 %.xml : %.txt
 	$(RM) $@+ $@
diff --git a/Documentation/manpage-1.72.xsl b/Documentation/manpage-1.72.xsl
index 4065a3a..06d4485 100644
--- a/Documentation/manpage-1.72.xsl
+++ b/Documentation/manpage-1.72.xsl
@@ -1,21 +1,17 @@
-<!-- Based on callouts.xsl. Fixes man page callouts for DocBook 1.72 XSL -->
-<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
+<!-- manpage-1.72.xsl:
+     special settings for manpages rendered from asciidoc+docbook
+     must be used with manpage-base.xsl
+     handles peculiarities in docbook-xsl 1.72.0 -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		version="1.0">
 
+<!-- these are the special values for the roff control characters
+     needed for docbook-xsl 1.72.0 -->
+<xsl:param name="git.docbook.backslash">&#x2593;</xsl:param>
+<xsl:param name="git.docbook.dot"      >&#x2302;</xsl:param>
+
+<!-- these params silence some output from xmlto -->
 <xsl:param name="man.output.quietly" select="1"/>
 <xsl:param name="refentry.meta.get.quietly" select="1"/>
 
-<xsl:template match="co">
-	<xsl:value-of select="concat('&#x2593;fB(',substring-after(@id,'-'),')&#x2593;fR')"/>
-</xsl:template>
-<xsl:template match="calloutlist">
-	<xsl:text>&#x2302;sp&#10;</xsl:text>
-	<xsl:apply-templates/>
-	<xsl:text>&#10;</xsl:text>
-</xsl:template>
-<xsl:template match="callout">
-	<xsl:value-of select="concat('&#x2593;fB',substring-after(@arearefs,'-'),'. &#x2593;fR')"/>
-	<xsl:apply-templates/>
-	<xsl:text>&#x2302;br&#10;</xsl:text>
-</xsl:template>
-
 </xsl:stylesheet>
diff --git a/Documentation/manpage-base.xsl b/Documentation/manpage-base.xsl
index 6a361a2..6d3eb19 100644
--- a/Documentation/manpage-base.xsl
+++ b/Documentation/manpage-base.xsl
@@ -1,30 +1,31 @@
-<!-- callout.xsl: converts asciidoc callouts to man page format -->
-<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
+<!-- manpage-base.xsl:
+     special formatting for manpages rendered from asciidoc+docbook -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		version="1.0">
+
+<!-- convert asciidoc callouts to man page format;
+     git.docbook.backslash and git.docbook.dot params
+     must be supplied by another XSL file or other means -->
 <xsl:template match="co">
-	<xsl:value-of select="concat('\fB(',substring-after(@id,'-'),')\fR')"/>
+	<xsl:value-of select="concat(
+			      $git.docbook.backslash,'fB(',
+			      substring-after(@id,'-'),')',
+			      $git.docbook.backslash,'fR')"/>
 </xsl:template>
 <xsl:template match="calloutlist">
-	<xsl:text>.sp&#10;</xsl:text>
+	<xsl:value-of select="$git.docbook.dot"/>
+	<xsl:text>sp&#10;</xsl:text>
 	<xsl:apply-templates/>
 	<xsl:text>&#10;</xsl:text>
 </xsl:template>
 <xsl:template match="callout">
-	<xsl:value-of select="concat('\fB',substring-after(@arearefs,'-'),'. \fR')"/>
+	<xsl:value-of select="concat(
+			      $git.docbook.backslash,'fB',
+			      substring-after(@arearefs,'-'),
+			      '. ',$git.docbook.backslash,'fR')"/>
 	<xsl:apply-templates/>
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
+	<xsl:value-of select="$git.docbook.dot"/>
+	<xsl:text>br&#10;</xsl:text>
 </xsl:template>
 
 </xsl:stylesheet>
diff --git a/Documentation/manpage-normal.xsl b/Documentation/manpage-normal.xsl
index 6a361a2..be0afc9 100644
--- a/Documentation/manpage-normal.xsl
+++ b/Documentation/manpage-normal.xsl
@@ -1,21 +1,16 @@
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
+<!-- manpage-normal.xsl:
+     special settings for manpages rendered from asciidoc+docbook
+     must be used with manpage-base.xsl
+     handles anything we want to keep away from docbook-xsl 1.72.0 -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		version="1.0">
+
+<!-- these are the normal values for the roff control characters -->
+<xsl:param name="git.docbook.backslash">\</xsl:param>
+<xsl:param name="git.docbook.dot"	>.</xsl:param>
 
-<!-- sorry, this is not about callouts, but attempts to work around
- spurious .sp at the tail of the line docbook stylesheets seem to add -->
+<!-- attempt to work around spurious .sp at the tail of the line
+     that docbook stylesheets seem to add -->
 <xsl:template match="simpara">
   <xsl:variable name="content">
     <xsl:apply-templates/>
-- 
1.6.2.1.214.ge986c
