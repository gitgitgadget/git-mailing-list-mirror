Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166C1C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 20:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiFIUGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 16:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiFIUGx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 16:06:53 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0C5E96CF
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 13:06:51 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A792147849;
        Thu,  9 Jun 2022 16:06:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F9UKU9u1uHPjeLOJCRjTRTPF/V9hzsfj6lLAay
        juLME=; b=Fq3zf97rvav7DuaVyO5IO9wWLz+cLCEQ+d79ATEnLUU2zktrPGJj4Y
        XfoK5/Y6eNGtKaY8uYIDjW6+QuPXGSs3+uGN6X3LQMHyubRsHdRC7snvSkPLLOG6
        y/ZXN9uDZcgZxjqpKtUUmlS+AU3wM05z4fXrf7+BIfVPI5vxJxzns=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91AF9147848;
        Thu,  9 Jun 2022 16:06:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0030C147847;
        Thu,  9 Jun 2022 16:06:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, Tassilo Horn <tsdh@gnu.org>,
        Tao Klerks <tao@klerks.biz>, git@vger.kernel.org
Subject: Re: [BUG?] Major performance issue with some commands on our repo's
 master branch
References: <87h750q1b9.fsf@gnu.org>
        <CAPMMpohzqKo-+q-tOcXymmzGxuOY-mf2NPRviHURm8-+3MPjZg@mail.gmail.com>
        <87y1yb2xc8.fsf@gnu.org> <YqEyh5opAaJxph2+@coredump.intra.peff.net>
        <87sfoe7hio.fsf@kyleam.com> <YqILyX97zKg5ViUS@coredump.intra.peff.net>
        <xmqqedzxlmpt.fsf@gitster.g>
        <YqI/TcZyXomxtXtN@coredump.intra.peff.net>
Date:   Thu, 09 Jun 2022 13:06:48 -0700
In-Reply-To: <YqI/TcZyXomxtXtN@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 9 Jun 2022 14:43:25 -0400")
Message-ID: <xmqqtu8tiotj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2A9B42A-E82F-11EC-BBE7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But what I wondered is whether "show" in particular, because it would
> never want to skip showing a commit, could get away with avoiding the
> diff automatically.

Ahh, that is a clever thought.  At least unless we automatically
turn ourselves into "git log" by giving an range, we are naming
individual object we want to see, so why not show them?

But I wonder if "git show A -- P" should or should not show the
commit if A does not touch the path P.  Right now we apply the same
history simplification so "git show master -- t/" gives nothing to
me, which is probably one sensible thing to do.  It is debatable why
somebody who wants to see 'master' wants to hide it when it does not
touch the paths that match the pathspec given, but it can also be
debated why somebody would give a pathspec if commits are to be
hidden when they do not touch paths that match it, so...

> I.e., currently "git show -Sfoo HEAD" will always
> show HEAD, even if "-S" does not match anything. So if we are not
> showing any diff output, there is no need to compute the diff in that
> case. That is unlike "git log", which would omit commits that didn't
> match.

OK, you came up with an example that behaves differently.

> And really it is not "git show" that is special there, but the
> always_show_header flag it sets. So something like this might work:

A tempting thought, indeed.

> diff --git a/log-tree.c b/log-tree.c
> index d0ac0a6327..ed57386938 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -1024,6 +1024,10 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>  	if (!all_need_diff && !opt->merges_need_diff)
>  		return 0;
>  
> +	if (opt->diffopt.output_format == DIFF_FORMAT_NO_OUTPUT &&
> +	    opt->always_show_header)
> +		return 0;
> +
>  	parse_commit_or_die(commit);
>  	oid = get_commit_tree_oid(commit);
>  
>
> It produces the same output in the cases I tried. And running with
> GIT_TRACE2_PERF shows that it doesn't diff and rename code.
>
> I'm not overly confident that it isn't violating some other subtle
> assumption / corner case that I haven't thought of, though. :)
>
> -Peff
