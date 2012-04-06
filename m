From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bad Man Page URLs
Date: Fri, 6 Apr 2012 01:17:17 -0500
Message-ID: <20120406061717.GB3911@burratino>
References: <2AC038A1-3D8D-425E-92B3-DADFD027761A@justatheory.com>
 <20120406023223.GB16264@sigill.intra.peff.net>
 <20120406025457.GA23997@sigill.intra.peff.net>
 <20120406042215.GA3938@burratino>
 <20120406054637.GA25301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"David E. Wheeler" <david@justatheory.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 08:17:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG2UC-0006Sa-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 08:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573Ab2DFGRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 02:17:24 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47989 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500Ab2DFGRX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 02:17:23 -0400
Received: by iagz16 with SMTP id z16so2726758iag.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 23:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wG61VfjjHrRaMrEHcie5v+iYKa5EoYxWhUHh4nfb+Gk=;
        b=GQSeqZ0lKY3lEv1TG5A0Ou/YPEG15oH4AEWOKlybjE57hVYihug7xEgZSs9Svk+6kg
         69VbcjoVQE32aghEo4TZ+HLXHDoa3f1w3vODAyIqcrlsXjrrOZ1+3nDK6dEJF1rymAfL
         TEkKcl13qfcRJxvRcb87E4qqJFXNKP+FNGMJLd/d+h4t+oHXtd+AzaXt2hKI0LdrMkQ6
         X54Ixl2O9mm9+vW+fPLcY9aVw1JltkGTkkdQgqa4ATIkJOE7znc2Gm6KbsbS3C95t3eR
         Zw0VLUlIrRD7Dq2/RRjAhrhP/vhecdymnNCIJmBFPiirXnOx53uMO5jJZ0tahH83x+jA
         RL9g==
Received: by 10.50.46.138 with SMTP id v10mr4243684igm.18.1333693042443;
        Thu, 05 Apr 2012 23:17:22 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id nq4sm4213797igc.5.2012.04.05.23.17.21
        (version=SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 23:17:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120406054637.GA25301@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194850>

Jeff King wrote:

> Junio, what do you think of building the git-manpages-* tarballs (and
> the git-manpages repo) with MAN_BASE_URL set to "http://some-official-place/"?
> As of now, they mention "file:///home/junio/...".

Could be as simple as this, no?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/Makefile |   10 ++++++++--
 Makefile               |    1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git i/Documentation/Makefile w/Documentation/Makefile
index d40e211f..0edad3a2 100644
--- i/Documentation/Makefile
+++ w/Documentation/Makefile
@@ -248,8 +248,14 @@ $(MAN_HTML): %.html : %.txt
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
 	mv $@+ $@
 
-manpage-base-url.xsl: manpage-base-url.xsl.in
-	sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
+manpage-base-url.xsl: manpage-base-url.xsl.in FORCE
+	$(QUIET_GEN)$(RM) $@+ && \
+	sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@+ && \
+	if test -e $@ && cmp -s $@+ $@; then \
+		$(RM) $@+; \
+	else \
+		mv $@+ $@; \
+	fi
 
 %.1 %.5 %.7 : %.xml manpage-base-url.xsl
 	$(QUIET_XMLTO)$(RM) $@ && \
diff --git i/Makefile w/Makefile
index be1957a5..ce6f805c 100644
--- i/Makefile
+++ w/Makefile
@@ -2623,6 +2623,7 @@ dist-doc:
 	$(RM) -r .doc-tmp-dir
 	mkdir -p .doc-tmp-dir/man1 .doc-tmp-dir/man5 .doc-tmp-dir/man7
 	$(MAKE) -C Documentation DESTDIR=./ \
+		MAN_BASE_URL=git-htmldocs/ \
 		man1dir=../.doc-tmp-dir/man1 \
 		man5dir=../.doc-tmp-dir/man5 \
 		man7dir=../.doc-tmp-dir/man7 \
-- 
