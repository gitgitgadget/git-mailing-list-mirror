From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Mon, 9 Jul 2007 14:16:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707091409480.5546@racer.site>
References: <11839118073186-git-send-email-skimo@liacs.nl>
 <1183911808787-git-send-email-skimo@liacs.nl> <Pine.LNX.4.64.0707090011070.4248@racer.site>
 <20070709123626.GC23494@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: skimo@liacs.nl, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 09 15:24:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7tEE-0007HH-Ro
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 15:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbXGINX6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 09:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754038AbXGINX6
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 09:23:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:52923 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754077AbXGINX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 09:23:56 -0400
Received: (qmail invoked by alias); 09 Jul 2007 13:23:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 09 Jul 2007 15:23:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194TfZbBpB4PQskTEh/2re44eavC7jy/mXSDrDPgD
	Xe75z9UqAhrJrC
X-X-Sender: gene099@racer.site
In-Reply-To: <20070709123626.GC23494@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51991>

Hi,

On Mon, 9 Jul 2007, Jeff King wrote:

> On Mon, Jul 09, 2007 at 12:56:04AM +0100, Johannes Schindelin wrote:
> 
> > But hey, maybe it _is_ time to rethink the whole filter business, and 
> > introduce some kind of regular expression based action language. Something 
> > like
> > 
> > 	git rewrite-commits -e '/^author Darl McBribe/skip-commit' \
> > 		-e 'substitute/^author Joahnnes/author Johannes/header' \
> > 		-e 'substitute/poreclain/porcelain/body' \
> > 		-e 'rewrite-commit-names'
> 
> This is starting to look an awful lot like sed.

Yep.  Fully intended.

> Which is good, but I wonder if we can get sed to do the heavy lifting. I 
> have had success with similar systems by writing the data structure out 
> into a canonical format, editing it as text, and then "applying" the 
> result.
> 
> Something like:
>   git rewrite-generate oldbranch |
>     sed 's/^author Darl McBribe/skip-commit/'
>     sed 's/^author Joahnnes/author Johannes/' |
>     git-rewrite-commit-names |
>     git rewrite-apply newbranch
> 
> where git-rewrite-generate would generate something like git-log output,
> and git-rewrite-apply would, given a log-ish input, write a new history
> branch. A nice advantage is that it makes things like this very natural:
>   git rewrite-generate oldbranch >history
>   vi history
>   git rewrite-apply newbranch <history
> 
> which allows interactive editing.

Granted.  It is a really nice idea, but again you lack the map function.

> Of course, this is:
>   - possibly inefficient, since rewrite-apply doesn't know what you
>     changed and what you didn't change; it would have to recalculate
>     a lot of sha1 hashes.
>   - doesn't really deal with actual tree rewriting, unless there is some
>     canonical text format for that, and then we are talking about making
>     things _really_ inefficient
> 
> Hmm. Which makes me think that maybe 'git-format-patch' is really
> git-rewrite-generate, and 'git-am' is really git-rewrite-apply (but with
> some extensions to preserve committer info).

Of course, you miss out the merge commits.

> So maybe a bad idea, but I thought I would throw it out there.

Not so bad.  What you describe as possibly inefficient has been 
implemented very, very efficiently already: git-fast-import!

So your idea brings me to another idea: Why not write git-fast-export?  
Actually, let's not all it that, since repo.or.cz has that name already 
(curiously enough, it is used for scripts exporting from _other_ SCMs, 
feeding to git-fast-import...), but git-fast-dump.

The output should be _exactly_ as expected by git-fast-import, so that 
"git fast-dump | git fast-import" would be a nop, data-wise.

Of course, there is a more fundamental problem with that approach: how to 
act on the commit message, conditional on the commit header?  I know, with 
perl it would be really easy.  But then you have to write a complete perl 
script, and the whole purpose of this 
admin-rewritehist/filter-branch/rewrite-commits frackass is that it should 
be _easy_ to use.

Ciao,
Dscho
