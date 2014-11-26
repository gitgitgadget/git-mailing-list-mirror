From: Mike Hommey <mh@glandium.org>
Subject: Re: "git notes show" is orders of magnitude slower than doing it
 manually with ls-tree and cat-file
Date: Wed, 26 Nov 2014 11:25:53 +0900
Message-ID: <20141126022553.GA16199@glandium.org>
References: <20141126004242.GA13915@glandium.org>
 <20141126010051.GA29830@peff.net>
 <20141126012448.GA11183@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 03:26:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtSJC-0006Ga-0C
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 03:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbaKZC0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 21:26:18 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:52294 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbaKZC0R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 21:26:17 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1XtSIj-000502-M4; Wed, 26 Nov 2014 11:25:53 +0900
Content-Disposition: inline
In-Reply-To: <20141126012448.GA11183@peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260265>

On Tue, Nov 25, 2014 at 08:24:49PM -0500, Jeff King wrote:
> On Tue, Nov 25, 2014 at 08:00:51PM -0500, Jeff King wrote:
> 
> > On Wed, Nov 26, 2014 at 09:42:42AM +0900, Mike Hommey wrote:
> > 
> > > I have a note tree with a bit more than 200k notes.
> > >
> > > $ time git notes --ref foo show $sha1 > /dev/null
> > > real    0m0.147s
> > > user    0m0.136s
> > > sys     0m0.008s
> > > 
> > > That's a lot of time, especially when you have a script that does that
> > > on a fair amount of sha1s.
> > 
> > IIRC, the notes code populates an in-memory data structure, which gives
> > faster per-commit lookup at the cost of some setup time. Obviously for a
> > single lookup, that's going to be a bad tradeoff (but it does make sense
> > for "git log --notes"). I don't know offhand how difficult it would be
> > to tune the data structure differently (or avoid it altogether) if we
> > know ahead of time we are only going to do a small number of lookups.
> > But Johan (cc'd) might.
> 
> One other question: how were your notes created?
> 
> I tried to replicate your setup by creating one note per commit in
> linux.git (over 400k notes total). I did it with one big mktree,
> creating a single top-level notes tree. Doing a single "git notes show"
> lookup on the tree was something like 800ms.
> 
> However, this is not what trees created by git-notes look like. It
> shards the object sha1s into subtrees (1a/2b/{36}), and I think does so
> dynamically in a way that keeps each individual tree size low. The
> in-memory data structure then only "faults in" tree objects as they are
> needed. So a single lookup should only hit a small part of the total
> tree.
> 
> Doing a single "git notes edit HEAD" in my case caused the notes code to
> write the result using its sharding algorithm. Subsequent "git notes
> show" invocations were only 14ms.
> 
> Did you use something besides git-notes to create the tree? From your
> examples, it looks like you were accounting for the sharding during
> lookup, so maybe this is leading in the wrong direction (but if so, I
> could not reproduce your times at all even with a much larger case).

So... this is interesting. I happen to have recreated the notes tree
"manually", and now each git notes show takes under 10ms.

Now, looking at the notes tree reflog, I see that at some point, some
notes were added at the top-level of the tree, without being nested,
which is strange.

And it looks like it's related to how I've been adding them, through
git-fast-import. I was using notemodify commands, and was using the
filemodify command to load the previous notes tree instead of using the
from command because I don't care about keeping the notes history.
So fast-import was actually filling the notes tree as if it were
starting over with whatever new notes were added with notemodify (which,
in a case where there were many, it filled with one level of
indirection)

I'm not sure this is a case worth fixing in fast-import. I can easily
work around it.

Mike
