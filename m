From: linux@horizon.com
Subject: Re: A look at some alternative PACK file encodings
Date: 7 Sep 2006 11:01:43 -0400
Message-ID: <20060907150143.14238.qmail@science.horizon.com>
References: <9e4733910609070719g42ff7d9buf4b798a9c6b3a7ee@mail.gmail.com>
Cc: git@vger.kernel.org, gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 07 17:02:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLLO9-0005W7-8Z
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 17:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbWIGPBy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 11:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWIGPBx
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 11:01:53 -0400
Received: from science.horizon.com ([192.35.100.1]:18486 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751793AbWIGPBw
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 11:01:52 -0400
Received: (qmail 14239 invoked by uid 1000); 7 Sep 2006 11:01:43 -0400
To: jonsmirl@gmail.com, linux@horizon.com
In-Reply-To: <9e4733910609070719g42ff7d9buf4b798a9c6b3a7ee@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26643>

> Yes I missed the thin pack context. Has anyone tried building a thin
> pack? Having thin packs would address major concerns with the download
> time of the initial Mozilla checkout. Right now you have to download
> 450MB of data that 99% of the people are never going to look at.

Unfortunately, no, it wouldn't.  There's a second misunderstanding here:
thin packs are used by the git on-the-wire protocol to send a delta
relative to an object *that you know the recipient already has*.

This can greatly speed up incremental updates.  It does NOT have
any effect on the initial checkout, because you know the recipient
has nothing, so you have to send everything.


What you seem to be talking about is what people call a "shallow clone".
Unfortunately, making a shallow clone is difficult for reasons that
are deeply embedded in git's incremental update protocol.

When you fetch from a remote repository, it needs to figure out what
you need and what you already have.  The fundamental assumption which
the protocol uses to send this efficiently is that if you have a commit
object, you have all its ancestors, and their trees and blobs.

So you can say "I have 60d4684068ff1eec78f55b5888d0bd2d4cca1520"
(which is the commit behind tags/v2.6.18-rc5 from the Linux kernel)
and the server you're pulling from knows a lot about what you have.

The first hard part about a shallow repository is describing *efficiently*
to git-upload-pack what you don't have.

The second is figuring out what you should get.

Suppose that you clone from a repository that has a linear chain
of development, and you cut off everything before version X.
Simple enough so far.

Then you try to pull from someone whose work branched off at version
X-1.  Do you want to fetch everything back to the common ancestor?
If you want to cut off their branch, where do we cut it off?  A simple
timestamp limit?  What if you get a bogus timestamp on a commit?

This has been considered by git developers quite carefully and is NOT
an easy problem.  A solution is welcomed, but if you come up with an
easy one, please spend a few minutes considering the possibility that
the reason it's so easy is that your solution is flawed.

There are also problems giving sensible error messages if you try to
refer to a missing object and making your clone deeper if desired,
but those are secondary to the big problems.

> I'm not sure I would mix these external references in with other
> objects. Instead I would make a pair of packs, one only contains
> external reference stubs and is tiny. The second is the full version
> of the same data. That makes getting the old data easy, it just
> replaces the stub pack. The stub pack doesn't need to contain stubs
> for all the objects, only the ones referenced upstream.

Huh??  This is flatly impossible, and completely defeats the purpose.
This is one of those "Pray, Mr. Babbage, if you put into the machine
wrong figures, will the right answers come out?" questions.
I think there is a *serious* miscommunication here.

I have a delta-compressed object.  It is stored in the pack as a series
of changes to some base object.  To be of any use, it needs to identify
that base object.  If the base object identification takes the form of
an intra-pack offset (the new proposal) as opposed to a global 20-byte
object ID, then the base object needs to be stored *intra-pack*.
Within the same pack.

The whole idea is "hey, we don't allow delta-ing relative to objects
not in the pack anyway, so why waste space storing such large pointers?"

This would make the currently forbidden case of a delta relative to
an object not in the same pack completely impossible.  It's like
asking for the square root of 2 in roman numerals.

> I haven't tried doing this, does the current git code support having
> multiple pack files covering difference pieces of the project? Can we
> have an archive pack and a local current pack that get merged
> together?

Yes, it supports it perfectly.  A pack is just a bag of objects.  There is
zero required higher-level structure.  In particular, you can have a
"100% blobs" pack with no tree or commit objects at all.

Git uses the object relationships in its compression heuristics, but
it has no effect on correctness.

The only thing is that the original pack was a *self-contained* bag of
objects; every object in the pack could be reconstructed given only the
pack itself.  In particular, cross-pack deltas were forbidden.

However, then someone realized that making an exception for git protocol
updates would be easy and a Really Good Thing.  A pack that is missing
one or more base objects is called a "thin pack".

So the rule I mentioned above has already been broken.  Supporting
that is what I'm talking about.
