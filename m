From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] improved delta support for git
Date: Wed, 18 May 2005 08:12:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505180754060.18337@ppc970.osdl.org>
References: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain>
 <d6dohe$dql$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 17:41:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYQbA-0006IT-Qs
	for gcvg-git@gmane.org; Wed, 18 May 2005 17:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVERPck (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 11:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVERPcT
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 11:32:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:38026 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262277AbVERPK2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 11:10:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4IFAMU3013508
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 May 2005 08:10:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4IFAL4K000824;
	Wed, 18 May 2005 08:10:22 -0700
To: Dan Holmsand <holmsand@gmail.com>
In-Reply-To: <d6dohe$dql$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 17 May 2005, Dan Holmsand wrote:
> 
> Therefore, I tried some other approaches. This one seemed to work
> best:
> 
> 1) I limit the maximum size of any delta to 10% of the size of the new
> version. That guarantees a big saving, as long as any delta is
> produced.
> 
> 2) If the "previous" version of a blob is a delta, I produce the new
> delta form the old deltas base version. This works surprisingly well.
> I'm guessing the reason for this is that most changes are really
> small, and they tend to be in the same area as a previous change (as
> in "Commit new feature. Commit bugfix for new feature. Commit fix for
> bugfix of new feature. Delete new feature as it doesn't work...").
> 
> 3) I use the same method for all tree objects.

Has anybody tried:

 4) don't limit yourself to previous-history-objects

One of the things I liked best about the delta patches was that it is
history-neutral, and can happily delta an object against any other random
object, in the same tree, in a future tree, or in a past tree.

Even without any history at all, there should be a noticeable amount of 
delta opportunities, as different architectures often end up sharing files 
that are quite similar, but not exactly the same.

Now, that's a very expensive thing to do, since it changes the question of
"which object should I delta against" from O(1) to O(n) (where "n" is tyhe
total number of objects), and thus the whole deltafication from O(n) to
O(n**2), but especially together with your "max 10%" rule, you should be
able to limit your choices very effectively: if you know that your delta
should be within 10% of the total size, you can limit your "let's try that
object" search to other objects that are also within 10% of your object.

That doesn't change the basic expense factor much in theory (if sizes were
truly evenly distributed in <n> it might change it, but there's probably
only a few different "classes" of file sizes, much fewer than <n>, so it's
still probably O(n**2)), but it should cut down the work by some
noticeable constant factor, making it a hopefully realistic experiment.

So your first rule makes a global deltafication cheaper, and in fact,
together with your second rule, you might even decide to make the size 
differential depend on the size of the _compressed_ object, since you 
don't care about objects that have already been deltafied, and if they are 
within 10% of each other, then they should also likely compress similarly, 
and it should thus be pretty equivalent to just compare compressed sizes.

Again, that second optimization wouldn't change the O(n**2) nature of the
expense, but should give another nice factor of speedup, maybe making the
exercise possible in the first place.

As to the long-term "O(n**2) deltafication is not practical for big 
projects with lots of history" issue, doing things incrementally should 
hopefully solve that, and turn it into a series of O(n) operations at the 
cost of saying "we'll never re-delta an object against the future once 
we've found a delta in the past or used it as a base for a delta".

The fsck "scan all objects" code could be a good starting point.

Doing this experiment at least once should be interesting. It may turn out
that the incremental space savings aren't all that noticeable, and that
the pure history-based one already finds 90% of all savings, making the
expensive version not worth it. It would be nice to _know_, though.

		Linus
