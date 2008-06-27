From: Junio C Hamano <gitster@pobox.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 11:15:44 -0700
Message-ID: <7vprq2rbfz.fsf@gitster.siamese.dyndns.org>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
 <alpine.DEB.1.00.0806271408290.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Anderson <rwa000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 27 20:17:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCIVN-0005Rs-4o
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 20:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758172AbYF0SQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 14:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756679AbYF0SQJ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 14:16:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179AbYF0SQH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 14:16:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E4B6A7C1;
	Fri, 27 Jun 2008 14:16:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0B0AFA69C; Fri, 27 Jun 2008 14:15:54 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806271408290.9925@racer> (Johannes
 Schindelin's message of "Fri, 27 Jun 2008 14:33:33 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1AB804AE-4475-11DD-A64D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86617>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 26 Jun 2008, Robert Anderson wrote:
>
>> Seems to me the concept of the "index" is a half-baked version of what
>> I really want, which is the ability to factor a working tree's changes
>> into its constituent parts in preparation for committing them.
>
> Half-baked is probably too strong a word.
>
> What you are basically asking for is to have the working directory 
> as staging area, and to be able to stash away changes that are not to be 
> committed.
>
> Now, this is not necessarily what everybody wants, which is why many 
> people are fine with the index.

I've always said that I am not in favor of any form of partial commits,
exactly for the reason Robert states, namely that you are not committing
what you had in your work tree as a whole.  I said so back when the only
form of partial commits were "git commit [-o] this-file".  I said it again
even when I introduced "add -i", that the interface goes backwards and
does not fix the issues associated with partial commits.

But I agree with you that calling the index half-baked is missing the
point.  The index is merely the lowest level of facility to stage what is
to be committed, and there is no half nor full bakedness to it.  The way
the current Porcelain layer uses it however could be improved and Robert
is allowed to call _that_ half-baked when he is in a foul mood (even then
I would rather prefer people to be civil on this list).

So I would welcome constructive proposals to make things better.

But before going into the discussion, to be fair, I would mention that
people who are used to partial commits (perhaps inherited from their
CVS/SVN habit) defend the practice by saying that they will want to make
commit series first (with unproven separation between commit boundaries
that is inherent to the practice of making partial commits) and it is not
problem for them that their commits are not tested at commit time, because
they will test each step afterwards after they are done committing.  They
can fix things up later with "rebase -i" if they find glitches.

The defense makes sense from the workflow point of view, in that batching
things up tends to make people more productive.  You think of the logical
separation first and make commits without having to wait for each step to
build and test (otherwise your train of thought would be interrupted), and
then you test the final resulting sequence as a separate phase.  Although
I imagine I would personally not be able to work that way comfortably, I
consider this a personal preference issue, and if some people are more
productive to work that way, it is fine to support the workflow.

But that is not a reason not to support other workflows.

> Having said that, I played with the idea of a "git stash -i", which would 
> allow you to select the changes to stash away.

I would actually go the other way.  I think the problem we are trying to
solve here in this thread is to support this (other) workflow:

    You keep working, and eventually build all the changes intermixed in
    your work tree, perhaps without any commit, or perhaps with a commit
    sequence that is only meant as snapshots and not as a logical
    sequence.  Your work tree state is in good shape right now (you do
    build and test at this "commit goal" state).  Now you would want to
    split the changes while making sure each step is good (i.e. builds and
    tests fine as well as the patch makes sense standalone).

One thing I think would make sense is to stash away _everything_ at this
point.  That would take you to the state before you started working.  Then
if we can selectively _unstash_ the parts that should logically be
committed first to bring them to your work tree, then you can inspect that
change against HEAD, test it, and when you are happy with it, you would
make your first commit in the final sequence.

Once you have capability to unstash selectively and make that first commit
in the final sequence like so, breaking up the remainder that is still in
your stash to a reasonable sequence of commits can be done with the same
workflow.  Unstash the next batch, inspect, test and be satisfied and then
commmit.  Lather, rinse and repeat.
