From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Sun, 25 Jun 2006 11:43:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606251138580.3747@g5.osdl.org>
References: <7v7j35wp84.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606251033030.3747@g5.osdl.org> <20060625210724.934617c4.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 20:43:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuZaE-0006uo-6S
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 20:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWFYSnm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 14:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWFYSnm
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 14:43:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751210AbWFYSnl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 14:43:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5PIhVnW013042
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 25 Jun 2006 11:43:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5PIhUr3007010;
	Sun, 25 Jun 2006 11:43:30 -0700
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060625210724.934617c4.tihirvon@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22644>



On Sun, 25 Jun 2006, Timo Hirvonen wrote:
> > 
> > I suspect that both could have been made to use NULL instead to indicate 
> > that no pointer exists.
> 
> I'll look into this.

An alternative is to really mark the char pointer structure members const. 
That is often the preferred thing to do, if usage allows it.

The biggest problem I've traditionally had with structure members that are 
"const char *" has ironically been that the standard C definition of 
"free()" is misdesigned. 

"free()" should take a "const volatile void *", not just a "void *". As it 
is, you often have to cast things to free() just to avoid the warning 
about discarding qualifiers. Which is really sad.

It's perfectly valid to do something like

	struct xyzzy {
		const char *member;
		..
	};

	s->member = strdup(string);
	..
	free(s->member);
	free(s)

but sadly, that member free generates a (bogus) warning.

Of course, we should probably do a "xfree()" anyway, to match our 
"x[c|re]alloc()".

			Linus
