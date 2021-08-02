Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783DCC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 19:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 502AD610FC
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 19:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhHBTAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 15:00:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61517 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhHBTAU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 15:00:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEC62D0F8A;
        Mon,  2 Aug 2021 15:00:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9V9tta+CAKQSA7L0lFBNHpsszQkaioUXJJIc9m
        /aL/Q=; b=A7l4yzGaMAXVGPGEVrrKkwq+eWQYzaDUHtTTRFCPrqN63lVPVxpP9u
        PZgMkvJrJ9o3wsyL7uS18CzRYS6O8cgShwZ9ItK9Zy6wJWnNN+Cgu7gLCJ7zliiV
        CE5pWL1//lBseSi6y81VnUo7P1gBnfgMFXjgjuXQbqVn2TgVGiBOg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 128BFD0F83;
        Mon,  2 Aug 2021 15:00:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 14B5BD0F70;
        Mon,  2 Aug 2021 15:00:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 1/4] connected: do not sort input revisions
References: <cover.1624858240.git.ps@pks.im> <cover.1627896460.git.ps@pks.im>
        <1fd83f726a04dfb5be27c74cb116618cb76be923.1627896460.git.ps@pks.im>
Date:   Mon, 02 Aug 2021 12:00:02 -0700
In-Reply-To: <1fd83f726a04dfb5be27c74cb116618cb76be923.1627896460.git.ps@pks.im>
        (Patrick Steinhardt's message of "Mon, 2 Aug 2021 11:38:01 +0200")
Message-ID: <xmqqa6lzwu31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9141062-F3C3-11EB-9226-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> In order to compute whether objects reachable from a set of tips are all
> connected, we do a revision walk with these tips as positive references
> and `--not --all`. `--not --all` will cause the revision walk to load
> all preexisting references as uninteresting, which can be very expensive
> in repositories with many references.
>
> Benchmarking the git-rev-list(1) command highlights that by far the most
> expensive single phase is initial sorting of the input revisions: after
> all references have been loaded, we first sort commits by author date.
> In a real-world repository with about 2.2 million references, it makes
> up about 40% of the total runtime of git-rev-list(1).

Nice finding.

> Ultimately, the connectivity check shouldn't really bother about the
> order of input revisions at all. We only care whether we can actually
> walk all objects until we hit the cut-off point. So sorting the input is
> a complete waste of time.

Sorting of positive side is done to help both performance and
correctness in regular use of the traversal machinery, especially
when reachability bitmap is not in effect, but on the negative side
I do not think there is any downside to omit sorting offhand.  The
only case that may get affected is when the revision.c::SLOP kicks
in to deal with oddball commits with incorrect committer timestamps,
but then the result of the sorting isn't to be trusted anyway, so...

> Introduce a new "--unsorted-input" flag to git-rev-list(1) which will
> cause it to not sort the commits and adjust the connectivity check to
> always pass the flag. This results in the following speedups, executed
> in a clone of gitlab-org/gitlab [1]:
> ...
> [1]: https://gitlab.com/gitlab-org/gitlab.git. Note that not all refs
>      are visible to clients.

So is this the 2.2 million refs thing?

> @@ -3584,7 +3586,7 @@ int prepare_revision_walk(struct rev_info *revs)
>  
>  	if (!revs->reflog_info)
>  		prepare_to_use_bloom_filter(revs);
> -	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
> +	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED && !revs->unsorted_input)
>  		commit_list_sort_by_date(&revs->commits);

Looks quite straight-forward.

I however suspect that in the longer term it may be cleaner to get
rid of REVSISION_WALK_NO_WALK_UNSORTED if we do this.  The knob that
controls if we sort the initial traversal tips and the knob that
controls if we walk from these tips used to be tied to --no-walk
only because ca92e59e30b wanted to affect only no-walk case, but
with your new finding, it clearly is not limited to the no-walk case
to want to avoid sorting.


