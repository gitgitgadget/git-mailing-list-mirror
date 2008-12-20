From: Jeff King <peff@peff.net>
Subject: Re: Git Notes idea.
Date: Fri, 19 Dec 2008 23:54:37 -0500
Message-ID: <20081220045437.GA27341@coredump.intra.peff.net>
References: <20081216085108.GA3031@coredump.intra.peff.net> <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com> <alpine.DEB.1.00.0812170003540.14632@racer> <5d46db230812161815s1c48af9dwc96a4701fb2a669b@mail.gmail.com> <alpine.DEB.1.00.0812170420560.14632@racer> <20081217101110.GC18265@coredump.intra.peff.net> <5d46db230812190918qf22b874n8d8aeea557083df8@mail.gmail.com> <5d46db230812190938r4e8ff994gfcb616c750be0f22@mail.gmail.com> <20081219212536.GA27168@coredump.intra.peff.net> <5d46db230812191424m14e82c5fx1c1c12027db901ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Govind Salinas <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 05:56:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDtsg-00010F-8N
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 05:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbYLTEyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 23:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbYLTEyl
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 23:54:41 -0500
Received: from peff.net ([208.65.91.99]:4885 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbYLTEyk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 23:54:40 -0500
Received: (qmail 21494 invoked by uid 111); 20 Dec 2008 04:54:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 19 Dec 2008 23:54:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Dec 2008 23:54:37 -0500
Content-Disposition: inline
In-Reply-To: <5d46db230812191424m14e82c5fx1c1c12027db901ed@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103621>

On Fri, Dec 19, 2008 at 04:24:01PM -0600, Govind Salinas wrote:

> > I think so. Otherwise how will you push and pull notes? You won't even
> > know which one is the more recent tree, let alone handle any merges
> > caused by editing notes in two places.
> 
> Couldn't you simply merge your tree and theirs even if there is no
> history.  You would have to find a way to handle merges in any event
> since they could just as easily happen if you have a history.

Let's say I have a tree T1 like this:

  $COMMIT_A -> $BLOB_A
  $COMMIT_B -> $BLOB_B1

and a tree T2 like this:

  $COMMIT_B -> $BLOB_B2
  $COMMIT_C -> $BLOB_C

what is the correct merge? Was $COMMIT_A added in T1, or deleted in T2?
How about $COMMIT_C? Even if you went with a strategy like "always add
from both" (which I don't think is a good idea, because deleted notes
will keep popping back up) you have a conflict with $COMMIT_B.  Should
it be B1 or B2? You can't tell if B1 became B2, vice versa, or if there
is a true merge conflict.

> > If the former, then you haven't solved the cruft accumulation problem.
> > You can get obsolete notes in your note history by rebasing on a branch
> > that is long-running (which is OK as long as you haven't published
> > _those particular_ commits). Or are you proposing to rebase and cleanup
> > the notes history every time you do a destructive operation?
> 
> Yes, it does not solve that problem.  But it does solve things like
> 
> Dev1 and Dev2 both have branches A and topic branch B. and they
> are in refs/notes/public (or refs/notes or something not branch specific).
> 
> Dev1 adds 100 notes to topic B, lets say half of them are obsolete due
> to rebases or whatever.  Dev2 pulls A and updates their notes
> as well.  Now Dev2 has acquired all the notes from Dev1 including the
> obsolete ones.  So you have 100 commits, 100 blobs and all the new
> trees that go with them that the user was not interested in.
> 
> Run this across 1000 users and you have a lot of cruft.
> 
> Now, if instead we have a per-branch notes scheme, then you only get
> the cruft from the branches you were interested in.  If you remove the
> history you could end up with no cruft because gc should handle it.

OK. But my point is that this is an incomplete solution. You can _still_
get cruft, and you _still_ have to deal with that cruft some other way.
So we will still end up having to implement something else.  And I might
even be fine with a partial solution that helped some if it didn't come
with a cost, but I think the "notes stick to branches" behavior is
strictly worse.

> > If the latter, then I don't see how you've solved the push-pull and
> > merge problem (which you need history for).
> 
> What git-fetch would have to do is say.  This is a note.  The remote
> sha is not the same as mine, i will treat this as a force and fetch the
> objects without checking history and then run a merge on the 2
> commits.  The notes merge could have its own strategy that checked
> if an object exists before deciding to add a new item or delete a
> removed one.  Then the user would only have to intervene if the
> notes where edited.

I don't like that because:

  - the user is going to end up manually resolving merge conflicts for
    things that _should_ have been fast forwards. But much worse, it's
    going to be on content they may never even have seen before. How
    will they decide which is which?

  - how do you push notes? There's no opportunity to handle the merge
    on the remote side. And you can't just pull, merge locally, and push
    what is now a fast-forward, because there is no concept of
    fast-forward without history.

  - Suddenly pulling and pushing notes isn't just taken care of by the
    usual ref transfer mechanisms. We have to implement a whole new
    system.

> You are correct of course that it will just be wasted space.  But I am
> concerned that it could end up being a lot of wasted space.  I mean, what
> if every person who contributed to the kernel contributed note cruft.  Users

What if every person who contributed to the kernel contributed history
cruft? It's really the same problem, and it is solved by people keeping
their trees clean (via rebase) and being picky about how data comes into
your tree (i.e., don't pull from people with cruft). I suspect Linus
wouldn't pull notes at all (and they wouldn't make it over patch
transmission anyway). But in a workflow that is pulling the notes, the
right time to clean up history is probably before publishing. That is,
you can rebase and clean up your notes history just before you push it
to somewhere public, just like you might clean up messy history.

> If you *really* don't think its something to be worried about then I
> am OK with that since you have a lot more experience with this, but it
> sounds hairy to me.

It is hairy, and I wish there were a better solution. But I think every
other option is much worse.

-Peff
