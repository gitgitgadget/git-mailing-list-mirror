From: Junio C Hamano <gitster@pobox.com>
Subject: Re: PUSH_HEAD, was Re: FETCH_HEAD question
Date: Tue, 17 Feb 2009 15:43:49 -0800
Message-ID: <7vab8k39ze.fsf@gitster.siamese.dyndns.org>
References: <76718490902162043k78e615b5g7ba4b7ac95e73b18@mail.gmail.com>
 <7veixxaale.fsf@gitster.siamese.dyndns.org>
 <76718490902162221i31e02052j48c9f620a2d47985@mail.gmail.com>
 <7vr61x8ra4.fsf@gitster.siamese.dyndns.org>
 <76718490902162341y2f122427i470c77d3915ff554@mail.gmail.com>
 <7vy6w5795h.fsf@gitster.siamese.dyndns.org>
 <76718490902170914p6258b77ak81318f13757f0dfd@mail.gmail.com>
 <alpine.DEB.1.00.0902171821190.6185@intel-tinevez-2-302>
 <76718490902170934u5e2c17ffl7599ddeb5ee59812@mail.gmail.com>
 <alpine.DEB.1.00.0902172357450.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 00:45:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZZd4-0003xM-Cc
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 00:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbZBQXoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 18:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbZBQXoA
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 18:44:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbZBQXn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 18:43:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B5FA19A2F3;
	Tue, 17 Feb 2009 18:43:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 391569A2F1; Tue,
 17 Feb 2009 18:43:50 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902172357450.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 17 Feb 2009 23:58:13 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D6FCE8BA-FD4C-11DD-BB39-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110476>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 17 Feb 2009, Jay Soffian wrote:
>
>> On Tue, Feb 17, 2009 at 12:22 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >> Unless dwim_ref() is updated to handle FETCH_HEAD specially, and
>> >> return not the first SHA1, but the one not marked "not-for-merge".
>> >> Then the UI would at least be consistent, but this would not be
>> >> backward compatible.
>> >
>> > You cannot fix parsing FETCH_HEAD as a ref (and neither will you be able
>> > to do with PUSH_HEAD), as it can contain _more_ than one SHA-1s.  This
>> > still holds true when ignoring the not-for-merge lines, as an octopus is
>> > a quite real possibility.
>> 
>> An even better argument against than it not being backward compatible. :-)
>> 
>> And there is no PUSH_HEAD.
>
> Heh, that's why I used the future tense :-)

FETCH_HEAD is something the user who is sitting in front of the repository
controls with "git fetch" into it.  The objects referenced from it is not
part of the "reachable" set, and expectation is that anything that
requires the objects will happen before that user decides to actively go
prune unreachable objects.

PUSH_HEAD is quite different, and it needs to be handled a lot more
carefully.

We have been looking at denyCurrentBranch as a way to capture gremlin
updates and prevent it from confusing the end user, but PUSH_HEAD is more
like a pull request in reverse.  The necessary object transfer part has
been already done, and the tip commit waits for the final merge step to
pick it up.  You might want a loud notification that tells you that there
are outstanding reverse pull requests waiting to be picked up.  Its need
to protect the objects pushed from pruning is stronger than that of
FETCH_HEAD.

When PUSH_HEAD is in use for a receiving repository, we would intercept
pushes to certain refs, and instead of updating them, append a record in
the PUSH_HEAD file.  Each entry of the file would record the object name
and who pushed it from where and for which branch.  A new front-end
command to deal with PUSH_HEAD would allow the user to:

 * browse them,

 * choose one of them and comply, by checking out the destination branch
   and performing the merge,

 * choose one of them and discard, or

 * leave undecided.

Earlier I've considered introducing the notion of (per-ref) split head.
Forgetting the presense of packed-refs for now, when a gremlin push tries
to update a ref that is the current branch, you would instead of
overwriting the ref (that is 40-byte hexadecimal SHA-1 plus LF), append it
(making it contain two such lines).  Bash completion and friends can
notice the situation and say "Your HEAD is split by a gremlin push", and
the the user can choose to "git merge" the two (or more) commits recorded
in the ref to get the split head merged again (optionally, if the work
tree and the index is clean, and if the object the push is trying to
overwrite the HEAD with is a descendant of the HEAD, then you can allow it
to overwrite and run "reset --hard" afterwards, instead of splitting the
head).  I think Hg does something like that, and I think PUSH_HEAD is
nicer than outright "you are not allowed to push into this branch",
because the users already understand how a pull in response to a pull
request works as a workflow.

Having said that, there need to be clear and sane semantics defined to
tell which push should go to PUSH_HEAD file and which should directly go
to the underlying ref.  It is probably the easiest to explain if all
pushes to local refs are redirected to PUSH_HEAD when the repository is
non-bare, but it means a non-bare repository cannot be used as the central
shared repository for everybody to meet and swap with push-pull.  We could
only redirect push to the checked-out branch to PUSH_HEAD, but then that
would introduce an inconsistency between checked-out branches and others
from fetchers' point of view; pushes to some branches are observable from
the outside while pushes to one special branch (the checked-out one) are
not.
