From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Detached HEAD warning (again)
Date: Wed, 01 Apr 2009 13:41:49 -0700
Message-ID: <7vr60ct8c2.fsf@gitster.siamese.dyndns.org>
References: <9099EAF5-6B43-4F15-A905-9E21B45B7AE9@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Wed Apr 01 22:43:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp7Hg-0000IB-PF
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 22:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758744AbZDAUmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 16:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758411AbZDAUmA
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 16:42:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738AbZDAUl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 16:41:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E20CFA7CA6;
	Wed,  1 Apr 2009 16:41:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A66F0A7CA4; Wed,
  1 Apr 2009 16:41:53 -0400 (EDT)
In-Reply-To: <9099EAF5-6B43-4F15-A905-9E21B45B7AE9@ai.rug.nl> (Pieter de
 Bie's message of "Mon, 30 Mar 2009 17:09:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8AA02A72-1EFD-11DE-B4E8-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115415>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> I strongly remember there being a discussion about this a few weeks ago,
> but I can't find it. Basically, someone wanted to introduce a warning
> every time someone commits on a detached HEAD. This was shot down
> because there already is a big warning when you detach your HEAD (with
> which I agree).
>
> However, someone here: http://news.ycombinator.com/item?id=538619
> pointed to an example here: http://book.git-scm.com/5_submodules.html ,
> which works with submodules:
>
> 	$ git submodule update --init
> 	# sub/ is created
> 	$ (cd sub && touch a && git add a && git commit -am "Add new file")
> 	[detached HEAD 8641889] Add new file
> 	 0 files changed, 0 insertions(+), 0 deletions(-)
> 	 create mode 100644 a
>
> 	$ git submodule update
> 	$ ls sub/a
> 	ls: sub/a: No such file or directory
>
> Now, it DOES say 'detached HEAD', but I still think this is something
> easily missed and something that can cause a lot of confusion. Perhaps a
> warning in such cases wouldn't hurt?

There are two distinct uses of detached HEAD state.

 * Sight-see.  Jump around in various points in history in order to check
   the contents inside work tree.  "git checkout vX.Y.Z" tag to build the
   released version and running bisect are examples of such uses.

 * Rebuilding history outside of any branch.  You could:

	... on "topic" that is to be rewritten ... 
	$ git checkout -b topic-2
        $ git rebase -i master
	... check the result, compare it with the original ...
	$ git show-branch topic topic-2
        $ git diff topic topic-2
	... wrap it up ...
        $ git branch -f topic
        $ git checkout topic
        $ git branch -D topic-2

   but it often is more convenient to detach the HEAD at the fork point of
   it:

	$ git checkout topic^0
        $ git rebase -i master
        $ git show-branch topic HEAD
        $ git diff topic HEAD
        $ git branch -f topic
        $ git checkout topic

When switching branches between superproject branches that have different
commits at one submodule, you may need to have a checkout of the matching
commit in the submodule directory.  From the superproject's point of view,
a submodule is not something you are developing directly (you may debug
and perform other observation of what is in submodule) inside its context,
iow inside the superproject's checkout.  A submodule is a shared resource
among multiple superprojects, does not belong to a particular
superproject, and inside one particular superproject's context is not the
best place to be developing it.  In such a workflow, the submodule
checkout is used only in "sightseeing" mode, and the user should not even
be thinking about making commits in there to affect the submodule's
history.  There is no need for a huge warning.

	Side note.  In such a workflow, when you find issues in submodule
	inside the context of the superproject checkout, you address them
	there first, perhaps by even making commits, but then you take the
	changes back to a standalone checkout the submodule repository you
	keep elsewhere (perhaps you would pull and may even need to
	merge), independently validate the result, perhaps within the
	context of some other superproject that shares the submodule,
	before advancing the branch tip.  And then you fetch the result
	back to the submodule checkout you started from.

Things get complex _only_ when you start using the submodule checkout that
is contained within a superproject work tree as the primary place to
advance history of the submodule.  Otherwise, your submodule "repository"
embedded within the superproject checkout do not even have to have any
branch.  Its HEAD can always be detached.

A few random thoughts to reduce the need of detached HEAD in the submodule
context, if the user chooses to use it to develop history:

 * Perhaps "git submodule update" may want an optional parameter for the
   users to tell "update by switching to this branch in the submodule",
   instead of detaching HEAD?  The submodule checkout may or may not what
   the superproject records for the path as the result, but after that an
   add followed by a commit in the superproject will record the fact that
   you now want to bind a new commit at the tip of the submoudle branch to
   the submodule path.

 * Perhaps "git submodule" may want to learn a feature for the users to
   optinally express "In my workflow, when I am on superproject branch
   'xyzzy', I want branch 'frotz' in this submodule" to facilitate the
   above?

 * When we switch branches while you have local changes to a blob in your
   work tree, you take them with you if two branches record the same blob
   at the path, and need to force a merge if two branches record different
   blobs.  In a similar way, perhaps when the commit recorded in the
   superproject tree does not match what the tip of the submodule branch
   switched to with the new feature suggested above, "submodule update"
   can fail and give the user a chance to force a merge?
