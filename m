From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] make rebase abort to original branch, not rebased branch
Date: Sat, 12 Mar 2011 23:05:18 -0800
Message-ID: <7vmxkzijpt.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.1103122253560.15442@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 08:05:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyfN2-00035l-Rw
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 08:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861Ab1CMHF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 03:05:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624Ab1CMHF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 03:05:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A88A2214;
	Sun, 13 Mar 2011 03:06:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WEZ4R/1y1OoMQbpR2bFXjYKAdX0=; b=ajYvwj
	7hXNaTopBTNf6pr8zx8vY0c/hVPpqCG0rK56anFGnv73TEO9vo/a8NkEULM0xUL1
	k3tKkxGuIFc0TGV8vN8KCTQZQFdhiK8i/+OmqDO43DisoYl4N4xoLpvNfX9S55UU
	PsCVRLa246CdySVlS9Pu1rtH2JavsOqvGBKys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VqhirvgGyjHo6ndIektSKwcvp5Na/9l0
	8qCbDbVt6H0q4xqGnDEz1bBtTH6SywyRVPL1wPtLCrK5U8CPmC/Oi53aC8aUQDT8
	wVrRkEpj8bg6pcBBr3Alz879J/RUJc1Q/U/p4auj0M9QfZA5tx3b905mVKwoRwux
	p1rfiL4tVmw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 375042213;
	Sun, 13 Mar 2011 03:06:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4AAE62212; Sun, 13 Mar 2011
 03:06:52 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1103122253560.15442@debian> (Martin von
 Zweigbergk's message of "Sat, 12 Mar 2011 22:58:20 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A9CA0F6-4D40-11E0-B0FB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168962>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> In most cases, this is just a small annoyance, since it's usually
> quick and easy to manually switch back to the original
> branch. However, I have run into at least two cases where it has been
> a bit more annoying:
>
>  1. When on a detached HEAD and running "git rebase HEAD topic", if
>     you abort the rebase, you will have to look up the old commit in
>     the reflog.

Doesn't this merely show a bad discipline? What were you envisioning to
do to your detached HEAD state if the rebase were to succeed? IOW, if the
state was so precious, why did you decide to switch to topic and rebase it
onto that state, without marking?

> Are there valid cases where the current behavior is bettter?

I don't particularly like the "when aborted it returns to the original
location" behaviour even for a single argument "git rebase A" case (I do
deeply care about the tip of the branch that you attempted to rebase _is_
set back to the original state, but I don't care deeply on which branch
you would end up on myself), but because "git rebase A B" is a shorthand
for "git checkout B; git rebase A" (at least that is how I view it
myself), I would imagine that it would be more surprising to switch back
to the branch you were on which may not have anything to do with A nor B.

At least going back to B conceptually makes more sense in one use case I
have, which was the original reason I invented rebase with the "checkout B
and rebase it ono A" shorthand in the first place (see 59e6b23), back when
I was an active contributor throwing patches at Linus (note that back then
I didn't have "abort then go back" in the code--and that is why I don't
care too deeply about this "which branch should I be after aborting?"
myself).

The reason I tried to rebase B on A with the short-hand form was because I
wanted to clean up what is on B; I may say "abort" when my first attempt
to rebase failed because it was a bit too much to bite at once (e.g. the
history diverged a bit too much since B forked from A's ancestor).

But then, the next thing I would want to do in such a case after aborting
is not to give up and forget about what I needed to do, which is to clean
up B into a shape easier to merge with the updated codebase that leads to
A.  I would want to stay on B and examine the situation a bit deeper, and
try to figuire out a different base (e.g. a bit older commit in the
history leading to A) to rebase to, so that I can keep up with the other
branch incrementally without lagging too far behind.  Switching away from
the original B would be majorly annoying in such a case.
