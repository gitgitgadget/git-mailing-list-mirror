From: Junio C Hamano <gitster@pobox.com>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a
 custom merge strategy
Date: Mon, 28 Jul 2008 17:37:33 -0700
Message-ID: <7vsktto78y.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
 <20080728185604.GA26322@sigill.intra.peff.net>
 <alpine.DEB.1.00.0807282008470.8986@racer>
 <20080728192651.GA26677@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	sverre@rabbelier.nl, Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 02:38:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNdEv-0002hr-G7
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 02:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197AbYG2Ahp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 20:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbYG2Ahp
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 20:37:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbYG2Aho (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 20:37:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 15E36406EE;
	Mon, 28 Jul 2008 20:37:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 92254406E9; Mon, 28 Jul 2008 20:37:35 -0400 (EDT)
In-Reply-To: <20080728192651.GA26677@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 28 Jul 2008 15:26:51 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8DC6E6BE-5D06-11DD-8BC4-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90538>

Jeff King <peff@peff.net> writes:

> My situation was two long-running branches, "stable" and "devel",
> both of which were worked on by many developers. One person was in
> charge of integration and branch management. They wanted "stable" to
> get the contents of "devel" (which were now ready for release), ignoring
> any small fixes that had been done on "stable" (since they had all been
> moved over to "devel" previously, but in subtly different ways that
> would create conflicts). And "git reset" was not an option, because they
> wanted to keep the history of "stable" in case those fixes needed to be
> looked at later.

I sense a slightly broken workflow here, whether the "-s theirs" strategy
is used or the merge is done in the other direction using "-s ours"
strategy.

Remember, when you create a merge commit between one history and another,
you are making this statement:

    I have looked at the tree state and the development history behind
    both of these commits, and came up with this tree, which I believe
    suits the purpose of _my_ history better than either of them.

That is why, after making such a merge with "git merge other", you won't
see any output from "git log ..other", which asks "what do I have yet to
merge?"  Everything that was included in other is now in your history and
there is nothing you have to worry about having left out anymore.

So if you suspect that the sutuation "in case those fixes needed to be
looked at later" ever arises, such a merge should *not* be recorded as a
proper merge on the 'stable' branch, because at that point when you are
doing that "-s theirs" merge (and this applies equally to the case where
you make "-s ours" merge as well), you actually have not looked at "those
fixes" closely enough to make the above statement with confidence.

Having said that, that "looking back in history" can easily be done if you
mark such a "Use '-s theirs' for expediency" merge as potentially an iffy
one in its commit log message somewhere.  Later if you actually hit
issues, you can locate such a merge commit, and inspect the output from
"git log $commit^2..$commit^1".  You would see those fixes the "devel"
history did not have in the "stable" branch when such a merge was made.

So the above is not a fundamental objection to the approach, and that is
why I said "slightly broken".  With a proper explanation between the right
use case (I think what you outlined is an example of good practice) and
the wrong use case (for example, the one described in $gmane/89024, the
whole thing after 'I think "-s theirs" is even worse.', not just the part
that was quoted in $gmane/89178), I think it is Ok to have "-s theirs"
strategy in our toolset.

Even though having said all of the above, I would actually prefer such a
"pull all of the devel down to stable" be done with this workflow instead:

 (1) go to 'devel';
 (2) merge all of 'stable';
 (3) look at the result and prove it is perfect;
 (4) go to 'stable';
 (5) merge 'devel'.

The last step would be a fast-forward, and you do not need "-s theirs"
anywhere in this procedure.  Step (2) can be helped with "-s ours" (which
have the same issue I discussed above), but the result is checked before
it hits the 'stable' (presumably more precious branch), which is
conceptually a big difference.  This is where the existing asymmetry
between theirs and ours comes from.

Incidentally, this is how 'maint' skips to tip of 'master' after a new
major version is released, but 'maint' is merged up into 'master' often
enough that we rarely need to even use "ours" strategy.
