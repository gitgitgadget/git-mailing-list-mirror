From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 14:33:58 -0400
Message-ID: <20080623183358.GA28941@sigill.intra.peff.net>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 20:35:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAqsT-0001ju-6q
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 20:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbYFWSeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 14:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755136AbYFWSeB
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 14:34:01 -0400
Received: from peff.net ([208.65.91.99]:1646 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755019AbYFWSeA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 14:34:00 -0400
Received: (qmail 28161 invoked by uid 111); 23 Jun 2008 18:33:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 23 Jun 2008 14:33:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2008 14:33:58 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85899>

On Mon, Jun 23, 2008 at 11:20:46AM -0700, Linus Torvalds wrote:

> Actually, I guess "--default" does, but if you try to mix that up with (a) 
> a default head that starts with a dash and (b) git-blame, you're doing 
> something pretty odd.

Yes, and I think that is why "in practice" this works with git-blame.

> And yes, "-n" does too, but if you pass it negative numbers you get what 
> you deserve.

It's worse than that. We assume by default that the option has no
argument, so the argument becomes a non-option parameter to the original
command. Try (with current git-blame, but I think your patch doesn't
change this):

  $ git blame -n 1 git.c
  fatal: bad revision '1'

  $ git blame --default HEAD git.c
  fatal: cannot stat path HEAD: No such file or directory

Oops. Now again, as it happens, git-blame seems to ignore "-n" entirely
(though I would have expected it to limit the depth of the blame
traversal), so maybe people shouldn't be using it.

> The point being, we really _do_ have a real-life existing case for 
> PARSE_OPT_CONTINUE_ON_UNKNOWN, which is hard to handle any other way. 
> Currently you can literally do
> 
> 	git blame --since=April -b Makefile
> 
> and while it's a totally made-up example, it's one I've picked to show 
> exactly what does *not* work with my patch that started this whole thread.
> 
> And guess what you need to fix it?
> 
> If you guessed PARSE_OPT_CONTINUE_ON_UNKNOWN, you win a prize. 

I guessed "to convert the revision and diff options to a format that
parse_options understands, so we can add them as appropriate to the
options tables of the various commands." Do I win anything?

-Peff
