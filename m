From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Thu, 24 May 2007 22:06:42 -0400
Message-ID: <20070525020642.GS28023@spearce.org>
References: <46528A48.9050903@gmail.com> <7v7iqz19d2.fsf@assigned-by-dhcp.cox.net> <56b7f5510705231655o589de801w88adc1aa6c18162b@mail.gmail.com> <7vps4ryp02.fsf@assigned-by-dhcp.cox.net> <20070524071235.GL28023@spearce.org> <56b7f5510705241629n192a41adi4c0d63c53cf8472b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 04:06:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrPCi-0001FB-TW
	for gcvg-git@gmane.org; Fri, 25 May 2007 04:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbXEYCGy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 22:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774AbXEYCGy
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 22:06:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59017 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbXEYCGx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 22:06:53 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HrPCP-0008LT-Gd; Thu, 24 May 2007 22:06:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BBEEA20FBAE; Thu, 24 May 2007 22:06:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <56b7f5510705241629n192a41adi4c0d63c53cf8472b@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48331>

Dana How <danahow@gmail.com> wrote:
> On 5/24/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> >Junio C Hamano <junkio@cox.net> wrote:
> >> "Dana How" <danahow@gmail.com> writes:
> >> > We have three options in this case:
> >> > (1) Drop the object (do not put it in the new pack(s)).
> >> > (2) Pass the object into the new pack(s).
> >> > (3) Write out the object as a new loose object.
> >> > Option (1) is unacceptable.  When you call git-repack -a,
> >> > it blindly deletes all the non-kept packs at the end.  So
> >> > the megablobs would be lost.
> >> Ok, I can buy that -- (1) nor (2) are unacceptable and (3) is
> >> the only sane thing to do for a previously packed objects that
> >> exceed the size limit.
> >
> >I still don't buy the idea that these megablobs shouldn't be packed.
> >I understand Dana's pain here (at least a little bit, my problems
> >aren't as bad as his are), but I also hate to see us run away from
> >packfiles for these really sick cases just because we have some
> >issues in our current packfile handling.
> >
> >Packfiles give us a lot of benefits:
> >
> > 1) less inode usage;
> I agree with Geert that blowing an inode on a 100MB+ object
> is no big deal.

You and me both.  If the size of the blob is high enough than
overhead associated with the inode and any tail-block wastage is
noise.  Filesystems are pretty good at tracking large-ish files.
My comment here wasn't so much about blowing an inode on a 100MiB+
object, but just in general that packfiles reduce inode usage,
which in the common metadata case (300,000 small objects) is a
big difference.

I think you are right; if we get an object in the >100MiB size
range we can certainly afford an inode for it.

> > 2) transport can write directly to local disk;
> > 3) transport can (quickly) copy from local disk;
> For (2) and (3) see comments on next para plus NFS discussion.
> > 4) testing for existance is *much* faster;
> This is true.  But I don't care about this cost if it
> is only incurred on large objects which are leaf nodes
> in the git "data relationship tree" (tags->commits->trees->blobs) anyway.

Yes, that's true.

> > 5) deltafication is possible;
> Again Geert made a good argument that didn't occur to me that
> you definitely DON'T want to do deltification on such large objects.
> Junio recently added delta/nodelta attribute; this would be useful
> to me,  but unfortunately I have several continua of files,  each with
> the same suffix,  but with largely varying sizes, so attributes won't
> help me unless the name globs in .gitattributes are expanded to full
> expressions similar to find(1) [i.e. include testing based on size,
> perms, type],  which I think would be insane.

Which brings up the comment I think I made (below) about skipping
deltas on very large objects.  Things over a certain size are not
likely to delta well, or in any reasonable time.  We probably should
default to not trying to delta those, but let the user force us to
do so with a .gitattributes option.  Maybe.

