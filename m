From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Wed, 05 Dec 2007 22:30:45 -0800
Message-ID: <7veje0gwru.fsf@gitster.siamese.dyndns.org>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org>
	<20071202212224.GA22117@midwinter.com>
	<20071203021333.GC8322@coredump.intra.peff.net>
	<7vlk8csetl.fsf@gitster.siamese.dyndns.org>
	<5920F34B-A94B-4C24-A95B-D35F35A4F0C0@midwinter.com>
	<7vhciwn5rl.fsf@gitster.siamese.dyndns.org>
	<20071206055723.GB23309@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 06 07:31:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0AGP-0007n6-Ax
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 07:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbXLFGax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 01:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbXLFGax
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 01:30:53 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57310 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbXLFGaw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 01:30:52 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4CDE52F0;
	Thu,  6 Dec 2007 01:31:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D56B9B7DF;
	Thu,  6 Dec 2007 01:31:09 -0500 (EST)
In-Reply-To: <20071206055723.GB23309@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 6 Dec 2007 00:57:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67254>

Jeff King <peff@peff.net> writes:

> On Wed, Dec 05, 2007 at 02:19:58PM -0800, Junio C Hamano wrote:
>
>> > what rewriting was done by the server, and if another push happened in
>> > the meantime, the client will have to basically guess about which
>> > commits correspond to the ones it pushed.
>> 
>> Ok, but the output from fetch is meant to be human readable and we do
>> not promise parsability, so if we go this route (which I think you made
>> a sensible argument for) we would need a hook on the pushing end to act
>> on this (perhaps record the correspondence of pushed and rewritten sha1
>> somewhere for the hook's own use).
>
> I am not clear on what you mean. Are you saying that the send-pack code
> should _not_ recognize the "ok, but I rewrote your commit" status?
> Because that is how we will avoid updating the tracking ref, which I
> think is a good goal.
>
> Or are you saying "it's ok to understand the 'ok, but...' response and
> not update the tracking ref, but pulling the new hash from the message
> is up to a hook on the pushing side"? Which I think it reasonable.
>
> Or alternatively, "there should be a hook on the pushing side which is
> allowed to set the ref status to 'ok, but don't bother updating the
> tracking ref' or 'ok, but here is the actual thing to put in the
> tracking ref'"? Which is also fine by me.

What I meant in response to what I thought Steven was talking about was
this.

 * With Steven's patch, the sending side needs to expect what it pushes
   to be rewritten.  If it starts with this history:

    ---o---o---o---Y---o---o---X

   where Y is what its remote tracking branch points at for the
   corresponding branch, three commits were built locally since the last
   fetch, and the sender pushes X.

 * Then the receiving end rewrites the history, making the history into
   this:

		     o'--o'--X'
                    /
    ---o---o---o---Y---o---o---X

 * Before the next fetch, the sending side can continue building on top
   of X, leading to this:

		     o'--o'--X'
                    /
    ---o---o---o---Y---o---o---X---o---Z

 * Similarly other people push into the same remote, get their commits
   rewritten and remote side's history becomes like this (but the
   original sender does not know about the upper history at all yet).

		     o'--o'--X'--o'--o'--W'
                    /
    ---o---o---o---Y---o---o---X---o---Z

 * Then the original sender fetches from the remote, now the tracking
   branch points at W' (it previously pointed at Y).  You would want to
   rebase your work since the last push on top of that tracking branch.

The rebase would be "rebase --onto W' X Z", so it is not strictly
necessary to keep the fact that X corresponds to X', but somehow I
thought it was necessary, and Steven's message was hinting about that:

  > If we want that status in principle, I'd argue that sending down the
  > updated commit SHA1 is actually the right way to indicate it, because
  > it gives the client all the information it needs to make an
  > intelligent choice about what to do next. If you don't transmit the
  > modified SHA1, the client will have to do another fetch to find out
  > what rewriting was done by the server, and if another push happened in
  > the meantime, the client will have to basically guess about which
  > commits correspond to the ones it pushed.

(notice the last part).

So if we want to transmit minimum amount of information, we can just
send a bit ("the ref was rewritten") back to send-pack without telling
it what X' is (but it would not hurt to send it back either).  With that
one bit of information, send-pack can refrain from updating tracking ref
from Y to X.

In the above scenario I illustrated, it turns out that getting
correspondence between X and X' is not strictly necessary to perform a
rebase later, but maybe there is some other scenario that keeping track
of that information would be helpful.  In such a case, a hook on the
send-pack end (which currently we do not have) can be called with X and
X' as parameters (and perhaps the name of the ref and the corresponding
tracking ref) to do whatever it wants to do with that information.

Even if we do not send X' back but just one bit, having that hook would
probably be needed so that sender can record "I've pushed up to X" and
perhaps "now I cannot push out Z until I rebase" after receiving "push
was accepted but rewritten" bit.

This is all handwaving --- I suspect for this to really work, send-pack
might need a pre-send-pack hook that pays attention to such "now I
cannot push out Z until I rebase" information the previous round of push
may have left and declines to push.  Of course, the receiving end would
would probably refuse such a push because it is not a fast-forward.
