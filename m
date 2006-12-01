X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: Garbled man pages (.sp instead of newline)
Date: Fri, 1 Dec 2006 20:01:59 +0100
Message-ID: <20061201190159.GA31028@diku.dk>
References: <87r6vjfqij.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 1 Dec 2006 19:02:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <87r6vjfqij.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32957>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqDeb-0003U3-Bd for gcvg-git@gmane.org; Fri, 01 Dec
 2006 20:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759360AbWLATCK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 14:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759359AbWLATCK
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 14:02:10 -0500
Received: from [130.225.96.91] ([130.225.96.91]:11493 "EHLO mgw1.diku.dk") by
 vger.kernel.org with ESMTP id S1759360AbWLATCG (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 14:02:06 -0500
Received: from localhost (localhost [127.0.0.1]) by mgw1.diku.dk (Postfix)
 with ESMTP id 7DADB77001C; Fri,  1 Dec 2006 20:02:02 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1]) by localhost (mgw1.diku.dk
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 18907-09; Fri,  1 Dec
 2006 20:01:59 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140]) by
 mgw1.diku.dk (Postfix) with ESMTP id D2A37770042; Fri,  1 Dec 2006 20:01:59
 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225]) by nhugin.diku.dk
 (Postfix) with ESMTP id 17F4F6DFD26; Fri,  1 Dec 2006 19:58:39 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873) id B63E162A44; Fri,  1
 Dec 2006 20:01:59 +0100 (CET)
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> wrote Fri, Dec 01, 2006:
> I can see a lot of things that I think I could improve in the
> documentation, but when I tried to build them, I'm getting broken man
> pages as a result. For example with "man git" I now see:
> 
>        Git is a fast, scalable, distributed revision control system with an unusually rich
>        command set that provides both high-level operations and full access to
>        internals..sp See this [1]tutorial to get started, then see [2]Everyday Git for a
>        useful minimum set of commands, and "man git-commandname" for documentation of each
>        command. CVS users may also want to read [3]CVS migration..sp The COMMAND is either
>        a name of a Git command (see below) or an alias as defined in the configuration
>        file (see git-repo-config(1))..sp
> 
> I appear to be using asciidoc 7.1.2. Does anyone here know what's
> causing the above and how to fix it?

The problem is that a newline is not inserted before the ".sp".  I (and
apparently a lot of other people on #git) thought it was just something
broken by the system. It appears that the DocBook XSL files got broken
between 1.69.0 and 1.69.1, but it appears to have been fixed upstream (I
didn't try it by from looking at the xsl/manpages/block.xsl file it
seems to insert a newline again before inserting a ".sp")

Git already has a custom XSL file to handle callouts so this might be
the right place to insert a workaround for this although I don't know if
it breaks systems that do not have this problem. The patch that I have
included is based on what I plan to add to tig. It would be great to
hear if it breaks manpages build on systems that do not have this ".sp"
problem.

I also have another small fix to insert an empty line after a code
block. Currently, the following paragraph will immediately follow the
code block which hurts readability a bit.

BTW, it might make sense to rename callouts.xsl to manpage.xsl if
something like this and the other fix I mentioned is acceptable.

diff --git a/Documentation/callouts.xsl b/Documentation/callouts.xsl
index ad03755..d016b3b 100644
--- a/Documentation/callouts.xsl
+++ b/Documentation/callouts.xsl
@@ -13,4 +13,44 @@
 	<xsl:apply-templates/>
 	<xsl:text>.br&#10;</xsl:text>
 </xsl:template>
+<xsl:template match="simpara">
+  <xsl:variable name="content">
+    <xsl:apply-templates/>
+  </xsl:variable>
+  <xsl:value-of select="normalize-space($content)"/>
+  <xsl:text>&#10;</xsl:text>
+  <xsl:text>.sp&#10;</xsl:text>
+</xsl:template>
+
+<xsl:template match="address|literallayout|programlisting|screen|synopsis">
+  <!-- * Yes, address and synopsis are verbatim environments. -->
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
+  <xsl:text>.nf&#10;</xsl:text>
+  <xsl:apply-templates/>
+  <xsl:text>&#10;</xsl:text>
+  <xsl:text>.fi&#10;</xsl:text>
+  <!-- * if first following sibling node of this verbatim -->
+  <!-- * environment is a text node, output a line of space before it -->
+  <xsl:if test="following-sibling::node()[1][name(.) = '']">
+    <xsl:text>&#10;</xsl:text>
+    <xsl:text>.sp&#10;</xsl:text>
+  </xsl:if>
+</xsl:template>
 </xsl:stylesheet>

-- 
