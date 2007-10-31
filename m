From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Wed, 31 Oct 2007 01:45:42 -0700
Message-ID: <7v8x5jiseh.fsf@gitster.siamese.dyndns.org>
References: <1193593581312-git-send-email-prohaska@zib.de>
	<11935935812741-git-send-email-prohaska@zib.de>
	<1193593581114-git-send-email-prohaska@zib.de>
	<1193593581486-git-send-email-prohaska@zib.de>
	<11935935812185-git-send-email-prohaska@zib.de>
	<11935935822846-git-send-email-prohaska@zib.de>
	<11935935821136-git-send-email-prohaska@zib.de>
	<11935935823045-git-send-email-prohaska@zib.de>
	<11935935821800-git-send-email-prohaska@zib.de>
	<11935935823496-git-send-email-prohaska@zib.de>
	<11935935821192-git-send-email-prohaska@zib.de>
	<7vfxztm2dx.fsf@gitster.siamese.dyndns.org>
	<52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de>
	<7vejfcl8aj.fsf@gitster.siamese.dyndns.org>
	<F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 09:46:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In9DA-00056H-DH
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 09:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbXJaIpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 04:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbXJaIpt
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 04:45:49 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:39781 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbXJaIps (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 04:45:48 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 082FB2EF;
	Wed, 31 Oct 2007 04:46:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A4148F9B1;
	Wed, 31 Oct 2007 04:46:06 -0400 (EDT)
In-Reply-To: <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de> (Steffen Prohaska's
	message of "Wed, 31 Oct 2007 08:53:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Steffen Prohaska <prohaska@zib.de> writes:

> Would it be acceptable if the error was less severe in the
> case of local being a strict subset of remote?
> Daniel proposed
> "%s: nothing to push to %s, but you are not up-to-date and
> may want to pull"
> It would still be an error, but a less severe one.

I am not convinced there is one true total order of "error
severity" that applies uniformly across different workflows, so
I would not immediately agree if you are suggesting to introduce
"severity levels".  But it certainly makes a lot of sense to be
able to _differentiate_ kinds of errors, and to have the calling
scripts and the push command itself react to them.

What are the possible error conditions?

 1. Error on the sending side.  The ref parameters given to
    git-push were bogus, or they were good commits but they were
    not fully connected to the commits the other side has
    (i.e. local repository corruption).  pack-objects will abort
    and no remote (nor local tracking ref that tracks what we
    pushed to the remote) would be updated.  This should be
    "most severe" in _any_ workflow, so I do not mind calling
    this "fatal".

 2. Push to a ref does fast forward, but the update hook on the
    remote side declines.  The ref on the remote nor the
    corresponding local tracking ref would not be updated, and
    the command would fail.

For all the other classes of errors, the ref on the remote nor
the corresponding local tracking ref would not be updated, and
by default, an error on any ref causes the command to error out.
For each of these classes of errors, we _could_ have an option
to let you tell the command not to error out because of it.

 3. Push to a ref does not fast forward and --force is not
    given, but you can prove the remote is strict subset of
    local (what your 10/10 wants to do).

 4. Same as #3 but you cannot prove the remote is strict subset
    of local.

Any other classes?

It might be a good idea to generalize 3 & 4, by the way.  The
remote being a strict descendant of what is being pushed might
be something you happened to want today, but somebody else may
come up with a different rule tomorrow.  So, 

 3'. Push to a ref does not fast forward and --force is not
     given, but there is a configuration (would this be per
     remote?, per remote branch?, or per local branch?) that
     tells git-push to call a hook on the local side that takes
     <ref being pushed, ref on the remote> as its parameter.
     The result from the hook does not change the fact that this
     is still an error, but it can instruct git-push not to
     error out due to this condition.

In some other workflows, it might make sense to maybe even
making 2. not to cause the error from git-push.  I dunno.

> It could also be a good idea to teach git push transactional
> behaviour.

That is certainly true.  I am not sure about other transports,
but it should be a relatively straightforward protocol extension
for the git native transport.

> - git push can be configuration to push only the current
>   branch, as outlined below. This would certainly work. What
>   I do not like is that you first need to do some configuration
>   before you get a safe working environment.

I would not doubt it would be safer for _your_ workflow, but you
should consider the risk of making things more cumbersome for
workflows of others by enforcing that policy.

In other words, don't change anything unless you have a very
good reason to convince everybody else that it is universally
a good change to the default.
