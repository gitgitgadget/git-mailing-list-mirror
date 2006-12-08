X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: [PATCH] Add support for building documentation in separate build-dir
 too.
Date: Fri, 08 Dec 2006 18:16:47 +0100
Message-ID: <elc6lk$vnl$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 17:20:26 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 102
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33709>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsjOY-0007TL-3t for gcvg-git@gmane.org; Fri, 08 Dec
 2006 18:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1426034AbWLHRUS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 12:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426035AbWLHRUS
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 12:20:18 -0500
Received: from main.gmane.org ([80.91.229.2]:57895 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1426034AbWLHRUP
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 12:20:15 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GsjOE-0001Yd-QC for git@vger.kernel.org; Fri, 08 Dec 2006 18:20:02 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Fri, 08 Dec 2006 18:20:02 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 08 Dec 2006 18:20:02
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

From 6969e092758f65e8b4b3875ab3050cd0c049cc60 Mon Sep 17 00:00:00 2001
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Date: Fri, 8 Dec 2006 18:09:23 +0100


Signed-off-by: Han-Wen Nienhuys <hanwen@xs4all.nl>
---
 Documentation/Makefile |   33 ++++++++++++++++++++-------------
 1 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c00f5f6..51cd707 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,6 +1,6 @@
 MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
-		$(wildcard git-*.txt)) \
+		$(wildcard $(here-srcdir)/git-*.txt)) \
 	gitk.txt
 MAN7_TXT=git.txt
 
@@ -33,8 +33,15 @@ man7dir=$(mandir)/man7
 
 INSTALL?=install
 
--include ../config.mak.autogen
+ifndef srcdir
+srcdir=..
+endif
+
+here-srcdir=$(srcdir)/Documentation
 
+ASCIIDOC_CONF=$(here-srcdir)/asciidoc.conf
+
+-include ../config.mak.autogen
 #
 # Please note that there is a minor bug in asciidoc.
 # The version after 6.0.3 _will_ include the patch found here:
@@ -63,9 +70,9 @@ install: man
 #
 # Determine "include::" file references in asciidoc files.
 #
-doc.dep : $(wildcard *.txt) build-docdep.perl
+doc.dep : $(wildcard $(here-srcdir)/*.txt) build-docdep.perl
 	rm -f $@+ $@
-	perl ./build-docdep.perl >$@+
+	perl $(lastword $^) >$@+
 	mv $@+ $@
 
 -include doc.dep
@@ -80,35 +87,35 @@ clean:
 	rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html doc.dep README
 
 %.html : %.txt
-	asciidoc -b xhtml11 -d manpage -f asciidoc.conf $<
+	asciidoc -b xhtml11 -d manpage -f $(ASCIIDOC_CONF) $<
 
 %.1 %.7 : %.xml
-	xmlto -m callouts.xsl man $<
+	xmlto --searchpath $(here-srcdir)/  -m callouts.xsl man $<
 
 %.xml : %.txt
-	asciidoc -b docbook -d manpage -f asciidoc.conf $<
+	asciidoc -b docbook -d manpage -f $(ASCIIDOC_CONF) $<
 
 git.html: git.txt README
 
 glossary.html : glossary.txt sort_glossary.pl
 	cat $< | \
-	perl sort_glossary.pl | \
+	perl $(lastword $^) | \
 	asciidoc -b xhtml11 - > glossary.html
 
-howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
+howto-index.txt: howto-index.sh $(wildcard $(here-srcdir)/howto/*.txt)
 	rm -f $@+ $@
-	sh ./howto-index.sh $(wildcard howto/*.txt) >$@+
+	sh $^ >$@+
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
-	asciidoc -b xhtml11 $*.txt
+	asciidoc -b xhtml11 $<
 
 WEBDOC_DEST = /pub/software/scm/git/docs
 
-$(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
+$(patsubst %.txt,%.html,$(wildcard $(here-srcdir)/howto/*.txt)): %.html : %.txt
 	rm -f $@+ $@
 	sed -e '1,/^$$/d' $< | asciidoc -b xhtml11 - >$@+
 	mv $@+ $@
 
 install-webdoc : html
-	sh ./install-webdoc.sh $(WEBDOC_DEST)
+	sh $(here-srcdir)/install-webdoc.sh $(WEBDOC_DEST)
-- 
1.4.4.1.gc9922-dirty


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
