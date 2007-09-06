From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Calculating tree nodes
Date: Wed, 5 Sep 2007 23:20:26 -0400
Message-ID: <20070906032026.GO18160@spearce.org>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com> <20070904025153.GS18160@spearce.org> <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com> <20070904062629.GZ18160@spearce.org> <7vbqcinxdb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 05:20:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT7v6-00072f-M2
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 05:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469AbXIFDUf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 23:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757242AbXIFDUf
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 23:20:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36976 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbXIFDUe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 23:20:34 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IT7ul-0007g4-3y; Wed, 05 Sep 2007 23:20:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9CA9720FBAE; Wed,  5 Sep 2007 23:20:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vbqcinxdb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57810>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > There's nothing stopping us from creating additional indexes.
> > ...
> > But we can also store the notes alongside the commits in the
> > packfile, so that if the data for the commit has been paged in
...
> 
> I would agree with your main thrust "nobody prevents you from
> building additional index", but on a tangent, I am skeptical
> about adding too much to pack v4.  Especially "clustering the
> notes" part.
...
> Now, hopefully many operations do not need notes either,
> although notes themselves can store _anything_ so each of them
> could be large and/or each commit could have large number of
> them.  I suspect clustering notes along with the commit they
> annotate would break the locality of access for common case.

I'm inclined to agree.

Its something I've thought about doing.  I haven't even prototyped
code for it.  Let alone shown numbers that say one way or the other.

One of the notes proposals was talking about having lots of different
classes of notes.  E.g. a "Signed-off-by" class and a "build and test
log results" class.

The former would generally be very small and may even want to be
shown most of the time the commit body is displayed (e.g. in gitk,
git-log).  These would be good candidates to cluster alongside the
commit.  Indeed they are clustered there today, just hung inside
of the commit object itself.  Nobody is bitching about the hit they
cause on the common case of `pack-objects`.  :)

The latter (build and test log) would generally be very large.
We would *not* want to cluster them.  But we might want to store
next to the commit a very small pointer to the note itself.  Such
as the note's SHA-1.  Or its offset within the packfile's index.
This would make locating those notes very cheap, while not having
a huge impact on the common case of commit traversal.

Likewise we might want to pack a tag's SHA-1 alongside of the commit
it points at, as parsing the commit would immediately give us all
annotated tags that refer to that commit.  Tags are (usually) few
and far between.  But tools like git-describe are commonly used and
would benefit from not needing to build the commit->tag hashtable.
OK, well, git-describe cheats and uses the struct object hashtable,
but whatever.

You get my point.  I think.  And I got yours about not making the
common case worse than it already is today.

-- 
Shawn.
