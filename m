From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH] Documentation: use "spurious .sp" XSLT if
 DOCBOOK_SUPPRESS_SP is set
Date: Wed,  1 Apr 2009 03:50:34 -0500
Message-ID: <1238575834-17838-1-git-send-email-chris_johnsen@pobox.com>
References: <7vljql4586.fsf@gitster.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org, Chris Johnsen <chris_johnsen@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 10:53:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LowBQ-0003I4-1g
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 10:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760055AbZDAIu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 04:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755472AbZDAIuz
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 04:50:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155AbZDAIuy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 04:50:54 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EE78AB180;
	Wed,  1 Apr 2009 04:50:51 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 03DD8B17F; Wed,  1 Apr 2009 04:50:46 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.556.g581a3
In-Reply-To: <7vljql4586.fsf@gitster.siamese.dyndns.org>
X-Pobox-Relay-ID: 3457E4A6-1E9A-11DE-9A94-C5D912508E2D-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115358>

With this change, the "spurious .sp" suppression XSLT code is
disabled by default. It can be enabled by defining
DOCBOOK_SUPPRESS_SP.

The "spurious .sp" XSLT fragment was used to work around a bug
first released in docbook-xsl 1.69.1. Modern versions of
docbook-xsl are negatively affected by the code (some empty lines
are omitted from manpage output; see
<http://article.gmane.org/gmane.comp.version-control.git/115302>).

The key revisions in the docbook SVN repo seem to be 5144 (before
docbook-xsl 1.69.1) and 6359 (before docbook-xsl 1.71.1).

Testing done with asciidoc 8.3.1 and docbook-xsl 1.74.0.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---

Here is a proof-of-concept. It is on top of next (it requires the
previous XSLT/asciidoc cleanup).

I went with a "feature knob" instead of a "version knob" since my
research in the docbook SVN repo indicates that multiple versions
are affected. Maybe the name could be better. Also I am not at
all sure that my research into past docbook-xsl releases is 100%
accurate. Anyone motivated enough to install old versions of
docbook-xsl and test with them?

The message that Peff cites
(<http://article.gmane.org/gmane.comp.version-control.git/32957>)
seems to indicate that the "spurious .sp" problem was injected
_between_ 1.69.0 and 1.69.1. So, I did some research in the
docbook SVN repo.

I grepped for ".sp" and "simpara" in
<http://docbook.svn.sourceforge.net/viewvc/docbook/trunk/xsl/manpages/block.xsl?view=log>
to find likely interesting spots (sure, not thorough, but I hoped
to get lucky). Then I slogged through the "tags" directory to
find out when in the revision stream docbook-xsl releases seemed
to have been cut.

Here are some of the "interesting" revision numbers:

5119  1.69.0
5144          .sp instead of blank line in mixed blocks
5152  1.69.1
5755          newline before .sp in verbatims (not simpara)
5985  1.70.0
6003  1.70.1
6166          suppress .sp inside {author,person}blurb
6279  1.71.0
6359          newline before .sp in simpara
6373  1.71.1
6552  1.72.0
...
7398  1.73.2
      no tags for 1.74.*?
7782          move .sp to before, not after simpara text
7844          suppress .sp inside callout
?     1.74.0  {relnotes include descriptions of 7782 and 7844}

Before I got tired of digging through the SVN history, it seemed
to me that the problematic ".sp" was introduced at 5144 and
resolved at 6359. The code in Git's XSLT is very similar to that
of revision 6359, lines 81-91 (with a double newline instead of a
properly positioned ".sp" command).

So, it seems that the "spurious .sp" problem that Git's simpara
template "fixes" is not present in docbook-xsl 1.69.0, but is
present in 1.69.1, 1.70.0, 1.70.1, and 1.71.0. The "spurious .sp"
might not be present in 1.69.0 and earlier, but I would guess
that there are still line spacing issues there.

Should more of this background info be in the commit message?
Less?
---
 Documentation/Makefile                |    7 ++++++-
 Documentation/manpage-base.xsl        |   13 -------------
 Documentation/manpage-suppress-sp.xsl |   21 +++++++++++++++++++++
 3 files changed, 27 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/manpage-suppress-sp.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index dae3174..dba97dc 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -69,7 +69,9 @@ endif
 #
 # For docbook-xsl ...
 #	-1.68.1,	set ASCIIDOC_NO_ROFF? (based on changelog from 1.73.0)
-#	1.69.0-1.71.1,	no extra settings are needed?
+#	1.69.0,		no extra settings are needed?
+#	1.69.1-1.71.0,	set DOCBOOK_SUPPRESS_SP?
+#	1.71.1,		no extra settings are needed?
 #	1.72.0,		set DOCBOOK_XSL_172.
 #	1.73.0-,	set ASCIIDOC_NO_ROFF
 #
@@ -97,6 +99,9 @@ endif
 ifdef MAN_BOLD_LITERAL
 XMLTO_EXTRA += -m manpage-bold-literal.xsl
 endif
+ifdef DOCBOOK_SUPPRESS_SP
+XMLTO_EXTRA += -m manpage-suppress-sp.xsl
+endif
 
 #
 # Please note that there is a minor bug in asciidoc.
diff --git a/Documentation/manpage-base.xsl b/Documentation/manpage-base.xsl
index 16e2e40..a264fa6 100644
--- a/Documentation/manpage-base.xsl
+++ b/Documentation/manpage-base.xsl
@@ -32,17 +32,4 @@
 	<xsl:text>br&#10;</xsl:text>
 </xsl:template>
 
-<!-- attempt to work around spurious .sp at the tail of the line
-     that docbook stylesheets seem to add -->
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
 </xsl:stylesheet>
diff --git a/Documentation/manpage-suppress-sp.xsl b/Documentation/manpage-suppress-sp.xsl
new file mode 100644
index 0000000..a63c763
--- /dev/null
+++ b/Documentation/manpage-suppress-sp.xsl
@@ -0,0 +1,21 @@
+<!-- manpage-suppress-sp.xsl:
+     special settings for manpages rendered from asciidoc+docbook
+     handles erroneous, inline .sp in manpage output of some
+     versions of docbook-xsl -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		version="1.0">
+
+<!-- attempt to work around spurious .sp at the tail of the line
+     that some versions of docbook stylesheets seem to add -->
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
1.6.2.1.556.g581a3
