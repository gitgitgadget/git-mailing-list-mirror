From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Mon, 9 Jul 2007 08:36:27 -0400
Message-ID: <20070709123626.GC23494@sigill.intra.peff.net>
References: <11839118073186-git-send-email-skimo@liacs.nl> <1183911808787-git-send-email-skimo@liacs.nl> <Pine.LNX.4.64.0707090011070.4248@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 14:36:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7sTe-0005jj-Ri
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 14:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbXGIMg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 08:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbXGIMg2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 08:36:28 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4989 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905AbXGIMg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 08:36:27 -0400
Received: (qmail 10089 invoked from network); 9 Jul 2007 12:36:51 -0000
Received: from unknown (HELO sigill.intra.peff.net) (71.63.4.50)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP
  (cert postmaster@peff.net); 9 Jul 2007 12:36:51 -0000
Received: (qmail 31336 invoked by uid 1000); 9 Jul 2007 12:36:27 -0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707090011070.4248@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51986>

On Mon, Jul 09, 2007 at 12:56:04AM +0100, Johannes Schindelin wrote:

> But hey, maybe it _is_ time to rethink the whole filter business, and 
> introduce some kind of regular expression based action language. Something 
> like
> 
> 	git rewrite-commits -e '/^author Darl McBribe/skip-commit' \
> 		-e 'substitute/^author Joahnnes/author Johannes/header' \
> 		-e 'substitute/poreclain/porcelain/body' \
> 		-e 'rewrite-commit-names'

This is starting to look an awful lot like sed. Which is good, but I
wonder if we can get sed to do the heavy lifting. I have had success
with similar systems by writing the data structure out into a canonical
format, editing it as text, and then "applying" the result.

Something like:
  git rewrite-generate oldbranch |
    sed 's/^author Darl McBribe/skip-commit/'
    sed 's/^author Joahnnes/author Johannes/' |
    git-rewrite-commit-names |
    git rewrite-apply newbranch

where git-rewrite-generate would generate something like git-log output,
and git-rewrite-apply would, given a log-ish input, write a new history
branch. A nice advantage is that it makes things like this very natural:
  git rewrite-generate oldbranch >history
  vi history
  git rewrite-apply newbranch <history

which allows interactive editing.

Of course, this is:
  - possibly inefficient, since rewrite-apply doesn't know what you
    changed and what you didn't change; it would have to recalculate
    a lot of sha1 hashes.
  - doesn't really deal with actual tree rewriting, unless there is some
    canonical text format for that, and then we are talking about making
    things _really_ inefficient

Hmm. Which makes me think that maybe 'git-format-patch' is really
git-rewrite-generate, and 'git-am' is really git-rewrite-apply (but with
some extensions to preserve committer info).

So maybe a bad idea, but I thought I would throw it out there.

-Peff
