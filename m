From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Tue, 01 Apr 2008 17:35:03 -0700
Message-ID: <7vd4p9ccw8.fsf@gitster.siamese.dyndns.org>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com>
 <47EECF1F.60908@vilain.net>
 <D0F821FA-AF53-4F1F-B9CC-58346828FA15@orakel.ntnu.no>
 <47EFD253.6020105@vilain.net>
 <C38585A9-F09C-4A5B-8E72-6F3127DB2BB9@orakel.ntnu.no>
 <32541b130803301603u65d1b6b6ladac0f6200433e5f@mail.gmail.com>
 <834174D1-82F4-4438-9854-762F416BB5EF@orakel.ntnu.no>
 <32541b130803311436t7b5041a4pabface15aad8ce63@mail.gmail.com>
 <47F2BFCD.5070202@vilain.net>
 <32541b130804011656l2e907895i98e5260b49743bbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Sam Vilain" <sam@vilain.net>,
	"Eyvind Bernhardsen" <eyvind-git@orakel.ntnu.no>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 02:36:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgqxP-0005RJ-Vz
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 02:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757289AbYDBAfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 20:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757241AbYDBAfS
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 20:35:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757238AbYDBAfR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 20:35:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 59DF61C4E;
	Tue,  1 Apr 2008 20:35:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 645031C4D; Tue,  1 Apr 2008 20:35:07 -0400 (EDT)
In-Reply-To: <32541b130804011656l2e907895i98e5260b49743bbe@mail.gmail.com>
 (Avery Pennarun's message of "Tue, 1 Apr 2008 19:56:10 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78671>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> Instead of storing only the commitid of each submodule in the parent
> tree, store the current branch name as well.
> ...
> This way, cloning a project with submodules will work much like
> cloning the parent project; pushing and pulling the parent and the
> submodules will do as you expect.

That goes quite against the fundamental design of git submodules in that
the submodules are by themselves independent entities.  An often-cited
example is an appliance project, where superproject bundles a clone of
Linux kernel and a clone of busybox repositories as its submodules.

Each submodule is an independent project, and as such, must not know
anything about the containing superproject (iow, the superproject can know
what the submodules are doing, but submodules should not know they are
contained within a particular superproject).

If your superproject (i.e. the appliance product) uses two branches to
manage two product lines, named "v1" and "v2", these names are local to
the superproject.  It should not force the projects you borrow your
submodules from to have branches with corresponding name.

Also, the submodules and the superproject are meant to be loosely coupled.
A single branch in superproject (say "v1") may have many branches in a
submodule ("add frotz to v1 product", "improve nitfol in v1 product") that
can potentially be merged and bound to.

The work flow for updating a tree would look like:

 - People "git fetch" in superproject and in its submodules. They
   obviously prime their tree with "git clone" of superproject, and the
   submodules they are interested in, and a single fetch will update all
   the remote tracking branches, so it does not really matter which branch
   is checked out.  However, if you employ a central repository model to
   keep them, an invariant must hold: all the necessary commits in
   submodules must be _reachable_ from some branch in them.

 - When not working in a particular submodule, but using it as a component
   to build the superproject, it would be better to leave its HEAD
   detached to the version the superproject points at.  IOW, usually you
   won't have to be on any branch in submodules unless you are working in
   them.

 - Sometimes you need to work in a submodule; e.g. you would want to add
   'frotz' tool to your copy of busybox.  You chdir to the submodule
   directory, and develop as if there is no superproject.

   - Most likely, because the superproject and the submodules are meant to
     be tied loosely, the (detached) HEAD you see in the submodule
     together with the superproject may be _behind_ the tip of any
     branches in the submodule repository.  This is really up to the
     project's policy, but the superproject is meant to point at a commit
     from submodules that is proven to be robust, and it may even be the
     responsibility of people above you to decide when and to what commit
     to advance the commit the superproject points at, and developers are
     given a single "development" branch to work on.  The project policy
     might be "a new feature should be on a new topic branch forked at the
     commit the superproject points at, and let the project leader to know
     what the topic is about so that it can be merged to the integration
     branch".  Follow the project policy and check out the branch to work
     on.

   - Then work on adding that 'frotz' tool.  Make commits, test it in
     isolation and test with superproject.  Push it out as whichever
     remote branch the project policy asks you to.

 - If you are the person who decides which commit in a submodule should be
   pointed at by the tree of the superproject, then check out the
   superproject, and check out the submodule at that commit.  Update the
   gitlink for the submodule and make a commit in the superproject.  This
   step may happen at the same time as the previous step if you worked in
   the submodule to advance its development branch tip and if you are the
   person who decides which submodule commit to point at from the
   superproject.

 - At any step above, a new clone (or a previously cloned trees, updated
   with "git fetch" in appropriate places) will have all necessary
   objects.
