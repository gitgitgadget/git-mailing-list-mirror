Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A60C433C1
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 18:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B46B6195E
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 18:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhCSSTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 14:19:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63685 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhCSSTN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 14:19:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24883BAF38;
        Fri, 19 Mar 2021 14:19:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rez4nMRG6BTc5uGc/CZnSP2vut0=; b=H3J28I
        kC6PtgRB/IvnQg8KVQYjTN2u9kp6i9y7GmOUtx70CFl/PdhBWCPqAndJIlBr2wSk
        2KCP0Q4YlVB/VbgwATDorvJMRVYAICbn/aB9gtwQYvUw7v7zcHRJ17FvDeSpjSsz
        C9xbM2YclAr1o3fHXraOaGdBPUiNBYaxT6v58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OK/zAkZWasRQsxuMq75GApnVrNd3kNqP
        FjI7+5Wx5Jq6IPbR12PNAhOOta5Ji14LXV8yCDQTQ3UjXl4Voa79l5urxVewkn6/
        G7MHoAEDwtH8LQutM5GVzK88HCxChXCMAxgc1fzGWvZ9owYGMj18lrFfT2BUzYKH
        UmsMdfP+liY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D3F5BAF36;
        Fri, 19 Mar 2021 14:19:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9634BBAF35;
        Fri, 19 Mar 2021 14:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v1] builtin/pack-objects.c: ignore missing links with
 --stdin-packs
References: <815623da67d283e8509fc4ac67e939c6140fc39a.1616168441.git.me@ttaylorr.com>
Date:   Fri, 19 Mar 2021 11:19:11 -0700
In-Reply-To: <815623da67d283e8509fc4ac67e939c6140fc39a.1616168441.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 19 Mar 2021 11:40:52 -0400")
Message-ID: <xmqqim5nm2g0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B1BB318-88DF-11EB-9B5E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> When 'git pack-objects --stdin-packs' encounters a commit in a pack, it
> marks it as a starting point of a best-effort reachability traversal
> that is used to populate the name-hash of the objects listed in the
> given packs.
>
> The traversal expects that it should be able to walk the ancestors of
> all commits in a pack without issue. Ordinarily this is the case, but it
> is possible to having missing parents from an unreachable part of the
> repository. In that case, we'd consider any missing objects in the
> unreachable portion of the graph to be junk.

Ah, OK.  So a pack that is being consolidated, or more likely a
loose commit that is rolled into the smallest geometric group) may
contain an unreachable commit, whose tree or blob has already been
pruned, which is an expected state (i.e. tree or blob may have been
older than the commit whose message may have been amended recently
before the entire commit got abandoned).  And we do not want to alarm
users by warning.

> This should be handled gracefully: since the traversal is best-effort
> (i.e., we don't strictly need to fill in all of the name-hash fields),
> we should simply ignore any missing links.

Or the entire set of objects that refer them can be omitted from the
resulting set of objects (iow, consider a commit that lacks a tree
or a blob to be checked out stale and prunable without downsides,
and prune it and its remaining trees and blobs by leaving them out
of the resulting pack), but I suspect that is a lot more involved
change.

> This patch does that (by setting the 'ignore_missing_links' bit on the
> rev_info struct), and ensures we don't regress in the future by adding a
> test which demonstrates this case.
>
> It is a little over-eager, since it will also ignore missing links in
> reachable parts of the packs (which would indicate a corrupted
> repository), but '--stdin-packs' is explicitly *not* about reachability.
> So this step isn't making anything worse for a repository which contains
> packs missing reachable objects (since we never drop objects with
> '--stdin-packs').

Yup.  I find the reasoning quite sensible.

Thanks, will queue.

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> I noticed a small number of repositories using geometric repacks
> complained about missing links when doing the best-effort traversal to
> fill in missing namehash fields with 'git pack-objects --stdin-packs'.
>
> This patch takes care to handle that situation gracefully. It is based
> on tb/geometric-repack, which is on 'next'.
>
>  builtin/pack-objects.c |  1 +
>  t/t5300-pack-object.sh | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 8cb32763b7..f513138513 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3122,6 +3122,7 @@ static void read_packs_list_from_stdin(void)
>  	revs.blob_objects = 1;
>  	revs.tree_objects = 1;
>  	revs.tag_objects = 1;
> +	revs.ignore_missing_links = 1;
>
>  	while (strbuf_getline(&buf, stdin) != EOF) {
>  		if (!buf.len)
> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index 7138a54595..ab509e8c38 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -629,4 +629,42 @@ test_expect_success '--stdin-packs with loose objects' '
>  	)
>  '
>
> +test_expect_success '--stdin-packs with broken links' '
> +	(
> +		cd stdin-packs &&
> +
> +		# make an unreachable object with a bogus parent
> +		git cat-file -p HEAD >commit &&
> +		sed "s/$(git rev-parse HEAD^)/$(test_oid zero)/" <commit |
> +		git hash-object -w -t commit --stdin >in &&
> +
> +		git pack-objects .git/objects/pack/pack-D <in &&
> +
> +		PACK_A="$(basename .git/objects/pack/pack-A-*.pack)" &&
> +		PACK_B="$(basename .git/objects/pack/pack-B-*.pack)" &&
> +		PACK_C="$(basename .git/objects/pack/pack-C-*.pack)" &&
> +		PACK_D="$(basename .git/objects/pack/pack-D-*.pack)" &&
> +
> +		git pack-objects test3 --stdin-packs --unpacked <<-EOF &&
> +		$PACK_A
> +		^$PACK_B
> +		$PACK_C
> +		$PACK_D
> +		EOF
> +
> +		(
> +			git show-index <$(ls .git/objects/pack/pack-A-*.idx) &&
> +			git show-index <$(ls .git/objects/pack/pack-C-*.idx) &&
> +			git show-index <$(ls .git/objects/pack/pack-D-*.idx) &&
> +			git rev-list --objects --no-object-names \
> +				refs/tags/C..refs/tags/D
> +		) >expect.raw &&
> +		git show-index <$(ls test3-*.idx) >actual.raw &&
> +
> +		cut -d" " -f2 <expect.raw | sort >expect &&
> +		cut -d" " -f2 <actual.raw | sort >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_done
> --
> 2.30.0.667.g81c0cbc6fd
