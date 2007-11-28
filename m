From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not generate full commit log message if it not going
 to be used
Date: Wed, 28 Nov 2007 21:43:12 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711282140470.27959@racer.site>
References: <81b0412b0711270254i58be4d2fi5021767d99fcb753@mail.gmail.com>
 <474C0105.3010908@viscovery.net> <81b0412b0711270448s6534a849u86bcb161d4d7b3fe@mail.gmail.com>
 <7vfxyrd2x2.fsf@gitster.siamese.dyndns.org>
 <81b0412b0711271018m6419b076n269a0175494fac84@mail.gmail.com>
 <20071127214425.GA3156@steel.home> <Pine.LNX.4.64.0711281211130.27959@racer.site>
 <20071128211059.GA3173@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Kristian =?iso-8859-15?Q?H=F8gsberg?= <krh@redhat.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 22:43:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxUh4-0004Xu-LC
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 22:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079AbXK1VnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 16:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754357AbXK1VnX
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 16:43:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:55488 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754725AbXK1VnW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 16:43:22 -0500
Received: (qmail invoked by alias); 28 Nov 2007 21:43:19 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 28 Nov 2007 22:43:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/kvulLgprkmvIhBXj71N1s83Ok2DoOv1jh8t1V7B
	jJtIHN9TwGK6Qz
X-X-Sender: gene099@racer.site
In-Reply-To: <20071128211059.GA3173@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66429>

Hi,

On Wed, 28 Nov 2007, Alex Riesen wrote:

> Johannes Schindelin, Wed, Nov 28, 2007 13:18:10 +0100:
> > On Tue, 27 Nov 2007, Alex Riesen wrote:
> > 
> > > Could not stop myself. Hopefully didn't beat anyone to it :)
> > > Almost all code shamelessly stolen from builtin-diff-index.c.
> > 
> > Then I have to wonder if it would not be a better idea to refactor the 
> > code, so that other people do not have to steal the code again, but are 
> > able to reuse it ;-)
> 
> Not sure it will be worth the effort. It is really short.

Okay.

> > > Preprocessor trickery in DIFF_OPT_* macros is disgusting, it breaks Vim 
> > > word completion and trying to use many flags in one expression looks 
> > > just ugly.
> > 
> > How does it break Vim word completion?  And why should something like
> > 
> > 		DIFF_OPT_SET(&rev.diffopt, QUIET | EXIT_WITH_STATUS);
> > 
> > look ugly?  I find it highly readable.
> 
> Oh, this would look ok. It just wont compile: DIFF_OPT_SET prepends
> second argument with DIFF_OPT_:
> 
> #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
> #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
> #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)

Ouch.  Sorry for suggesting it when I clearly had no clue.

> > > +	if (no_edit) {
> > > +		static const char *argv[] = { NULL, "HEAD", NULL };
> > > +		struct rev_info rev;
> > > +		unsigned char sha1[40];
> > > +		int is_initial;
> > > +
> > > +		fclose(fp);
> > > +
> > > +		if (!active_nr && read_cache() < 0)
> > > +			die("Cannot read index");
> > > +
> > > +		if (get_sha1("HEAD", sha1) != 0)
> > > +			return !!active_nr;
> > 
> > Don't want to be anal here, but are there possibly reasons (read "possible 
> > errors") other than an empty repo where this triggers?
> 
> Definitely. I just don't know. OTOH, I can only return "committable" or 
> "not committable".

I guess it is good enough.  Just wanted to point out that this can fail if 
.git/HEAD is not readable.

> > Besides, would this not be more elegant as
> > 
> > 		setup_revisions(0, NULL, &rev, "HEAD");
> 
> Hmm... And I was so puzzled as to what that "def" argument could
> possibly mean... Still am, in fact. But it works.

It is the mechanism which makes "git log" default to "git log HEAD".

> > Other than that (including my remark about refactoring that piece of 
> > code), I like it.
> 
> Me too: I have *extensively* tested it today and a commit on the
> 2.6GHz/2Gb/SATA windows machine is almost as fast as on my linux
> laptop now (Centrino/1.2GHz downclocked to 800MHz/384Mb/IDE).

Yes, I suspected something like this would happen.

Ciao,
Dscho
