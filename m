From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Per-path attribute based hunk header selection.
Date: Sat, 7 Jul 2007 13:17:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707071317060.4093@racer.site>
References: <7v8x9tdlbv.fsf@assigned-by-dhcp.cox.net>
 <200707071011.l67AB9rg005792@mi0.bluebottle.com> <7vabu88qem.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-144041899-1183810566=:4093"
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 14:24:31 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I79Ku-0003US-Bu
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 14:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbXGGMYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 08:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652AbXGGMYY
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 08:24:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:58462 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753355AbXGGMYX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 08:24:23 -0400
Received: (qmail invoked by alias); 07 Jul 2007 12:24:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 07 Jul 2007 14:24:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+ZalmGMp+2ddYXvPWFaJviVulnMKJ4eP43GbHnw
	IcHqODS7ntPsty
X-X-Sender: gene099@racer.site
In-Reply-To: <7vabu88qem.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51813>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-144041899-1183810566=:4093
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 7 Jul 2007, Junio C Hamano wrote:

> しらいしななこ  <nanako3@bluebottle.com> writes:
> 
> > I would love to see "diff=tex" attribute to work on my manuscripts, 
> > [...]
> > It does not work well, however.  It shows only part of lines.
> >
> > 	@@ -8,7 +8,8 @@ \section{
> > 	@@ -224,7 +225,7 @@ sub
> > 	@@ -240,7 +241,7 @@ subsub
> >
> > I have no idea what am I doing wrong (truthfully, I do not know what I 
> > am doing, period).

Those are regular expressions. Read more about them here:

	http://en.wikipedia.org/wiki/Regular_expression

> > +	if (!strcmp(ident, "tex"))
> > +		return "^\\\\\\(sub\\)*section{";

It is always easier, and will never require C skills, to put this into the 
config. With Junio's current version:

	echo '*.tex funcname=tex' >> .gitattributes
	echo '[funcname] tex = ^\(\\\(sub\)*section{.*\)' >> .git/config

The problem is of course that the backslashes have to be escaped _both_ in 
C and in regexps.

You could write that much simpler, though:

	\\[a-z]*section.*

It would work the same, in practice, because if something like 
\supercoolsection is defined, you are likely wanting to match that, too.

> Johannes, it strikes me that it is very odd having to add ".*$" at the 
> end and to surround the whole thing in a parentheses. Shouldn't the 
> ff_regexp() grabber simply pick the whole line? After all, that is what 
> GNU "diff -p -F RE" does.

Yes, but then you can forget about your hierarchical idea.

Or maybe not, since I am still awaiting a sane syntax for that, which 
would probably have to solve just one more problem.

Here is a patch for the rest of the line thing:

diff --git a/xdiff-interface.c b/xdiff-interface.c
index be866d1..9503dfb 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -156,7 +156,7 @@ static long ff_regexp(const char *line, long len,
 	}
 	i = pmatch[1].rm_so >= 0 ? 1 : 0;
 	line += pmatch[i].rm_so;
-	result = pmatch[i].rm_eo - pmatch[i].rm_so;
+	result = (int)len - pmatch[i].rm_so;
 	if (result > buffer_size)
 		result = buffer_size;
 	else

> Also this makes me realize that not all contents in the world are not 
> programming language source files, and "funcname" is a misnomer.  For 
> this one, however, we _can_ blame GNU diff, as they call this 
> --show-function-line option ;-)

Okay.

How about sorting out the other technical issues first 
(diff.<type>.funcname instead of funcname.<type>), leaving the names 
alone, and then rename the remaining references of funcname to hunkheader?

Ciao,
Dscho

--8323584-144041899-1183810566=:4093--
