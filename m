From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mailsplit and mailinfo: gracefully handle NUL
 characters
Date: Sat, 17 May 2008 01:26:26 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805170120550.30431@racer>
References: <482BE5F7.2050108@thorn.ws>  <alpine.DEB.1.00.0805161139530.30431@racer>  <alpine.DEB.1.00.0805161148010.30431@racer>  <alpine.DEB.1.00.0805161403130.30431@racer>  <32541b130805160703r27a55b91xbad03eb1d107a176@mail.gmail.com> 
 <alpine.DEB.1.00.0805161529390.30431@racer> <32541b130805160756h5a8fc4d7x313f9bfde4760568@mail.gmail.com> <alpine.DEB.1.00.0805170058160.30431@racer> <482E2175.8030904@thorn.ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Tommy Thorn <tommy-git@thorn.ws>
X-From: git-owner@vger.kernel.org Sat May 17 02:27:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxAH3-0000hR-IQ
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 02:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760656AbYEQA0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 20:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756809AbYEQA0X
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 20:26:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:57067 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756516AbYEQA0W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 20:26:22 -0400
Received: (qmail invoked by alias); 17 May 2008 00:26:20 -0000
Received: from R2eb4.r.pppool.de (EHLO racer.local) [89.54.46.180]
  by mail.gmx.net (mp024) with SMTP; 17 May 2008 02:26:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18pY/ZU+3QpNz8mULyzzg0F9cP50cphb0Ltj6P81v
	k+W4rGjdl78cw+
X-X-Sender: gene099@racer
In-Reply-To: <482E2175.8030904@thorn.ws>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82327>

Hi,

On Fri, 16 May 2008, Tommy Thorn wrote:

> Johannes Schindelin wrote:
> > +/*
> > + *  This is an ugly hack to avoid fgetc(), which is slow, as it is locking.
> > + *  The argument "in" must be the same for all calls to this function!
> > + */
> > +static int fast_fgetc(FILE *in)
> > +{
> >   
> 
> Looks great to me, but shouldn't you add an "inline" for this one? Also, 
> maybe a double the buffer size.

No.  This is an ugly hack, and not meant for application.

If that is substantially faster than the fgetc() version (and I want this 
be tested in a _real-world_ scenario, i.e. not the fgetc() alone, but a 
real mailsplit and a real mailinfo on a huge patch, with all three 
versions: fgets(), fgetc() and fast_fgetc())), then I would prefer having 
something like

	struct line_reader {
		FILE *in;
		char buffer[4096];
		int offset, int len;
		char line[1024];
		int linelen;
	};

and corresponding functions to read lines in that setting.  Maybe it would 
even be better to have line be a strbuf, but I am not so sure on that.

Let's see what the tests show.  Would you do them, please?  
"git format-patch --stdout bla..blub | /usr/bin/time git mailsplit -o." 
three times in succession should give you a good hint on the runtime.

Ciao,
Dscho
