From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 2 May 2005 17:00:12 -0700
Message-ID: <20050503000011.GA22038@waste.org>
References: <20050429165232.GV21897@waste.org> <427650E7.2000802@tmr.com> <Pine.LNX.4.58.0505021457060.3594@ppc970.osdl.org> <20050502223002.GP21897@waste.org> <Pine.LNX.4.58.0505021540070.3594@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Davidsen <davidsen@tmr.com>,
	Morten Welinder <mwelinder@gmail.com>,
	Sean <seanlkml@sympatico.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 01:55:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSkkP-0004fn-2W
	for gcvg-git@gmane.org; Tue, 03 May 2005 01:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVECAAr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 20:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVECAAr
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 20:00:47 -0400
Received: from waste.org ([216.27.176.166]:33707 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261237AbVECAAX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 20:00:23 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j4300Cgf030485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 2 May 2005 19:00:12 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j4300CMD030479;
	Mon, 2 May 2005 19:00:12 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505021540070.3594@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2005 at 03:49:49PM -0700, Linus Torvalds wrote:
> > >  - you can drop old objects.
> > 
> > You can't drop old objects without dropping all the changesets that
> > refer to them or otherwise being prepared to deal with the broken
> > links.

[...]
 
> I could write this up in ten minutes. It's really simple.

It's still simple in Mercurial, but more importantly Mercurial _won't
need it_. Dropping history is a work-around, not a feature.
 
> > > delta models very fundamentally don't support this. 
> > 
> > The latter can be done in a pretty straightforward manner in mercurial
> > with one pass over the data. But I have a goal to make keeping the
> > whole history cheap enough that no one balks at it.
> 
> With delta's, you have two choices:
> 
>  - change all the sha1 names (ie a pruned tree would no longer be 
>    compatible with a non-pruned one)
>  - make the delta part not show up as part of the sha1 name (which means 
>    that it's unprotected).
> 
> which one would you have?

Umm.. I am _not_ calculating the SHA of the delta itself. That'd be
silly.

There are an arbitrary number of ways to calculate a delta between two
files. Similarly, there are an arbitrary number of ways to compress a
file (gzip has at least 9, not counting all the permutations of
flush). The only sensible thing to do is store a hash of the raw text
and check it against the fully restored text, because that's what you
care about being correct.

In Mercurial, deltas are just a storage detail and are effectively
completely hidden from everything except the innermost part of the
back-end. What's important is that Mercurial knows that A is a
revision of B in the backend and thus has enough information to
opportunistically attempt to calculate a delta.

So if the day ever comes when I want to prune the head of a log, I
simply reconstruct the first version to keep, store it in a new file,
then append all the deltas, unmodified. And fix up the offsets in the
indices. None of the hashes change.

> > What is a tree re-linker? Finds duplicate files and hard-links them?
> > Ok, that makes some sense. But it's a win on one machine and a lose
> > everywhere else.
> 
> Where would it be a loss? Esepcially since with git, it's cheap (you don't 
> need to compare content to find objects to link - you can just compare 
> filename listings).

Git repositories will be 10x larger than Mercurial everywhere that
doesn't benefit from this linking of unrelated trees. That is, folks
who aren't running gitbits.net.

> > I've added an "hg verify" command to Mercurial. It doesn't attempt to
> > fix anything up yet, but it can catch a couple things that git
> > probably can't (like file revisions that aren't owned by any
> > changeset), namely because there's more metadata around to look at.
> 
> git-fsck-cache catches exactly those kinds of things. And since it checks
> pretty much every _single_ assumption in git (which is not a lot, since
> git doesn't have a lot of assumptions), I guarantee you that you can't
> find any more than it does (the filename ordering is the big missing
> piece: I _still_ don't verify that trees are ordered. I've been mentioning
> it since the beginning, but I'm lazy).
> 
> In other words, your verifier can't verify anything more. It's entirely 
> possible that more things can go _wrong_, since you have more indexes, so 
> your verifier will have more to check, but that's not an advantage, that's 
> a downside.

Uh, no. It's just like a filesystem. Redundancy is what lets you
recover.

The extra indices are also very useful in their own right:

- they let you do easily do delta storage
- they let you efficiently do delta transmission
- they let you find past revisions of a file in O(1)
- they let you efficiently do "annotate"
- they let you do smarter merge

At least the first four seem fairly critical to me.

As various people have pointed out, you can hack delta transmission
and file revision indexing on top of git. But to do that, you'll need
to build the same indices that Mercurial has. And you'll need to check
their integrity.

Unfortunately, since the git back-end refuses to know anything about
the relation between file revisions, this will all happen in the front
end, and you'll have done almost all the work needed to do delta
storage without actually getting it. How sad.

You'll also likely end up with something quite a bit more complicated
than Mercurial because of the extra layering. This all strongly suggests
to me that the git back-end is just a little bit too simple.

-- 
Mathematics is the supreme nostalgia of our time.
