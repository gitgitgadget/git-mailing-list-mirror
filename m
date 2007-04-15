From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Correct dir.c to compile on Solaris 9
Date: Sun, 15 Apr 2007 23:03:12 +0200
Message-ID: <200704152303.12435.Josef.Weidendorfer@gmx.de>
References: <20070415043328.GA17285@spearce.org> <Pine.LNX.4.64.0704151824240.18846@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 15 23:03:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdBsV-0002GW-Vc
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 23:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbXDOVDR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 17:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753957AbXDOVDR
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 17:03:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:43557 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753955AbXDOVDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 17:03:16 -0400
Received: (qmail invoked by alias); 15 Apr 2007 21:03:14 -0000
Received: from p54969526.dip0.t-ipconnect.de (EHLO noname) [84.150.149.38]
  by mail.gmx.net (mp047) with SMTP; 15 Apr 2007 23:03:14 +0200
X-Authenticated: #352111
X-Provags-ID: V01U2FsdGVkX19BnUd3mVtBcfaab9qIWQY7Aigq8uX/5YAbZyK1LQ
	4R8TKGsu+I/tls
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0704151824240.18846@racer.site>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44526>

On Sunday 15 April 2007, Johannes Schindelin wrote:
> On Sun, 15 Apr 2007, Shawn O. Pearce wrote:
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
> > +		switch (c) {
> > +		case 0: case '?':
> > +		case '\\': case '*':
> > +		case '[':
> >  			return len;
> > +		}
> >  	}
> >  }
> 
> You are replacing a table-based check with a switch based, which might be 
> substantially slower (depends on how often cmp_name() is called).

Or faster. When the table gives a cache miss and has to be
loaded from main memory, I am quite sure that 5 compares in a row are
faster than the cache miss.

Actually, with the switch, the compiler is free to implement it with a
table (and gcc usually does this, probably even using a substantially
smaller table). The table-based check in contrast looks
like some kind of micro-optimization which makes the code IMHO more
difficult to read, and which only would be justified with meassured
improvements.

Josef
