From: "George Spelvin" <linux@horizon.com>
Subject: Re: Git commit generation numbers
Date: 17 Jul 2011 19:39:59 -0400
Message-ID: <20110717233959.3548.qmail@science.horizon.com>
References: <CA+55aFwqFhzd_cmbFxkCyNXhF99igBqdr8p4J76hLz=m4=ZNWg@mail.gmail.com>
Cc: git@vger.kernel.org
To: linux@horizon.com, torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Mon Jul 18 01:40:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiawT-00051l-0r
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 01:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010Ab1GQXkC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 19:40:02 -0400
Received: from science.horizon.com ([71.41.210.146]:23616 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755943Ab1GQXkA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 19:40:00 -0400
Received: (qmail 3549 invoked by uid 1000); 17 Jul 2011 19:39:59 -0400
In-Reply-To: <CA+55aFwqFhzd_cmbFxkCyNXhF99igBqdr8p4J76hLz=m4=ZNWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177323>

> So the generation number really is very very fundamnetal. It's
> absolutely not some "additional information that can be computed",
> because the whole AND ONLY point of having the number is to not
> compute it.
> 
> We are never interested in the generation number for its own sake. We
> are only interested in it in order to avoid having to look at the rest
> of the DAG.

You're making my point and somehow not seeing it.

What you're describing here is the archetpical cache.

The only reason for having a memory cache is to avoid accessing memory!
The only reason for having a TLB is to avoid walking the page tables!
The only reason for having a page cache is to avoid hitting the disk!
The only reason for having a dcache is to avoid traversing the file
system directories!

And yes, the only reason for having a generation number cache is to avoid
traversing the DAG.  D'oh.  Do you think this is somehow news to anyone?

The fundamental nature of a cache is that it lets you look something up
quickly that you could compute but don't want to.

I'm slapping my forehead like Homer Simpson here.  The fact that computing
the generation number is expensive is why it's worth cacheing.  But the
fact that it *can* be computed is a reason not to clutter the published
commit object format with it.


The generation number is NOT FUNDAMENTAL.  It contains no information
that's not already in the DAG.  The danger of putting it into a commit
is that you'll do it wrong, and thereby screw everything up.

If we have broken code that generates a broken cache, we fix the code
and the bugs magically go away.

If we have broken code that generates a broken commit object, we have
a huge problem.

Just like we don't ship pack indexes around, but recompute them on arrival.
The index is essential for performance, but it's absolutely non-essential
for correctness.


As a general design principle, the exported data structures, like the
commits, should be as simple as possible.  Do not include extraneous
or redundant data, because then you have to deal with the possibility
of inconsistency.  This leads to bugs.  (Frequently buffer overflow bugs.)

Maybe it would have been worth violating that principle during the initial
git design.  I still see a good argument for not doing that even if we
had a time machine.

But now that the commit format is established and widely used, the argument
has far more force.  Changing the commit format provides zero functionality
gain, and the performance gain can be obtained a different way.

Maybe a bit more code, but nothing extraordinary.

To me, the KISS principle says "don't change the commit format!"

Now, you complain about code complexity.  But this is a read-only cache.
The generation number of a commit object never changes.  There's no update
operation.  Like an I-cache, if there's ever any problem, throw it away.

Arguing that "the patch to put it in the commit object is smaller" is
stupidly short-sighted.  Now every version of git from now until forever
has to support both kinds of commit objects.  (And browsing old git
trees will forever be slow.)

You only take on that sort of legacy support burden if you absolutely have to.

> But "just because we could recompute it" is a bad bad reason.

Bull puckey.  You're ugly and stupid and WRONG.

It's an excellent reason.  I'm amazed that you're not seeing it.
The principle is "don't include redundant data in a transport format."
Because it can be recomputed, it's redundant.  Therefore, it shouldn't
be included in the transport format.

It's exactly the same principle as "don't store the indexes in the
database dump" and "don't store filename hashes in file system
archives".

This is a principle, not an iron-clad rule.  It can be violated for
good and sufficient reasons, notably performance.

But in this case, we can get the performance without it.  Without,
in fact, changing the git transport format at all.

And "don't change a widely-used transport format" is ANOTHER important
principle.  Backward-compatible is much better than incompatible, but
far better to avoid changing it at all.

Breaking two such principles without an absolutely iron-clad reason is
ugly and stupid and wrong.

(As you well know, the more general principle is "don't store redundant
data AT ALL unless you need to for performance".  Redundant data is A
Bad Thing.  It can get out of sync.  But if you have to, a private cache
is much better than a exchange format.)


Put another way, it IS stupid, it IS expendable, and therefore it SHOULD go.
