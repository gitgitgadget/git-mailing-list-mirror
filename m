From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] Quote ' as \(aq in manpages
Date: Wed, 21 Oct 2009 20:57:27 +0200
Message-ID: <7a3e6c8c5a11e14c19bc1a27608dcc78171c9feb.1256151199.git.trast@student.ethz.ch>
References: <alpine.DEB.2.00.0910211357160.5105@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Anders Kaseorg <andersk@mit.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	bill lam <cbill.lam@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 20:58:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0gOD-0006fv-O1
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 20:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbZJUS6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 14:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754663AbZJUS6T
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 14:58:19 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:37326 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753903AbZJUS6T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 14:58:19 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 20:58:22 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 20:58:01 +0200
X-Mailer: git-send-email 1.6.5.1.144.g316236
In-Reply-To: <alpine.DEB.2.00.0910211357160.5105@dr-wily.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130952>

The docbook/xmlto toolchain insists on quoting ' as \'.  This does
achieve the quoting goal, but modern 'man' implementations turn the
apostrophe into a unicode "proper" apostrophe (given the right
circumstances), breaking code examples in many of our manpages.

Quote them as \(aq instead, which is an "apostrophe quote" as per the
groff_char manpage.

Unfortunately, as Anders Kaseorg kindly pointed out, this is not
portable beyond groff, so we add an extra Makefile variable GNU_ROFF
which you need to enable to get the new quoting.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

[Reinstated the Cc list, which I accidentally dropped when sending the
first patch...]

Anders Kaseorg wrote:
> \(aq is not portable to non-GNU roff.  See
>   http://bugs.debian.org/507673#65
>   http://sourceforge.net/tracker/index.php?func=detail&aid=2412738&group_id=21935&atid=373747
> for a proposed portable solution.

Thanks for pointing that out.  Makes things a lot easier though.  I'm
really beginning to enjoy the whole doc toolchain.

I could not find a way to insert the proposed definitions into the
header by tweaking the xsls, so unless someone comes up with a way of
doing that, this is the best I can do.

To save you the effort of clicking the links, the header definitions
would be

.ie \n(.g .ds Aq \(aq
.el .ds Aq '

and you then have to change the template to quote to \(Aq instead.


 Documentation/Makefile               |    3 +++
 Documentation/manpage-quote-apos.xsl |   16 ++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/manpage-quote-apos.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 06b0c57..68876d0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -102,6 +102,9 @@ endif
 ifdef DOCBOOK_SUPPRESS_SP
 XMLTO_EXTRA += -m manpage-suppress-sp.xsl
 endif
+ifdef GNU_ROFF
+XMLTO_EXTRA += -m manpage-quote-apos.xsl
+endif
 
 SHELL_PATH ?= $(SHELL)
 # Shell quote;
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
-- 
1.6.5.1.144.g316236
