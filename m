From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cogito - how do I ???
Date: Sun, 22 May 2005 09:23:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505220908290.2307@ppc970.osdl.org>
References: <20050521214700.GA18676@mars.ravnborg.org>
 <2765.10.10.10.24.1116713164.squirrel@linux1> <Pine.LNX.4.58.0505211635440.2206@ppc970.osdl.org>
 <20050522071435.GA10681@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 18:21:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZtBj-0004Rr-1b
	for gcvg-git@gmane.org; Sun, 22 May 2005 18:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVEVQVk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 12:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVEVQVk
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 12:21:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:11670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261821AbVEVQVd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2005 12:21:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4MGLQjA004328
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 22 May 2005 09:21:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4MGLOFm017635;
	Sun, 22 May 2005 09:21:25 -0700
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20050522071435.GA10681@mars.ravnborg.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 22 May 2005, Sam Ravnborg wrote:
>
> > > > 1) Something similar to "bk changes -R". I use this to see what has
> > > > happened upstream - to see if I really want to merge stuff.
> > > 
> > > Not sure what bk did here, but you can do something like:
> > > 
> > > cg-pull origin
> > > cg-log -c -r origin
> > 
> > In the raw git interfaces, you'd basically have to do the same thing that
> > "git-pull-script" does, except that _instead_ of calling the
> > git-resolve-script thing, you'd do
> > 
> > 	git-rev-tree MERGE_HEAD ^HEAD | git-diff-tree -v -m -s --stdin
> That looks ... long.

That's why people don't generally use git natively. 

I want teach people what the "raw" interfaces are not because you're 
supposed to use them, but because I expect that the raw ones are useful 
for scripting.

> In bk the usage pattern was to check what was in mainline _before_
> fetching and merging.

In git (and cogito, although it's less obvious), the "fetching" is totally 
separate from the "merging". In BK, the two were the same - you couldn't 
merge without fetching, and you couldn't fetch without merging.

> So it seems that with git/cogoto one has to fetch the chages, inspect
> them, and then decide to apply or not.

Well, that's really what you ended up largely doing in BK too, since even
if it _looks_ like you first inspect them with "bk changes -R", the fact
is, in order to do that, you do have to _fetch_ the data first. It's just
that BK (a) fetched just the changeset changes (I think) and (b) then
threw the data away.

With git, you can also do the "fetch just the changeset changes", since if 
you use "git-http-pull" you can instruct it to first _only_ fetch the 
actual commits, and forget about the actual data. But since git considers 
"fetching" and "merging" totally separate phases, it's up to your scripts 
whether they leave the objects around or not afterwards. The normal 
operaion is to leave everything around, since that means that if/when you 
do decide to merge, you already have the data, and you don't need to 
re-fetch.

If you decide to throw it away, you first remove the reference to the
stuff you pulled, and then use "git-prune-script" to get rid of the
objects you used. Right now that is admittedly quite expensive, it's
considered a "rare" thing to do (sicne even if you decide not to merge,
the extra objects never hurt - you can prune things once a week if you
care).

> When the fetches changes stay in MERGE_HEAD I assume my work when
> committed will be based on top of HEAD - so I do not have to know
> if I have fetched some (unmerged) updates.

Yes. Note that MERGE_HEAD ends up being just a totally temporary reference
to the top (that you decided not to merge). It has no meaning for git
itself, and the naming and meaning is purely as a git-pull-script (and
git-resolve-script) internal temporary thing.

> > And again, without the porcelain this is:
> > 
> > 	git-diff-tree -v -p <name>
> 
> The key here is the SHA1. I hoped to avoid specifying SHA1's with
> cogito, I so often miss one character when doing copy'n'paste.

You don't have to use the raw SHA1. git understands tags and references, 
so for example, if you take the "fetch" part of git-pull-script (I really 
should split it up into "git-fetch-script"), then you can, for example, do

	git-diff-tree -v -p MERGE_HEAD

to see the top of the (unmerged) thing. Similarly, doing a

	git-rev-list MERGE_HEAD | git-diff-tree --stdin -v -s

will give you the changelog for the unmerged side. No SHA1's necessary.

Of course, if you don't have a reference to the thing you want to look at, 
you do need to figure out the SHA1 some way. But for example, gitk will 
work fine for the unmerged stuff too - ie you can do

	gitk MERGE_HEAD ^HEAD

_before_ you merge, and get all the nice graphical tools to inspect what 
the hell there is that is new there..

Notice how this "fetch is independent of merge" thing thus means that you 
can do a lot _more_ than "bk changes -R" ever did. But yes, it's a bit 
more complex too (so normally you'd probably only use the porcelain 
layer).

		Linus
