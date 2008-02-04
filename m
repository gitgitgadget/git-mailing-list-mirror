From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: man pages are littered with .ft C and others
Date: Mon, 4 Feb 2008 23:01:20 +0100
Message-ID: <20080204220120.GA23798@diku.dk>
References: <alpine.DEB.1.00.0802021055180.21831@an.sumeria> <m34pcr6vnm.fsf@localhost.localdomain> <7vejbuxwpu.fsf@gitster.siamese.dyndns.org> <200802031139.48752.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Adam Flott <adam@npjh.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 23:25:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM9kM-0003eA-Iy
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 23:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbYBDWYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 17:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754786AbYBDWYa
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 17:24:30 -0500
Received: from mgw2.diku.dk ([130.225.96.92]:50740 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780AbYBDWY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 17:24:28 -0500
X-Greylist: delayed 1384 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Feb 2008 17:24:28 EST
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id E21DF19BB3B;
	Mon,  4 Feb 2008 23:01:23 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12003-18; Mon,  4 Feb 2008 23:01:21 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 2D85319BB53;
	Mon,  4 Feb 2008 23:01:21 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id F1F076DF894; Mon,  4 Feb 2008 22:59:54 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 11D145B8001; Mon,  4 Feb 2008 23:01:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200802031139.48752.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72582>

Jakub Narebski <jnareb@gmail.com> wrote Sun, Feb 03, 2008:
> Junio C Hamano wrote:
> > Jakub Narebski <jnareb@gmail.com> writes:
> >
> > [From] http://thread.gmane.org/gmane.comp.version-control.git/53457/focus=53458
> Julian Phillips:
> > Are you using docbook xsl 1.72?  There are known problems building the 
> > manpages with that version.  1.71 works, and 1.73 should work when it get 
> > released.

I was able to solve this problem with this patch, which adds a XSL file
used specifically for DOCBOOK_XSL_172=YesPlease and where dots and
backslashes are escaped properly so they won't be substituted to the
wrong thing further down the "DocBook XSL pipeline". Doing the escaping
in the existing callout.xsl breaks v1.70.1. Hopefully v1.73 will end
this part of the manpage nightmare.

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 7a32546..43781fb 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -45,6 +45,7 @@ man7dir=$(mandir)/man7
 
 ASCIIDOC=asciidoc
 ASCIIDOC_EXTRA =
+MANPAGE_XSL = callouts.xsl
 INSTALL?=install
 RM ?= rm -f
 DOC_REF = origin/man
@@ -65,6 +66,7 @@ ASCIIDOC_EXTRA += -a asciidoc7compatible
 endif
 ifdef DOCBOOK_XSL_172
 ASCIIDOC_EXTRA += -a docbook-xsl-172
+MANPAGE_XSL = manpage-1.72.xsl
 endif
 
 #
@@ -159,7 +161,7 @@ $(MAN_HTML): %.html : %.txt
 
 %.1 %.5 %.7 : %.xml
 	$(RM) $@
-	xmlto -m callouts.xsl man $<
+	xmlto -m $(MANPAGE_XSL) man $<
 
 %.xml : %.txt
 	$(RM) $@+ $@
diff --git a/Documentation/manpage-1.72.xsl b/Documentation/manpage-1.72.xsl
new file mode 100644
index 0000000..fe3cd72
--- /dev/null
+++ b/Documentation/manpage-1.72.xsl
@@ -0,0 +1,17 @@
+<!-- callout.xsl: converts asciidoc callouts to man page format -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
+<xsl:template match="co">
+	<xsl:value-of select="concat('&#x2593;fB(',substring-after(@id,'-'),')&#x2593;fR')"/>
+</xsl:template>
+<xsl:template match="calloutlist">
+	<xsl:text>&#x2302;sp&#10;</xsl:text>
+	<xsl:apply-templates/>
+	<xsl:text>&#10;</xsl:text>
+</xsl:template>
+<xsl:template match="callout">
+	<xsl:value-of select="concat('&#x2593;fB',substring-after(@arearefs,'-'),'. &#x2593;fR')"/>
+	<xsl:apply-templates/>
+	<xsl:text>&#x2302;br&#10;</xsl:text>
+</xsl:template>
+
+</xsl:stylesheet>

> Besids, I have different set of problems; only with literal blocks.
> So while DOCBOOK_XSL_172 is not set... let me check...
> 
> Hmmm...
> 
> Before
> $ man git-diff-tree
> 
>        Example:
> 
>        .ft C
>        :100644 100644 5be4a4...... 000000...... M file.c
>        .ft
> 
> $ make DOCBOOK_XSL_172=YesPlease doc
> $ man Documentation/git-diff-tree.1
> 
>        Example:
> 
>               :100644 100644 5be4a4...... 000000...... M file.cWhen -z  option  is
>               not  used, TAB, LF, and backslash characters in pathnames are repre-
>               sented as \t, \n, and \\, respectively.
> 
> So setting DOCBOOK_XSL_172 while it fixes the bug (even if docbook-xsl
> is version 1.68.1, not 1.72), but introduces another.
> 
> Unfortunately I don't know enough about AsciiDoc, DocBook and XML
> toolchain to even *try* to fix this issue.

I have no idea what this could be. The literallayout block is
overwritten in Documentation/asciidoc.conf unless when DOCBOOK_XSL_172
is set. Newer AsciiDoc installations seem to use a different set of
DocBook tags than what is overwritten by git's asciidoc.conf.

-- 
Jonas Fonseca
