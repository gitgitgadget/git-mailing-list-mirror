From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Fast forward strategies allow, never, and only
Date: Tue, 11 Mar 2008 18:57:20 -0700
Message-ID: <7v1w6gbt6n.fsf@gitster.siamese.dyndns.org>
References: <20080311093553.23191.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: hvammen@gmail.com, git@vger.kernel.org
To: colin@horizon.com
X-From: git-owner@vger.kernel.org Wed Mar 12 02:58:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZGEN-00063X-25
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 02:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbYCLB5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 21:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbYCLB5c
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 21:57:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbYCLB5b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 21:57:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CF39031F2;
	Tue, 11 Mar 2008 21:57:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C2BDB31EF; Tue, 11 Mar 2008 21:57:25 -0400 (EDT)
In-Reply-To: <20080311093553.23191.qmail@science.horizon.com>
 (colin@horizon.com's message of "Tue, 11 Mar 2008 05:35:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76904>

colin@horizon.com writes:

>      a--a--a
>     /       \
> o--o         o---o <-- A's head
>     \       / \ /
>      b--b--b---o <-- B's head
>
>      a--a--a
>     /       \
> o--o         o---o <-- A's head
>     \       / \ / \
>      b--b--b---o---o <-- B's head
>
> .. and it never ends.  All of the merged commits are identical trees, but
> if you insist on creating a new commit object each time, you can generate
> an infinite number of bogus commits, and more to the point, A and B will
> never actually agree on the current HEAD commit.
>
> With more developers, you can make even more of a mess.
>
> What use does the "--ff=never" option have except to generate this cruft?

Judicious use of non-fast-forward has a justification that is not too
unreasonable.  That is, when you want to treat one lineage of history as
"more special than others".

If your workflow is always to branch from the special branch ("master")
when working on even a miniscule topic and merge that back to "master", if
you happen to have worked only on a single topic and the "master" was
never advanced during the time you worked on that topic, merging the topic
back to "master" will result in a fast-forward.  When you look back that
history, you won't be able to tell where the topic started and ended by
following the ancestry chain of the "master" branch.

Using "never fast forward" policy on such a special branch will be a way
to make sure that all commits on the first-parent ancestry of that special
branch will be merges from something else, and by computing $it^1..$it^2
for a merge commit $it on the special branch, which merges the topic fully
into it, you can tell what commits the topic consisted of.

When you have repeated merges from a topic to that special branch, this
computation needs to be a bit more than just $it^1..$it^2 of the last
merge commit that merges the topic into "master".  E.g. you would have two
"should have been fast forward but artificially made into a real merge for
the purpose of peeing in the snow" like this:

           o---o---o---o---o "topic"
          /     \           \
      ---o-------*-----------* "master"
 
By following the first-parent ancestry of "master", you can tell that the
first two changes on "topic" were accepted earlier and then three fixups
on top were incorporated much later, which is not something you can do if
you allowed fast-forward merge into "master".  Computing this history is
somewhat expensive but it is doable.  You have to follow the commit
ancestry of "topic", and for each commit you find, you would need to see
which commit on the first-parent ancestry of "master" can reach it
(e.g. the three topmost ones on "topic" can be reachable only by the last
merge on "master", while the remaining two can be reached by the previous
merge on "master").

In other words, if there is a globally special "master" history where
everybody meets, forcing an artificial merge can have value.  However, for
this to work, you can never commit anything directly on such a special
"master" branch, because directly committing on "master" is equivalent to
fork a small topic branch that has a single commit on it, and immediately
merging it back with a fast-forward merge to "master".  So an artificial
merge can have value but that value can be had only with a disciplined
workflow.

Last night I pulled a topic from Shawn which was a series of updates to
the bash completion script.  It was based on the tip of 'master' and
resulted in a fast forward.  In git.git circle, it happens that my
"master" history is not special at all.  I have "trivially correct fixups"
directly committed on "master" all the time, and fast-forwarding to the
tip of bash completion updates Shawn collected for me was exactly that,
with only different committer.  So even though I act as the top-level
integrator for git.git history, there was no reason to do non-fast-forward
merge at that point.  My tree is not that special.

On the other hand, I probably _could_ use non-ff to manage "next", which
will fork off of the tip of "master" after every major release.  In order
to treat the first topic that will be merged into "next" just like other
later topics, it should be merged without fast-forward.  The latter topics
will never fast-forward (because topics fork off of "master" or "maint"
and never from "next" itself) but the very first one can (because "master"
and "next" will be at the same at that point), and allowing fast-forward
would mean the first topic after a major release is treated differently
from others.  This is possible only because there is a fairly strict
discipline of not committing anything directly on top of "next" and not
forking off of it.
