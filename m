From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mailsplit and mailinfo: gracefully handle NUL
 characters
Date: Fri, 16 May 2008 15:29:26 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805161526120.30431@racer>
References: <482BE5F7.2050108@thorn.ws>  <alpine.DEB.1.00.0805161148010.30431@racer>  <alpine.DEB.1.00.0805161403130.30431@racer>  <200805161539.29259.brian.foster@innova-card.com> <a537dd660805160707y3830b164td0605a15e6ae05a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-629829389-1210948167=:30431"
Cc: Tommy Thorn <tommy-git@thorn.ws>, git@vger.kernel.org
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Fri May 16 16:31:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx0wm-0003uS-Le
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 16:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbYEPO3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 10:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbYEPO3W
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 10:29:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:41316 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750906AbYEPO3V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 10:29:21 -0400
Received: (qmail invoked by alias); 16 May 2008 14:29:20 -0000
Received: from R4f5c.r.pppool.de (EHLO racer.local) [89.54.79.92]
  by mail.gmx.net (mp044) with SMTP; 16 May 2008 16:29:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/JaadeHzfJfVzQaPNOzFmNYWibS92WDnUhAL+cJR
	ERh7Rhe4N61ofc
X-X-Sender: gene099@racer
In-Reply-To: <a537dd660805160707y3830b164td0605a15e6ae05a5@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82296>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-629829389-1210948167=:30431
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 16 May 2008, Brian Foster wrote:

> Johannes Schindelin suggested:
> > The function fgets() has a big problem with NUL characters: it reads
> > them, but nobody will know if the NUL comes from the file stream, or
> > was appended at the end of the line.
> >
> > So implement a custom read_line() function.
>                         ^^^^^^^^^^^
>                         read_line_with_nul()
> meaning read part or all of one line which may contain NULs.

Right.

> >[ ... ]
> > diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
> > index 46b27cd..021dc16 100644
> > --- a/builtin-mailsplit.c
> > +++ b/builtin-mailsplit.c
> > @@ -45,6 +45,25 @@ static int is_from_line(const char *line, int len)
> >  /* Could be as small as 64, enough to hold a Unix "From " line. */
> >  static char buf[4096];
> >
> > +/* We cannot use fgets() because our lines can contain NULs */
> > +int read_line_with_nul(char *buf, int size, FILE *in)
> > +{
> > +     int len = 0, c;
> > +
> > +     for (;;) {
> > +             c = fgetc(in);
> > +             buf[len++] = c;
> > +             if (c == EOF || c == '\n' || len + 1 >= size)
> > +                     break;
> > +     }
> > +
> > +     if (c == EOF)
> > +             len--;
> > +     buf[len] = '\0';
> > +
> > +     return len;
> 
>  when fgetc(3) — why not use getc(3)? -

Because mailsplit can read from a file, too.

>  returns EOF it is pointlessly stored in buf[] (as a 'char'!), len's 
>  advanced, and then the storage and advancing are undone.  isn't that a 
>  bit silly?

I left it at that, because it is a rare case, the buffer has to be 
accessed with the trailing NUL anyway, and I think it is worth to have 
this function quite readable.  I, for one, am pretty certain that I 
understand what this function does, and how, in 6 months from now, without 
any additional documentation.

>  untested:
> 
> 	assert(2 <= size);
> 	do {
> 		if ((c = getc(in)) == EOF)
> 			break;
> 	} while (((buf[len++] = c) != '\n' && len+1 < size);
> 	buf[len] = '\0'
> 
> 	return len;

... except this is unreadable at best ;-)

>  I'd tend to write this in terms of pointers,
>  something along the lines (untested):
> 
> 	char	*p, *endp;
> 
> 	assert(1 <= size);
> 	p    = buf;
> 	endp = p + (size-1);
> 	while (p < endp) {
> 		if ((c = getc(in)) == EOF || (*p++ = c) == '\n')
> 			break;
> 	}
> 	*p = '\0';
> 
> 	return p - buf;

Again, I think this is too cuddled.  You have to think about every second 
line, and that makes for stupid mistakes with this developer.

Ciao,
Dscho

--8323329-629829389-1210948167=:30431--
