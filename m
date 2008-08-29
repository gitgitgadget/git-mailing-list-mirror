From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] dir.c: avoid c99 array initialization
Date: Fri, 29 Aug 2008 13:08:13 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808291306420.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil> <G-ipWASixyGW7nvO1KquifehvBB7FNKwjPtIB0ukyEJ1Si1CJWM34w@cipher.nrlssc.navy.mil> <81b0412b0808281301m29830c20l3e16432ea8aef45d@mail.gmail.com>
 <20080828201657.GH21072@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, davidk@lysator.liu.se,
	Andreas Ericsson <ae@op5.se>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 13:08:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ1pk-0005rq-93
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 13:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbYH2LGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 07:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbYH2LGx
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 07:06:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:39331 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752751AbYH2LGw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 07:06:52 -0400
Received: (qmail invoked by alias); 29 Aug 2008 11:03:03 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 29 Aug 2008 13:03:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196FCApshd6wKmIm0W/bcyvt3J8rHV1J1arIc+xwS
	qbOv5QgXRxGS3L
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080828201657.GH21072@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 28 Aug 2008, Shawn O. Pearce wrote:

> Alex Riesen <raa.lkml@gmail.com> wrote:
> > 
> > For just these 5 values it is likely more effective to just use
> > a conditional statement (less stack requested, less likely
> > some stupid compiler tries to optimize it wrongly).
> > And just as readable.
> > 
> > diff --git a/dir.c b/dir.c
> > index 92452eb..1cf5985 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -680,17 +680,12 @@ static int cmp_name(const void *p1, const void *p2)
> >   */
> >  static int simple_length(const char *match)
> >  {
> > -	const char special[256] = {
> > -		[0] = 1, ['?'] = 1,
> > -		['\\'] = 1, ['*'] = 1,
> > -		['['] = 1
> > -	};
> >  	int len = -1;
> > 
> >  	for (;;) {
> >  		unsigned char c = *match++;
> >  		len++;
> > -		if (special[c])
> > +		if (!c || '?' == c || '\\' == c || '*' == c || '[' == c)
> 
> I am reminded of a year old thread with my patch to this:
> 
>   http://kerneltrap.org/mailarchive/git/2007/4/15/243541
> 
> The patch never applied.  I wonder why.  Was it just Dscho's comment?

If it was, I am very sorry.

But I still think that a lookup for something that is called potentially a 
million times per second is better than a switch statement (except when 
there are less than, say, 4 cases).

Ciao,
Dscho
