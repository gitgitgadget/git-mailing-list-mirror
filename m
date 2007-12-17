From: Jan Hudec <bulb@ucw.cz>
Subject: Re: git annotate runs out of memory
Date: Tue, 18 Dec 2007 00:24:50 +0100
Message-ID: <20071217232450.GA13012@efreet.light.src>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com> <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org> <alpine.LFD.0.9999.0712111146200.25032@woody.linux-foundation.org> <20071212075725.GA7676@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Berlin <dberlin@dberlin.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:25:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4PLC-00055M-8O
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765508AbXLQXZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764712AbXLQXZQ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:25:16 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:38592 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761996AbXLQXZN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:25:13 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 267A057356;
	Tue, 18 Dec 2007 00:25:12 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id IceDebyA5ZDh; Tue, 18 Dec 2007 00:25:05 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 9F7CD5744D;
	Tue, 18 Dec 2007 00:25:01 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1J4PKM-0003fP-H6; Tue, 18 Dec 2007 00:24:50 +0100
Content-Disposition: inline
In-Reply-To: <20071212075725.GA7676@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68660>

On Wed, Dec 12, 2007 at 02:57:25 -0500, Jeff King wrote:
> On Tue, Dec 11, 2007 at 11:50:08AM -0800, Linus Torvalds wrote:
> > And, btw: the diff is totally different from the xdelta we have, so even 
> > if we have an already prepared nice xdelta between the two versions, we'll 
> > end up re-generating the files in full, and then do a diff on the end 
> > result.

The problem is whether git does not end-up re-generating the same file
multiple times. When it needs to construct the diff between two versions of
a file and one is delta-base (even indirect) of the other, does it know to
create the first, remember it, continue to the other and calculate the diff?

> > Of course, part of that is that git logically *never* works with deltas, 
> > except in the actual code-paths that generate objects (or generate packs, 
> > of course). So even if we had used a delta algorithm that would be 
> > amenable to be turned into a diff directly, it would have been a layering 
> > violation to actually do that.
> 
> That doesn't mean we can't opportunistically jump layers when available,
> and fall back on the regular behavior otherwise. The nice thing about
> clean and simple layers is that you can always add optimizations later
> by poking sane holes.
> 
> Let's assume for the sake of argument that we can convert an xdelta into
> a diff fairly cheaply.  Using the patch below, we can count the places
> where we are diffing two blobs, and one blob is a delta base of the
> other (assuming our magical conversion function can also reverse diffs.
> ;) ).
> 
> For a "git log -p" on git.git, I get:
> 
>    9951 diffs could be optimized
>   10958 diffs could not be optimized
> 
> or about 48%. It would be nice if we could drop the cost by almost 50%
> (if our magical function is free to call, too!).

This is actually a gross underestimation. The idea would be to know all the
diffs we need to calculate and than remember all useful results. Ie. if we
know we'll want objects A and C, A's delta base is B and B's delta base is C,
start calculating A and when it turns out to need C at some point, just
remember it for purpose of doing the final diff. On the other hand B can be
thrown away early (because we don't need it) to save memory.

Now git can know the list of deltas it will need in advance. First generate
the list of revisions -- nothing helps there, but their delta bases are
likely to be randomish anyway -- and than with the knowledge of full list of
trees, start doing the diffs to see which touched the subtree in question.
Repeat for each level.

Since the list of deltas that will be needed is known, the objects from
which all deltas were already generated can be expired from cache (but not
thrown away immediately, as they may help building other objects).

> Of course, I haven't even looked at whether converting xdeltas to
> unified diffs is possible. I suspect in some cases it is (e.g., pure
> addition of text) and in some cases it isn't (I assume xdelta doesn't
> have any context lines, which might hurt). And it's possible that a
> specialized diff user like git-blame can just learn to use the xdeltas
> by itself (I didn't get a "could optimize" count for git-blame since
> it seems to follow a different codepath for its diffs).

Well, it's about as hard as applying them, because you can remember the
necessary stuff when applying. The imporant bit would be to avoid applying
the same delta more than once during the whole annotate.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