> >By pushing the megablob packs to the end of our packed_git search
> >list we won't tend to scan their indexes, as most of our objects
> >will be found earlier in the search list.  Hence we will generally
> >avoid any costs associated with their indexes.
> Good argument and I submitted a patch to do this.
> Let's see who chokes on the floating arithmetic ;-)

I actually had another thought in this area.  I'll try to work up a
patch to accompany yours.  I think we can avoid even touching the
alternate object databases half of the time, and I'd like to be
able to do that.  Why?  Because I started to setup this megablob
approach on my own Windows based repositories.  Unfortunately it
makes git-log about 1 second slower, and I suspect its in the
alternate repository initialization.
 
> >Huge packfiles probably should be scheduled for keeping with a .keep
> >automatically.  We probably should teach pack-objects to generate a
> >.keep file if the resulting .pack was over a certain size threshold
> >(say 1.5 GiB by default) and teach git-repack to rename the .keep
> >file as it also renames the .idx and .pack.
> I have experimented with this,  and Jakub Narebski made related
> suggestions.  I find this quite hokey,  but even if I do it in my central
> alternate,  I still do not want to be packing megablobs in individual user's
> repos EVER,  and need some way to exclude them.

Yes, that makes a lot of sense.

> >Better that we degrade gracefully when faced with massive inputs
> >than we do something stupid by default and make the poor user pay
> >for their mistake of not throughly reading plumbing documentation
> >before use.
> Unnecessary copying of several GB is not degrading gracefully in my view.
> In fact having repack.maxblobsize = 2000 (K) in the default "config"
> strikes me as degrading much more gracefully than what the code
> would currently do.

Sure.  But I think this goes back to #3 (network transport) and
how our loose object format now doesn't support it well.  And even
if that's fixed I don't think 2 MiB is a good default; its *far*
too low.  I have a number of blobs that are in the 12-16 MiB range
and they delta very well in a pretty reasonable time.

> This silly patch took my packfile sets from 12GB+ to 13MB,
> and it's difficult to describe how relieved I now feel.

I think I understand a little bit.  Today I took 3 repositories
that were about 70 MiB each and dropped them down to 16 MiB, 2
MiB and 4.5 MiB by creating a single 120 MiB "megablob" packfile
that spanned all 3 of them.  This isn't the same scale as what you
are dealing with, but now I have a current metadata pack for each
that isn't gummed up with large blobs, making repacking faster.
I also have a smaller working set size.  :-

> But I think you have an understandable motivation:
> you want packfiles to be as good as possible,  and any escape
> mechanism from them decreases the motivation to "fix" packing.

Yes, that's correct.  I'm not against stepping outside of
packfiles and making usage of loose objects for megablobs easier.
I just want to make sure its the best way to handle these things.
Generally we've made major improvements in things when we've been
pushed by large repositories/datasets.

> Now I agree with this, which is why I just submitted some other patches,
> but I don't share your goal of the universality of all packfiles --
> just the ones used for transport.  Don't your packv4 plans introduce
> mods which won't be used for transport as well?

Yes, at least initially we'd reencode from pack v4 down to pack v2
for transport, because transporting the dictionary with delta reuse
is an interesting problem.  However Nico and I have discussed it
at length and have plans for how to code a pack v4 based transport,
and pack v4's file format concepts are partially based upon making
pack v4 transport easier to implement.  But from a "start simple and
keep it simple, stupid" principle we'd like to avoid the complexity
early on.

> >Now I would agree that we should punt on deltification of anything
> >that is just too large, and let the user decide what too large means,
> >and default it around 500 or 1024 MiB.  But I would still stuff it
> >into a packfile.
> >
> >Maybe it still makes sense to have a limit on the maximum size of a
> >loose object to pack, but I think that's only to avoid the sick case
> >of a very simple no-argument "git repack" taking a long while because
> >there's 8 loose objects and 6 of them are 900 MiB image files.
> Perhaps we _will_ make progress if we all agree to describe
> my situation as "sick" ;-) .  In this paragraph you seem to agree that
> there is some argument for keeping megablobs from _entering_ packs?

