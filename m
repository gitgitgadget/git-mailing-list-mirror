From: Junio C Hamano <gitster@pobox.com>
Subject: Re: setting up tracking on push
Date: Tue, 10 Mar 2009 21:37:21 -0700
Message-ID: <7vwsaw7jzy.fsf@gitster.siamese.dyndns.org>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
 <76718490903052049k217e9c12gb7881f8904fdd9d@mail.gmail.com>
 <alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de>
 <buoy6vi297q.fsf@dhlpc061.dev.necel.com>
 <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>
 <76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com>
 <87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com>
 <20090310230939.GB14083@sigio.peff.net>
 <76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com>
 <20090311020409.GA31365@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 11 05:39:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhGDe-0000M5-2e
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 05:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbZCKEhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 00:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbZCKEhd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 00:37:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZCKEhc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 00:37:32 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 25515A0109;
	Wed, 11 Mar 2009 00:37:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3AD58A0108; Wed,
 11 Mar 2009 00:37:22 -0400 (EDT)
In-Reply-To: <20090311020409.GA31365@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 10 Mar 2009 22:04:09 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 54AAEC44-0DF6-11DE-9675-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112880>

Jeff King <peff@peff.net> writes:

>   # track origin/master with a different branch
>   git branch --track=origin/master other_branch

Isn't this one confusing with "git branch other_branch origin/master" (I
thought --track is the default these days)?

In any case, I find these "branch --retrack" proposals too confusing and
probably overengineered.

I need to ask a more fundamental question.  Is it really useful for people
to be able to re-track arbitrary remote/branch with an existing branch?

The only use case I've heard in this thread and nearby is where you are
the one who started the history of the branch, and pushed it into a public
repository as a new branch, making the result _the_ most authoritative
one.  After that, everybody else will be able to have a local branch that
tracks the authoritative one with "branch --track frotz origin/frotz", and
you will be the only one left unable to do so because you already have
that frotz branch.

And for that use case, I find it sensible if we had a way to easily say
"This branch hasn't been tracking anything so far (because it is the
originator of the history), but now it will give up its authority and
start tracking the one it is pushing into", and it would make sense to
somehow link that to the invocation of "git push".

    Side note.  I would also accept "It is only one person in the world,
    who can edit .git/config and be done with it; why bother complicate
    the UI for other people" as a valid argument against it, though ;-).

In that "my private branch gave autority to the branch at my public
repository" case, it is of course easy to re-clone (or "branch -m" away
and then re-fetch) like everybody else, but then you would lose the reflog
from the time before the branch went public, so it is not a solution but a
poor workaround.

I somehow think it would not make any sense to say "This branch used to
track that branch but now it will start tracking this other one".  People
of course can come up with contrived example to claim it is a useful
operation, but in real life, would it really be?  "The authoritative
repository has moved" is not an example.  It would merely be a change in
remote.<name>.url.  "The upstream renamed the branch" is not an example
either.  It falls into "Don't do that, then.  It will confuse everybody"
case.
