From: Olaf Hering <olaf@aepfle.de>
Subject: Re: implement a stable 'Last updated' in Documentation
Date: Tue, 27 Jan 2015 12:11:07 +0100
Message-ID: <20150127111107.GA6517@aepfle.de>
References: <20150126172409.GA15204@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 12:11:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG43L-0006Dt-Iw
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 12:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757797AbbA0LLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 06:11:12 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:64072 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756291AbbA0LLK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 06:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1422357068; l=2821;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:To:From:Date;
	bh=GpEgHLAMc5hztPm8xG5OsmbWJffdkK1eR4QZAp0EOKc=;
	b=oKfXbY2QgcDr1Q+2TeryfxC52josz+Y78vo8/ywKPGeBEITyfIqmE2F662BKdtk+R+f
	v/CRs8noSIcJ7boK77VQAYyggpI8DwWN9tpqBDqEAi8Nb4bRqT3PyTMJEqd9MX8ZAivQp
	J8Shy38OkW+pYVqrHVyqaEbYI8T/eD7t4cA=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfssDIlSQZelGPTkz+JJHiQM2XCL4FiyQ+n/+A0DGQ==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:1087:7e01:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 37.1 AUTH)
	with ESMTPSA id J03851r0RBB802U
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	for <git@vger.kernel.org>;
	Tue, 27 Jan 2015 12:11:08 +0100 (CET)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id D4DF15016F; Tue, 27 Jan 2015 12:11:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150126172409.GA15204@aepfle.de>
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263063>

On Mon, Jan 26, Olaf Hering wrote:

> Several files in Documentation have an unstable 'Last updated' timestamp. The
> reason is that their mtime changes every time, which prevents reproducible
> builds.
> 
> 341 technical/api-index.txt: technical/api-index-skel.txt \
> 342         technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
> 343         $(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
> 
> 388 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
> 389         $(QUIET_GEN)$(RM) $@+ $@ && \
> 390         '$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(wildcard howto/*.txt)) >$@+ && \
> 391         mv $@+ $@
> 
> 399 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
> 400         $(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> 401         sed -e '1,/^$$/d' $< | \
> 402         $(TXT_TO_HTML) - >$@+ && \
> 403         mv $@+ $@
> 
> What file timestamp should be used for them? Likely "../version"?
> The final file, before passing it to asciidoc, should get a fixed timestamp
> with 'touch -r $reference_file $file'.

I came up with this change. If anything happens to depend on
howto-index.txt and technical/api-index.txt then this part needs rework.

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3e39e28..25ad0bd 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -6,6 +6,7 @@ TECH_DOCS =
 ARTICLES =
 SP_ARTICLES =
 OBSOLETE_HTML =
+TIMESTAMP_FILE = ../version
 
 MAN1_TXT += $(filter-out \
 		$(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
@@ -341,6 +342,7 @@ user-manual.xml: user-manual.txt user-manual.conf
 technical/api-index.txt: technical/api-index-skel.txt \
 	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
 	$(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
+	touch -r '$(TIMESTAMP_FILE)' $@
 
 technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt asciidoc.conf
@@ -388,6 +390,7 @@ $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	$(QUIET_GEN)$(RM) $@+ $@ && \
 	'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(wildcard howto/*.txt)) >$@+ && \
+	touch -r '$(TIMESTAMP_FILE)' $@+ && \
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
@@ -397,9 +400,12 @@ WEBDOC_DEST = /pub/software/scm/git/docs
 
 howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	sed -e '1,/^$$/d' $< | \
-	$(TXT_TO_HTML) - >$@+ && \
+	$(QUIET_ASCIIDOC)$(RM) $@++ $@+ $@ && \
+	sed -e '1,/^$$/d' $< >$@++ && \
+	touch -r '$(TIMESTAMP_FILE)' $@++ && \
+	$(TXT_TO_HTML) -o $@+ $@++ && \
+	$(RM) $@++ && \
+	touch $@+ && \
 	mv $@+ $@
 
 install-webdoc : html

Olaf
