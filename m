From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3] Quote ' as \(aq in manpages
Date: Thu, 22 Oct 2009 10:19:06 +0200
Message-ID: <232607a038ef84087b7c8c69e9038ec6c9f6ba01.1256199311.git.trast@student.ethz.ch>
References: <alpine.DEB.2.00.0910211824220.5105@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Anders Kaseorg <andersk@mit.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	bill lam <cbill.lam@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 22 10:19:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0stl-0002Lb-MP
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 10:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682AbZJVITk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 04:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753456AbZJVITj
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 04:19:39 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:56125 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175AbZJVITi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 04:19:38 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 22 Oct
 2009 10:19:41 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 22 Oct
 2009 10:19:40 +0200
X-Mailer: git-send-email 1.6.5.1.144.g316236
In-Reply-To: <alpine.DEB.2.00.0910211824220.5105@dr-wily.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131005>

The docbook/xmlto toolchain insists on quoting ' as \'.  This does
achieve the quoting goal, but modern 'man' implementations turn the
apostrophe into a unicode "proper" apostrophe (given the right
circumstances), breaking code examples in many of our manpages.

Quote them as \(aq instead, which is an "apostrophe quote" as per the
groff_char manpage.

Unfortunately, as Anders Kaseorg kindly pointed out, this is not
portable beyond groff, so we add an extra Makefile variable GNU_ROFF
which you need to enable to get the new quoting.

Thanks also to Miklos Vajna for documentation.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Anders Kaseorg wrote:
> On Wed, 21 Oct 2009, Junio C Hamano wrote:
> > > +# Define GNU_ROFF if you have GNU roff and you don't want to have pretty
> > > +# apostrophe so that cut&pasting examples to the shell will work.
> > 
> > This makes it sound as if groff is the only roff implementation that has 
> > this problem---iow, if we use non-GNU roff then the documentation comes 
> > out just fine.  Is that the case?
> 
> Yes:

I'll take your word for it, but I cannot test with anything non-GNU.

> In order to build a manpage that can be viewed correctly on both 
> platforms, the conditional logic should live in the manpage itself (as per 
> the bug comments I linked to and Thomas quoted from).

I reworded Miklos' doc patch a bit to indicate that it's about the
target system, and also added a slightly longer comment to the
Documentation/Makefile for completeness.


 Documentation/Makefile               |    8 ++++++++
 Documentation/manpage-quote-apos.xsl |   16 ++++++++++++++++
 Makefile                             |    4 ++++
 3 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/manpage-quote-apos.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 06b0c57..cd5b439 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -103,6 +103,14 @@ ifdef DOCBOOK_SUPPRESS_SP
 XMLTO_EXTRA += -m manpage-suppress-sp.xsl
 endif
 
+# If your target system uses GNU groff, it may try to render
+# apostrophes as a "pretty" apostrophe using unicode.  This breaks
+# cut&paste, so you should set GNU_ROFF to force them to be ASCII
+# apostrophes.  Unfortunately does not work with non-GNU roff.
+ifdef GNU_ROFF
+XMLTO_EXTRA += -m manpage-quote-apos.xsl
+endif
+
 SHELL_PATH ?= $(SHELL)
 # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
diff --git a/Documentation/manpage-quote-apos.xsl b/Documentation/manpage-quote-apos.xsl
new file mode 100644
index 0000000..aeb8839
--- /dev/null
+++ b/Documentation/manpage-quote-apos.xsl
@@ -0,0 +1,16 @@
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		version="1.0">
+
+<!-- work around newer groff/man setups using a prettier apostrophe
+     that unfortunately does not quote anything when cut&pasting
+     examples to the shell -->
+<xsl:template name="escape.apostrophe">
+  <xsl:param name="content"/>
+  <xsl:call-template name="string.subst">
+    <xsl:with-param name="string" select="$content"/>
+    <xsl:with-param name="target">'</xsl:with-param>
+    <xsl:with-param name="replacement">\(aq</xsl:with-param>
+  </xsl:call-template>
+</xsl:template>
+
+</xsl:stylesheet>
diff --git a/Makefile b/Makefile
index fea237b..2ccbe4a 100644
--- a/Makefile
+++ b/Makefile
@@ -159,6 +159,10 @@ all::
 # Define ASCIIDOC_NO_ROFF if your DocBook XSL escapes raw roff directives
 # (versions 1.72 and later and 1.68.1 and earlier).
 #
+# Define GNU_ROFF if your target system uses GNU groff.  This forces
+# apostrophes to be ASCII so that cut&pasting examples to the shell
+# will work.
+#
 # Define NO_PERL_MAKEMAKER if you cannot use Makefiles generated by perl's
 # MakeMaker (e.g. using ActiveState under Cygwin).
 #
-- 
1.6.5.1.144.g316236
