From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] Looking at multiple ancestors in merge
Date: Wed, 24 Aug 2005 23:32:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508242249030.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Aug 25 05:29:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E88Q6-0003cD-IQ
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 05:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVHYD2p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 23:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbVHYD2p
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 23:28:45 -0400
Received: from iabervon.org ([66.92.72.58]:18951 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964778AbVHYD2p (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 23:28:45 -0400
Received: (qmail 32109 invoked by uid 1000); 24 Aug 2005 23:32:19 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Aug 2005 23:32:19 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7740>

I'm starting to work on letting the merging process see multiple
ancestors, and I think it's messy enough that I should actually discuss
it.

Review of the issue:

It is possible to lost reverts in cases when merging two commits with
multiple ancestors, in the following pattern: (letters representing blobs
at some filename, children to the right)

a-b-b-a-?
 \ X   /
  a-b-b

You form a branch with unrelated changes, apply a patch in the top line,
separately merge both ways, do unrelated development in the bottom line,
and revert the patch in the top line. Then you're trying to merge the two
lines. There are two candidates for the common ancestor, the two in the
second column. If you pick the top one, you get the revert; if you pick
the bottom one, you don't. This is a bug, because it ignores the 'a'
version due to it being "unchanged", but it actually did change and
changed back.

Note that the revert is going to also be ignored if there isn't the "X" in
the middle of that diagram and the a->b change on the bottom is due to
independantly applying the same patch. Users are more likely to expect
this, however, than the situation above, where the side that is causing
the patch to be included never applied it explicitly at all; it just
merged at an unfortunate moment.

My theory is that we should handle merges by passing all of the ancestors
to read-tree, and having it use the following additions to the rules for
trivial merges:

 - If any of the ancestors matches a side, don't use that side
 - If you eliminate both side, don't do the trivial merge

(The first of these also means that it'll pick the best combination of
ancestors for maximizing trivial merges, as a nice side effect; the second
means that it'll avoid messing up with reverts when it has a chance of
understanding them)

If it doesn't do the trivial merge, it just puts the blob from the first
listed ancestor in stage 1, rather than trying anything fancy.

(As a further improvement, we could actually look through the history for
reasons to disregard a similarity, which would determine that there isn't
a continuous line of similarity from the recent 'a' to the common ancestor
'a', and therefore that it should be retained; but I'll be satisfied for
now with having it just not do the incorrect trivial merge.)

Of course, this is going to take a bit of work, because read-tree
currently puts all of its arguments into the cache and then works on
merging, and taking multiple ancestors requires putting them somewhere
else, because they won't fit in the cache.

	-Daniel
*This .sig left intentionally blank*
