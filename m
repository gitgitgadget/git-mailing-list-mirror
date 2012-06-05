From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] api-credentials.txt: add "see also" section
Date: Tue, 5 Jun 2012 03:34:03 -0400
Message-ID: <20120605073403.GC25809@sigill.intra.peff.net>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
 <1338739804-32167-4-git-send-email-Matthieu.Moy@imag.fr>
 <7vsjecvxmc.fsf@alter.siamese.dyndns.org>
 <vpq1ulvuxd9.fsf@bauges.imag.fr>
 <20120604115630.GC27676@sigill.intra.peff.net>
 <vpqpq9en8ol.fsf@bauges.imag.fr>
 <20120605065955.GB25809@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 09:34:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SboHN-0004fo-Vj
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 09:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874Ab2FEHeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 03:34:08 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43107
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753435Ab2FEHeG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 03:34:06 -0400
Received: (qmail 14620 invoked by uid 107); 5 Jun 2012 07:34:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 03:34:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 03:34:03 -0400
Content-Disposition: inline
In-Reply-To: <20120605065955.GB25809@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199211>

On Tue, Jun 05, 2012 at 02:59:55AM -0400, Jeff King wrote:

> I wonder if we could even make asciidoc work to convert
> linkgit:git-config[1] into the right path (i.e., to include the ".."
> automatically) when we are in the subdir.
> 
> I don't really have a sense how powerful asciidoc macros are, but this
> seems like an obvious case that they should handle.

Here is a simple fix. The Makefile bits are more hacky than I would
like. It would be really nice if the asciidoc macro could convert "we
are working on X/Y/Z.html" into "we need ../../ to get to the relative
base", but I don't think it is that flexible.

We could also replace asciidoc with a wrapper script that does the
conversion and sets the appropriate attribute. I don't know if it is
worth the trouble. It's not like we add documentation subdirectories
very often.

-- >8 --
Subject: docs: fix cross-directory linkgit references

Most of our documentation is in a single directory, so using
linkgit:git-config[1] just generates a relative link in the
same directory. However, this is not the case with the API
documentation in technical/*, which need to refer to
git-config from the parent directory.

We can fix this by passing a special prefix attribute when building
in a subdirectory, and respecting that prefix in our linkgit
definitions.

We only have to modify the html linkgit definition.  For
manpages, we can ignore this for two reasons:

  1. we do not generate actual links to the file in
     manpages, but instead just give the name and section of
     the linked manpage

  2. we do not currently build manpages for subdirectories,
     only html

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/Makefile      | 2 ++
 Documentation/asciidoc.conf | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 14286cb..b3693c8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -280,6 +280,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
 	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
 	$(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
 
+technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %,%.html,$(API_DOCS) technical/api-index): %.html : %.txt
 	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) $*.txt
@@ -333,6 +334,7 @@ $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 
 WEBDOC_DEST = /pub/software/scm/git/docs
 
+howto/%.html: ASCIIDOC_EXTRA += git-relative-html-prefix=../
 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	sed -e '1,/^$$/d' $< | $(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 - >$@+ && \
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index aea8627..6d06271 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -91,5 +91,5 @@ endif::doctype-manpage[]
 
 ifdef::backend-xhtml11[]
 [linkgit-inlinemacro]
-<a href="{target}.html">{target}{0?({0})}</a>
+<a href="{git-relative-html-prefix}{target}.html">{target}{0?({0})}</a>
 endif::backend-xhtml11[]
-- 
1.7.11.rc1.3.gf8b4f5c
