From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: Re: request for pre-generated git.info pages
Date: Fri, 31 Oct 2008 02:19:59 +0200
Message-ID: <871vxx8vkg.fsf@Astalo.kon.iki.fi>
References: <ee2a733e0810291500o67b3f94fibef63e0a173e8cc1@mail.gmail.com>
	<8763n98yz7.fsf@Astalo.kon.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 09:38:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvpWu-0003qU-G3
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 09:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbYJaIh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 04:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974AbYJaIh2
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 04:37:28 -0400
Received: from smtp1.dnainternet.fi ([87.94.96.108]:56309 "EHLO
	smtp1.dnainternet.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809AbYJaIh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 04:37:27 -0400
Received: from Astalo.kon.iki.fi (85-23-32-64-Rajakyla-TR1.suomi.net [85.23.32.64])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp1.dnainternet.fi (Postfix) with ESMTP id 254E2C92D
	for <git@vger.kernel.org>; Fri, 31 Oct 2008 10:26:43 +0200 (EET)
Received: from Kalle by Astalo.kon.iki.fi with local (Exim 4.52)
	id 1Kvhk7-0002Jf-HO; Fri, 31 Oct 2008 02:19:59 +0200
In-Reply-To: <8763n98yz7.fsf@Astalo.kon.iki.fi> (Kalle Olavi Niemitalo's
	message of "Fri, 31 Oct 2008 01:06:20 +0200")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99566>

Kalle Olavi Niemitalo <kon@iki.fi> writes:

> However, the Info browser does not recognize cross-references
> between them.  I am playing with some patches to fix those.

This seems to fix it, although the result isn't pretty.
Not signed off.

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 62269e3..56e1cf5 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -184,12 +184,12 @@ git.info: user-manual.texi
 
 user-manual.texi: user-manual.xml
 	$(RM) $@+ $@
-	$(DOCBOOK2X_TEXI) user-manual.xml --to-stdout | $(PERL_PATH) fix-texi.perl >$@+
+	$(DOCBOOK2X_TEXI) -s texi.xsl user-manual.xml --to-stdout | $(PERL_PATH) fix-texi.perl >$@+
 	mv $@+ $@
 
 gitman.texi: $(MAN_XML) cat-texi.perl
 	$(RM) $@+ $@
-	($(foreach xml,$(MAN_XML),$(DOCBOOK2X_TEXI) --to-stdout $(xml);)) | \
+	($(foreach xml,$(MAN_XML),$(DOCBOOK2X_TEXI) -s texi.xsl --to-stdout $(xml);)) | \
 	$(PERL_PATH) cat-texi.perl $@ >$@+
 	mv $@+ $@
 
diff --git a/Documentation/texi.xsl b/Documentation/texi.xsl
new file mode 100644
index 0000000..5c6f4cd
--- /dev/null
+++ b/Documentation/texi.xsl
@@ -0,0 +1,17 @@
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+                xmlns="http://docbook2x.sourceforge.net/xmlns/Texi-XML"
+                version="1.0">
+  <!-- docbook2x 0.8.3 recognizes sf.net but not sourceforge.net.  -->
+  <xsl:import href="http://docbook2x.sf.net/latest/xslt/texi/docbook.xsl"/>
+
+  <!-- In a man page, asciidoc.conf expands linkgit to citerefentry.
+       Each man page goes in gitman.texi so ref/@file is not needed.  -->
+  <xsl:template match="citerefentry[starts-with(refentrytitle, 'git')]">
+    <ref node="{refentrytitle}" />
+  </xsl:template>
+
+  <!-- In Git User's Manual, user-manual.conf expands linkgit to ulink.  -->
+  <xsl:template match="ulink[starts-with(@url, 'git') and substring(@url, string-length(@url) - 4) = '.html']">
+    <ref node="{substring(@url, 1, string-length(@url) - 5)}" file="gitman.info" />
+  </xsl:template>
+</xsl:stylesheet>
