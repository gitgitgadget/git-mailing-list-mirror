From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Force listingblocks to be monospaced in manpages
Date: Thu, 19 Jul 2007 13:37:43 +0200
Message-ID: <20070719113743.GA27553@diku.dk>
References: <m3k5sxiiib.fsf@pc7.dolda2000.com> <20070718213725.31383.50523.julian@quantumfyre.co.uk> <7vr6n55krx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707190157430.1964@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 19 13:38:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBUKT-0000wU-Lr
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 13:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764756AbXGSLhu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 07:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764648AbXGSLhu
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 07:37:50 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:39184 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764756AbXGSLhr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 07:37:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 8D628278051;
	Thu, 19 Jul 2007 13:37:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zLMsm2i2D3by; Thu, 19 Jul 2007 13:37:43 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id AA3BB27804B;
	Thu, 19 Jul 2007 13:37:43 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 3A2666DFB5B; Thu, 19 Jul 2007 13:34:26 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 8C34462BC4; Thu, 19 Jul 2007 13:37:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707190157430.1964@beast.quantumfyre.co.uk>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52972>

For the html output we can use a stylesheet to make sure that the
listingblocks are presented in a monospaced font.  For the manpages do
it manually by inserting a ".ft C" before and ".ft" after the block in
question.

In addition, also add an empty line after all verbatim blocks.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

  Julian Phillips <julian@quantumfyre.co.uk> wrote Thu, Jul 19, 2007:
  > On Wed, 18 Jul 2007, Junio C Hamano wrote:
  > 
  > >I tried with your patch, both with asciidoc7 and asciidoc8.  Did
  > >you really mean "&#x2302;" above?  Replacing them with "."  gave
  > >me a series of these changes (diff between output before and
  > >after your patch with the "s/\&#x2302;/./g" fixup):
  > 
  > I did mean it.  I originally just had .ft, but I was getting \&.ft in the 
  > manpage, which then just came out as .ft in the console.
  
  This is because AsciiDoc does the escaping. I think it would be cleaner
  to do this thing when converting from DocBook to roff like we already
  do for other things.

  While fixing the above, a fix for separating verbatim blocks from any
  following blocks is easy to apply.

diff --git a/Documentation/callouts.xsl b/Documentation/callouts.xsl
index 6a361a2..44ab77d 100644
--- a/Documentation/callouts.xsl
+++ b/Documentation/callouts.xsl
@@ -27,4 +27,93 @@
   </xsl:if>
 </xsl:template>
 
+<!-- * Yes, address, synopsis, and funcsynopsisinfo are verbatim environments. -->
+<xsl:template match="literallayout|programlisting|screen|
+                     address|synopsis|funcsynopsisinfo">
+  <xsl:param name="indent">
+    <!-- * Only indent this verbatim if $man.indent.verbatims is -->
+    <!-- * non-zero and it is not a child of a *synopsis element -->
+    <xsl:if test="not($man.indent.verbatims = 0) and
+                  not(substring(local-name(..),
+                  string-length(local-name(..))-7) = 'synopsis')">
+      <xsl:text>Yes</xsl:text>
+    </xsl:if>
+  </xsl:param>
+
+  <xsl:choose>
+    <!-- * Check to see if this verbatim item is within a parent element that -->
+    <!-- * allows mixed content. -->
+    <!-- * -->
+    <!-- * If it is within a mixed-content parent, then a line space is -->
+    <!-- * already added before it by the mixed-block template, so we don't -->
+    <!-- * need to add one here. -->
+    <!-- * -->
+    <!-- * If it is not within a mixed-content parent, then we need to add a -->
+    <!-- * line space before it. -->
+    <xsl:when test="parent::caption|parent::entry|parent::para|
+                    parent::td|parent::th" /> <!-- do nothing -->
+    <xsl:otherwise>
+      <xsl:text>&#10;</xsl:text>
+      <xsl:text>.sp&#10;</xsl:text>
+    </xsl:otherwise>
+  </xsl:choose>
+  <xsl:if test="$indent = 'Yes'">
+    <!-- * start indented section -->
+    <xsl:text>.RS</xsl:text>
+    <xsl:if test="not($man.indent.width = '')">
+      <xsl:text> </xsl:text>
+      <xsl:value-of select="$man.indent.width"/>
+    </xsl:if>
+    <xsl:text>&#10;</xsl:text>
+  </xsl:if>
+  <xsl:choose>
+    <xsl:when test="self::funcsynopsisinfo">
+      <!-- * All Funcsynopsisinfo content is by default rendered in bold, -->
+      <!-- * because the man(7) man page says this: -->
+      <!-- * -->
+      <!-- *   For functions, the arguments are always specified using -->
+      <!-- *   italics, even in the SYNOPSIS section, where the rest of -->
+      <!-- *   the function is specified in bold -->
+      <!-- * -->
+      <!-- * Look through the contents of the man/man2 and man3 directories -->
+      <!-- * on your system, and you'll see that most existing pages do follow -->
+      <!-- * this "bold everything in function synopsis" rule. -->
+      <!-- * -->
+      <!-- * Users who don't want the bold output can choose to adjust the -->
+      <!-- * man.font.funcsynopsisinfo parameter on their own. So even if you -->
+      <!-- * don't personally like the way it looks, please don't change the -->
+      <!-- * default to be non-bold - because it's a convention that's -->
+      <!-- * followed is the vast majority of existing man pages that document -->
+      <!-- * functions, and we need to follow it by default, like it or no. -->
+      <xsl:text>.ft </xsl:text>
+      <xsl:value-of select="$man.font.funcsynopsisinfo"/>
+      <xsl:text>&#10;</xsl:text>
+      <xsl:text>.nf&#10;</xsl:text>
+      <xsl:apply-templates/>
+      <xsl:text>&#10;</xsl:text>
+      <xsl:text>.fi&#10;</xsl:text>
+      <xsl:text>.ft&#10;</xsl:text>
+    </xsl:when>
+    <xsl:otherwise>
+      <!-- * Other verbatims do not need to get bolded -->
+      <xsl:text>.nf&#10;</xsl:text>
+      <xsl:text>.ft C&#10;</xsl:text>
+      <xsl:apply-templates/>
+      <xsl:text>&#10;</xsl:text>
+      <xsl:text>.ft&#10;</xsl:text>
+      <xsl:text>&#10;</xsl:text>
+      <xsl:text>&#10;.fi&#10;</xsl:text>
+    </xsl:otherwise>
+  </xsl:choose>
+  <xsl:if test="$indent = 'Yes'">
+    <!-- * end indented section -->
+    <xsl:text>.RE&#10;</xsl:text>
+  </xsl:if>
+  <!-- * if first following sibling node of this verbatim -->
+  <!-- * environment is a text node, output a line of space before it -->
+  <xsl:if test="following-sibling::node()[1][name(.) = '']">
+    <xsl:text>.sp&#10;</xsl:text>
+  </xsl:if>
+</xsl:template>
+
 </xsl:stylesheet>
-- 
Jonas Fonseca
