From: Junio C Hamano <junkio@cox.net>
Subject: Re: Best practices for developing multiple related branches simultaneously
Date: Sat, 07 Apr 2007 21:54:55 -0700
Message-ID: <7v7isnbh40.fsf@assigned-by-dhcp.cox.net>
References: <d4cf37a60704071957r7bb907eg84180097a4594f43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Wink Saville" <wink@saville.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 06:55:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaPQz-00076F-86
	for gcvg-git@gmane.org; Sun, 08 Apr 2007 06:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbXDHEy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 00:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbXDHEy5
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 00:54:57 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42438 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbXDHEy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 00:54:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070408045457.IEGV28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Apr 2007 00:54:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kUuv1W00J1kojtg0000000; Sun, 08 Apr 2007 00:54:56 -0400
In-Reply-To: <d4cf37a60704071957r7bb907eg84180097a4594f43@mail.gmail.com>
	(Wink Saville's message of "Sat, 7 Apr 2007 19:57:29 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43996>

"Wink Saville" <wink@saville.com> writes:

> A couple of questions on how to manage a series of
> hierarchically related branches.
>
> I've created something like this:
>
> ----> master
>    \----> branchA
>         \----> branchB
>              \----> branchC
>
> With the intent to be able to create three separate
> patches that others can make to master and also continue
> development on all three branches simultaneously.
>
> What I'm doing at the moment is to "git-checkout"
> one of the three branches A, B or C and make changes.
> Note; I don't make changes to master as it represents the
> upstream code and will be pulling from it periodically.
>
> If the branch is a parent to a child and I want the
> new changes in the parent to be seen by the children I
> recursively check out the immediate child do a git-rebase.

This depends on how you plan to ultimately use the result of
work done on the topic branches.  If you are feeding the
completed series as a set of patches to upstream to be applied
(and eventually contained when you pull into 'master'), this
"master is always pristine, topics are constantly rebased on top
of it" pattern is a reasonable thing to do.  With a few caveats:

 * It is harder to share the topics across multiple people as
   you are constantly rebasing.

 * As you found out, you need to keep track of which ones come
   directly on top of 'master', which ones are second generation
   on top of which other branches, etc.

You do not necessarily have to be constantly rebasing on top of
'master', though.  You can instead:

 - Keep 'master' pristine (as your upstream does not 'pull' from
   you);

 - When you start a topic, try to fork from the branch closest
   to 'master' (preferrably 'master' itself);

 - When there are new changes on 'master' (or topic that is
   closer to 'master') that affect the work you did on your
   topic, merge 'master' into the topic, and keep going, never
   rebasing the topic.  This 'merging from upstream as needed'
   includes the case where your submission was applied to
   'master'.

As you go, when all the work you are done on a topic has been
applied to 'master', your 'merge from master' would result in
the tree of that topic exactly match the tree of 'master'.  At
that point you can discard that topic branch.

The set of changes you have on a topic that have not been
applied to 'master' can be found using 'git-cherry'.

> Also, I'd like to checkout and work on all three branches
> simultaneously.

Julian Phillips's git-new-workdir script in contrib/workdir may
suit your needs.

Having said all that, the first advice is to avoid second
generation topic that depends on another topic when possible.
Is your branchB absolutely need to depend on branchA?
