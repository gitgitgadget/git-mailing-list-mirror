From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Tue, 23 Aug 2005 14:05:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508231304130.23242@iabervon.org>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com>
 <20050819194832.GA8562@fanta> <1124572356.7512.21.camel@localhost.localdomain>
 <20050821094059.GA5453@fanta> <Pine.LNX.4.63.0508221707520.23242@iabervon.org>
 <tnxvf1wd24m.fsf@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Veldeman <jan.veldeman@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 20:04:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7d6T-0008Ni-Eg
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 20:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVHWSCZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVHWSCZ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 14:02:25 -0400
Received: from iabervon.org ([66.92.72.58]:10513 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932266AbVHWSCZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 14:02:25 -0400
Received: (qmail 14036 invoked by uid 1000); 23 Aug 2005 14:05:57 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Aug 2005 14:05:57 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxvf1wd24m.fsf@arm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7662>

On Tue, 23 Aug 2005, Catalin Marinas wrote:

> > So the point is that there are things which are, in fact, parents, but we
> > don't want to list them, because it's not desired information.
>
> What's the definition of a parent in GIT terms? What are the
> restriction for a commit object to be a parent? Can a parent be an
> arbitrarily chosen commit?

Something is legitimate as a parent if someone took that commit and did
something to it to get the new commit. The operation which caused the
change is not specified. But you only want to include it if anyone cares
about the parent.

(For example, I often start with a chunk of work that does multiple things
and is committed; I take mainline and generate a series of commits from
there. It would be legitimate to list my development commit as a parent of
each of these, since I did actually take it and strip out the unrelated
changes. This would be a bit confusing in the log, but would make merges
between something based on the "messy" version and something based on the
"refined" version work well. On the other hand, I don't want to report the
existance of the messy version, so I don't include it.)

> An StGIT patch is a represented by a top and bottom commit
> objects. The bottom one is the same as the parent of the top
> commit. The patch is the diff between the top's tree id and the
> bottom's tree id.
>
> Jan's proposal is to allow a freeze command to save the current top
> hash and later be used as a second parent for the newly generated
> top. The problem I see with this approach is that (even for the
> internal view you described) the newly generated top will have two
> parents, new-bottom and old-top, but only the diff between new-top and
> new-bottom is meaningful. The diff between new-top and old-top (as a
> parent-child relation) wouldn't contain anything relevant to the patch
> but all the new changes to the base of the stack.

Having a useful diff isn't really a requirement for a parent; the diff in
the case of a merge is going to be the total of everything that happened
elsewhere. The point is to be able to reach some commits between which
there are interesting diffs.

This also depends on how exactly freeze is used; if you use it before
commiting a modification to the patch without rebasing, you get:

old-top -> new-top
      ^    ^
       \  /
      bottom

bottom to old-top is the old patch
bottom to new-top is the new patch
old-top to new-top is the change to the patch

Then you want to keep new-top as a parent for rebasings until one of these
is frozen. These links are not interesting to look at, but preserve the
path to the old-top:new-top change, which is interesting.

Ignoring the links to the corresponding bottoms, the development therefore
looks like:

local1 -> local2 -> merge -> local3 -> merge
^                   ^                  ^
mainline---->-->--------->------>-->----->

And this is how development is normally supposed to look. The trick is to
only include a minimal number of merges.

	-Daniel
*This .sig left intentionally blank*
