Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819A0C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F7AD22280
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TO+a/Pjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgKBSbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:31:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50850 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKBSbf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:31:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92A8C8D80B;
        Mon,  2 Nov 2020 13:31:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=m0i3nRgZncehdQj5B7yjTVvvI3s=; b=TO+a/PjbQIJP20rhIMiy
        z63MpOGEFnKb9q1oqC8eF+5GR1E/8nK8GBmrdyDZCWXCwIygi6wUbWR/+E0rOSmV
        T7/+WFChWn7/9jPyk8wYkRmld0pCjeRr79Ily+uuWJlBcW0tD5kHc67V1cekJPiu
        Gdy2nqNN+wf7NEN/wsenX7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=F7taY+36laIGqb7od/BP/5U+HSod4DYKz+jBrRm43d5gjS
        tDhYNh7V9ODNdLKDwwrqFh2FSguKNEWouXYadPysQQutwm0Lgr7PBjANbxqUjQTT
        SnmA8Uhy12hvGS7UZ7q3yDDZOt7wfNCY4cEam8LAYnNfR79qfShMR3ck4qANY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 894EE8D80A;
        Mon,  2 Nov 2020 13:31:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EDC2D8D809;
        Mon,  2 Nov 2020 13:31:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sathyajith Bhat <sathya@sathyasays.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: Segfault in git when using git logs
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
        <20201102144321.GA3962443@coredump.intra.peff.net>
Date:   Mon, 02 Nov 2020 10:31:30 -0800
Message-ID: <xmqqzh3zvce5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1360F1C-1D39-11EB-A5CE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That commit causes the line-log to clear the set of pathspecs, but the
> --follow option requires exactly one pathspec (and it even makes sure
> the user gives us one, but that happens before we clear it internally).
> Something like this makes the segfault go away:
>
> diff --git a/line-log.c b/line-log.c
> index 42c5e41f68..f789863928 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -847,6 +847,7 @@ static void queue_diffs(struct line_log_data *range,
>  		clear_pathspec(&opt->pathspec);
>  		parse_pathspec_from_ranges(&opt->pathspec, range);
>  	}
> +	opt->flags.follow_renames = 0;
>  	DIFF_QUEUE_CLEAR(&diff_queued_diff);
>  	diff_tree_oid(parent_tree_oid, tree_oid, "", opt);
>  	if (opt->detect_rename && diff_might_be_rename()) {
>
> but I'm not clear on how "--follow" and "-L" are supposed to interact. I
> wouldn't expect --follow to do anything at all with line-log (nor for it
> to be useful to specify pathspecs outside of the -L option). So possibly
> this is restoring the behavior prior to that commit, or possibly it's
> just papering over a breakage. ;)

Another option is to catch it as "these options are mutually
exclusive" error early before the control reaches this deep in the
codeflow, I would think, but I suspect that some people may
habitually add the "--follow" option in a context where it does not
make sense, so "--follow is silently ignored when other options that
contradict it is in effect at the same time" is OK by me, too.

I do not know if that is the case offhand, but in the ideal
world, I would imagine

	git log -L1,5:hello.c -C -C -- hello.c goodbye.c
	git log -L1,5:hello.c -C -C

to notice and show that some of these five lines were copied
when or after hello.c was created, and keep following the
origin of them in goodbye.c, and

	git log -L1,5:hello.c -C -C

may do the same or find better match outside goodbye.c for
the origin of these lines and follow them instead, while

	git log -L1,5:hello.c -- hello.c
	git log -L1,5:hello.c --no-renames

in the same history may say the commit that actually copied
these lines from goodbye.c just added them directly to hello.c
instead.

And to extend the imagination a bit more,

	git log -M -L1,5:hello.c
	git log -L1,5:hello.c
	git log --follow -L1,5:hello.c

in a different history may notice that hello.c was created
wholesale by renaming hola.c and follow the changes to these
five lines down the history.  As -M is in effect by default
these days, the first two would be equivalent, and "--follow"
would be a meaningless noiseword in the context of this example
where we are interested only in a single path hello.c in the
end result, but in the ideal world, meaningless noiseword
should become hardless no-op, I would think.

Of course, the above assumes that -L plays well with the
-M/-C/--follow options and pathspec.  If not, then "they are
incompatible" would be the more sensible and easy-to-explain
option.

Thanks.


