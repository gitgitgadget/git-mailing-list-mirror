Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B2FB1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 20:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756260AbeASUZI (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 15:25:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50657 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756213AbeASUZG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 15:25:06 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12E22BE6AC;
        Fri, 19 Jan 2018 15:25:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+4B4/3XXfCTW5h3x5EFNsVGKve4=; b=ZSg+gU
        6zHFdxqeJGV42B5RtQmlAgO86bGukq65wiO/SJxT/IhUo1Fbf3TN1FbzwDToIUAl
        TBZBlGDzm7yR6v45aLJq60HU5T8viJmKtuOIFxvpWmjF+rbSKbIHIdQDMdWBOCK4
        /j+tERsJpUHCEjsPUk92IIfIe6k8hOKGpLF1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r/Ddg1miD7qflYFO3U9nWL/bVWo1ZgLK
        k1pdv6bjFOoP8N+BBAxflr043jPjofZpYMM9P7eOmqK3gGsVqyGQs5HjGiKL96p1
        9aoUS6fFfe7Wb7waMhWfeMsM4WdwIMrvzgEYlcZEpwoiH+UEyytsnjJ2SKvotaa8
        MA79+sjdOio=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B3AFBE6AB;
        Fri, 19 Jan 2018 15:25:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 832C0BE6AA;
        Fri, 19 Jan 2018 15:25:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 0/8] rebase -i: offer to recreate merge commits
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
Date:   Fri, 19 Jan 2018 12:25:04 -0800
In-Reply-To: <cover.1516225925.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Thu, 18 Jan 2018 16:35:23 +0100 (STD)")
Message-ID: <xmqqmv19ppen.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5E2FE7E-FD56-11E7-9BF3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Think of --recreate-merges as "--preserve-merges done right". It
> introduces new verbs for the todo list, `label`, `reset` and `merge`.
> For a commit topology like this:
>
>             A - B - C
>               \   /
>                 D
>
> the generated todo list would look like this:
>
>             # branch D
>             pick 0123 A
>             label branch-point
>             pick 1234 D
>             label D
>
>             reset branch-point
>             pick 2345 B
>             merge 3456 D C

Yup.  I've seen this design talked about on list in the past, and
I've always felt that this is "sequencer done right".

At the first glance, it may feel somewhat unsatisfying that "merge"
has to say effects of which commits should be reflected in the
result and which commot to take the log message from, i.e.
(recreated)D is merged to form the resulting tree, and 3456=C is
used for the log, to recreate C in the above example, while "pick"
always uses the same commit for both, i.e. recreated B inherits both
the changes and log message from the original B=2345 (or depending
on the readers' point of view, "merge" is allowed to use two
different commits, while "pick" is always limited to the same one).

But I think this distinction is probably fundamental and I am not
opposed to it at all.  The result of "pick" has only one parent, and
the parent is determined only by the previous actions and not by
anything on the "pick" line in the todo list.  But the result of
"merge" has to record all the other parents, and only the first
parent is determined implicitly by the previous actions.  We need to
tell the "merge" command about "3456=C" in order to recreate the
effect of original merge commit (i.e. changes between B and C) as
well as its log message, and we also need to tell it about label "D"
that it is the "other parent" that need to be recorded.

Obviously "merge" command syntax should allow recreating an octopus,
so whenever I said "two" in the above, I meant "N".  The original
merge commit is needed so that the effect to replay (roughly: a
patch going to the original merge result from its first parent) can
be learned from the existing history, and all the other "N-1"
parents needs to be given (and they must have been already created
in the todo list) so that the resulting recreated merge can be
recorded with them as parents (in addition to the first parent that
is implicitly given as the result of all the previous steps).

One interesting (and probably useful) thing to notice is that if A
were not rebased in the above sample picture, and only B were the
one that was tweaked, then a recreated C may use the same original D
as its side parent, and the mechanism outlined above naturally can
support it by allowing an un-rewritten commit to be given as a side
parent when "merge" is redoing C.

I probably won't have time to actually look at the code for a few
days, but I am reasonably excited about the topic ;-)

Thanks.
