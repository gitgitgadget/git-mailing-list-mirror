From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a simple getpass() for MinGW
Date: Fri, 10 Apr 2009 20:03:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904102001340.10279@pacific.mpi-cbg.de>
References: <cover.1239154140u.git.johannes.schindelin@gmx.de> <7ba615a300fe2742e8d32f0313c6ee9a1a1aaed3.1239154140u.git.johannes.schindelin@gmx.de> <49DE5120.8050904@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 10 20:02:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsL3M-0000CV-Ch
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 20:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765771AbZDJSAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 14:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763771AbZDJSAe
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 14:00:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:55118 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751218AbZDJSAd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 14:00:33 -0400
Received: (qmail invoked by alias); 10 Apr 2009 18:00:28 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 10 Apr 2009 20:00:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kRVQGSz8kDcrfBVxzX4yfMLyUyEgT88Ys9/nmiP
	jKm8sDrXGfzYma
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49DE5120.8050904@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116268>

Hi,

On Thu, 9 Apr 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > This should be replaced with a graphical getpass() at some stage.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > 
> >  I saw it coming that I had to do this.
> 
> There are two callers of getpass: One is in imap-send.c, but we don't 
> build it on Windows. The other is in http.c. But notice that this is 
> only built if NO_CURL is not defined, yet, upstream git defines it in 
> the MinGW section, and so this patch alone is not needed in upstream 
> git.
> 
> I see you have removed NO_CURL = YesPlease in 4msysgit.git. You should 
> make it a part of a series that removes NO_CURL = YesPlease from the 
> MinGW section.

Indeed we did, as we ship curl, and we rely on http:// protocol being 
available in the netinstaller.

> >  compat/mingw.c |   15 +++++++++++++++
> >  1 files changed, 15 insertions(+), 0 deletions(-)
> > 
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index d50186e..2ab5bbe 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -1157,3 +1157,18 @@ int link(const char *oldpath, const char *newpath)
> >   }
> >   return 0;
> > }
> > +
> > +char *getpass(const char *prompt)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +
> > +	fputs(prompt, stderr);
> > +	for (;;) {
> > +		char c = _getch();
> > +		if (c == '\r' || c == '\n')
> > +			break;
> > +		strbuf_addch(&buf, c);
> > +	}
> > +	fputs("\n", stderr);
> > +	return strbuf_detach(&buf, NULL);
> > +}
> 
> Where do the callers get the prototype from (on MinGW)? Usually, we have to
> have a corresponding function declaration in compat/mingw.h for functions that
> are missing on Windows.
> 
> From http://opengroup.org/onlinepubs/007908775/xsh/getpass.html:
> 
>   The return value points to static data whose content may be overwritten
>   by each call.
> 
> I'm not saying that you should use a fixed-size static character array, but
> only that you should not leak memory on each call ;) (But not even that is
> very important; I'm just summarizing the research I did because I was
> wondering what would happen to the returned buffer.)

Good catch!

Will fix.

> Apart from that, the implementation looks good. (_getch(), according to 
> the docs on MSDN, doesn't echo the input.)

I'll probably add handling for ^H (as I need it very often ;-), but not 
for ^W (overkill).

Ciao,
Dscho
