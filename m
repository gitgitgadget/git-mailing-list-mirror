From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 15:53:14 -0400
Message-ID: <20080623195314.GA29569@sigill.intra.peff.net>
References: <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 21:54:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAs7B-0003xY-QQ
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 21:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757548AbYFWTxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 15:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755101AbYFWTxR
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 15:53:17 -0400
Received: from peff.net ([208.65.91.99]:2311 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754865AbYFWTxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 15:53:16 -0400
Received: (qmail 28701 invoked by uid 111); 23 Jun 2008 19:53:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 23 Jun 2008 15:53:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2008 15:53:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85909>

On Mon, Jun 23, 2008 at 11:47:49AM -0700, Linus Torvalds wrote:

> >   $ git blame --default HEAD git.c
> >   fatal: cannot stat path HEAD: No such file or directory
> > 
> > Oops.
> 
> Oops. And then, how would you fix this most easily?
> 
> Be honest now.

Your statement is obviously loaded. I haven't seen _anything_ that fixes
it except what I have already mentioned. But I'm sure you are going to
complain that it isn't easy enough.

> Example: many arguments cause multiple option variables to change. 
> parse_options() simply can't handle that well - you can do it with a 
> callback, but then you need to make the option variables global or make 
> them a structure or something. All of which just makes it nasty to do 
> partial conversions for the simple cases.

I'm not so sure. I assumed that most of the callbacks would simply take
a "struct rev_list". So you would end up in builtin-blame.c with:

  ...
  OPT__REVISION(&my_rev_list),
  ...

in your options table. And if setup_revisions takes options that affect
things that _aren't_ in that struct, then they probably ought to be.

> And I guarantee that just adding PARSE_OPT_{CONTINUE|STOP}_ON_UNKNOWN is 
> going to be the smallest patch, and make for the easiest usage case. It 
> may not be "pretty", but I can whip up a patch in five minutes.

I don't have a problem with STOP_ON_UNKNOWN, as I think it is a building
block upon which sane things can be done (like linearly going through
each parser and saying "did you want this?"). I think IGNORE/CONTINUE
has a fundamental flaw.

> Or are we going to sit around discussing this for another five months?

Please! :)

Pierre was working on the approach I mentioned, but I think he is short
on time. I will take a look at the conversion, but I have a few other
fixes on my plate first.

In the meantime, I don't think your patch makes anything _worse_, since
we already have these sorts of bugs in the current parsing code.

-Peff
