From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH 3/8] Documentation: rename docbook-xsl-172 attribute to
 git-asciidoc-no-roff
Date: Tue, 24 Mar 2009 03:04:21 -0500
Message-ID: <1237881866-5497-4-git-send-email-chris_johnsen@pobox.com>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Chris Johnsen <chris_johnsen@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 09:06:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1es-0006ZF-It
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756796AbZCXIFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756740AbZCXIFS
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:05:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63904 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756591AbZCXIFM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:05:12 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C5F56A4BD3;
	Tue, 24 Mar 2009 04:05:10 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 74D1DA4BD0; Tue, 24 Mar 2009 04:05:05 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.214.ge986c
In-Reply-To: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: 7F2B38C6-184A-11DE-8414-32B0EBB1AA3C-07245699!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114415>

It seems that the ability to use raw roff codes in asciidoc.conf
was eliminated by docbook-xsl 1.72.0 _and later_. Unlike the
1.72.0-specific XSLT problem, this behavior was not reverted in
later releases.

This patch aims to make it clear that the affected asciidoc
attribute (flag) can be reasonably used with docbook-xsl versions
other than 1.72.0.

Also, document which make variables should be set for various
versions of asciidoc and docbook-xsl.

Testing done with asciidoc 8.3.1 and docbook-xsl 1.74.0.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---

This has no behavior changes for existing uses (make
DOCBOOK_XSL_172=Yes), but it enables new functionality
(ASCIIDOC_NO_ROFF=Yes) by divorcing the roff-avoiding parts of
asciidoc.conf from the label docbook-xsl-172.

I like the idea of including "tested with asciidoc/docbook-xsl
version info" in the commit message. It would have been very
helpful if all the previous commits to the core documentation
generation infrastructure carried such information.
---
 Documentation/Makefile      |   29 ++++++++++++++++++++++++++++-
 Documentation/asciidoc.conf |    8 ++++----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 1b5ff36..11b26aa 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -59,12 +59,39 @@ endif
 -include ../config.mak.autogen
 -include ../config.mak
 
+#
+# For asciidoc ...
+#	-7.1.2,	no extra settings are needed.
+#	8.0-,	set ASCIIDOC8.
+#
+
+#
+# For docbook-xsl ...
+#	-1.68.1,	set ASCIIDOC_NO_ROFF? (based on changelog from 1.73.0)
+#	1.69.0-1.71.1,	no extra settings are needed?
+#	1.72.0,		set DOCBOOK_XSL_172.
+#	1.73.0-,	set ASCIIDOC_NO_ROFF
+#
+
+#
+# If you had been using DOCBOOK_XSL_172 in an attempt to get rid
+# of 'the ".ft C" problem' in your generated manpages, and you
+# instead ended up with weird characters around callouts, try
+# using ASCIIDOC_NO_ROFF instead (it works fine with ASCIIDOC8).
+#
+
 ifdef ASCIIDOC8
 ASCIIDOC_EXTRA += -a asciidoc7compatible
 endif
 ifdef DOCBOOK_XSL_172
-ASCIIDOC_EXTRA += -a docbook-xsl-172
+ASCIIDOC_EXTRA += -a git-asciidoc-no-roff
 MANPAGE_XSL = manpage-1.72.xsl
+else
+	ifdef ASCIIDOC_NO_ROFF
+	# docbook-xsl after 1.72 needs the regular XSL, but will not
+	# pass-thru raw roff codes from asciidoc.conf, so turn them off.
+	ASCIIDOC_EXTRA += -a git-asciidoc-no-roff
+	endif
 endif
 
 #
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 1e735df..ce1b175 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -27,7 +27,7 @@ ifdef::backend-docbook[]
 endif::backend-docbook[]
 
 ifdef::backend-docbook[]
-ifndef::docbook-xsl-172[]
+ifndef::git-asciidoc-no-roff[]
 # "unbreak" docbook-xsl v1.68 for manpages. v1.69 works with or without this.
 # v1.72 breaks with this because it replaces dots not in roff requests.
 [listingblock]
@@ -42,9 +42,9 @@ ifdef::doctype-manpage[]
 endif::doctype-manpage[]
 </literallayout>
 {title#}</example>
-endif::docbook-xsl-172[]
+endif::git-asciidoc-no-roff[]
 
-ifdef::docbook-xsl-172[]
+ifdef::git-asciidoc-no-roff[]
 ifdef::doctype-manpage[]
 # The following two small workarounds insert a simple paragraph after screen
 [listingblock]
@@ -62,7 +62,7 @@ ifdef::doctype-manpage[]
 </literallayout><simpara></simpara>
 {title#}</para></formalpara>
 endif::doctype-manpage[]
-endif::docbook-xsl-172[]
+endif::git-asciidoc-no-roff[]
 endif::backend-docbook[]
 
 ifdef::doctype-manpage[]
-- 
1.6.2.1.214.ge986c
