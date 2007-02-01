From: Matt Mackall <mpm@selenic.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Wed, 31 Jan 2007 18:34:29 -0600
Message-ID: <20070201003429.GQ10108@waste.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <eppshi$1l4$1@sea.gmane.org> <20070131222507.GO10108@waste.org> <200702010058.43431.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mercurial@selenic.com, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 01:47:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCQ6Q-0002dH-8x
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 01:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030511AbXBAAq7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 19:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbXBAAq7
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 19:46:59 -0500
Received: from waste.org ([66.93.16.53]:40121 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030511AbXBAAq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 19:46:58 -0500
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l110YTn3032141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 31 Jan 2007 18:34:30 -0600
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id l110YTUG032140;
	Wed, 31 Jan 2007 18:34:29 -0600
Content-Disposition: inline
In-Reply-To: <200702010058.43431.jnareb@gmail.com>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38316>

On Thu, Feb 01, 2007 at 12:58:42AM +0100, Jakub Narebski wrote:
> Matt Mackall wrote:
> > On Wed, Jan 31, 2007 at 11:56:01AM +0100, Jakub Narebski wrote:
> >> Theodore Tso wrote:
> >> 
> >>> On Tue, Jan 30, 2007 at 11:55:48AM -0500, Shawn O. Pearce wrote:
> >>>> I think hg modifies files as it goes, which could cause some issues
> >>>> when a writer is aborted.  I'm sure they have thought about the
> >>>> problem and tried to make it safe, but there isn't anything safer
> >>>> than just leaving the damn thing alone.  :)
> >>> 
> >>> To be fair hg modifies files using O_APPEND only.  That isn't quite
> >>> as safe as "only creating new files", but it is relatively safe.
> >> 
> >>>From (libc.info):
> >> 
> >>  -- Macro: int O_APPEND
> [...] 
> >> I don't quote understand how that would help hg (Mercurial) to have
> >> operations like commit, pull/fetch or push atomic, i.e. all or
> >> nothing. 
> > 
> > That's because it's unrelated.
> [...]
> > Mercurial has write-side locks so there can only ever be one writer at
> > a time. There are no locks needed on the read side, so there can be
> > any number of readers, even while commits are happening.
> > 
> >> What happens if operation is interrupted (e.g. lost connection to
> >> network during fetch)?
> > 
> > We keep a simple transaction journal. As Mercurial revlogs are
> > append-only, rolling back a transaction just means truncating all
> > files in a transaction to their original length.
> 
> Thanks a lot for complete answer. So Mercurial uses write-side locks
> for dealing with concurrent operations, and transaction journal for
> dealing with interrupted operations. I guess that incomplete transactions
> are rolled back on next hg command...

They are either automatically rolled back on abort or if that fails
for some reason like power failure the user is prompted to run "hg
recover" to complete the rollback. We also save the last transaction
journal which allows one level of undo for pulls/commits.

> I guess (please correct me if I'm wrong) that git uses "put reference
> after putting data" scheme, and write-side lock in few places when it
> is needed.

Mercurial also uses a "put reference after putting data" which is what
allows us to have no read vs write locking.
  
> >> In git both situations result in some prune-able and fsck-visible crud in
> >> repository, but repository stays uncorrupted, and all operations are atomic
> >> (all or nothing).
> > 
> > If a Mercurial transaction is interrupted and not rolled back, the
> > result is prune-able and fsck-visible crud. But this doesn't happen
> > much in practice.
> > 
> > The claim that's been made is that a) truncate is unsafe because Linux
> > has historically had problems in this area and b) git is safer because
> > it doesn't do this sort of thing. 
> > 
> > My response is a) those problems are overstated and Linux has never
> > had difficulty with the sorts of straightforward single writer
> > operations Mercurial uses and b) normal git usage involves regular
> > rewrites of data with packing operations that makes its exposure to
> > filesystem bugs equivalent or greater.
> 
> Rewrites in git perhaps are (or should be) regular, but need not be often.
> And with new idea/feature of kept packs rewrite need not be of full data.

If the set of files in a given commit (say tip) gets spread out across
an arbitrary number of packs ordered by last modification time,
performance degrades to O(n) lookups and random seeking.

> One command which _is_ (a bit) unsafe in git is git-prune. I'm not sure
> if it could be made safe. But not doing prune affects only a bit
> repository size (where git is best I think of all SCMs) and not performance.
> 
> On the other hand hg repository structure (namely log like append changelog
> / revlog to store commits) makes it I think hard to have multiple persistent
> branches.

Not sure why you think that. There are some difficulties here, but
they're mostly owing to the fact that we've always emphasized the one
branch per repo approach as being the most user-friendly.

> Sidenote 1: it looks like git is optimized for speed of merge and checkout
> (branch switching, or going to given point in history for bisect), and
> probably accidentally for multi-branch repos, while Mercurial is optimized
> for speed of commit and patch.

I think all of these things are comparable.

> Sidenote 2: Mercurial repository structure might make it use "file-ids"
> (perhaps implicitely), with all the disadvantages (different renames
> on different branches) of those.

Nope.

> > In either case, both provide strong integrity checks with recursive
> > SHA1 hashing, zlib CRCs, and GPG signatures (as well as distributed
> > "back-up"!) so this is largely a non-issue relative to traditional
> > systems.
> 
> Integrity checks can tell you that repository is corrupted, but it would
> be better if it didn't get corrupted in first place.

Obviously. Hence our append-only design. Data that's written to a repo
is never rewritten, which minimizes exposure to software bugs and I/O
errors.
 
> Besides: zlib CRC for Mercurial? I thought that hg didn't compress the
> data, only delta chain store it?

We use zlib compression of deltas and have since April 6, 2005.

-- 
Mathematics is the supreme nostalgia of our time.
