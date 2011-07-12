From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Tue, 12 Jul 2011 01:35:32 -0400
Message-ID: <20110712053532.GB11644@sigill.intra.peff.net>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <7vliw4d1hu.fsf@alter.siamese.dyndns.org>
 <20110711220107.GC30155@sigill.intra.peff.net>
 <7vk4bo9ze5.fsf@alter.siamese.dyndns.org>
 <4E1B91D8.5040500@ronin-capital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Illia Bobyr <Illia.Bobyr@ronin-capital.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 07:35:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgVdF-0001KX-Id
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 07:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244Ab1GLFff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 01:35:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47396
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846Ab1GLFfe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 01:35:34 -0400
Received: (qmail 8732 invoked by uid 107); 12 Jul 2011 05:35:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jul 2011 01:35:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2011 01:35:32 -0400
Content-Disposition: inline
In-Reply-To: <4E1B91D8.5040500@ronin-capital.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176913>

On Mon, Jul 11, 2011 at 07:14:16PM -0500, Illia Bobyr wrote:

> I am not 100% sure that my solution is exactly about this problem, but 
> it seems to be quite relevant.
> 
> I think that if you rebase "step-by-step" by doing, for this particular 
> example, something like
> 
> $ git rebase master^ topic
> $ git rebase master topic
> 
> You will first see the /modified one/one/ conflict that you will resolve 
> your "two" against and then your second rebase will apply with no conflicts.
> 
> I have a set of scripts that help me do this kind of rebases by 
> essentially rebasing the topic branch against every single commit on the 
> upstream.

That makes a lot of sense to me as a strategy. Of course, as you
mention, it is horribly slow. And when you do have real conflicts, you
would end up looking at the same conflicts again and again (and as you
mention, rerere can be some help there, though not necessarily
perfect).

> At the same time the less changes are in topic...master the faster it 
> would be and the more changes are there the more you benefit from a 
> gradual rebase.

Yeah, this seems like the real problem to me. It's one thing to rebase
on top of a single series that somebody has applied upstream. But if it
has been 2 weeks, there may be hundreds of commits, and doing hundreds
of rebases is awful. I wonder if you could do better by picking out some
"key" commits in master to rebase on top of using one of:

  1. Divide-and-conquer the commit space. Try the rebase, starting on
     the HEAD. If it works, great. If the user says "this is too hard",
     then find the midpoint between where we tried to rebase and the
     merge base, and try rebasing there. Every time it's too hard, go
     back halfway to the start. Every time it's easy, try the new result
     on top of HEAD.

     So it's basically doing a O(lg n) search backwards for an easy
     place to rebase, and then repeatedly checking if that was a good
     spot (and repeating the backwards search if not). The worst case
     complexity is O(n lg n) rebases. But in practice, you can hopefully
     find the problematic spot in O(lg n), and then everything will just
     work out after 1 or 2 problematic spots.

  2. Use heuristics (like commit message content) to find related
     commits. So if I have a 5-patch series, I can perhaps find the
     likely commits upstream that match my patches, and those are
     good places to try individual rebases. And then I don't care how
     many commits are in master. If I have a 5 patch series, I won't do
     more than 5 rebases.

But I've never tried this in practice. Maybe next time a rebase is ugly
I'll manually work through one of the methods and see how it fares.

-Peff
