From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/5] pretty describe: add %ds, %dn, %dd placeholders
Date: Sun, 4 Nov 2007 15:25:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711041518130.4362@racer.site>
References: <472DB1B0.1050904@lsrfire.ath.cx> <Pine.LNX.4.64.0711041356330.4362@racer.site>
 <472DDA3B.4090100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Nov 04 16:28:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IohOg-0008Nx-3o
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 16:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135AbXKDP1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 10:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756244AbXKDP1H
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 10:27:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:38381 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755643AbXKDP1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 10:27:06 -0500
Received: (qmail invoked by alias); 04 Nov 2007 15:27:04 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp002) with SMTP; 04 Nov 2007 16:27:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hfP9OR8khZLRAs9Hd5nP70/ipqaJ4/C/bPz43e0
	+h5wNnFvzbN+6s
X-X-Sender: gene099@racer.site
In-Reply-To: <472DDA3B.4090100@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63416>

Hi,

On Sun, 4 Nov 2007, Ren? Scharfe wrote:

> Johannes Schindelin schrieb:
> 
> > On Sun, 4 Nov 2007, Ren? Scharfe wrote:
> > 
> >> +	unsigned long occurs[ARRAY_SIZE(table)];
> > 
> > You do not ever use the counts.  So, longs are overkill.  Even ints 
> > might be overkill, but probably the most convenient.  I would have 
> > gone with chars.  If I knew how to memset() an array of unsigned:1 
> > entries to all zero, I would even have gone with that, but the runtime 
> > cost of this is probably higher than the chars.
> 
> Well, it isn't used in format_commit_message() currently, but it could 
> be.  Multiply the count and and the length of each substitution (minus 
> the length of the placeholder) and you get the number of bytes you need 
> to allocate.  interpolate() wouldn't need to be called twice anymore.

The better change, of course, would be to migrate interpolate() to strbuf.  
Then you do not have to play clever tricks anymore.

> > But the even more fundamental problem is that you count the needed 
> > interpolations _every_ single time you output a commit message.
> > 
> > A much better place would be get_commit_format().  Yes that means 
> > restructuring the code a bit more, but I would say that this definitely 
> > would help.  My preference would even be introducing a new source file for 
> > the user format handling (commit-format.[ch]).
> 
> Counting the interpolations is easier than actually interpolating. 
> Wherever the code goes, the calls to interpolate() and interp_count() 
> should stay together.

No.

The purpose of calling interp_count() is to know what placeholders have to 
be filled with substitutes.  As a consequence, the _logical_ thing to do 
is call interp_count() _once_.

It makes absolutely no sense to call the function over and over again, 
only to end up with the same result over and over again.

> >> +
> >> +/*
> >> + * interp_count - count occurences of placeholders
> >> + */
> >> +void interp_count(unsigned long *result, const char *orig,
> >> +                  const struct interp *interps, int ninterps)
> >> +{
> >> +	const char *src = orig;
> > 
> > You do not ever use orig again.  So why not just use that variable instead 
> > of introducing a new one?
> 
> I simply copied interpolate() and then chopped off the parts not needed
> for counting, to make it easy to see that this is the smaller brother.

It is not.  It does not do any substitution.  It is a pure helper for the 
process of filling the interpolation table.

> > I'd rewrite this whole loop as
> > 
> > 	while ((c = *(orig++)))
> > 		if (c == '%')
> > 			/* Try to match an interpolation string. */
> > 			for (i = 0; i < ninterps; i++)
> > 				if (prefixcmp(orig, interps[i].name)) {
> > 					result[i] = 1;
> > 					orig += strlen(interps[i].name);
> > 					break;
> > 				}
> 
> Cleanups are sure possible, but they should be done on top, and to both 
> interpolate() and interp_count().  Let's first see how far we get with 
> dumb code-copying and reusing the result in new ways. :)

Code copying is one of the primary sources for bad code.  Let's not even 
start.

IMHO there have to be _very_ good reasons to commit something that you 
plan to fix later anyway.

One such good reason would be that it is too hard to do in one go.  
Another good reason would be that you think the fix is not even needed 
(like I did when I wrote format: in the first place; I am quite surprised 
that after _that_ long a time people complain -- I'd have expected 
complaints right away or never).

In this case, I see no reason why we should go for suboptimal code first.

But hey, if you do not want to do it, I'll do it.  Just say so.

Ciao,
Dscho
