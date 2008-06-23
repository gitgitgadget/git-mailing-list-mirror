From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 18:04:48 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806231756340.6440@racer>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 19:08:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KApWB-0003Mj-HX
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 19:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbYFWRGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 13:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754562AbYFWRGy
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 13:06:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:44656 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753077AbYFWRGx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 13:06:53 -0400
Received: (qmail invoked by alias); 23 Jun 2008 17:06:51 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp030) with SMTP; 23 Jun 2008 19:06:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+GruEORpKGQtvczVd/FUDpwTXTMSjZCcEh5ObKhp
	Pjk9QeLbzZzwsZ
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85886>

Hi,

On Mon, 23 Jun 2008, Linus Torvalds wrote:

> On Mon, 23 Jun 2008, Johannes Schindelin wrote:
> > 
> > Thinking about the recursive approach again, I came up with this POC:
> 
> "recursive" is pointless.

Nope, it is not.

To keep things _simple_ a callback is not good.  Sure, you can work around 
the limitations of callbacks for aggregation, but the code change looks 
horrible.  And the same holds true for the help message.

Just compare that to the recursive approach.

Okay, now for the "granted, your approach has merits" part.

> Look at cmd_apply() in builtin-apply.c. Notice how it currently 
> absolutely CANNOT sanely be turned into using "parse_options()", not 
> because it needs any "recursive" handling, but simply because it wants 
> to do *incremental* handling.

That is a totally independent issue from the one I discussed, namely sane 
handling of the diff (and rev) options.

> 	for (;;) {
> 		const char *arg;
> 		argc = parse_options(argc, argv,
> 			options, usage, PARSE_OPT_STOP_AT_UNKNOWN);

We do have PARSE_OPT_STOP_AT_NON_OPTION since a0ec9d25(parseopt: add flag 
to stop on first non option), which tries to solve a _similar_ problem, 
and it should be not hard at all to get PARSE_OPT_STOP_AT_UNKNOWN without 
changing the loop as you suggested.

Heck, we could just as easily introduce PARSE_OPT_IGNORE_UNKNOWN.

> Could you handle the "recursive" use of parse_options() in builtin-blame.c 
> by teaching it about recursion? Yes. But again, it's just _simpler_ to 
> just teach parse_options() to parse the things it knows about, and leave 
> the other things in place.

And here I disagree.  You might not need a nice "--help" output, but most 
mortals do.  And this is not easy with your approach.

In contrast, by using my approach of having an option_table for a bundle 
of common options, which just set variables in a certain struct, you can 
have a relatively painless migration, and you get all the benefits of 
parse-options.

But I guess the approach of whoever has more time to work on it will 
win... ;-)

Ciao,
Dscho
