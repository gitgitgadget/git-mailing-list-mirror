Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C86442018B
	for <e@80x24.org>; Wed, 22 Jun 2016 23:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbcFVXJG (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 19:09:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751159AbcFVXJE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 19:09:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EADA127083;
	Wed, 22 Jun 2016 19:09:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3sOjHo6MfaWw9MjqtpIbxBllRaw=; b=u4ZLIq
	68dyxh/HHeUpPmqIQBdtUm76mSy25oXJFASTemmCwQLJXPzKBwbA1+SCjnqxqieA
	wASaSYQjJ70jDnYsVnCe5aBDii8D1T2/s4Q62cD4eQO0k/qwVmSA3Igfzb8zIZFE
	seN72vRD7McMwh9swKbVeheACK+WhkwN3ktLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CGa7XQIPV0gcgy0cxP7qA59x6gaOntBx
	l7gVUNLgwDvF63l3ZDoJnfo4bksWxHrAT94u0WDhnt6Uoz5Pq1/Z2asSu7c9Lv5+
	Twnx1SUBxu8BB/w0Y1FYfdmcchxXzxU9GhqRGKdc3cp84gwuu1d9/Yh4HyxEZbyN
	GpxYwad4UhE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E333F27082;
	Wed, 22 Jun 2016 19:09:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C6B927080;
	Wed, 22 Jun 2016 19:09:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	David Lightle <dlightle@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Fast-forward able commit, otherwise fail
References: <CAP4gbxqjHzqHhPuNK8UOwPMa46g2=vcNSk1AvGjxN8s+ou-0Dw@mail.gmail.com>
	<xmqqh9cnrvp2.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 22 Jun 2016 16:09:00 -0700
In-Reply-To: <xmqqh9cnrvp2.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 20 Jun 2016 21:51:21 -0700")
Message-ID: <xmqqr3bokeib.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F2918DA-38CE-11E6-8B5A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> However, Git as a tool is not opinionated strongly enough to make it
> hard to do these two things (independently).  I do not think it is
> unreasonable to add a new mode of "merge" that rejects a resulting
> history that is not shaped the way you like.  So far the command
> rejected --ff-only and --no-ff given together, so if an updated Git
> starts taking them together and creating a needless real merge and
> failing only when the first parent does not fast-forward to the
> second parent, nobody's existing workflow would be broken.
>
> Having said that, you need to think things through.  Sample
> questions you would want to be asking yourself are (not exhaustive):
>
>  - What is your plan to _enforce_ your project participants to use
>    this new mode of operation?
>
>  - Do you _require_ your project participants to always pass a new
>    option to "git merge" or "git pull"?
>
>  - Do you force them to set some new configuration variables?  
>
>  - Do you trust them once you tell them what to do?  
>
>  - How will your project's trunk get their changes?
>
>  - How you prevent some participants who misunderstood your
>    instructions from pushing an incorrectly shaped history to your
>    project?

Another thing to consider is that the proposed workflow would not
scale if your team becomes larger.  Requiring each and every commit
on the trunk to be a merge commit, whose second parent (i.e. the tip
of the feature branch) fast-forwards to the first parent of the
merge (i.e. you require the feature to be up-to-date), would mean
that Alice and Bob collaborating on this project would end up
working like this:

 A:    git pull --ff-only origin ;# starts working
 A:    git checkout -b topic-a
 A:    git commit; git commit; git commit
 B:    git pull --ff-only origin ;# starts working
 B:    git checkout -b topic-b
 B:    git commit; git commit

 A:    git checkout master && git merge --ff-only --no-ff topic-a
 A:    git push origin ;# happy

 B:    git checkout master && git merge --ff-only --no-ff topic-b
 B:    git push origin ;# fails!

 B:    git fetch origin ;# starts recovering
 B:    git reset --hard origin/master
 B:    git merge --ff-only --no-ff topic-b ;# fails!
 B:    git rebase origin/master topic-b
 B:    git checkout master && git merge --ff-only --no-ff topic-b
 B:    git push origin ;# hopefully nobody pushed in the meantime

The first push by Bob fails because his 'master', even though it is
a merge between the once-at-the-tip-of-public-master and topic-b
which was forked from that once-at-the-tip, it no longer fast-forwards
because Alice pushed her changes to the upstream.

And it is not sufficient to redo the previous merge after fetching
the updated upstream, because your additional "feature branch must
be up-to-date" requirement is now broken for topic-b.  Bob needs to
rebuild it on top of the latest, which includes what Alice pushed,
using rebase, do that merge again, and hope that nobody else pushed
to update the upstream in the meantime.  As you have more people
working simultanously on more features, Bob will have to spend more
time doing steps between "starts recovering" and "hopefully nobody
pushed in the meantime", because the probability is higher that
somebody other than Alice has pushed while Bob is trying to recover.

The time spend on recovery is not particularly productive, and this
workflow gives him a (wrong) incentive to do that recovery procedure
quickly to beat the other participants to become the first to push.

The workflow should instead be designed to incentivise participant
to spend more time to carefully inspect the result of his rebasing
to make sure that his changes still make sense in the context of the
updated codebase that contains changes from others since he forked
topic-b from the upstream, in order to ensure quality.

This "push quickly immediately after rebasing without carefully
checking the result of rebase" pressure is shared by a workflow that
requires a completely linear history, and not unique to your
proposed workflow, but because you also require a --no-ff merge to
the updated upstream, robbing even more time from the project
participants, it aggravates the problem.
