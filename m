From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Add merge-base
Date: Sun, 17 Apr 2005 12:36:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171205190.30848-100000@iabervon.org>
References: <20050417160106.GI1487@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 18:33:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNChW-0001cP-Gh
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 18:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVDQQgk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 12:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVDQQgk
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 12:36:40 -0400
Received: from iabervon.org ([66.92.72.58]:45060 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261354AbVDQQgd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 12:36:33 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNClP-0000GQ-00; Sun, 17 Apr 2005 12:36:51 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050417160106.GI1487@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Petr Baudis wrote:

> Dear diary, on Sun, Apr 17, 2005 at 05:27:13PM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > merge-base finds one of the best common ancestors of a pair of commits. In
> > particular, it finds one of the ones which is fewest commits away from the
> > further of the heads.
> 
> What does it return when I have
> 
>   A -- C
>     \/   \
>     /\   /
>   B -- D
> 
> ? >:)
> 
> I assume just either A or B, randomly?

Essentially, yes.

> I think it would be best if it could list all the "first-class" matches
> (both A and B in this case), each on a separate line; this way the
> overlay tools could choose an algorithm to evaluate those further as
> they see fit - e.g. sort them by time (you might aid that by listing the
> commit time in front of them), then take the first n and try to diff
> them all and take the one with least changes (as suggested by Linus).

It's actually kind of tricky to get all of the "best" ancestors without
getting any useless ancestors; the "best" criterion is maintained in the
current version by stopping as soon as possible.

I think that the real solution would be to have a merge program that
interacts back and forth with the revision history processor, since I
think that merges for which the choice of ancestor matters (for whether it
gives a conflict) would benefit most directly and clearly from figuring
out the histories of the conflicting changes, not choosing different
ancestors.

If someone comes up with an algorithm that wants an alternative ancestor
rather than more interactive stuff, I can work on getting a complete list.

> > Index: merge-base.c
> > ===================================================================
> > --- /dev/null  (tree:37a0b01b85c2999243674d48bfc71cdba0e5518e)
> > +++ d662b707e11391f6cfe597fd4d0bf9c41d34d01a/merge-base.c  (mode:100644 sha1:0f85e7d9e9a896d1142a54170ddf1159f11f9cdd)
> > @@ -0,0 +1,108 @@
> > +#include <stdlib.h>
> > +#include "cache.h"
> > +#include "revision.h"
> > +
> > +struct revision *common_ancestor(struct revision *rev1, struct revision *rev2)
> > +{
> > +	struct parent *parent;
> > +
> > +	struct parent *rev1list = malloc(sizeof(struct parent));
> > +	struct parent *rev2list = malloc(sizeof(struct parent));
> 
> Did I overlook anything or you could have just a single revlist?

I tried with just one, but I couldn't keep it straight in my
head. rev1list holds the unmarked ancestors of rev1; rev2list holds the
unmarked ancestors of rev2.

> > +	struct parent *posn, *temp;
> > +
> > +	rev1list->parent = rev1;
> > +	rev1list->next = NULL;
> > +
> > +	rev2list->parent = rev2;
> > +	rev2list->next = NULL;
> > +
> > +	while (rev1list || rev2list) {
> > +		posn = rev1list;
> > +		rev1list = NULL;
> > +		while (posn) {
> > +			parse_commit_object(posn->parent);
> > +			if (posn->parent->flags & 0x0001) {
> > +				/*
> > +				printf("1 already seen %s %x\n",
> > +				       sha1_to_hex(posn->parent->sha1),
> > +				       posn->parent->flags);
> > +				*/
> > +                                // do nothing
> 
> Mostly for consistency, I'd prefer you to use /* */ comments in general.

Sure.

> I think a terrified squeak at stderr in this situation (possibly
> suggesting fsck-cache) might be appropriate.

No, this is normal; it indicates that tree 1 has a recent little merge:

orig --------------- tree 2
 \
  --- X -- Y -- Z -- tree 1
       \       /
        -- A --

When we see X for A, we've already seen it for Y, but that's fine. I get
this case when I merge with you after you merge twice with Linus since I
last merged.

> > +			} else if (posn->parent->flags & 0x0002) {
> > +                                // XXXX free lists
> 
> Hmm, so, why not free the lists?

Ah, details; mainly, I want to wait until revision.h is cleaner before
fixing this sort of thing.

> Symmetrical notes apply to this half. Actually, they are too similar.
> What about factoring them to a common function?

Sure.

Fixed version to follow.

	-Daniel
*This .sig left intentionally blank*

