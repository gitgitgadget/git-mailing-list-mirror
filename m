Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F0D20281
	for <e@80x24.org>; Sun, 24 Sep 2017 00:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbdIXAle (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 20:41:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53077 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751389AbdIXAld (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 20:41:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50290B1FFA;
        Sat, 23 Sep 2017 20:41:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ziKdqBFuZMH32LhF485G5L5O6jE=; b=ewOP/H
        o+nzvEMvrPsQFvyzcqVUxfI25h34tSmI4n/DkF/9A0z6qSWzK8Dvi4mq90/Z+Y0s
        yfmcG2NvT20OuYO/ED9awjXo7TNzLZ0PGGNpPgp3/Zhg8uBel8xUY3tijrzbtdlm
        bBxzY6JRbFT0VSeck5dx4XMsj4TGP9+KBRoBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u00XAaRfhyP9RFOpnMljKwFNxHyruFru
        q1WjMFVf95wBNfaeE5keyuMyWR5fJAZ6+ojrCA5+aZppFK6WoJHkL5yq3BX2boh1
        U3tQuocCieZGraWUzBDzpoS1E90WJoL7vUhV6Ar5lnQ/N173qaOT/5GPZtscwlpB
        kHiA9LHSo1I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 49355B1FF9;
        Sat, 23 Sep 2017 20:41:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B19C6B1FF8;
        Sat, 23 Sep 2017 20:41:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
Subject: Re: Behaviour of 'git stash show' when a stash has untracked files
References: <1505626069.9625.6.camel@gmail.com>
        <xmqqfubinddb.fsf@gitster.mtv.corp.google.com>
        <20170920193630.l7ifret5dpqgxiwm@sigill.intra.peff.net>
        <xmqqpoakn8tj.fsf@gitster.mtv.corp.google.com>
        <20170921033152.4hbkctzxraww5rqo@sigill.intra.peff.net>
Date:   Sun, 24 Sep 2017 09:41:31 +0900
In-Reply-To: <20170921033152.4hbkctzxraww5rqo@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 20 Sep 2017 23:31:52 -0400")
Message-ID: <xmqqing9hqro.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C9F64F8-A0C1-11E7-97FC-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think it would mostly Just Work for your case. git-apply should ignore
> the subject cruft at the top of the patch. And if you didn't create a
> stash with "-u" or with bits in the index, then those would be absent
> from the diff.
>
> And if you _did_ create such a stash, I actually suspect that "apply"
> barfing on the resulting patch may be a better outcome than silently
> ignoring the changes.

OK, that sounds sensible.

> I dunno. I do not use either of those features ("-u" or stashing the
> index state) myself. But I have always been bothered how the saved state
> is a bit hidden from the user. It seems like a recipe for user confusion
> when they save something with "git stash" but then "stash show" doesn't
> even mention it.

Yes, I do not dispute that the issue needs to be addressed.  What I
was unsure was how (e.g. should that be given always? does the user
ask and if so how? what the output to tell the information looks
like?)

> Those all seem like sane interface proposals. As I said above, I have a
> vague feeling that the default _ought_ to tell about everything.

OK.

> I guess the nuclear option there is introducing "git stash info" or
> something, and marking "git stash show" as an alias for "git stash info
> --worktree". It is too bad, though, as "show" is really the perfect
> name.

I think the end result of that becomes the same as adding "git stash
info" an alias for "git stash show --all" on top of what I wrote.

I suspect nobody uses "stash show" in a script in such a way that
its output is consumed by the script logic, so it may probably be OK
to show everything by default (which I agree is the way we would
have done _if_ people demanded on day 1 that we need to record all
three variants; IIRC, in the early days of the command back when the
"show" subcommand appeared, even "--index" was merely an intellectual
curiosity and was not a serious feature, and from that point of view
the historical output we currently have made sense).