Yes.  If your workflow is basically "git add HUGE; git commit; git push;
git prune-alternates" then you only have to pack the huge object once,
and can remove the loose object from the user's .git/objects directly
pretty quickly, because its available via your NFS alternate.  In such
a configuration yes, it does make some sense to never allow a megablob
from entering a pack.

So I guess I'm partially in agreement with you...

> >Once in a packfile, I'd keep it there, even if the user decreases
> >the threshold, as the advantages of it being in the packfile outweigh
> >the disadvantages of it being in the packfile.  And there's like no
> >advantage to being loose once packed.
> To (almost) follow this suggestion I would need git-fast-import to respect
> repack.maxblobsize as well.  Is that OK with you?

Yes I could implement that (or better accept a patch that does so)
but I'd actually wonder why not just categorize the objects into
two different packfiles.  Have one for "small stuff" and another
for "everything larger than small stuff".  Split the two packfiles
independently of each other.  Hence fast-import would produce more
packfiles, but each output packfile would probably have a couple
of megablobs in it, and you'd have one single packfile with all of
the smaller metadata.

And actually if you are trying to shove large objects through
fast-import we really can do a lot better.  Like avoiding
deltification attempts, adjusting the compression level to something
better suited to your blob (I don't know if its compressable or not)
and streaming to the output packfile, rather than holding the entire
thing in memory before writing the first byte.

Given the advantages discussed above about being in a packfile, and
that fast-import was writing specifically for creating packfiles
instead of loose objects during large IO transfers into Git, I
think it is sort of anti-fast-import to have it create loose objects.
 
> I previously offered to Junio that the "write loose object" thing
> could be restricted:  it would only happen if -f were supplied to
> git-repack,  otherwise the bad blob would pass through to the new pack.
> Does this "reduction in strength" make this feature more palatable to you?

Yes.  But go back to the .keep discussion above where I suggest
we automatically .keep any "large" packfile.  Once you get a huge
packfile you probably don't want to redo the disk IO associated with
repacking it, unless you really are trying to force a large reorg.
So I'd agree with the idea of making a -f needed to eject a megablob,
but I think you'd need more than that as you'd also be trying to
bypass the usual .keep logic.
 
> If the stats on a repo change significantly,  "write loose object"
> becomes more important if you have to make a significant reduction
> to repack.maxblobsize (or specify it for the first time).

I'm not sure users should be tweaking this...  Its fine to make
the knob available, but we really should have the knob adjust
itself somewhat intelligently.  Don't ever add a knob that you
cannot write a rule to control; if you can write a rule than write
it dammit and don't make the user do your job for you.  Knobs are
good for when your case is just so far away from the normal that
the rule is utterly wrong...

Guess what, your repository is such a repository (its far away from
our normal rules).  But I think its problems are also common enough
that we really should attempt to make our rules handle it better.
 
> I don't agree that once in a packfile,  a blob should stay there.
> Its presence is degrading access to "normal" blobs co-habiting with it.
> So you will want to repack to separate them in different packs
> (the various .keep-related ideas) or just write them out loose.

If we're evicting a megablob from one packfile to a loose object
(because its degrading access to the other objects in its current
packfile) we're already committed to doing the massive disk IO
required for that eviction.  We might as well write it back out
to a file format that we can more easily work with, than one that
we cannot.

But I have to circle back here and say "why is a megablob degrading
access in a packfile"?  This goes right back to your point above
about my wanting to stay in the packfile format just to make the
packfile format better.  What's so wrong with the packfile format
(and the code that writes/reads it) that makes access for a small
metadata more expensive when there are megablobs attached in the
same packfile?

Or is it just because we like to repack the smaller metadata
frequently, but that's horribly expensive because the megablobs
are in the same packfile?  If its really just about repacking then
.keep marked megablob packs are the way to go.

-- 
Shawn.
