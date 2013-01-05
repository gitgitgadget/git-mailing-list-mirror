From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: fix man page dependency on asciidoc.conf
Date: Sat, 5 Jan 2013 15:28:00 -0800
Message-ID: <20130105232800.GF3247@elie.Belkin>
References: <20130105160017.GD6440@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sergey Vlasov <vsu@altlinux.ru>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 06 00:29:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrdBX-0007H0-In
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 00:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924Ab3AEX2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 18:28:07 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:42679 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898Ab3AEX2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 18:28:06 -0500
Received: by mail-pa0-f48.google.com with SMTP id fa1so10067304pad.7
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 15:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WjsxwMGXUsu4VTH6reCqddzOTwR4QMDljL4D2p6wopQ=;
        b=t6BZOU8sICHnszkQRnuV/tu6smXs33aFIorGEB2/1DdVs60piK6BQ5envAgjMglEfS
         9ozew+hE5j1jQp8J5Vg5ALLLKK9mx4Pf1q3X2GqC0wRAD+AVjdVsciWMeu3+hvxE2gYs
         hYgVlQaaFdRtV03tg06J8bX+4OC5ukURSOOjnX6zSYcXS0JxG/gwo8taARTLdAt3Hkc9
         vYMlNdOTzmWe+nDmnecrndThtK7PBRy5TmK8N3i7ucCcgesXXHxRe/GZsIh2giYzA6jm
         lrIGKCphlRj12rNYhO38sl3Cs5/5ladJN69jIAb+utCWwBR6yNmL7RcjWXvG6Z8LfjkE
         Soig==
X-Received: by 10.68.130.225 with SMTP id oh1mr28729079pbb.147.1357428485043;
        Sat, 05 Jan 2013 15:28:05 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id sy1sm34752315pbc.66.2013.01.05.15.28.03
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 15:28:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130105160017.GD6440@serenity.lan>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212740>

John Keeping wrote:

> When building manual pages, the source text is transformed to XML with
> AsciiDoc before the man pages are generated from the XML with xmlto.
>
> Fix the dependency in the Makefile so that the XML files are rebuilt
> when asciidoc.conf changes and not just the manual pages from unchanged
> XML.

Good catch, thanks.

Would something like the following make sense, to make it more obvious
how the dependency needs to be adjusted if we change the $(ASCIIDOC)
command line for some reason?

diff --git i/Documentation/Makefile w/Documentation/Makefile
index e53d333e..971977b8 100644
--- i/Documentation/Makefile
+++ w/Documentation/Makefile
@@ -178,8 +178,6 @@ all: html man
 
 html: $(DOC_HTML)
 
-$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7): asciidoc.conf
-
 man: man1 man5 man7
 man1: $(DOC_MAN1)
 man5: $(DOC_MAN5)
@@ -257,7 +255,7 @@ clean:
 	$(RM) $(cmds_txt) *.made
 	$(RM) manpage-base-url.xsl
 
-$(MAN_HTML): %.html : %.txt
+$(MAN_HTML): %.html : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
@@ -270,7 +268,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
-%.xml : %.txt
+%.xml : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
@@ -286,7 +284,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
 	$(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
 
 technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
-$(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt
+$(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) $*.txt
 
diff --git i/t/test-terminal.perl w/t/test-terminal.perl
index 10172aee..1fb373f2 100755
--- i/t/test-terminal.perl
+++ w/t/test-terminal.perl
@@ -31,7 +31,7 @@ sub finish_child {
 	} elsif ($? & 127) {
 		my $code = $? & 127;
 		warn "died of signal $code";
-		return $code - 128;
+		return $code + 128;
 	} else {
 		return $? >> 8;
 	}
