Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78359C43603
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 20:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6080261242
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 20:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348193AbhDMUSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 16:18:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57062 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348181AbhDMUSR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 16:18:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A5B3B5A00;
        Tue, 13 Apr 2021 16:17:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gdT/UHY49gDWI7GMSIfgW6mw6zc=; b=YZgyL1
        QAIHo9WtVbzZvkqNxUmp7feo/BjLWngeDskMttjyqu4LEygfZDY6Vwl4eHs/rMyD
        kpQFwxNxmjUI+JWohHAuNVptjmTAdbA9gcNRJ9e9mauWRspp7xo86Le5vaTGbfKp
        Rrh30s9wR3J7HSO9Jv4MVVEjT9d13QnCQh5cQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BpXy00HoIiolivg3a4//2TzzNwGqQt0Y
        4UGb4/zmK4oHtUEEX77f0rU5m51mvjk4NCDiqX5S17VUhqzNrjJjgvhxJ7NF7UgU
        NDwhAD8/6en81OoDyk1DPlfK5N7V/Tyf8yMxGzLsMphS0/T+j5NeomK/Br+VhW3P
        Uea3uO7Qfig=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71FADB59FF;
        Tue, 13 Apr 2021 16:17:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EDB17B59FE;
        Tue, 13 Apr 2021 16:17:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] is_promisor_object(): free tree buffer after parsing
References: <YHVECXHfZ1bidTJH@coredump.intra.peff.net>
        <YHVFKgn7WN76QnRz@coredump.intra.peff.net>
Date:   Tue, 13 Apr 2021 13:17:55 -0700
In-Reply-To: <YHVFKgn7WN76QnRz@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 13 Apr 2021 03:15:54 -0400")
Message-ID: <xmqqtuoakkgc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5549D274-9C95-11EB-8C51-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The added perf test shows only a tiny improvement on my machine for
> git.git, since 1.7GB isn't enough to cause any real memory pressure:
>
>   Test                                 HEAD^               HEAD
>   --------------------------------------------------------------------------------
>   5600.4: fsck                         21.26(20.90+0.35)   20.84(20.79+0.04) -2.0%
>
> With linux.git the absolute change is a bit bigger, though still a small
> percentage:
>
>   Test                          HEAD^                 HEAD
>   -----------------------------------------------------------------------------
>   5600.4: fsck                  262.26(259.13+3.12)   254.92(254.62+0.29) -2.8%
>
> I didn't have the patience to run it under massif with linux.git, but
> it's probably on the order of about 14GB improvement, since that's the
> sum of the sizes of all of the uncompressed trees (but still isn't
> enough to create memory pressure on this particular machine, which has
> 64GB of RAM). Smaller machines would probably see a bigger effect on
> runtime (and sadly our perf suite does not measure peak heap).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  packfile.c                    | 1 +
>  t/perf/p5600-partial-clone.sh | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/packfile.c b/packfile.c
> index 8668345d93..b79cbc8cd4 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -2247,6 +2247,7 @@ static int add_promisor_object(const struct object_id *oid,
>  			return 0;
>  		while (tree_entry_gently(&desc, &entry))
>  			oidset_insert(set, &entry.oid);
> +		free_tree_buffer(tree);
>  	} else if (obj->type == OBJ_COMMIT) {
>  		struct commit *commit = (struct commit *) obj;
>  		struct commit_list *parents = commit->parents;

Hmph, does an added free() without removing one later mean we've
been leaking?

Nicely done.  Thanks.


> diff --git a/t/perf/p5600-partial-clone.sh b/t/perf/p5600-partial-clone.sh
> index 3e04bd2ae1..754aaec3dc 100755
> --- a/t/perf/p5600-partial-clone.sh
> +++ b/t/perf/p5600-partial-clone.sh
> @@ -23,4 +23,8 @@ test_perf 'checkout of result' '
>  	git -C worktree checkout -f
>  '
>  
> +test_perf 'fsck' '
> +	git -C bare.git fsck
> +'
> +
>  test_done
