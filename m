From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 2/4] Encode the manpage section in the file name
Date: Fri, 10 Mar 2006 15:43:57 +0100
Message-ID: <20060310144357.GC7920@diku.dk>
References: <20060310144106.GA7920@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 15:44:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHiqZ-0008G2-Ux
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 15:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWCJOoA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 09:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCJOoA
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 09:44:00 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:2476 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751382AbWCJOn7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Mar 2006 09:43:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 1D687770030;
	Fri, 10 Mar 2006 15:43:59 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01774-03; Fri, 10 Mar 2006 15:43:57 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 83E5877002C;
	Fri, 10 Mar 2006 15:43:57 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 460F26DF8C8; Fri, 10 Mar 2006 15:42:33 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 70DCE61DC1; Fri, 10 Mar 2006 15:43:57 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20060310144106.GA7920@diku.dk>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17476>

This makes it easier to handle other document types.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 Documentation/Makefile |   39 +++++++++++++++++++++++++++------------
 1 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 661c259..00e9276 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -3,13 +3,13 @@ CG_SRC=$(filter-out $(CG_IGNORE), $(wild
 
 PACKAGE=cogito
 
-MAN1_TXT=$(patsubst ../cg%,cg%.txt,$(CG_SRC))
-MAN7_TXT=$(PACKAGE).txt
+MAN1_TXT=$(patsubst ../cg%,cg%.1.txt,$(CG_SRC))
+MAN7_TXT=$(PACKAGE).7.txt
 
 DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT)) introduction.html
 
-DOC_MAN1=$(patsubst %.txt,%.1,$(MAN1_TXT))
-DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
+DOC_MAN1=$(patsubst %.txt,%,$(MAN1_TXT))
+DOC_MAN7=$(patsubst %.txt,%,$(MAN7_TXT))
 
 prefix=$(HOME)
 bin=$(prefix)/bin
@@ -56,28 +56,43 @@ install-html: html
 	$(INSTALL) $(DOC_HTML) $(DESTDIR)/$(htmldir)
 
 clean:
-	rm -f *.xml *.html *.1 *.7 cg*.txt $(PACKAGE).txt
+	rm -f *.xml *.html *.1 *.7 cg*.[17].txt $(PACKAGE).7.txt
 
 .PRECIOUS: cg%.txt
 
 introduction.html: ../README
 	asciidoc -b xhtml11 -d article -f asciidoc.conf -o $@ $<
 
-%.html : %.txt
+%.1.html : %.1.txt
 	asciidoc -b xhtml11 -d manpage -f asciidoc.conf $<
 
-%.1 %.7 : %.xml
-	xmlto man $<
+%.7.html : %.7.txt
+	asciidoc -b xhtml11 -d manpage -f asciidoc.conf $<
 
-%.xml : %.txt
+%.html : %.txt
+	asciidoc -b xhtml11 -d article -f asciidoc.conf -o $@ $<
+
+%.1.xml : %.1.txt
 	asciidoc -b docbook -d manpage -f asciidoc.conf $<
 
-$(PACKAGE).txt : make-$(PACKAGE)-asciidoc
+%.7.xml : %.7.txt
+	asciidoc -b docbook -d manpage -f asciidoc.conf $<
+
+%.xml : %.txt
+	asciidoc -b docbook -d article -f asciidoc.conf $<
+
+%.1 : %.1.xml
+	xmlto man $<
+
+%.7 : %.7.xml
+	xmlto man $<
+
+$(PACKAGE).7.txt : make-$(PACKAGE)-asciidoc
 	./make-$(PACKAGE)-asciidoc > $@
 
 # It seems that cg%.txt won't match this so use an explicit rule
-cg.txt : ../cg make-cg-asciidoc
+cg.1.txt : ../cg make-cg-asciidoc
 	CGPACKAGE=$(PACKAGE) ./make-cg-asciidoc $< > $@
 
-cg-%.txt : ../cg-% make-cg-asciidoc
+cg-%.1.txt : ../cg-% make-cg-asciidoc
 	CGPACKAGE=$(PACKAGE) ./make-cg-asciidoc $< > $@

-- 
Jonas Fonseca
