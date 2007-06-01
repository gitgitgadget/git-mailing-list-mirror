From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] catch asciidoc failures
Date: Fri, 1 Jun 2007 05:10:30 -0400
Message-ID: <20070601091030.GA2215@coredump.intra.peff.net>
References: <11806790373908-git-send-email-slamb@slamb.org> <20070601083621.GB3521@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Lamb <slamb@slamb.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, jonas.fonseca@gmail.com
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 11:10:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu39g-0007XC-GI
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 11:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727AbXFAJKf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 05:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754255AbXFAJKf
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 05:10:35 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4501 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111AbXFAJKe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 05:10:34 -0400
Received: (qmail 30980 invoked from network); 1 Jun 2007 09:10:41 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 1 Jun 2007 09:10:41 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jun 2007 05:10:30 -0400
Content-Disposition: inline
In-Reply-To: <20070601083621.GB3521@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48856>

On Fri, Jun 01, 2007 at 10:36:21AM +0200, Martin Waitz wrote:

> perhaps we should simply change the pipe ordering to get asciidoc
> to the end of the pipeline so that all shells respect its exit code?
> [...]
> something like (untested):
> 	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' $< |
> 		$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
> 			$(ASCIIDOC_EXTRA) -o $@+ -

That won't work. The text @@GIT_VERSION@@ is pulled in from the
asciidoc.conf file, so it's not even in the source file; it's only in
the built product.

As Jonas suggested, making it an asciidoc attribute is much more
elegant (patch even tested!):

-- >8 --
Documentation: robustify asciidoc GIT_VERSION replacement

Instead of using sed on the resulting file, we now have a
git_version asciidoc attribute. This means that we don't
pipe the output of asciidoc, which means we can detect build
failures.

Problem reported by Scott Lamb, solution suggested by Jonas Fonseca.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/Makefile      |    6 ++----
 Documentation/asciidoc.conf |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3f92783..4064b38 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -112,8 +112,7 @@ clean:
 %.html : %.txt
 	rm -f $@+ $@
 	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
-		$(ASCIIDOC_EXTRA) -o - $< | \
-		sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' >$@+
+		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $<
 	mv $@+ $@
 
 %.1 %.5 %.7 : %.xml
@@ -122,8 +121,7 @@ clean:
 %.xml : %.txt
 	rm -f $@+ $@
 	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
-		$(ASCIIDOC_EXTRA) -o - $< | \
-		sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' >$@+
+		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $<
 	mv $@+ $@
 
 user-manual.xml: user-manual.txt user-manual.conf
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index fa7dc94..60e15ba 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -40,7 +40,7 @@ template::[header-declarations]
 <refentrytitle>{mantitle}</refentrytitle>
 <manvolnum>{manvolnum}</manvolnum>
 <refmiscinfo class="source">Git</refmiscinfo>
-<refmiscinfo class="version">@@GIT_VERSION@@</refmiscinfo>
+<refmiscinfo class="version">{git_version}</refmiscinfo>
 <refmiscinfo class="manual">Git Manual</refmiscinfo>
 </refmeta>
 <refnamediv>
-- 
1.5.2.871.g0ff23
