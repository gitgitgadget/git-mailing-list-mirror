From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH v2 2/8] Documentation: use parametrized manpage-base.xsl with
 manpage-{1.72,normal}.xsl
Date: Fri, 27 Mar 2009 01:43:59 -0500
Message-ID: <1238136245-22853-3-git-send-email-chris_johnsen@pobox.com>
References: <1238136245-22853-1-git-send-email-chris_johnsen@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 07:48:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln5rB-0008Hu-W9
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 07:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbZC0GpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 02:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbZC0GpM
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 02:45:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45494 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbZC0GpK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 02:45:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 089E49354;
	Fri, 27 Mar 2009 02:45:09 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 30BD29352; Fri, 27 Mar 2009 02:45:03 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.401.gc048
In-Reply-To: <1238136245-22853-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: D055C070-1A9A-11DE-BCC4-C5D912508E2D-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114857>

Parametrize the backslash and dot characters that are used to
generate roff control sequences in manpage-base.xsl.

Testing done with asciidoc 8.3.1 and docbook-xsl 1.74.0.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---

Changes since "v1": In manpage-{normal,1.72}.xsl, use
  <xsl:import> to incorporate manpage-base.xsl. Take
  manpage-base.xsl off the xmlto commandline. Thanks, Peff!

  Implementation details in the commit message have been moved to
  the last patch.

---

Still no change in behavior. Just refactoring here.
---
 Documentation/manpage-1.72.xsl   |   29 ++++++++++++---------------
 Documentation/manpage-base.xsl   |   39 +++++++++++++++++++------------------
 Documentation/manpage-normal.xsl |   30 ++++++++++++----------------
 3 files changed, 46 insertions(+), 52 deletions(-)

diff --git a/Documentation/manpage-1.72.xsl b/Documentation/manpage-1.72.xsl
index 4065a3a..e24d26c 100644
--- a/Documentation/manpage-1.72.xsl
+++ b/Documentation/manpage-1.72.xsl
@@ -1,21 +1,18 @@
-<!-- Based on callouts.xsl. Fixes man page callouts for DocBook 1.72 XSL -->
-<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
+<!-- manpage-1.72.xsl:
+     special settings for manpages rendered from asciidoc+docbook
+     handles peculiarities in docbook-xsl 1.72.0 -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		version="1.0">
 
+<xsl:import href="manpage-base.xsl"/>
+
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
index 6a361a2..e36472f 100644
--- a/Documentation/manpage-normal.xsl
+++ b/Documentation/manpage-normal.xsl
@@ -1,21 +1,17 @@
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
+     handles anything we want to keep away from docbook-xsl 1.72.0 -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		version="1.0">
+
+<xsl:import href="manpage-base.xsl"/>
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
1.6.2.1.401.gc048
