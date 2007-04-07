From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH] Optimized PowerPC SHA1 generation for Darwin (OS X)
Date: Fri, 6 Apr 2007 18:40:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704061830350.6730@woody.linux-foundation.org>
References: <20070406234826.GG3854@regex.yaph.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Sat Apr 07 04:05:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZzvP-0005uA-7z
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 03:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbXDGBk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 21:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbXDGBk4
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 21:40:56 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42109 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964893AbXDGBkz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 21:40:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l371esPD026580
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 Apr 2007 18:40:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l371ertC025015;
	Fri, 6 Apr 2007 18:40:53 -0700
In-Reply-To: <20070406234826.GG3854@regex.yaph.org>
X-Spam-Status: No, hits=-3.954 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43953>



On Sat, 7 Apr 2007, Arjen Laarhoven wrote:
>
> The compiler toolchain supplied by Apple's Xcode environment has an old
> version (1.38) of the GNU assembler.  It cannot assemble the optimized
> ppc/sha1ppc.S file.  ppc/sha1ppc.S was rewritten into a Perl script
> which outputs the same code, but valid for the Xcode assembler.

Ugh. That's just too ugly.

The Linux version of the GNU assembler can certainly take the same limited 
input as the old Apple one. 

So how about instea dof having two totally different versions of this 
file, just having *one*, and having a pre-processor that turns it into 
something that is acceptable to both?

And yes, it could be your perl script, except your perl script is ugly as 
*hell*. The old C preprocessor code is much nicer than your perl script 
that does "print" statements.

How about something like the following instead?

 (a) make the register macros expand to something easily 
     greppable/parseable
 (b) have a *separate* preprocessor phase that actually then takes that 
     pattern, and evaluates it to a numeric value.
 (c) assemble the end result

The (a) part is trivial. Just a patch like the appended will make sure 
that all the registers are now written as "REG[int-expression]", and then 
all you need is a perl-script or something that can trigger on the regexp

	"REG\[\([^]]*\)\]"

and replace that regex with

	"%eval(\1)"

which is somethign that perl should be designed for.

That way you just have *one* source file (the "sha1ppc.S" one), which is 
readable, and a simple script to then evaluate the register numbers 
statically instead of expecting that the assembler can do it (since the 
Apple one apparently cannot).

So it would just require somebody who knows perl. What's a one-liner perl 
script to turn a line like

	add REG[((0)+0)%5+6],REG[((0)+0)%5+6],REG[(0)%16+11];

into

	add %6,%6,%11

(ie it just evaluated the expression inside the [] things, and replaced it 
with the "%<num>" string)?

<Taunting mode>Or maybe perl can't do that in a single line!</Taunting mode>

		Linus

---
diff --git a/ppc/sha1ppc.S b/ppc/sha1ppc.S
index f132696..cc554a4 100644
--- a/ppc/sha1ppc.S
+++ b/ppc/sha1ppc.S
@@ -32,14 +32,14 @@
  * We use registers 6 - 10 for this.  (Registers 27 - 31 hold
  * the previous values.)
  */
-#define RA(t)	(((t)+4)%5+6)
-#define RB(t)	(((t)+3)%5+6)
-#define RC(t)	(((t)+2)%5+6)
-#define RD(t)	(((t)+1)%5+6)
-#define RE(t)	(((t)+0)%5+6)
+#define RA(t)	REG[((t)+4)%5+6]
+#define RB(t)	REG[((t)+3)%5+6]
+#define RC(t)	REG[((t)+2)%5+6]
+#define RD(t)	REG[((t)+1)%5+6]
+#define RE(t)	REG[((t)+0)%5+6]
 
 /* We use registers 11 - 26 for the W values */
-#define W(t)	((t)%16+11)
+#define W(t)	REG[(t)%16+11]
 
 /* Register 5 is used for the constant k */
 
