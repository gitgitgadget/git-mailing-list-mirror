From: Johan Herland <johan@herland.net>
Subject: Re: Tag refspecs (was Re: [PATCH] Remove restriction on notes ref base)
Date: Fri, 05 Nov 2010 02:02:16 +0100
Message-ID: <201011050202.16931.johan@herland.net>
References: <1288657003-17802-1-git-send-email-kroot@google.com>
 <201011040149.47968.johan@herland.net> <4CD2C49A.8010309@xiplink.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Kenny Root <kroot@google.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Nov 05 02:02:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEAhJ-0008Ko-RT
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 02:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126Ab0KEBCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 21:02:23 -0400
Received: from smtp.getmail.no ([84.208.15.66]:45018 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770Ab0KEBCW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 21:02:22 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBE00F8J07UT300@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 05 Nov 2010 02:02:18 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 470E417995B4_CD3579AB	for <git@vger.kernel.org>; Fri,
 05 Nov 2010 01:02:18 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id C0BA71799577_CD35799F	for <git@vger.kernel.org>; Fri,
 05 Nov 2010 01:02:17 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBE0042307T1F00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 05 Nov 2010 02:02:17 +0100 (MET)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.3; x86_64; ; )
In-reply-to: <4CD2C49A.8010309@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160794>

On Thursday 04 November 2010, Marc Branchaud wrote:
> On 10-11-03 08:49 PM, Johan Herland wrote:
> > I'd probably suggest a more straightforward (and hopefully less
> > confusing)
> > 
> > setup like this:
> >   Remote repo    ->   Local repo
> >   ------------------------------------------------
> >   refs/heads/*        refs/remotes/$remote/heads/*
> >   refs/tags/*         refs/remotes/$remote/tags/*
> >   refs/notes/*        refs/remotes/$remote/notes/*
> > 
> > ...and these would all be set in the config, i.e. no implicit/magic
> > refspecs.
> 
> I'll second this proposal, at least as far as tags go.  I can offer two
> reasons to support this.
> 
> 
> First, I think the assumption that tags are immutable is too strong.  In
> our repo, we try to keep our topic branches mergeable into both the
> "master" and "maintenance-of-the-latest-release" branches.
> 
> This means the topic branches need to be based at the point where the
> maintenance and master branches diverged.  Making this rule easy to
> follow is best accomplished with a tag, e.g. "topic-base", but that tag
> will move when we create a new maintenance branch for a new release. 
> With the current tag semantics, when that happens everyone has to delete
> their local topic-base tags and get the new one from the common/shared
> repo.  People who forget to do this end up basing their topics on
> outdated code, with predictable results.
> 
> It would be much easier to be able to just use an "origin/topic-base" tag
> instead, one that that tracks the topic-base tag in the origin repo.

Actually, this is not a valid reason. To me, it sounds like your "topic-
base" tag _really_ should be a "topic_base" _branch_. The branch is 
initialized to the merge-base between "master" and "maintenance-of-the-
latest-release" branches, and when you create a new maintenance branch, the 
"topic-base" branch is fast-forwarded along the master branch until it 
reaches the merge-base with the new maintenance branch. (Remember that 
branches really are nothing but named pointers into the commit graph, and as 
long as the "topic-base" branch stays within the history of the "master" 
branch, it does not constitute a proper "branch", i.e. a fork in the commit 
history.)

IMHO, tags should still be very much immutable.

However, when working with remotes, you may get into a situation where the 
same tag name is independently set in different repos pointing at different 
commits. When these repos fetch from eachother, the tag name collision will 
be ignored, and each repo will keep their local version of the tag. Git 
will, AFAIK, not alert you to the tag name collision, and even after you 
identify the collision, it is not always easy to resolve it [1]. However, if 
we namespace remote tags (like we already do with remote branches), it is 
much easier to review which commits each remote has associated with a given 
tag name, and it's also much simpler to resolve which remote's tag you want 
to use in your own repo. (e.g. "git tag xyzzy refs/remotes/foo/tags/xyzzy").

> Second, I agree with Johan that the current semantics are confusing.  I'm
> basically the git guru here at work, so it falls to me to teach people
> how git works and how to use it.  I find that once people wrap their
> minds around the concept of remote and local branches, they get tripped
> up by the way tags work.
> 
> IMHO it would be more intuitive if tags used the same local/remote
> semantics as branches.

I am in much the same situation at my $dayjob, and I can only agree.


...Johan


[1]: Resolving tag collisions currently involves removing the tag from one 
repo and re-fetching from the other, or writing a custom refspec to rename 
the tag when fetching.


-- 
Johan Herland, <johan@herland.net>
www.herland.net
