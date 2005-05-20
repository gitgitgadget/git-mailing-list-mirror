From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: [PATCH] Fix and clean up man page building
Date: Fri, 20 May 2005 11:09:57 -0600
Message-ID: <E1DZB0X-0004qW-QX@highlab.com>
References: <E1DYmy8-0003YB-JW@highlab.com> <20050519155804.GB4513@pasky.ji.cz> <E1DYnpO-0003cF-I6@highlab.com> <Pine.LNX.4.58.0505190956330.2322@ppc970.osdl.org> <E1DYpbT-0003jv-JY@highlab.com> <20050520133533.GA27395@diku.dk> <m37jhu56ta.fsf@harinath.blr.novell.com> <20050520145211.GB27395@diku.dk>
X-From: git-owner@vger.kernel.org Fri May 20 19:12:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZB25-0000sR-Ee
	for gcvg-git@gmane.org; Fri, 20 May 2005 19:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVETRMS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 13:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVETRMS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 13:12:18 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:50843 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261517AbVETRIu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 13:08:50 -0400
Received: from highlab.com ([24.8.179.27])
          by comcast.net (rwcrmhc12) with ESMTP
          id <2005052017084901400kah49e>; Fri, 20 May 2005 17:08:49 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1DZB0X-0004qW-QX
	for git@vger.kernel.org; Fri, 20 May 2005 11:09:57 -0600
To: git@vger.kernel.org
In-reply-to: <20050520145211.GB27395@diku.dk> 
Comments: In-reply-to Jonas Fonseca <fonseca@diku.dk>
   message dated "Fri, 20 May 2005 16:52:12 +0200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jonas Fonseca <fonseca@diku.dk> wrote:
> Raja R Harinath <rharinath@novell.com> wrote Fri, May 20, 2005:
> > Jonas Fonseca <fonseca@diku.dk> writes:
> > > +%.7 : %.1
> > > +	# FIXME: this next line works around an output filename bug in asciidoc 6.0.3
> > > +	if [ -f "$<" ]; then mv $< $@; fi
> > > +
> > >  %.1 %.7 : %.xml
> > >  	xmlto man $<
> > > -	# FIXME: this next line works around an output filename bug in asciidoc 6.0.3
> > > -	[ "$@" = "git.7" ] || mv git.1 $@
> > >  
> > >  %.xml : %.txt
> > >  	asciidoc -b docbook -d manpage $<
> > 
> > That doesn't look right.  I think you want
> > 
> >   %.7: %.xml
> >       xmlto man %<
> >
> >   %.1: %.xml
> >        xmlto man $<
> >        [ test -f $@ ] || mv git.1 $@
> 
> [ Looks like you mixed up %.1 and %.7 ]
> 
> Yes, separating the rule for %.1 and %.7 might be clearer. But it would
> be great if it would work for any man page in section 7 not just git.7.
> Since I hope to add cogito.7 soon.


That's still not right.  Jonas' %.7 target works (as long as none of the
%.7 source files have dashes in the name), but the %.1 target fails to
rebuild the manpages if they already exist.


The underlying problem, just so we're all clear, is that asciidoc 6.0.3
has a bug that causes it to output buggy xml files when the command-name
has a dash in it.  When there's a dash in the command-name, asciidoc
produces xml that says everything _before_ the first dash is the command
name, and everything _after_ the first dash is the quick description
("purpose") of that command.


The git.txt -> git.xml transition is fine since there is no dash in "git",
but (for example) the git-cat-file.txt -> git-cat-file.xml transition
tickles the bug.  git-cat-file.xml thinks it's documenting a program
called "git", with the quick description beginning with "cat-file".
Here's the relevant snippet from git-cat-file.xml:

<refnamediv>
    <refname>git</refname>
    <refpurpose>cat-file - Provide content or type information for repository objects</refpurpose>
</refnamediv>


So far it's not too bad (it's still getting the filename right, even
though the contents are less than perfect).  But when we feed that xml to
'xmlto man', xmlto sensibly uses the buggy command name "git" for the
output file name, producing "git.1".  _That_ is what we have to move.
(xmlto has no --output-filename option, or we'd just use that.)


Here's another attempt at the Makefile patch.  It's got the broken-out
man1 vs man7 layout that Jonas sensibly suggested.


Note that the asciidoc bug workaround is incredibly fragile.  If we have
any man1 pages that don't begin with "git-", it'll do the wrong thing
(because they won't be named git.1).  And if we have any man7 pages
that have "-" in the name, it'll do the wrong thing (by not renaming
the incorrectly named manpage).


Please please Stuart Rackham, Mr Asciidoc man, use David Greaves'
patch <http://marc.theaimsgroup.com/?l=git&m=111558757202243&w=2> to
fix this bug.


Index: Documentation/Makefile
===================================================================
--- a81ef956b9b2946bea2104cd11a4529c965976ad/Documentation/Makefile  (mode:100644)
+++ uncommitted/Documentation/Makefile  (mode:100644)
@@ -1,25 +1,40 @@
-DOC_SRC=$(wildcard git*.txt)
-DOC_HTML=$(patsubst %.txt,%.html,$(DOC_SRC))
-DOC_MAN=$(patsubst %.txt,%.1,$(DOC_SRC))
+MAN1_TXT=$(wildcard git-*.txt)
+MAN7_TXT=git.txt
 
-all: $(DOC_HTML) $(DOC_MAN)
+DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT))
+
+DOC_MAN1=$(patsubst %.txt,%.1,$(MAN1_TXT))
+DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
+
+
+all: html man
 
 html: $(DOC_HTML)
 
-man: $(DOC_MAN)
+man: man1 man7
+
+man1: $(DOC_MAN1)
+
+man7: $(DOC_MAN7)
+
 
 # 'include' dependencies
 git-diff-%.txt: diff-format.txt
 	touch $@
 
 clean:
-	rm -f *.xml *.html *.1
+	rm -f *.xml *.html *.1 *.7
 
 %.html : %.txt
 	asciidoc -b css-embedded -d manpage $<
 
 %.1 : %.xml
 	xmlto man $<
+	@# FIXME: this next line works around an output filename bug in asciidoc 6.0.3
+	mv git.1 $@
+
+%.7 : %.xml
+	xmlto man $<
 
 %.xml : %.txt
 	asciidoc -b docbook -d manpage $<


-- 
Sebastian Kuzminsky
"Marie will know I'm headed south, so's to meet me by and by"
-Townes Van Zandt
