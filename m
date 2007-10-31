From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Wed, 31 Oct 2007 14:31:05 -0700
Message-ID: <7vlk9jgeee.fsf@gitster.siamese.dyndns.org>
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
	<7v8x5jiseh.fsf@gitster.siamese.dyndns.org>
	<B3C76DB8-076D-4C43-AC28-99119A05325C@z ib.de>
	<7vve8nglrt.fsf@gitster.siamese.dyndns.org>
	<B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:32:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InLA6-0006xS-T1
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbXJaVbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755232AbXJaVbN
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:31:13 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:39710 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059AbXJaVbM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 17:31:12 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E33CF2F0;
	Wed, 31 Oct 2007 17:31:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 453D690CB2;
	Wed, 31 Oct 2007 17:31:29 -0400 (EDT)
In-Reply-To: <B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de> (Steffen Prohaska's
	message of "Wed, 31 Oct 2007 22:09:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62881>

Steffen Prohaska <prohaska@zib.de> writes:

>> You forgot a lot more important part.  Pushing into publishing
>> repositories.  And the discussion is about git-push command.
>
> Exactly, here are two examples:
>
> If you push only to publishing repositories that are read
> only by others, you'll never encounter the problem that
> 10/10 tried to solve. The publishing repository is never
> changed by others. You are the only one who pushes to this
> repository. Therefore the remote never advances unexpectedly.

Wrong.

People can and do work from more than one private repositories
(I do).  In a sense, that is sharing the repository with
oneself.

I may do an emergency patch to fix breakage on 'maint' (and
'maint' only) from a location that is not my primary development
box and push the fix out.  I fully expect that the push will
push out 'maint' and expect the other branches such as 'master'
on the remote side to stay the same, as I haven't touched
'master' on that box for quite a while and it is now stale.  In
that situation, I _want_ the "git push" itself to report failure
to notify me that it did not push what _I_ asked it to push out,
so that I can be reminded that I'd better do "git push $remote
maint" the next time.  In the meantime, even though it reports
a failure, 'master' on the remote side is _not_ updated, so the
behaviour is still _safe_.

> Another difference is the way changes are integrated. In
> a workflow without shared repositories, only pull is used
> for integration, while push in only used for publishing the
> changes.

Wrong.  push is a mirror of fetch and does not do _any_
integration.  It is just a safe (because it insists on
fast-forward) propagation mechanism.  Your integration still
happens with pull (actually, shared repository people seem to
prefer "fetch + rebase" over "pull" which is "fetch + merge").

> This is different if you work with a shared repository. Bob
> checks out the shared branch foo to his local branch bar and
> later he needs to push bar back to the shared branch foo. Bob
> needs to push changes from his local branch bar to the branch
> foo in the remote repository, a branch with a different name.
> This need does not emerge when working with two publishing
> repositories, as described above.

So you do "git push $remote bar:foo".  If you do that regulary,
there are configuration mechanisms to help you reduce your
keyboard wear.  What's the problem?
