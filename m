From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --first-parent plus path limiting
Date: Tue, 29 Jan 2008 12:03:34 -0800
Message-ID: <7vy7a8mmax.fsf@gitster.siamese.dyndns.org>
References: <479EE405.1010001@viscovery.net>
	<7vk5ltow61.fsf@gitster.siamese.dyndns.org>
	<479EEC3D.9030100@viscovery.net>
	<7v63xdov20.fsf@gitster.siamese.dyndns.org>
	<479EEF68.7080505@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 21:04:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJwgv-0001YW-06
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 21:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbYA2UDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 15:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756728AbYA2UDs
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 15:03:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57577 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbYA2UDr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 15:03:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ACAF23176;
	Tue, 29 Jan 2008 15:03:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E7F0B3171;
	Tue, 29 Jan 2008 15:03:41 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71992>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Is there a combination of options that does --first-parent on the full
> history, but then --dense on the resulting strand of pearls with respect
> to a certain path?


The way these features are combined in the revision walker is
pretty much hardwired.

Marking commits that do not change the tree with respect to set
of paths as irrelevant (i.e. REV_TREE_SAME) comes first, and the
merge simplification happens about the same time.  Following
first-parent-chain only works on the result of that.  If you
tell a single-tree form of diff-tree to be applied to the
resulting commit (i.e. give -p/--stat/--name-status and friends
to "git log"), they work on the resulting commit with the same
pathspec unless --full-diff is given.

	Side note: incidentally, this is why you do not get "git
	log $single_pathspec" to notice a file that matches the
	single pathspec was created by copying or renaming.

But there is a deeper issue between "first-parent" and the
simplification (both merge history simplification and dense
processing) with pathspec.  They are based on quite different
viewpoint to what the history is.

The first-parent view is about what was seen by who made merges.
If you follow a branch that never fast-forwards (e.g. my "next"
is that way) using --first-parent, you will see the evolution of
the branch: "I merged updates to this topic, then I merged
updates to that topic, etc."  Even though there is no meaning to
the concept of "branch" other than "a sticky label that moves
around, mostly going forward, on a possible DAG of commits", it
makes you pretend that one person and nobody else "owns" the
branch and grows it, and ask only about what that one person did
and saw.  It is probably against the distributed nature of git
history that fast-forward merge can happen anytime and there is
no true mainline nor owner of the branch.

On the other hand, history simplification based on pathspecs is
about what changed the area.  It does not matter the feature was
cooked in a side branch (which is a second class citizen in the
world view "first-parent" takes) --- if "the mainline" did not
touch that area and the changes to the area were merged from a
side branch, the history on that side branch is much more
interesting than the history of the mainline when you are
inspecting the changes to the area specified by a set of paths.
The philosophy is more natural to the distributed nature of git
history.

These two inherently do not mesh well.

Having said that, culling with first-parent first and then
applying pathspecs may have its own use.  You will be asking
this question:

    I do not care about the details of what other people did.
    Among the actions that was made to this branch of mine, find
    the ones that change the area.

This will not find the "Make fetch built-in" commit if you dig
from 'master' (because that was not something that happened on
"master"), but will find the merge to the "mainline" that
touched the file.
