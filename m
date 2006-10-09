From: Junio C Hamano <junkio@cox.net>
Subject: Re: "fatal: Untracked working tree file 'so-and-so' would be overwritten by merge"
Date: Sun, 08 Oct 2006 21:48:11 -0700
Message-ID: <7v7izaf62c.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610081657400.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 09 06:48:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWn3x-0001I6-J7
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 06:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWJIEsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 00:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWJIEsM
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 00:48:12 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:8840 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750705AbWJIEsM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 00:48:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061009044811.QVJX21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Oct 2006 00:48:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y4oE1V00Y1kojtg0000000
	Mon, 09 Oct 2006 00:48:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610081657400.3952@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 8 Oct 2006 17:11:01 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28561>

Linus Torvalds <torvalds@osdl.org> writes:

> Hmm. I'm getting this message annoyingly often, simply because a few files 
> that used to be tracked are now generated, and so they exist in my tree 
> but are no longer tracked.
>
> However, they may be tracked in an older tree that I pull, because in that 
> older tree they _do_ exist, and we get the
>
> 	fatal: Untracked working tree file 'so-and-so' would be overwritten by merge.
>
> which is actually incorrect, because the merge result will not even 
> _contain_ that untracked file any more.

> So the message is misleading - we should only consider this a fatal thing 
> if we actually do generate that file as part of a git-read-tree, but if a 
> merge won't touch a file, it shouldn't be "overwritten".
>
> It's true that if the _other_ end actually removed a file that we used to 
> have (ie the file _disappears_ as part of the merge), then we should 
> verify that that file matched what we're going to remove, but if the old 
> index didn't contain the file at all, and the new index won't contain it 
> either, it really should be a no-op.

True.

I think it is verify_absent() on l.665 in threeway_merge().

	if (index) {
		verify_uptodate(index, o);
	}
	else if (path)
		verify_absent(path, "overwritten", o);

	o->nontrivial_merge = 1;

We say "we know this path is involved in the non-trivial merge;
if the current index has it, it had better be up-to-date" (the
first "if").  I think that up to that check is fine.

However, we say that otherwise, the path should not exist in the
working tree; this should not be done unconditionally.  As you
say, the check should depend on the merge result.

But that is a bit tricky.  This is not on the aggressive path,
and the merge result is decided by the policy implemented by the
caller of read-tree.  So in that sense we should not be doing
the working tree check ourselves either.  We just should leave
that to the caller.

Hence, I think removing the above "else if" part altogether is
the right thing to do here.

---
diff --git a/unpack-trees.c b/unpack-trees.c
index 3ac0289..b1d78b8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -661,8 +661,6 @@ int threeway_merge(struct cache_entry **
 	if (index) {
 		verify_uptodate(index, o);
 	}
-	else if (path)
-		verify_absent(path, "overwritten", o);
 
 	o->nontrivial_merge = 1;
 
