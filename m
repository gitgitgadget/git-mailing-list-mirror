From: Jeff King <peff@peff.net>
Subject: Re: Apostrophe at the end of author name
Date: Fri, 29 Jun 2012 14:29:44 -0400
Message-ID: <20120629182944.GA20346@sigill.intra.peff.net>
References: <20120629124122.GG1258@camk.edu.pl>
 <robbat2-20120629T170457-788694600Z@orbis-terrarum.net>
 <20120629174358.GB3804@sigill.intra.peff.net>
 <20120629181701.GB6533@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Fri Jun 29 20:30:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkfxY-0006Hn-FR
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 20:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030Ab2F2SaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 14:30:01 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:49533
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755945Ab2F2S3r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 14:29:47 -0400
Received: (qmail 14891 invoked by uid 107); 29 Jun 2012 18:29:52 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Jun 2012 14:29:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jun 2012 14:29:44 -0400
Content-Disposition: inline
In-Reply-To: <20120629181701.GB6533@camk.edu.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200823>

On Fri, Jun 29, 2012 at 08:17:01PM +0200, Kacper Kornet wrote:

> >  as strbuf_addstr_without_crud was
> > only added recently (but it is a refactoring of older code which should
> > have the same behavior).
> 
> It depends what you call recently. It was refactored in July 2005
> (commit: 6aa33f4035d5). But it looks like the previous code (before
> refactoring) removed only comma, dot and semicolon from the end of the
> author name.

I meant the name strbuf_addstr_without_crud did not exist until I added
it in c96f0c8, about a month ago. But yes, the functionality of the code
has been there since the very early days.

I'm tempting by the patch below, which would remove only the
syntactically significant meta-characters ("\n", "<", and ">"), as well
as trimming any stray whitespace at the edges. The problem is that we
don't really have a clue how many people were relying on this trimming
to clean up their names or emails, so there may be regressions for other
people.

diff --git a/ident.c b/ident.c
index 443c075..4552f8d 100644
--- a/ident.c
+++ b/ident.c
@@ -127,15 +127,8 @@ const char *ident_default_date(void)
 static int crud(unsigned char c)
 {
 	return  c <= 32  ||
-		c == '.' ||
-		c == ',' ||
-		c == ':' ||
-		c == ';' ||
 		c == '<' ||
-		c == '>' ||
-		c == '"' ||
-		c == '\\' ||
-		c == '\'';
+		c == '>';
 }
 
 /*
