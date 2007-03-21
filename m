From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT v1.5.1-rc1
Date: Tue, 20 Mar 2007 22:06:05 -0700
Message-ID: <7v648v5goy.fsf@assigned-by-dhcp.cox.net>
References: <20070306063501.GA24355@spearce.org>
	<7v1wk2ua55.fsf@assigned-by-dhcp.cox.net>
	<20070306071630.GB24004@spearce.org>
	<7vtzwyprr7.fsf_-_@assigned-by-dhcp.cox.net>
	<7v8xdth5c4.fsf_-_@assigned-by-dhcp.cox.net>
	<17918.36447.419632.224014@lisa.zopyra.com>
	<7v7itcd8mk.fsf@assigned-by-dhcp.cox.net>
	<20070320025539.GA28922@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 06:06:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTt1k-0007wt-Kv
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 06:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbXCUFGI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 01:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbXCUFGI
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 01:06:08 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:51560 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbXCUFGH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 01:06:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070321050605.KMIK2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 21 Mar 2007 01:06:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dH651W00b1kojtg0000000; Wed, 21 Mar 2007 01:06:06 -0400
In-Reply-To: <20070320025539.GA28922@spearce.org> (Shawn O. Pearce's message
	of "Mon, 19 Mar 2007 22:55:39 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42778>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I was hoping Andy or one of the other folks who have worked on
> that hook would pick up the ball and update the hook, but I
> think they are stuck on the fact that you cannot use:
>
> 	git log $new --not --all
>
> in the post-receive hook to see what commits are "new to this
> repository", as $new is already in --all.  ;-)

As you have the set of refs that were updated and their old and
new commit object names, I do not think it is a problem at all.
Instead of using --all, you can list the old commit object names
for the refs involved in this round of the push and you
enumerate the refs that are _not_ involved in this round of the
push.

But I do not think "new to this repository" is the right thing
to compute in the first place.  In a heavily topic-oriented
development style, you may do something like this:

	$ git checkout -b topic master
        $ git am series.mbox
	$ git checkout next
	$ git merge topic
        $ git push $URL next

The hook would report the commit resulting from patches in
series.mbox after this push, which is fine.

However, after the topic cooks in 'next' and proves to be fine,
the next push would go like this:

	$ git checkout master
        $ git merge topic
        $ git push $URL master

There is no new commit that appeared in the repository with this
push, and there will be no notification sent out, if you do "new
to this repository".

The latter is, however, far more significant event than the
former, from the point of view of overall project history, both
for a casual user who tracks only the primary integration branch
and for a developer who is expected to fork his new work off of
the primary integration branch.  Showing only new commits that
appeared in the repository is absolutely the wrong thing to do.
