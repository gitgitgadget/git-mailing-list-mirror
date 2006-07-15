From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Make asciidoc related rules depend on asciidoc.conf
Date: Sat, 15 Jul 2006 09:44:25 +0200
Message-ID: <20060715074425.GA2661@diku.dk>
References: <11528726881431-git-send-email-alp@atoker.com> <20060714215039.GA21994@diku.dk> <7v3bd3ois4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alp Toker <alp@atoker.com>
X-From: git-owner@vger.kernel.org Sat Jul 15 09:44:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1epE-00030c-2W
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 09:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946010AbWGOHo3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Jul 2006 03:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946009AbWGOHo3
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Jul 2006 03:44:29 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:20688 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1946010AbWGOHo2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Jul 2006 03:44:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 3D23F770013;
	Sat, 15 Jul 2006 09:44:27 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10691-04; Sat, 15 Jul 2006 09:44:26 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id A2E94770014;
	Sat, 15 Jul 2006 09:44:25 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 9017F6DFEC9; Sat, 15 Jul 2006 09:43:57 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 8C8DD629BE; Sat, 15 Jul 2006 09:44:25 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bd3ois4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23926>

Any rule running asciidoc, whether using -f asciidoc.conf or not,
will read asciidoc.conf. Make such rules depend on asciidoc.conf.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

Junio C Hamano <junkio@cox.net> wrote Fri, Jul 14, 2006:
> Alp is right -- the comments in [attributes] section after the
> definition do appear in the output, even with asciidoc 7.1.2, so
> here is a replacement proposal from me.

Am using the same setup as Alp (AsciiDoc 7.0.2 on Ubuntu Dapper), so I
was a bit curious that I could not see that. So I guess I compiled the
docs first and later decided to add the comments which then didn't cause
a recompilation.

I don't know if there should be a dependency on asciidoc.conf in every
rule calling asciidoc. Could be annoying if you are only making a minor
change.

---

diff --git a/Documentation/Makefile b/Documentation/Makefile
index cc83610..ce6c6cf 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -76,18 +76,18 @@ README: ../README
 clean:
 	rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html doc.dep README
 
-%.html : %.txt
+%.html : %.txt asciidoc.conf
 	asciidoc -b xhtml11 -d manpage -f asciidoc.conf $<
 
 %.1 %.7 : %.xml
 	xmlto -m callouts.xsl man $<
 
-%.xml : %.txt
+%.xml : %.txt asciidoc.conf
 	asciidoc -b docbook -d manpage -f asciidoc.conf $<
 
 git.html: git.txt README
 
-glossary.html : glossary.txt sort_glossary.pl
+glossary.html : glossary.txt sort_glossary.pl asciidoc.conf
 	cat $< | \
 	perl sort_glossary.pl | \
 	asciidoc -b xhtml11 - > glossary.html
@@ -97,12 +97,12 @@ howto-index.txt: howto-index.sh $(wildca
 	sh ./howto-index.sh $(wildcard howto/*.txt) >$@+
 	mv $@+ $@
 
-$(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
+$(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt asciidoc.conf
 	asciidoc -b xhtml11 $*.txt
 
 WEBDOC_DEST = /pub/software/scm/git/docs
 
-$(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
+$(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt asciidoc.conf
 	rm -f $@+ $@
 	sed -e '1,/^$$/d' $? | asciidoc -b xhtml11 - >$@+
 	mv $@+ $@
-- 
Jonas Fonseca
