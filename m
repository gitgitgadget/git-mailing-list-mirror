From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: --keep option just saves
Date: Wed, 11 Feb 2009 14:10:31 -0800
Message-ID: <7vljscbp60.fsf@gitster.siamese.dyndns.org>
References: <20090212062514.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 23:12:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXNJN-0004EO-Fb
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 23:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbZBKWKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 17:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbZBKWKi
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 17:10:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbZBKWKh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 17:10:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 26A422AEF4;
	Wed, 11 Feb 2009 17:10:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 412E52AEE7; Wed,
 11 Feb 2009 17:10:33 -0500 (EST)
In-Reply-To: <20090212062514.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Thu, 12 Feb 2009 06:25:14 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CEE6436A-F888-11DD-94AD-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109536>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> The "save" subcommand usually removes the changes it stashed from the
> index and the work tree. Existing --keep-index option however keeps the
> changes to the index. This new option keeps the changes made to both the
> index and the work tree.

I saw --no-reset mentioned earlier but probably this is a more consistent
name for the feature.

But I somewhat doubt if this line of change is a good idea to begin with.

The earlier --keep-index feature had a clear definition of what workflow
benefits from it, and also made it clear that the workflow it helped was a
good workflow.  You build what you would consider a good change in the
index bit by bit, but you would want a final test of the whole tree,
without the changes that you are still not sure and are not in the index.
Before --keep-index, we did not have a good way to do so.

This one, the "snapshot", and various other related topics, are quite
different.  The workflow the --keep (and for that matter, "snapshot")
would support I can think of does not sound a very good one we would want
to recommend (--untracked is a different issue; I haven't formed an
opinion).

You build on a branch, but you are forever in the state of indecision, and
instead of committing, you keep saying "save --keep" number of times to
leave a checkpoint on your stash.  After number of iterations, you may
have many stashes in "git stash list", but what you can do with them is
"git reset --hard && git stash apply stash@{$n}" to go back to any of the
state, but that is about it.

If the topic you are working on is that involved, and if you are afraid of
contaminating the branch you started off of (which is groundless given the
nature of git that is distributed --- the act of committing is explicitly
disconnected from the act of publishing), then you are much better off
forking the original branch to another branch on which you do your own
work, and make normal commits to checkpoint your states.  That way, you
can use the usual history rewriting tools such as "rebase --interactive"
and "merge --squash" to finish it off once you reached a good state.

All talks about using stash --no-rest and snapshot share this problem.  By
not making regular commits, you are denying yourself the rich set of tools
git offers you to use on regular commits and the ancestry chains between
them, and nobody explained what the benefits of not using normal commits
on normal branches are, nor how the inconveniences from this aversion to
branches forces you are justified by those unexplained benefits.

This topic won't go beyond 'next' during this round because it started way
after -rc0 was tagged.  It is not urgent to decide what will happen to the
recent "snapshot" related topics, and we have plenty of time to toss ideas
around, but currently I have to say that I am not very enthused about any
of the causes mentioned in various discussion threads.
