From: Junio C Hamano <gitster@pobox.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 15:23:00 -0800
Message-ID: <7vhc2uezl7.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm>
 <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
 <alpine.LNX.1.00.0902160322530.19665@iabervon.org>
 <7veixybw7u.fsf@gitster.siamese.dyndns.org>
 <loom.20090216T101457-231@post.gmane.org>
 <20090216135812.GA20377@coredump.intra.peff.net> <49999ED6.7010608@gmail.com>
 <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
 <4999BD54.8090805@gmail.com> <7vprhidpnc.fsf@gitster.siamese.dyndns.org>
 <20090216224330.GA23764@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 00:24:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZCpO-0000GG-I4
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 00:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbZBPXXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 18:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbZBPXXM
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 18:23:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbZBPXXL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 18:23:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2AAB22B478;
	Mon, 16 Feb 2009 18:23:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2E7091CF65; Mon,
 16 Feb 2009 18:23:01 -0500 (EST)
In-Reply-To: <20090216224330.GA23764@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 16 Feb 2009 17:43:30 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C5908D92-FC80-11DD-8440-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110261>

Jeff King <peff@peff.net> writes:

>   1. How can we improve this situation?

The situation you described is all about "don't allow a push that is NOT
CONTROLLED BY YOU and that can interfere with what you are doing into a
live repository", and you are right, we have operations that deliberately
detach the HEAD and expect nobody mucks with the branch.

But is this something even worth considering about in the same context as
the denyCurrentBranch?  The same thing can happen even if you are not
detaching HEAD.

For example, I sometimes end up with an ugly series on a branch, whose
endpoint is a good looking tree.  And a refactoring I would want to do
would be too cumbersome for the interactive rebase (I could do it, but the
machinery does not help as much as it would for a simpler case).  In such
a case, often I would just say:

	$ git branch -f goal
        $ git reset --hard master
        : repeat from here until "diff HEAD goal" becomes empty
        ... cherry-pick $a_commit_in_goal_branch, or
        ... edit "show $a_commit_in_goal_branch" output and apply, or
        ... edit the files in place.
        ... make a commit, perhaps using -c $a_commit_in_goal_branch
	: repeat up to here

I would not push into this repository to update the branch "goal" while I
am doing this, as it will obviously screw up the whole process.  I think
it is the same thing that you would not push from elsewhere to update the
branch you are in the middle of interactively rebasing.  Mucking with the
same repository from two different places at the same time, when you know
there can be only one version of a work tree that is checked out, is
simply insane.

It's just a common sense thing.  What denyCurrentBranch protects you from
is a push from elsewhere *while* you are not there, and then next day,
getting confused by what such a push did in the receiving repository.  In
that scenario, you are not mucking with the receiving repository from two
places at the same time, but still you can get your repository into a
confusing state, and it is worth protecting new people from.

Obviously you can tell receive-pack to refuse pushing into a non-bare
repository, with a "I know what I am doing" configuration, but I think at
that point the whole "you could break things this way, so let's prevent a
new user from making such mistake" goes into the realm of absurdity.
