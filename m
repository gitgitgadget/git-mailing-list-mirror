From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH 1/2] Documentation/Makefile: make most operations "quiet"
Date: Wed, 25 Mar 2009 04:55:19 -0500
Message-ID: <1237974919-3020-1-git-send-email-chris_johnsen@pobox.com>
References: <20090325042842.GB15498@coredump.intra.peff.net>
Cc: git@vger.kernel.org, Chris Johnsen <chris_johnsen@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 10:57:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmPrN-0002rJ-8z
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 10:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbZCYJzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 05:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbZCYJzs
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 05:55:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbZCYJzr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 05:55:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4EBCB9C57;
	Wed, 25 Mar 2009 05:55:45 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 090149C53; Wed, 25 Mar 2009 05:55:39 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.315.g33192
In-Reply-To: <20090325042842.GB15498@coredump.intra.peff.net>
X-Pobox-Relay-ID: 1C1125BE-1923-11DE-A4C8-C5D912508E2D-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114578>

On 2009 Mar 24, at 23:28, Jeff King wrote:
> On Tue, Mar 24, 2009 at 11:21:39PM -0500, Chris Johnsen wrote:
>
> >  technical/api-index.txt: technical/api-index-skel.txt \
> > -	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
> > +	$(QUIET_GEN)technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS)) && \
> >  	cd technical && sh ./api-index.sh
>
> What's going on here? The line you remove is part of the dependencies,
> but you replace it with a line of build instructions (and make barfs, of
> course).

Yes, I botched that one. The QUIET_GEN should have been on the
next line. Thanks for catching it. I fixed it along with error
propagation and initially-also-botched "&& chaining" for
gitman.texi. I also added QUIET_XSLTPROC for user-manual.html.

I tested the man, html, info, and git-add.texi targets
(previously I only ran man and info targets; git-add.texi
exercises a rule not otherwise used in the usual targets).

An interdiff from "v1" to what I have now follows (it include
parts that would be in 1/2 and 2/2 from "v1").

-- >8 --
 Documentation/Makefile |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git c/Documentation/Makefile w/Documentation/Makefile
index 373a2cc..d145372 100644
--- c/Documentation/Makefile
+++ w/Documentation/Makefile
@@ -92,6 +92,7 @@ ifndef V
 	QUIET_DB2TEXI	= @echo '   ' DB2TEXI $@;
 	QUIET_MAKEINFO	= @echo '   ' MAKEINFO $@;
 	QUIET_DBLATEX	= @echo '   ' DBLATEX $@;
+	QUIET_XSLTPROC	= @echo '   ' XSLTPROC $@;
 	QUIET_GEN	= @echo '   ' GEN $@;
 	QUIET_STDERR	= 2> /dev/null
 	QUIET_SUBDIR0	= +@subdir=
@@ -202,8 +203,8 @@ user-manual.xml: user-manual.txt user-manual.conf
 	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b docbook -d book $<
 
 technical/api-index.txt: technical/api-index-skel.txt \
-	$(QUIET_GEN)technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS)) && \
-	cd technical && sh ./api-index.sh
+	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
+	$(QUIET_GEN)cd technical && sh ./api-index.sh
 
 $(patsubst %,%.html,$(API_DOCS) technical/api-index): %.html : %.txt
 	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
@@ -213,7 +214,7 @@ XSLT = docbook.xsl
 XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
 
 user-manual.html: user-manual.xml
-	xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
+	$(QUIET_XSLTPROC)xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
 
 git.info: user-manual.texi
 	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split -o $@ user-manual.texi
@@ -233,7 +234,7 @@ user-manual.pdf: user-manual.xml
 gitman.texi: $(MAN_XML) cat-texi.perl
 	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
 	($(foreach xml,$(MAN_XML),$(DOCBOOK2X_TEXI) --encoding=UTF-8 \
-		--to-stdout $(xml) &&) true) > $@++
+		--to-stdout $(xml) &&) true) > $@++ && \
 	$(PERL_PATH) cat-texi.perl $@ <$@++ >$@+ && \
 	rm $@++ && \
 	mv $@+ $@
