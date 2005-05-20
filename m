From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Fix and clean up man page building
Date: Fri, 20 May 2005 15:35:33 +0200
Message-ID: <20050520133533.GA27395@diku.dk>
References: <E1DYmy8-0003YB-JW@highlab.com> <20050519155804.GB4513@pasky.ji.cz> <E1DYnpO-0003cF-I6@highlab.com> <Pine.LNX.4.58.0505190956330.2322@ppc970.osdl.org> <E1DYpbT-0003jv-JY@highlab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 15:37:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ7en-0001ii-40
	for gcvg-git@gmane.org; Fri, 20 May 2005 15:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVETNgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 09:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVETNgD
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 09:36:03 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:27601 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261382AbVETNfg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 09:35:36 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 398406E20C7; Fri, 20 May 2005 15:35:16 +0200 (CEST)
Received: from brok.diku.dk (brok.diku.dk [130.225.96.163])
	by nhugin.diku.dk (Postfix) with ESMTP
	id E6B4F6E20EA; Fri, 20 May 2005 15:35:15 +0200 (CEST)
Received: by brok.diku.dk (Postfix, from userid 3873)
	id 8629161DDD; Fri, 20 May 2005 15:35:33 +0200 (CEST)
To: Sebastian Kuzminsky <seb@highlab.com>
Content-Disposition: inline
In-Reply-To: <E1DYpbT-0003jv-JY@highlab.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sebastian Kuzminsky <seb@highlab.com> wrote Thu, May 19, 2005:
> -%.1 : %.xml
> +%.1 %.7 : %.xml
>  	xmlto man $<
> +	# FIXME: this next line works around an output filename bug in asciidoc 6.0.3
> +	[ "$@" = "git.7" ] || mv git.1 $@
>  
>  %.xml : %.txt
>  	asciidoc -b docbook -d manpage $<

This doesn't work for me since make stops when the test fails. Besides
it is a bit verbose. Following is a patch which will only check for
moving when building .7 files. It also cleans up the Makefile so it will
be easier to add the manpages for cogito.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

--- f435f47dab3465a47fbd2114cf006e0e869f31a9/Documentation/Makefile  (mode:100644)
+++ uncommitted/Documentation/Makefile  (mode:100644)
@@ -1,6 +1,7 @@
-DOC_SRC=$(wildcard git*.txt)
-DOC_HTML=$(patsubst %.txt,%.html,$(DOC_SRC))
-DOC_MAN=$(patsubst %.txt,%.1,$(wildcard git-*.txt)) git.7
+MAN1_TXT=$(wildcard git-*.txt)
+MAN7_TXT=git.txt
+DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT))
+DOC_MAN=$(patsubst %.txt,%.1,$(MAN1_TXT)) $(patsubst %.txt,%.7,$(MAN7_TXT))
 
 all: $(DOC_HTML) $(DOC_MAN)
 
@@ -18,10 +19,12 @@
 %.html : %.txt
 	asciidoc -b css-embedded -d manpage $<
 
+%.7 : %.1
+	# FIXME: this next line works around an output filename bug in asciidoc 6.0.3
+	if [ -f "$<" ]; then mv $< $@; fi
+
 %.1 %.7 : %.xml
 	xmlto man $<
-	# FIXME: this next line works around an output filename bug in asciidoc 6.0.3
-	[ "$@" = "git.7" ] || mv git.1 $@
 
 %.xml : %.txt
 	asciidoc -b docbook -d manpage $<
-- 
Jonas Fonseca
