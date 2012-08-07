From: Jeff King <peff@peff.net>
Subject: [PATCH] docs: monospace listings in docbook output
Date: Tue, 7 Aug 2012 16:07:38 -0400
Message-ID: <20120807200738.GC440@sigill.intra.peff.net>
References: <CANes+HZ3EH70x6KiaPsV=SQpbjr5o+pEzj2+4Xx613GPZv0SLw@mail.gmail.com>
 <20120807060157.GA13222@sigill.intra.peff.net>
 <874nofcgrl.fsf@fencepost.gnu.org>
 <20120807194211.GB440@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, David Kastrup <dak@gnu.org>,
	mofaph <mofaph@gmail.com>, git <git@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 22:07:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Syq4E-0000wd-JI
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 22:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756372Ab2HGUHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 16:07:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54867 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756331Ab2HGUHm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 16:07:42 -0400
Received: (qmail 30882 invoked by uid 107); 7 Aug 2012 20:07:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Aug 2012 16:07:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Aug 2012 16:07:38 -0400
Content-Disposition: inline
In-Reply-To: <20120807194211.GB440@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203042>

When asciidoc converts a listing block like:

----------------------
$ git log --merge
----------------------

it marks it to be displayed in a monospace font. This works
fine when generating HTML output. However, when generating
docbook output, we override the expansion of a listingblock
to work around bugs in some versions of the docbook
toolchain. Our override did not mark the listingblock with
the "monospaced" class.

The main output that uses docbook as an intermediate format
is the manpages. We didn't notice any issue there because
the monospaced class seems to be ignored when generating
roff from the docbook manpages.

However, when generating texinfo to make info pages, docbook
does respect this class. The resulting texinfo output
properly uses "@example" blocks to display the listing in
this case. Besides possibly looking prettier in some texinfo
backends,  one important effect is that the monospace font
suppresses texinfo's expansion of "--" and "---" into
en-dashes and em-dashes.  With the current code, the example
above ends up looking like "git log -merge", which is
confusing and wrong.

Signed-off-by: Jeff King <peff@peff.net>
---
I wonder if we can maybe just rip out our custom overrides entirely.
They date back to versions of docbook from 2006. I'm not sure I entirely
understand their purpose, though (they seem to also be about inserting
extra line breaks, and handling manual additions of roff).

This cleans up many of the problems with the info result. However, there
are still lots of places that use "--" outside of a listing block or a
backtick literal. Those still look bad in the generated info page.

 Documentation/asciidoc.conf    | 4 ++--
 Documentation/user-manual.conf | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index a26d245..1273a85 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -36,7 +36,7 @@ ifndef::git-asciidoc-no-roff[]
 # v1.72 breaks with this because it replaces dots not in roff requests.
 [listingblock]
 <example><title>{title}</title>
-<literallayout>
+<literallayout class="monospaced">
 ifdef::doctype-manpage[]
 &#10;.ft C&#10;
 endif::doctype-manpage[]
@@ -53,7 +53,7 @@ ifdef::doctype-manpage[]
 # The following two small workarounds insert a simple paragraph after screen
 [listingblock]
 <example><title>{title}</title>
-<literallayout>
+<literallayout class="monospaced">
 |
 </literallayout><simpara></simpara>
 {title#}</example>
diff --git a/Documentation/user-manual.conf b/Documentation/user-manual.conf
index 339b309..d87294d 100644
--- a/Documentation/user-manual.conf
+++ b/Documentation/user-manual.conf
@@ -14,7 +14,7 @@ ifdef::backend-docbook[]
 # "unbreak" docbook-xsl v1.68 for manpages. v1.69 works with or without this.
 [listingblock]
 <example><title>{title}</title>
-<literallayout>
+<literallayout class="monospaced">
 |
 </literallayout>
 {title#}</example>
-- 
1.7.12.rc1.12.g5eaae48
