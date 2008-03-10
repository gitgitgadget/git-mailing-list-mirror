From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [jgit] index v2 pull request
Date: Mon, 10 Mar 2008 19:31:38 -0400
Message-ID: <20080310233138.GG8410@spearce.org>
References: <20080308025027.GZ8410@spearce.org> <200803100051.55367.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Dave Watson <dwatson@mimvista.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 00:32:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYrTh-0006pL-Dj
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 00:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbYCJXbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 19:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbYCJXbn
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 19:31:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50766 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbYCJXbm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 19:31:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JYrSr-0002q7-3r; Mon, 10 Mar 2008 19:31:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 760E220FBAE; Mon, 10 Mar 2008 19:31:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200803100051.55367.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76769>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Den Saturday 08 March 2008 03.50.27 skrev Shawn O. Pearce:
> 
> > We now actually use the following .git/config options to control
> > how the window cache limits work:
> >
> >   core.packedGitWindowSize
> >   core.packedGitLimit
> >   core.deltaBaseCacheLimit
> >   core.packedGitMMAP
> 
> Will the net effect, in practice, be the same on Jgit as on C Git?

Yes.  The options actually translate precisely into jgit and are
the exact same knobs as they are in C Git.  That shouldn't be a
surprise as the damn knobs were written in both places by the
same person (me).

Under an Eclipse workspace we read these options _only_ from the
user's ~/.gitconfig.  The values in the repository config file are
not honored as there is only one window cache and one delta base
case for the entire Eclipse workspace.  Given that all projects
in the workspace must share the same virtual address space this is
the only sane configuration.

> >   repo.or.cz:/srv/git/egit/spearce.git master
> Something missing in the formatting?

Heh.  That's the SSH URL.  I ran git-request-pull against my
remote rather than the public git:// URL for the repository.
Sorry about that.

> >       Stop creating "new format" loose objects as C Git no longer likes them
>
> And there goes the unit test for reading them...

Uhm, yeaaah.  I forgot about that.  Actually that's why the object
size changed in that test that I deleted the assert from.  It was
no longer a new-style loose object and thus had to use a few extra
bytes for the type code.  *sigh*

I am pretty sure that C Git also has the same need-egg-no-chicken
problem we now have in jgit.  It has code to read a new style
loose object but has no code to actually create those anymore.
So it cannot actually do a test for the new style reader either.
 
> >       Don't make unit tests depend upon compressed file lengths

Yea, its this commit I was just talking about above.  Needing to
delete this length assert was because of the new format breakage
above.

> >       Extract StGitPatch from Repository to its own top-level type
>
> I'm considering dropping stacked git support. We should have much
> more of it and I don't use it myself anymore to what support we have
> gets very little testing.

I've never used it.  I played around with it in my early git days,
then got into the porcelain and plumbing business with pg, git-gui,
jgit, egit... ;-)
 
> >       Refactor RepositoryState into its own top-level type
> \ No newline at end of file

Arrrrrrrgh.  Damnit Eclipse!  Do what I want, not what you want!
I'll fix it with a follow-up commit.  Unless you really want me
to rewrite that branch.  I'm suspecting not as you are talking
about pushing it below.

> >       Use Java 5 bit twiddling APIs rather than hand-rolling bit counting
>
> I'm surprised *you* didn't know about them bitcounting algorithm java uses 
> before. It's pretty common.

Heh.  Yea, I was surprised too.  Its fixed now.  ;-)
 
> >       Remove unnecessary bitwise AND masks in readTree 
> Good catch
> >       Precount the number of tree entries during readTree
> this one too

These were micro-optimizations while I was trying to figure out
why the hell the History view cost so much.  We spend about 95%
of our time in readTree.  With the above changes we _still_ spend
about 95% of our time in readTree.

I'm rewriting things so we don't do that.  We'll see how well
that works for me.

> >       Change the ObjectLoader.getType method to return int
> >       Fix ArrayIndexOutOfBoundsException in WindowCache
> 
> Very good work (as always) Shawn. I've only read the code so far. I'll do some 
> testing too before pushing. Do you have any unit tests for the v2 pack format 
> (config reading too for that matter)?

Nope, I didn't write any yet.  :-)

A good v2 pack index test probably requires having a v2 pack
index writer.  We don't have that yet.  Plus its a "which is
correct?" game.

I did manually test the pack index v2 reader by pulling history from
a tree that I know for a fact was fully repacked (nothing loose)
and fully repacked with index v2 (I double checked the header
with dd|od).

What I did fail to test was the 64 bit offset table.  Its a pita as
nobody has a packfile that large.  Nico left some back door debugging
options in index-pack to generate an index with a mixture of offset
types but I forgot to manually rebuild my .idx file with it.

-- 
Shawn.
