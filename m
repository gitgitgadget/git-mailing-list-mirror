From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: clarify git clone --local --shared --reference
Date: Wed, 6 Jun 2007 01:11:11 -0400
Message-ID: <20070606051111.GF9513@spearce.org>
References: <4664A5FE.30208@nrlssc.navy.mil> <20070605045008.GC9513@spearce.org> <46658F98.6020001@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 06 07:11:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvnoF-0002Y3-Le
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 07:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757319AbXFFFLV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 01:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757263AbXFFFLV
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 01:11:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41542 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757319AbXFFFLU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 01:11:20 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1Hvnni-0001IE-9k; Wed, 06 Jun 2007 01:11:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1B8DA20FBAE; Wed,  6 Jun 2007 01:11:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46658F98.6020001@nrlssc.navy.mil>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49246>

Brandon Casey <casey@nrlssc.navy.mil> wrote:
> Shawn O. Pearce wrote:
> >
> >  b) Don't repack the source repository without accounting for the
> >  refs and reflogs of all --shared repositories that came from it.
> >  Otherwise you may delete objects that the source repository no
> >  longer needs, but that one or more of the --shared repositories
> >  still needs.
> 
> How should this be accomplished? Does this mean never run 
> git-gc/git-repack on the source repository? Or is there a way to
> cause the sharing repositories to copy over objects no longer
> required by the source repository?

Well, you can repack, but only if if you account for everything.
The easiest way to do this is push every branch from the --shared
repos to the source repository, repack the source repository, then
you can run `git prune-packed` in the --shared repos to remove
loose objects that the source repository now has.

You can account for the refs by hand when you run pack-objects
by hand, but its horribly difficult compared to the push and then
repack I just described.  I think that long-lived --shared isn't that
common of a workflow; most people use --shared for shortterm things.
For example contrib/continuous uses --shared when it clones the
repository to create a temporary build area.
 
> >>4) is space savings obtained only at initial clone? or is it on going?
> >>   does a future git pull from the source repository create new hard
> >>   links where possible?
> >
> >Only on initial clone.  Later pulls will copy.  You can try using
> >git-relink to redo the hardlinks after the pull.
> 
> How about with --shared? Particularly with a fast-forward not much
> would need to be copied over. Do later pulls into a repository with
> configured objects/info/alternates take advantage of space savings
> when possible?

Yes.  Recently a --shared avoids copying the objects if at all
possible.  This makes fetches from the source repository into the
--shared repository very, very fast, and uses no additional disk.
 
> If the answer above is "yes", then this brings up an interesting use 
> case. I assume that clone, fetch, etc follow the alternates of the 
> source repository? Otherwise a --shared repository would be unclone-able 
> right? And only pull-able from the source repository? So if that is the 
> case (that remote alternates are followed),

Alternates are followed as many as 5 deep.  So you can do something like
this:

	git clone --shared source share1
	git clone --shared share1 share2
	git clone --shared share2 share3
	git clone --shared share3 share4
	git clone --shared share4 share5
	git clone --shared share5 corrupt

I think corrupt is corrupt; it doesn't have access to the source anymore
and therefore is missing 90%+ of the object database.  To help make this
case work the objects/info/alternates should always contain absolute paths;
we store them absolute in git-clone by default but you could set them up
by hand.  The other repositories should however be intact and usable, but
you cannot clone from share5.

Normal fetch/push/pull will work fine against any of those working
repos, as they are all using the normal Git object transport methods,
which means we copy objects unless they are available to us already
(see above).

> then a group of developers 
> could add all of the other developers to their alternates list (if 
> multiple alternates are supported)

Yes, they are.  I don't think we have a limit on the number of
alternates you are allowed to have.  However each additional
alternate adds some cost to starting up any given Git process.
The more alternates you have (or the more deeply nested they are)
the slower Git will initialize itself.  For 1 or 2 alternates its
within the fork+exec noise of any good UNIX system; for 50 alternates
I think you would notice it.

> and reference their objects when 
> possible. To the extent that it is possible, each developer would end up 
> only storing their commit objects. This would then create a distributed 
> repository.

Yes, but that has very high risk.  If developer Joe Smith quits and
then the administrator `rm -rf /home/jsmith` everyone is hosed as
they can no longer access the objects that were originally created
by Joe.  Then the administrator is off looking for backup tapes,
assuming he has them and they are valid.  One nice property of Git
(really any DVCS) is that the data is automatically backed up by
every developer participating in the project.  Its unlikely you
will lose the project that way.

Also this scheme doesn't really work well for packing.  I don't
think we'll pack the loose objects that we borrow from the other
developers, and Git packfiles are a major performance improvement
for all Git operations.  Plus they are very small, so they save a
lot of disk.

You might find that it takes up less total disk to have everyone
keep a complete (non --shared) copy of the project, but repack
regularly, then to have everyone using alternates against each
other and nobody repacks.
 
> Of course, this new distributed repository may be somewhat fragile since 
> the entire thing could become unusable if any portion was corrupted. 
> Just because you can do a thing, doesn't mean you should.

Yes, exactly.  ;-)

In my day-job repositories I have about 150 MiB of blobs that
are very common across a number of Git repositories.  I've made a
single repo that has all of those packed, and then setup that as an
alternate for everything else.  It saves a huge chunk of disk for us.
But that common-blob.git thing that I created never gets changed,
and never gets repacked.  Its sort of a "historical archive" for us.
Works very nicely.  Alternates have their uses...

-- 
Shawn.
