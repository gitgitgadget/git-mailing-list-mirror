X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: should git download missing objects?
Date: Sun, 12 Nov 2006 11:41:23 -0800
Message-ID: <7vwt60bggs.fsf@assigned-by-dhcp.cox.net>
References: <ej7fgp$8ca$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 12 Nov 2006 19:41:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31272>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjLCq-0006Nv-6z for gcvg-git@gmane.org; Sun, 12 Nov
 2006 20:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752926AbWKLTlZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 14:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752933AbWKLTlZ
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 14:41:25 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:65018 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1752926AbWKLTlY
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 14:41:24 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061112194124.ZUJP5575.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Sun, 12
 Nov 2006 14:41:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id lvgy1V00F1kojtg0000000; Sun, 12 Nov 2006
 14:40:58 -0500
To: "Anand Kumria" <wildfire@progsoc.org>
Sender: git-owner@vger.kernel.org

"Anand Kumria" <wildfire@progsoc.org> writes:

> I did an initial clone of Linus' linux-2.6.git tree, via the git protocol,
> and then managed to accidently delete one of the .pack and
> corresponding .idx files.
>
> I thought that 'cg-fetch' would do the job of bring down the missing pack
> again, and all would be well. Alas this isn't the case.
>
> <http://pastebin.ca/246678>
>
> Pasky, on IRC, indicated that this might be because git-fetch-pack isn't
> downloading missing objects when the git:// protocol is being used.

There are the invariants between refs and objects:

 - objects that its refs (files under .git/refs/ hierarchy that
   record 40-byte hexadecimal object names) point at are never
   missing, or the repository is corrupt.

 - objects that are reachable via pointers in another object
   that is not missing (a tag points at another object, a commit
   points at its tree and its parent commits, and a tree points
   at its subtrees and blobs) are never missing, or the repository
   is corrupt.

Git tools first fetch missing objects and then update your refs
only when fetch succeeds completely, in order to maintain the
above invariants (a partial fetch does not update your refs).
And these invariants are why:

 - fsck-objects start reachability check from the refs;

 - commit walkers can stop at your existing refs;

 - git native protocols only need to tell the other end what
   refs you have, in order for the other end to exclude what you
   already have from the set of objects it sends you.

What's missing needs to be determined in a reasonably efficient
manner, and the above invariants allow us not have to do the
equivalent of fsck-objects every time.  Being able to trust refs
is fairly fundamental in the fetch operation of git.

I am not opposed to the idea of a new tool to fix a corrupted
repository that has broken the above invariants, perhaps caused
by accidental removal of objects and packs by end users.  What
it needs to do would be:

 - run fsck-objects to notice what are missing, by noting
   "broken link from foo to bar" output messages.  Object 'bar'
   is what you _ought_ to have according to your refs but you
   don't (because you removed the objects that should be there),
   and everything that is reachable from it from the other side
   needs to be retrieved.  Because you do not have 'bar', your
   end cannot determine what other objects you happen to have in
   your object store are reachable from it and would result in
   redundant download.

 - run fetch-pack equivalent to get everything reachable
   starting at the above missing objects, pretending you do not
   have any object, because your refs are not trustworthy.

 - run fsck-objects again to make sure that your refs can now be
   trusted again.

To implement the second step above, you need to implement a
modified fetch-pack that does not trust any of your refs.  It
also needs to ignore what are offered from the other end but
asks the objects you know are missing ('bar' in the above
example).  This program needs to talk to a modified upload-pack
running at the other end (let's call it upload-pack-recover),
because usual upload-pack does not serve starting from a random
object that happen to be in its repository, but only starting
from objects that are pointed by its own set of refs to ensure
integrity.

The upload-pack-recover program would need to start traversal
from object 'bar' in the above example, and when it does so, it
should not just run 'rev-list --objects' starting at 'bar'.  It
first needs to prove that its object store has everything that
is reachable from 'bar' (the recipient would still end up with
an incomplete repository if it didn't).

What this means is that it needs to prove some of its refs can
reach 'bar' (again, on the upstream end, only refs are trusted,
not mere existence of object is not enough) before sending
objects back.  Usual upload-pack do not have to do it because it
refuses to serve starting from anything but what its refs point
at (and by the invariants, the objects pointed at by refs are
guaranteed to be complete [an object is "complete" if no object
that can be reachable is not missing]).

This is needed because the repository might have discarded
branch that used to reach 'bar', and while the object 'bar' was
in a pack but some of its ancestors or component trees and/or
blobs were loose and subsequent git-prune have removed the
latter without removing 'bar'.  Mere existence of the object
'bar' does not mean 'bar' is complete.

So coming up with such a pair of programs is not a rocket
science, but it is fairly delicate.  I would rather have them as
specialized commands, not a part of everyday commands, even if
you were to implement it.

Since this is not everyday anyway, a far easier way would be to
clone-pack from the upstream into a new repository, take the
pack you downloaded from that new repository and mv it into your
corrupt repository.  You can run fsck-objects to see if you got
back everything you lost earlier.
