From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add [HOWTO] using merge subtree.
Date: Wed, 09 Jan 2008 14:33:26 -0800
Message-ID: <7vabnefx3d.fsf@gitster.siamese.dyndns.org>
References: <1199882097-10420-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 23:34:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCjUt-0003lB-W3
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 23:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbYAIWdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 17:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbYAIWdk
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 17:33:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbYAIWdj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 17:33:39 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 050814AF0;
	Wed,  9 Jan 2008 17:33:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1310C4AEC;
	Wed,  9 Jan 2008 17:33:32 -0500 (EST)
In-Reply-To: <1199882097-10420-1-git-send-email-vmiklos@frugalware.org>
	(Miklos Vajna's message of "Wed, 9 Jan 2008 13:34:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70021>

Miklos Vajna <vmiklos@frugalware.org> writes:

> here is an updated version. i added a section (before the commands) to
> describe the workflow where the subtree merge strategy can be useful. i
> also added a section at the end where i mention submodules.

That's better.

> @@ -0,0 +1,48 @@
> +Date: Sat, 5 Jan 2008 20:17:40 -0500
> +From: Sean <seanlkml@sympatico.ca>
> +To: Miklos Vajna <vmiklos@frugalware.org>
> +Cc: git@vger.kernel.org
> +Subject: Re: how to use git merge -s subtree?
> +Abstract: In this article, Sean demonstrates how one can use the subtree merge
> + strategy.
> +Message-ID: <BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>
> +
> +How to use the subtree merge strategy
> +=====================================
> +
> +The merge strategy 'subtree' is a slightly modified 'recursive'.  It merges
> +current branch A with other branch B using common merge base O (and if there
> +are more than one common merge bases, they are recursively merged), but it can
> +"shift" trees while doing so.
> +
> +This can be handy if you want to merge a branch to a subdirectory, for example
> +git has the git-gui master branch in its git-gui/ subdirectory.
> +
> +So the target is to merge a branch of repo B to a subdirectory of the current
> +branch.
> +
> +You need the followings steps to perform the master branch of B to the
> +subdirectory B/ for the first merge:

I think the presentation order is still screwy.  Before saying
what it does, let's state why the reader might want to use what
we are going to describe, so that the reader can say "I am not
in that situation, I do not have to read the rest" and skip the
document quickly.

    When you want to include contents in your project from
    another project that has started its life independently, you
    can do so by merging the other project into your project.
    If there is no (and more importantly if there will never be
    any) overlap in paths the two project have, you can merge
    them without any tricks.

    However, if there are overlapping paths (e.g. you have
    Makefile, they have Makefile but as separate projects, these
    two Makefiles do not have anything to do with each other),
    you have a problem.  You do not necessarily have the option
    to merge these Makefiles together.  Instead, you may want to
    merge the other project as a subdirectory in your project.

    The 'subtree' merge strategy is designed to help you in such
    a situation.

Then give the birds-eye-view of the names you use in the example
description, so that the readers can substitute them to suit
their needs:

    Suppose you are merging the "master" branch of another
    project located at /path/to/B (the repository does not have
    to be local but we use /path/to/B for the sake of
    simplicity) as a subdirectory "dir-B" in our project.  Here
    is the procedure to bootstrap and maintain such a layout.

> +----
> +$ git remote add -f B /path/to/B <1>
> +$ git merge -s ours --no-commit B/master <2>
> +$ git read-tree --prefix=B/ -u B/master <3>
> +$ git commit -m "Merge commit 'B/master'" <4>
> +$ git pull -s subtree B master <5>
> +----
> +<1> creates and fetches the remote.
> +<2> initiates a merge, but stops before committing it.
> +<3> reads B/master into the subdirectory "sub".
> +<4> all that remains is committing the completed merge.
>
> +You only need the above four steps once, after that you can keep doing:
> +
> +----
> +$ git pull -s subtree B master
> +----

This part looks like a half-updated WIP.

    ----------------
    $ git remote add -f Bproject /path/to/B <1>
    $ git merge -s ours --no-commit B/master <2>
    $ git read-tree --prefix=dir-B/ -u B/master <3>
    $ git commit -m "Merge B project as our subdirectory" <4>

    $ git pull -s subtree Bproject master <5>
    ----------------
    <1> name the other project "Bproject", and fetch.
    <2> prepare for the later step to record the result as a merge.
    <3> read "master" branch of Bproject to the subdirectory "dir-B".
    <4> record the merge result.
    <5> maintain the result with subsequent merges using "subtree"
    
Then the discussion.

> +The benefit of the subtree merge strategy over submodules is that submodules
> +were not always available and it may still make sense to avoid it today,
> +because use of a submodule in a repository makes the repository
> +non-interoperable with any clients older than 1.5.2 series.

That's not incorrect, but I think we would need to discuss more
important matters first.  The discussion should consist of two
parts.

First, the tips, tricks and caveats when using subtree merge.

 - The participant to your project may want to make changes
   pertaining to the subtree merged project independently and
   send the result upward, although it is not required (the
   other project can merge from your project using subtree --
   the subtree strategy can shift your tree up and let the other
   project merge only the parts of your tree that corresponds to
   it).

 - The other project may not choose to.  One possible reason not
   to is if it does not want to connect its history to yours
   (although you wanted to do so in your repository).

And comparison with an alternative, "submodules":

 - It is simpler to merge another project using subtree than
   treating the other project as "submodule", due to less
   management hassles (pro).

 - It ties the two histories together as equals.  If the other
   project chooses to also use subtree merge from you, the two
   histories will be tied very closely, which often is not
   desirable from the point of view of the "contained" project
   (con).

 - It does not allow "narrow checkout" and "narrow clone" as
   submodule does (con).
