From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 2 May 2005 15:49:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505021540070.3594@ppc970.osdl.org>
References: <20050429165232.GV21897@waste.org> <427650E7.2000802@tmr.com>
 <Pine.LNX.4.58.0505021457060.3594@ppc970.osdl.org> <20050502223002.GP21897@waste.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Davidsen <davidsen@tmr.com>,
	Morten Welinder <mwelinder@gmail.com>,
	Sean <seanlkml@sympatico.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261206AbVEBWsJ@vger.kernel.org Tue May 03 00:44:30 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261206AbVEBWsJ@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSjdO-0000Sq-Bm
	for glk-linux-kernel@gmane.org; Tue, 03 May 2005 00:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVEBWsJ (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Mon, 2 May 2005 18:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVEBWsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 18:48:09 -0400
Received: from fire.osdl.org ([65.172.181.4]:38788 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261194AbVEBWr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 18:47:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j42Mlms4015039
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 2 May 2005 15:47:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j42MllMX025155;
	Mon, 2 May 2005 15:47:47 -0700
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20050502223002.GP21897@waste.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 May 2005, Matt Mackall wrote:
> > 
> >  - you can share the objects freely between different trees, never 
> >    worrying about one tree corrupting another trees object by mistake.
> 
> Not sure if this is terribly useful. It just makes it harder to pull
> the subset you're interested in.

You don't have to share things in a single subdirectory. Symlinks and 
hardlinks work fine, as do actual filesystem tricks ;)

> >  - you can drop old objects.
> 
> You can't drop old objects without dropping all the changesets that
> refer to them or otherwise being prepared to deal with the broken
> links.

Absolutely. This needs support from fsck to allow us to say "commit xxxx 
is no longer in the tree, because we pruned it".

Alternatively (and that's the much less intrusive one), you keep all the
commit objects, but drop the tree and blob objects. Again, all you need 
for this to work is just feed a list of commits to fsck, and tell it 
"we've pruned those from the tree", which tells fsck not to start looking 
for the contents of those commits.

So for example, you can trivially have something that automates this: take 
each commit that is older than <x> days, add it to the "prune list", and 
run fsck, and delete all objects that now show up as being unreachable 
(since fsck won't be looking at what those commits reference).

I could write this up in ten minutes. It's really simple.

And it's simple _exactly_ because we don't do deltas.

> > delta models very fundamentally don't support this. 
> 
> The latter can be done in a pretty straightforward manner in mercurial
> with one pass over the data. But I have a goal to make keeping the
> whole history cheap enough that no one balks at it.

With delta's, you have two choices:

 - change all the sha1 names (ie a pruned tree would no longer be 
   compatible with a non-pruned one)
 - make the delta part not show up as part of the sha1 name (which means 
   that it's unprotected).

which one would you have?

> What is a tree re-linker? Finds duplicate files and hard-links them?
> Ok, that makes some sense. But it's a win on one machine and a lose
> everywhere else.

Where would it be a loss? Esepcially since with git, it's cheap (you don't 
need to compare content to find objects to link - you can just compare 
filename listings).

> I've added an "hg verify" command to Mercurial. It doesn't attempt to
> fix anything up yet, but it can catch a couple things that git
> probably can't (like file revisions that aren't owned by any
> changeset), namely because there's more metadata around to look at.

git-fsck-cache catches exactly those kinds of things. And since it checks
pretty much every _single_ assumption in git (which is not a lot, since
git doesn't have a lot of assumptions), I guarantee you that you can't
find any more than it does (the filename ordering is the big missing
piece: I _still_ don't verify that trees are ordered. I've been mentioning
it since the beginning, but I'm lazy).

In other words, your verifier can't verify anything more. It's entirely 
possible that more things can go _wrong_, since you have more indexes, so 
your verifier will have more to check, but that's not an advantage, that's 
a downside.

		Linus
