From: Jeff King <peff@peff.net>
Subject: Re: Git Notes idea.
Date: Tue, 16 Dec 2008 03:51:08 -0500
Message-ID: <20081216085108.GA3031@coredump.intra.peff.net>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Govind Salinas <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 09:52:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCVfJ-0001Wh-Sy
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 09:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbYLPIvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 03:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbYLPIvL
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 03:51:11 -0500
Received: from peff.net ([208.65.91.99]:3510 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbYLPIvL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 03:51:11 -0500
Received: (qmail 11912 invoked by uid 111); 16 Dec 2008 08:51:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 16 Dec 2008 03:51:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Dec 2008 03:51:08 -0500
Content-Disposition: inline
In-Reply-To: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103259>

On Tue, Dec 16, 2008 at 02:15:47AM -0600, Govind Salinas wrote:

> I was thinking about possible ideas for my little pet project and I
> had and idea for way to tack on notes to a commit, or any object
> really.  I know that the idea has been flying around for a long time
> but there has never been any implementation or a concept that people
> liked enough to use (unless I have missed something).

I think you look at the previous suggestions, because yours is very
similar. Which is good, I think, because the current status is that the
design is good, but nobody has gotten around to working on it yet. So
maybe you can fix that. :)

> .git/refs/notes  contains a tree-id (assuming that using a tree-id
> will not cause any problems, otherwise a commit object can be used.
> it does not *need* a history, but it *could* have one).

That is the same as the current proposal, except:

 - the proposal is to use a commit, so your notes are version-controlled

 - I have suggested supporting multiple note "bases" in the refs/notes
   namespace. This would allow you to share some notes but not others
   (e.g., if you had some automated notes related to a build/test
   system, you might not want to mix those with your human-written
   notes).

> That tree has a structure similar to the layout of .git/objects, where
> it is 2 letter subdirectories for the notes objects.

I don't think this has been suggested yet, but I'm not sure it is a good
idea. The usual reason for this split is that many filesystems handle
large directories badly; that isn't a problem here.

It does reduce the size of the resulting tree objects when a note is
modified (we make updates to two smaller trees instead of one big tree).
I don't know if this really matters all that much, since the trees
will end up deltified in a pack anyway.

And it does make the implementation slightly less simple, since we have
to deal with two levels of trees.

> Given a git object (commit, tree, blob, tag), use its sha as the
> path/filename in this tree.
>     If I have a commit 1234567890123456789012345678901234567890 then
> the notes tree will have a file
> 12/34567890123456789012345678901234567890
> 
> That file has a list of sha1s (one per line).  These shas are object
> IDs for blobs that have the notes or whatever that you want attached
> to the item.

This is slightly different than the current proposal. You are proposing
that each item have a "list of notes". My thinking was to have "named
notes" using a tree for each entry full of blobs. So you could look up
the "foo" note for a given commit, but that note would be a single
scalar (which could, of course, be interpreted according to its name).

> I think you get the idea.  When looking up an item, it should be
> fairly easy to have the notes tree and subtrees available for doing
> lookups.  And as far as I know stuff under .git/refs can be

It is easy, but it's slow because we have to do a linear search in the
(potentially huge) notes tree. And that's what held up the initial
implementation. I did a proof-of-concept a month or so ago that
pre-seeded an in-memory hash using the tree contents and got pretty
reasonable performance.

> pushed/pulled even if its not under heads or remotes or tags using
> already existing machinery.  I am not sure, but I think that would
> satisfy gc operations as well.  Also, these trees and blobs never have
> to be put in the working directory.

Right, though I think one of the benefits of this approach is that you
_could_ do a checkout on the notes tree if you wanted to do very
flexible editing.

> Does this sound like something that is workable?  I thought it might
> appeal since it uses only features that are already present.

Yes, it sounds workable, though if you diverge from what has already
been discussed, I think you should make an argument about why your
approach is better.

> This could be extended so that you have different sets of notes under
> .git/refs/notes/<my note set> or whatever.  So that you can have some
> notes you keep private and some that you publish or whatever.

Oops, I should have read your whole mail. Yes, that is a good idea. :)

For reference, here are the previous discussions that I think are
relevant:

  Johan Herland's original notes proposal (which I think is largely
  dead, replaced by the one below):
  http://thread.gmane.org/gmane.comp.version-control.git/46770

  Johannes Schindelin's notes proposal (which is more or less the
  current proposal, but I think the on-disk notes index was not
  well liked):
  http://thread.gmane.org/gmane.comp.version-control.git/52598

  My test with using a hash to speed it up:
  http://article.gmane.org/gmane.comp.version-control.git/99415

  Some discussion of the interaction of notes and rebase:
  http://thread.gmane.org/gmane.comp.version-control.git/100533

  Some thoughts from me on naming issues:
  http://article.gmane.org/gmane.comp.version-control.git/100402

  Some thoughts from me on the tree speedup:
  http://article.gmane.org/gmane.comp.version-control.git/101460

which I think should bring you up to speed. :)

-Peff
