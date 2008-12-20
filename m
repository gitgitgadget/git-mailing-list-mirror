From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] Add a documentat on how to revert a faulty merge
Date: Sat, 20 Dec 2008 20:27:02 +0900
Message-ID: <20081220202702.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 12:29:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE01m-000629-Kb
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 12:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbYLTL2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 06:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbYLTL2c
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 06:28:32 -0500
Received: from karen.lavabit.com ([72.249.41.33]:36606 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbYLTL2b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 06:28:31 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 8E050C8409;
	Sat, 20 Dec 2008 05:28:30 -0600 (CST)
Received: from 7613.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 15T3SVFLCGMX; Sat, 20 Dec 2008 05:28:30 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=RyI09Fp23cLJEs9KFjRBQaDhV0vWh9zZ71RNVJ50OSGBsIA+MYTAFCsEpzqrZIayZsQE6PZGjDK42R4rKbaKYS54CNqwrlgc0apLtHbZ7bVRpbT7pj9NOTeNZ9C/US4XeAfIElrtyBldyJSLnv+j3q6c6JVtv6uOAEvJEI3D9QI=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103640>

Linus and Junio explained issues that are involved in reverting a merge
and how to continue working with a branch that was updated since such a
revert on the mailing list.  This is to help new people who did not see
these messages.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 Documentation/howto/revert-a-faulty-merge.txt |  179 +++++++++++++++++++++++++
 1 files changed, 179 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/howto/revert-a-faulty-merge.txt

diff --git a/Documentation/howto/revert-a-faulty-merge.txt b/Documentation/howto/revert-a-faulty-merge.txt
new file mode 100644
index 0000000..c3ef24f
--- /dev/null
+++ b/Documentation/howto/revert-a-faulty-merge.txt
@@ -0,0 +1,179 @@
+Date: Fri, 19 Dec 2008 00:45:19 -0800
+From: Linus Torvalds <torvalds@linux-foundation.org>, Junio C Hamano <gitster@pobox.com>
+Subject: Re: Odd merge behaviour involving reverts
+Abstract: Sometimes a branch that was already merged to the mainline
+ is later found to be faulty.  Linus and Junio give guidance on
+ recovering from such a premature merge and continuing development
+ after the offending branch is fixed.
+Message-ID: <7vocz8a6zk.fsf@gitster.siamese.dyndns.org>
+References: <alpine.LFD.2.00.0812181949450.14014@localhost.localdomain>
+
+Alan <alan@clueserver.org> said:
+
+    I have a master branch.  We have a branch off of that that some
+    developers are doing work on.  They claim it is ready. We merge it
+    into the master branch.  It breaks something so we revert the merge.
+    They make changes to the code.  they get it to a point where they say
+    it is ok and we merge again.
+
+    When examined, we find that code changes made before the revert are
+    not in the master branch, but code changes after are in the master
+    branch.
+
+and asked for help recovering from this situation.
+
+The history immediately after the "revert of the merge" would look like
+this:
+
+ ---o---o---o---M---x---x---W
+               /
+       ---A---B
+
+where A and B are on the side development that was not so good, M is the
+merge that brings those premature changes into the mainline, x are changes
+unrelated to what the side branch did and already made on the mainline,
+and W is the "revert of the merge M" (doesn't W look M upside down?).
+IOW, "diff W^..W" is similar to "diff -R M^..M".
+
+Such a "revert" of the merge can be made with:
+
+    $ git revert -m 1 M
+
+After the develpers of the side branch fixes up, the history may look like
+this:
+
+ ---o---o---o---M---x---x---W---x
+               /
+       ---A---B-------------------C---D
+
+where C and D are to fix what was broken in A and B, and you may already
+have some other changes on the mainline after W.
+
+If you merge the updated side branch (with D at its tip), none of the
+changes made in A nor B will be in the result, because they were reverted
+by W.  That is what Alan saw.
+
+Linus explains the situation:
+
+    Reverting a regular commit just effectively undoes what that commit
+    did, and is fairly straightforward. But reverting a merge commit also
+    undoes the _data_ that the commit changed, but it does absolutely
+    nothing to the effects on _history_ that the merge had.
+
+    So the merge will still exist, and it will still be seen as joining
+    the two branches together, and future merges will see that merge as
+    the last shared state - and the revert that reverted the merge brought
+    in will not affect that at all.
+
+    So a "revert" undoes the data changes, but it's very much _not_ an
+    "undo" in the sense that it doesn't undo the effects of a commit on
+    the repository history.
+
+    So if you think of "revert" as "undo", then you're going to always
+    miss this part of reverts. Yes, it undoes the data, but no, it doesn't
+    undo history.
+
+In such a situation, you would want to first revert the previous revert,
+which would make the history look like this:
+
+ ---o---o---o---M---x---x---W---x---Y
+               /
+       ---A---B-------------------C---D
+
+where Y is the revert of W.  Such a "revert of the revert" can be done
+with:
+
+    $ git revert W
+
+This history would (ignoring possible conflicts between what W and W..Y
+changed) be equivalent to not having W nor Y at all in the history:
+
+ ---o---o---o---M---x---x-------x----
+               /
+       ---A---B-------------------C---D
+
+and merging the side branch again will not have conflict arising from an
+earlier revert and revert of the revert.
+
+ ---o---o---o---M---x---x-------x-------*
+               /                       /
+       ---A---B-------------------C---D
+
+Of course the changes made in C and D still can conflict with what was
+done by any of the x, but that is just a normal merge conflict.
+
+On the other hand, if the developers of the side branch discarded their
+faulty A and B, and redone the changes on top of the updated master branch
+after the revert, the history would have looked like this:
+
+ ---o---o---o---M---x---x---W---x---x
+               /                 \
+       ---A---B                   A'--B'--C'
+
+If you reverted the revert in such a case as in the previous example:
+
+ ---o---o---o---M---x---x---W---x---x---Y---*
+               /                 \         /
+       ---A---B                   A'--B'--C'
+
+where Y is the revert of W, A' and B'are rerolled A and B, and there may
+also be a further fix-up C' on the side branch.  "diff Y^..Y" is similar
+to "diff -R W^..W" (which in turn means it is similar to "diff M^..M"),
+and "diff A'^..C'" by definition would be similar but different from that,
+because it is a rerolled series of the earlier change.  There would be a
+lot of overlapping change that results in conflicts.  So do not do "revert
+of revert" blindly.
+
+ ---o---o---o---M---x---x---W---x---x
+               /                 \
+       ---A---B                   A'--B'--C'
+
+In the history with rebased side branch, W (and M) are behind the merge
+base of the updated branch and the tip of the master, and they should
+merge without the past faulty merge and its revert getting in the way.
+
+To recap, these are two very different scenarios, and wants two very
+different resolution strategies:
+
+ - If the faulty side branch was fixed by adding corrections on top, then
+   doing a revert of the previous revert would be the right thing to do.
+
+ - If the faulty side branch whose effects were discarded by an earlier
+   revert of a merge was rebuilt from scratch (i.e. rebasing and fixing,
+   as you seem to have interpreted), then re-merging the result without
+   doing anything else fancy would be the right thing to do.
+
+However, there are things to keep in mind when reverting a merge (and
+reverting such a revert).
+
+For example, think about what reverting a merge (and then reverting the
+revert) does to bisectability. Ignore the fact that the revert of a revert
+is undoing it - just think of it as a "single commit that does a lot".
+Because that is what it does.
+
+When you have a problem you are chasing down, and you hit a "revert this
+merge", what you're hitting is essentially a single commit that contains
+all the changes (but obviously in reverse) of all the commits that got
+merged. So it's debugging hell, because now you don't have lots of small
+changes that you can try to pinpoint which _part_ of it changes.
+
+But does it all work? Sure it does. You can revert a merge, and from a
+purely technical angle, git did it very naturally and had no real
+troubles. It just considered it a change from "state before merge" to
+"state after merge", and that was it. Nothing complicated, nothing odd,
+nothing really dangerous. Git will do it without even thinking about it.
+
+So from a technical angle, there's nothing wrong with reverting a merge,
+but from a workflow angle it's something that you generally should try to
+avoid.
+
+If at all possible, for example, if you find a problem that got merged
+into the main tree, rather than revert the merge, try _really_ hard to
+bisect the problem down into the branch you merged, and just fix it, or
+try to revert the individual commit that caused it.
+
+Yes, it's more complex, and no, it's not always going to work (sometimes
+the answer is: "oops, I really shouldn't have merged it, because it wasn't
+ready yet, and I really need to undo _all_ of the merge"). So then you
+really should revert the merge, but when you want to re-do the merge, you
+now need to do it by reverting the revert.
-- 
1.6.1.rc3

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
