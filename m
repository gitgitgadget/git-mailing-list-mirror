From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Sun, 07 Sep 2008 15:00:27 -0700
Message-ID: <7v8wu3lipw.fsf@gitster.siamese.dyndns.org>
References: <20080907103415.GA3139@cuci.nl>
 <7vtzcrn9uv.fsf@gitster.siamese.dyndns.org> <20080907201038.GB8765@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Mon Sep 08 00:02:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcSKU-0006YT-GH
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 00:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542AbYIGWAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 18:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755538AbYIGWAf
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 18:00:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498AbYIGWAd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 18:00:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A94B5F7CA;
	Sun,  7 Sep 2008 18:00:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id ACE285F7C9; Sun,  7 Sep 2008 18:00:29 -0400 (EDT)
In-Reply-To: <20080907201038.GB8765@cuci.nl> (Stephen R. van den Berg's
 message of "Sun, 7 Sep 2008 22:10:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 64476F9C-7D28-11DD-8D33-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95180>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> Junio C Hamano wrote:
>>"Stephen R. van den Berg" <srb@cuci.nl> writes:
>>> The questions now are:
>>> - Would there be good reason not to record the backport/forwardport
>>>   relationship in the additional parents of a commit?
>
>>In general, I do not think what you did is a good idea.  The _only_ case
>>you can do what you did and keep your sanity is if you cherry-picked every
>>single commit that matters from one branch to the other.
>
> Wouldn't that be the normal use case for these kind of side-port
> references?
> ...
>>Remember, when you are making a commit on top of one or more parents, you
>>are making this statement:
>
>> * I have considered all histories leading to these parent commits, and
>>   based on that I decided that the tree I am recording as a child of
>>   these parents suits the purpose of my branch better than any of them.
>
> That is a statement which depends on the view of the user.  I concur
> that up till now, that is what a user says.  But maybe it is possible to
> accomodate both the traditional statement and the sideport-statement
> without confusing the two.

Read what you are quoting again and notice I explicitly said "suits the
purpose of *MY* branch better".  In your side-port example, if (perhaps a
critical security bugfix) B does *not* matter for the purpose of *your*
branch (perhaps because you know the product built from the branch you are
cherry-picking into will not be used in a context that would be affected
by the bug), it is perfectly fine to record the cherry pick source as a
parent of A'.

One ramification of this, however, is that you will give wrong impression
that such a branch contains the bugfix B to other people.  By merging A'
(not A) to their history, they think they obtained the bugfix B through
you, but in fact they are *not* getting the fix.  Running diff between A
to A' will reveal that in fact with the "merge" A' you discarded the fix
in B.  This makes your branch that has A' in its history useless for
people other than you.  But it can still be said that the resulting
history suits the purpose of *your* branch.

I said (and I maintain) it is not a good idea *in general*; building that
kind of history is just not a normal thing to do, and it will lead to
confusion unless you are careful and know what you are doing.  I still do
not necessarily agree that what you did is "the normal use case for these
kind of side-port", but people who consider it the normal use case would
be careful and know exactly what they are doing.  It is Ok in that kind of
context.

But just do not recommend it blindly to people who do not understand the
consequences, one example of which is that you cannot get the bugfix B by
merging A' to your branch as I mentioned above.

At that point, the choice becomes between merging from you (i.e. A') or
not merging from you.  The other people may find that merging from you
to honor *your* choice of discarding the bugfix made by B does *not* suit
the purpose of *their* branch, in which case they just do not merge from
you, and that is perfectly fine.

It is all relative --- each owner of history can have different objective
of his own history, and sometimes it contradicts with each other.  I do
not recommend recording A as a parent of A' because it explicitly makes
the objective *your* branch a more specialized one, "this branch does not
care about the bugfix B (among other things you discarded from the
original history that leads to A)", which in general makes it less
agreeable by other people which in turn means it is less useful to them.
