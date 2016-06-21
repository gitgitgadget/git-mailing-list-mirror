Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB1901FE4E
	for <e@80x24.org>; Tue, 21 Jun 2016 04:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbcFUExW (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 00:53:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752385AbcFUExV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 00:53:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 62C1726FA9;
	Tue, 21 Jun 2016 00:51:23 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DgD/gu9udM4gTFIVBqEit3f/zLo=; b=StP2rC
	9pCJBCquXAvmLJISt7i8vRIv1Le6oNeLa9fyBY2wOlLcTAbhRmwlFqZmPmwF+Vby
	kFZ/8/PWU89IVjkpWD0Kg3HuvBTZJIGzi8JMHm6bZw5kLy4dD2IWsyldJHJsZNbQ
	ribmgRLIZPLPCtFySz1RT5SJCZ6wU4I5h1BIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bd+UcVArMKiMelAZhLcLxdT4WgSnZ9NW
	2MlglV0fo7msSwDrxc7kiy+d+EiGyZziBJc5HWo11qFBw36I7MIrpaVDS3KfGgKG
	cWKuLUVDT8RhGWJtMXKxQAfz9E0lIbO60dqX0aemnFmRq5bROxRTQ0MJS6qgYOuN
	8yjjdfRiFB0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C4B126FA8;
	Tue, 21 Jun 2016 00:51:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED2F626FA7;
	Tue, 21 Jun 2016 00:51:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	David Lightle <dlightle@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Fast-forward able commit, otherwise fail
References: <CAP4gbxqjHzqHhPuNK8UOwPMa46g2=vcNSk1AvGjxN8s+ou-0Dw@mail.gmail.com>
Date:	Mon, 20 Jun 2016 21:51:21 -0700
In-Reply-To: <CAP4gbxqjHzqHhPuNK8UOwPMa46g2=vcNSk1AvGjxN8s+ou-0Dw@mail.gmail.com>
	(David Lightle's message of "Mon, 20 Jun 2016 22:58:20 -0500")
Message-ID: <xmqqh9cnrvp2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD7B26A6-376B-11E6-B216-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

David Lightle <dlightle@gmail.com> writes:

> I know that I have read that --ff-only and --no-ff are contradictory,
> but I believe that is somewhat ambiguously correct -- I believe the
> two flags contradict in the sense of "what to do with the merge
> commit", but not necessarily on the "when it can be done".

Traditionally we have mildly suggested against making otherwise
needless merge commit with "--no-ff".  We also have suggested
against keeping the history too linear, not because linear history
is bad, but because it will require rebasing soon before pushing out
your changes [*1*].

I personally would feel that what you seem to be aiming for is the
worst of both worlds in the sense that contributors are still forced
to rebase immediately before pushing out, which leads to
insufficiently tested version landing on truck, and at the same time
forcing the resulting history to have otherwise needless merges (the
latter is probably a much lessor of the two sins).

However, Git as a tool is not opinionated strongly enough to make it
hard to do these two things (independently).  I do not think it is
unreasonable to add a new mode of "merge" that rejects a resulting
history that is not shaped the way you like.  So far the command
rejected --ff-only and --no-ff given together, so if an updated Git
starts taking them together and creating a needless real merge and
failing only when the first parent does not fast-forward to the
second parent, nobody's existing workflow would be broken.

Having said that, you need to think things through.  Sample
questions you would want to be asking yourself are (not exhaustive):

 - What is your plan to _enforce_ your project participants to use
   this new mode of operation?

 - Do you _require_ your project participants to always pass a new
   option to "git merge" or "git pull"?

 - Do you force them to set some new configuration variables?  

 - Do you trust them once you tell them what to do?  

 - How will your project's trunk get their changes?

 - How you prevent some participants who misunderstood your
   instructions from pushing an incorrectly shaped history to your
   project?

If they are eventually pushing the result to a central repository
and that is how the project's overall history advances, then the
most reliable mechanism that is least limiting to your users is
pre-receive hook at that central repository that ensures the shape
of the history being pushed to update the branches.  You walk the
first-parent chain of the commits and ensure all the commits are
merges, and for each of these merges, its second parent is a
descendant of its first parent.  Otherwise you reject their push.

That way, your users can make normal merges while trying their
changes locally all they want without straightjacket.  Only when
they prepare the final history to be placed at the tip of the
project's official history, they need to make sure that the history
is shaped as you specified.


[Footnote]

*1* Your changes before rebasing may have seen enough
testing in one context (i.e. built on older base), but "rebase
immediately before push to ensure fast-forward" will force you to
publish a version that by definition will have little or no testing,
which may or may not work well with a different context.
