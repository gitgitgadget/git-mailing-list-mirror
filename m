From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: parsecvs tool now creates git repositories
Date: Sun, 2 Apr 2006 21:38:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604022122430.3781@g5.osdl.org>
References: <1143956188.2303.39.camel@neko.keithp.com>  <20060402093906.GH1259@lug-owl.de>
  <20060402193144.GK1259@lug-owl.de> <1144037456.2303.92.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-714510296-1144039108=:3781"
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 03 06:38:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQGpt-0001fP-12
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 06:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWDCEih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 00:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWDCEih
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 00:38:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31393 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750813AbWDCEig (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 00:38:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k334cTEX004890
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Apr 2006 21:38:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k334cSlT002914;
	Sun, 2 Apr 2006 21:38:28 -0700
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1144037456.2303.92.camel@neko.keithp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18314>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-714510296-1144039108=:3781
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Sun, 2 Apr 2006, Keith Packard wrote:

> On Sun, 2006-04-02 at 21:31 +0200, Jan-Benedict Glaw wrote:
> 
> > lex.l: In function ÿÿparse_dataÿÿ:
> > lex.l:90: error: ÿÿyytext_ptrÿÿ undeclared (first use in this function)
> > lex.l:90: error: (Each undeclared identifier is reported only once
> > lex.l:90: error: for each function it appears in.)
> > make: *** [lex.o] Error 1
> 
> I think this is a bug in your version of flex; I'm using standard lex
> conventions here. I don't know how to make it work for you.

I need something like this to make it work with flex/lex..

The "-l" tells flex to be more traditional.

The "clean" rule is obvious.

And the "yylineno" is a lot more traditional than yyget_lineno(), which 
doesn't work for me at all. I think that's some issue with flex' support 
for re-entrant parsers.

Whether it works after this, I dunno. But at least it compiles.

		Linus

---
diff --git a/Makefile b/Makefile
index 639353a..c7e04a5 100644
--- a/Makefile
+++ b/Makefile
@@ -4,6 +4,7 @@ GCC_WARNINGS3=-Wnested-externs -fno-stri
 GCC_WARNINGS=$(GCC_WARNINGS1) $(GCC_WARNINGS2) $(GCC_WARNINGS3)
 CFLAGS=-O0 -g $(GCC_WARNINGS)
 YFLAGS=-d
+LFLAGS=-l
 
 SRCS=gram.y lex.l cvs.h parsecvs.c cvsutil.c revlist.c atom.c revcvs.c git.c
 
@@ -20,4 +21,4 @@ lex.o: lex.c
 y.tab.h: gram.c
 
 clean:
-	rm -f $(OBJS) y.tab.h gram.c parsecvs
+	rm -f $(OBJS) y.tab.h gram.c parsecvs lex.c
diff --git a/lex.l b/lex.l
index 39cafb0..c7833a4 100644
--- a/lex.l
+++ b/lex.l
@@ -65,8 +65,7 @@ parse_data (int save);
 \t				;
 \n				;
 .				{ 
-				    fprintf (stderr, "%s: (%d) ignoring %c\n", 
-					     yyfilename, yyget_lineno (),
+				    fprintf (stderr, "%s: (%d) ignoring %c\n", yyfilename, yylineno,
 					     yytext[0]);
 				}
 %%
@@ -146,8 +145,7 @@ lex_date (cvs_number *n)
 	d = mktime (&tm);
 	if (d == 0) {
 	    int i;
-	    fprintf (stderr, "%s: (%d) unparsable date: ", yyfilename,
-		     yyget_lineno ());
+	    fprintf (stderr, "%s: (%d) unparsable date: ", yyfilename, yylineno);
 	    for (i = 0; i < n->c; i++) {
 		if (i) fprintf (stderr, ".");
 		fprintf (stderr, "%d", n->n[i]);
--21872808-714510296-1144039108=:3781--
