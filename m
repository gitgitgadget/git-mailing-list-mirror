From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Wed, 02 Apr 2008 14:32:29 -0700
Message-ID: <7v7ifg6iz6.fsf@gitster.siamese.dyndns.org>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com>
 <47EECF1F.60908@vilain.net>
 <D0F821FA-AF53-4F1F-B9CC-58346828FA15@orakel.ntnu.no>
 <47EFD253.6020105@vilain.net>
 <C38585A9-F09C-4A5B-8E72-6F3127DB2BB9@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Avery Pennarun <apenwarr@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Wed Apr 02 23:34:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhAam-0004zV-Qb
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 23:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761303AbYDBVco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 17:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759367AbYDBVcn
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 17:32:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761279AbYDBVcm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 17:32:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 764654D63;
	Wed,  2 Apr 2008 17:32:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AEB674D5A; Wed,  2 Apr 2008 17:32:31 -0400 (EDT)
In-Reply-To: <C38585A9-F09C-4A5B-8E72-6F3127DB2BB9@orakel.ntnu.no> (Eyvind
 Bernhardsen's message of "Sun, 30 Mar 2008 21:50:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78718>

Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no> writes:

> One solution that occurred to me was to have a branch in each
> submodule for every main module and branch.  A branch name would be
> provided for each submodule in .gitmodules, used by "submodule push"
> but not "submodule update".  In this case, if the push to the branch
> fails, the main module branch is probably behind too.
>
> This seemed like a good idea, but it's racy.

It's not just racy, but I think it's wrong to limit to _one_ branch in
each submodule..

A submodule is an independent project on its own.

Suppose the commit DAG in the submodule looked like this:

                 o---o
                /     \
     --o---o---o---o---o---X---o---Z
            \                 /
             o---o---o---o---o---o
                  \     /
                   o---o

and the superproject points at commit X. You may need to tweak the
submodule to make it work better with the change you are making to the
superproject.

You have two choices:

 (1) update to some "stable" branch head that is descendant of X first,
     and make sure it works with the superproject.  Then develop on top of
     it, and bind the tip of suc development trail to the superproject:

                 o---o
                /     \
     --o---o---o---o---o---X---o---Z---o---o---Y (your changes are Z..Y)
            \                 /
             o---o---o---o---o---o
                  \     /
                   o---o

I think this is what you are suggesting.  But the superproject may not be
ready to use the submodule with the history from the lower side branch
merged in.  You would

 (2) fork off of X and develop; bind the tip of such development trail to
     the superproject.  IOW, you make the submodule DAG like this, and
     then "git add" commit Y in superproject.

                 o---o       o---o---Y (your changes)
                /     \     /
     --o---o---o---o---o---X---o---Z
            \                 /
             o---o---o---o---o---o
                  \     /
                   o---o

Sometimes forked branches need to be maintained until it proves stable
(and then your "tip" Y may be merged back to the tip of a public branch
Z).  So you would at least need to allow a set of topic branches in
submodules that corresponds to a single lineage of superproject history.

Then when both Z (with the changes from the lower side branch) and Y (your
changes) prove stable, the submodule project may decide to make a merge
between Y and Z.

                 o---o       o---o---Y (your changes)
                /     \     /         \
     --o---o---o---o---o---X---o---Z---W
            \                 /
             o---o---o---o---o---o
                  \     /
                   o---o

The superproject may decide to "git add" the result of such a merge, but
that decision is done separately (and obviously after such a merge is
made).

If everybody involved in the superproject forked from whatever happened to
be bound to the superproject, however, the submodule will have
uncontrolled number of unmerged "tips".  For the submodule to stay viable
as an independent project, some management has to be done to clean up this
mess.  To manage the forked development inside submodule properly, I do
not think you can autocruise from the toplevel superproject and leave the
random branches or unnamed commits unmerged.

That is why I suggested to:

 * Leave the HEAD in submodule detached, if you are not working in it;

 * Have a project policy regarding the use of branches in the submodule.
   When you need to work on submodule, first switch to the branch (the
   policy may allow/encourage you to create a new topic branch here), and
   commit to it.

 * The policy should also say when these forked branches should be merged;
   keep them tidy by following that policy.

And by pushing from submodule and then in toplevel, you will never have
"superproject names a commit unreachable from any of the branch tips of
submodules" problem.  Nor there is any raciness issue -- only after you
push out the submodule successfully, you push out the toplevel (and if the
former fails, you may need to redo the toplevel commit, but that happens
before you push it out so you can afford to rebase or amend).
