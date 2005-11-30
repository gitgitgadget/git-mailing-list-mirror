From: linux@horizon.com
Subject: Re: git-name-rev off-by-one bug
Date: 29 Nov 2005 19:15:03 -0500
Message-ID: <20051130001503.28498.qmail@science.horizon.com>
References: <7vsltf6o8f.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org, linux@horizon.com, pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Nov 30 01:17:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhFcr-00007H-QN
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 01:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbVK3APF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 19:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbVK3APF
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 19:15:05 -0500
Received: from science.horizon.com ([192.35.100.1]:50736 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751422AbVK3APE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 19:15:04 -0500
Received: (qmail 28499 invoked by uid 1000); 29 Nov 2005 19:15:03 -0500
To: junkio@cox.net
In-Reply-To: <7vsltf6o8f.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12974>

> It is not silly.  Actually we have "been there, done that".

Um, okay, but I don't see why you changed...

> We used to leave the higher stages around in the index after
> automerge failure.  Note that you would not just have stage2 in
> such a case.  stage1 keeps the common ancestor, stage2 has what
> you started with, and stage3 holds the version from other
> branch.  diff-stages can be used to diff between these stages.
> We _could_ have added feature to either diff-stages or
> diff-files to compare between stageN and working tree.

Yes, exactly.  This is what I expected.

> However, this turned out to be not so convenient as we wished
> initially.  What you would do after inspecting diffs between
> stage1 and stage3, between stage2 and stage3 and between stage1
> and stage2 typically ends up doing what "merge" have tried (and
> failed) manually anyway, and being able to find the conflict
> markers by simply running "git diff" was just as good, except
> that we risk getting still-unresolved files checked in if the
> user is not careful.

You seem to be saying that producing a merge with conflict markers is
what you (almost) always want, so it's the default.  No objections.

But why collapse the index and only keep stage2?  Why not leave all
stages in the index *and* the merge-with-conflict-markers in the working
directory?

They you could, for example, try alternate single-file merge algorithms
on the conflict, or regenerate the conflict markers if you wanted.
By keeping all of the source material around until the user has decided
on a resolution, you achieve maximal flexibility.

This is no more effort for the user to use in the common case (edit the
conflicts and git-update-index), but lets you try various things in the
working directory and eaily back out of them.  ("git-merge-index -s manual
-a" would regenerate all of the conflict markers.)  And it prevents a
checkin until the matter has been resolved.


I'm wondering if this isn't a philosophical issue.  One side says that,
since all automated merging is complete, the stages should be collapsed.
To me, it makes more sense to leave out the adjective "automated" and
consider the merge to be incomplete; we're just putting the user in the
loop when software fails.
