From: Tom Lord <lord@emf.net>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 10:34:53 -0700 (PDT)
Message-ID: <200504291734.KAA25263@emf.net>
References: <Pine.LNX.4.58.0504290854270.18901@ppc970.osdl.org>
Cc: mpm@selenic.com, seanlkml@sympatico.ca,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 19:30:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRZJj-0002wI-IC
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 19:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbVD2Rfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 13:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbVD2Rfs
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 13:35:48 -0400
Received: from emf.emf.net ([205.149.0.19]:24841 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S262852AbVD2RfC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 13:35:02 -0400
Received: (from lord@localhost) by emf.net (K/K) id KAA25263; Fri, 29 Apr 2005 10:34:53 -0700 (PDT)
To: torvalds@osdl.org
In-reply-to: <Pine.LNX.4.58.0504290854270.18901@ppc970.osdl.org> (message from Linus Torvalds on Fri, 29 Apr 2005 08:58:37 -0700 (PDT))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


   From: Linus Torvalds <torvalds@osdl.org>

   On Fri, 29 Apr 2005, Tom Lord wrote:
   > 
   > On the other hand, you're asking people to sign whole trees and not
   > just at first-import time but also for every change.

   I don't agree.

Let's be more precise, then.

   Sure, the commit determins the whole tree end result, but if you want to 
   sign the _tree_, you can do so: just tag the actual _tree_ object as "this 
   tree has been verified to be bug-free and non-baby-seal-clubbing".

   But that's not what people do with tags. They sign a _commit_ object. And
   yes, the commit object points to the tree, but it also points to the whole
   history of other commit objects (and thus all historical trees etc), and 
   together with just common sense it is very obvious that what you're really 
   signing is that "point in time".

   If you want to clarify it, you can always just say so in the tag. Instead 
   of saying "I tag this as something I have verified every byte of", you can 
   say "this was what I released as xxx", or "this commit contains my change" 
   or something.


A programmer publishing a change to the kernel has three pieces of 
data in play.  They are:
nn
	1) the ancestry of their modified tree

	2) the complete contents of their modified tree

	3) input data for a patching program (let's call it "PATCH")
	   which, at the very least, satisfies the equation:

		MOD_TREE = PATCH (this_diff, ORIG_TREE)


An upstream consumer, most often, is (should be) using (1) and (3).
In your system, the upstream consumer is given (1) and (2) and must
compute (3) for themselves.   The upstream consumer can also be provided
a signed version of (3) but if clients are mostly relying on the (2)
then there are multiple vulnerabilities there.

The set of pairs of type (1) and (2) is a dual space to the set of
pairs of type (1) and (3).   In that sense, it makes no mathematical
difference whether the programmer signs a {(1),(3)} pair or a {(1),(2)}
pair since either way, the other pair can be trivially derived.

On the other hand, signing documents which represent a {(1),(3)} pair
with robust accuracy is, in most cases, much much less expensive than
signing {(1),(2)} pairs with robust accuracy.  This is a bit like the
difference between "*I* didn't set loose any mice in the house" vs. "I
have searched every corner of the house and swear there are no mice
here."

Another way to say that is that if someone gives me a signed {(1),(3)} pair
I am likely to be much more confident that the signature represents
an in-depth endorsement of the content as opposed to "here is what the 
tools on my system happened to generate -- I hope it's what I meant".


   > If I've changed five files, I should be signing a statement of:
   > 
   > 	1) my belief about the identity of the immediate ancestor tree
   > 	2) a robust summary of my changes, sufficient to recreate my
   > 	   new tree given a faithful copy of the ancestor

   So _do_ exactly that. You can say that in the tag you're signing.

Which is pretty much exactly what Arch does except that, in the case
of Arch, the signed diff is actually used directly to produce the mod
tree.   There isn't a step in the process where a programmer reads
a purported diff, assumes that the signed tree accurately reflects
that diff, and then merges against the signed tree rather than the
diff.

The Arch approach also has the win that the signed diffs are useful
even in the absense of the ORIG_TREE.  In the Arch world, we use this
for the form of selective merging that we call "cherry-picking" (picking
the desired changes from somebody else's line of development while 
skipping those which are not desired -- yet still being able to proceed
with bidirectional merging in a simple way).

The Arch approach also has the win that it amounts to delta-compression,
simplifying the design of efficient transports and helping to tame
I/O bandwidth costs in the local case.   A lot of good features simply
"fall out" of this approach.

This is kind of a yin-yang thing.  It's also valuable, in my view, to
sign {(1),(2)} pairs.  It's also (in a more obscure way) valuable to
sign {(1),(2),(3)} triples, especially if clients are regularly validating
them by making sure the triple describes a true diff application.
So one ultimately wants both functionalities, really.

Signing trees which are really defined by a diff is a handy checksum
on the accuracy of tools which people are using but it isn't a substitute
for signing the diff itself and using it as the primary definition of 
the tree it generates when combined with the immediate ancestor(s).

Signing trees is also handy when that signature is then further linked
to a set of binaries.

Signing trees also is easier to implement and so gets git off the ground
faster.

But there's more to do, if a serious system is desired.

-t

