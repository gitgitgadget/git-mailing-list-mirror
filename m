Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F93E1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 16:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbfILQxG (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 12:53:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62796 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbfILQxG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 12:53:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6580786A2;
        Thu, 12 Sep 2019 12:52:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IXLPkkC4PfMA
        dmzL9gZmhOTcRv4=; b=FolcfTMBIHPr9foK8v8QVjoPifMWS9wzcu/rV6rPSd3h
        v0JmAknOBoReGofhyjrCqtejoF80uyh2QNceuKVGaJ+7oe07RmfeWHYV9x46Vaic
        5hfkOX3zz2Y4gXUlmfGD+DdsZvjzU+p+fHHQ76avcneRgJLkhe5sbQwAE8zJDLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ptXDgg
        /08ZMVGli6PLGKQ9OJHKZ2dQvSFy9duO++8ThJymlsm/UsTD7/zeWk/cOYfgL9bG
        H8CTh0wVoAa73PhcCEJscK8jXqJuI1aIcSBS4rYjcG20I+6p+Y97nIIWeLNdZ/zT
        F9aq35oa0NZOz03kfMsfoLGXSni7HpkNzOrJM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE2E3786A1;
        Thu, 12 Sep 2019 12:52:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D9CF3786A0;
        Thu, 12 Sep 2019 12:52:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] list-objects: don't queue root trees unless revs->tree_objects is set
References: <20190912000414.GA31334@sigill.intra.peff.net>
        <20190912001846.GA31370@sigill.intra.peff.net>
        <20190912011137.GA23412@sigill.intra.peff.net>
Date:   Thu, 12 Sep 2019 09:52:53 -0700
In-Reply-To: <20190912011137.GA23412@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 11 Sep 2019 21:11:37 -0400")
Message-ID: <xmqqd0g5h2xm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C4B1622A-D57D-11E9-BF51-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I was surprised we ever called repo_get_commit_tree() at all, since
>> we're literally just traversing commits here. It looks like
>> list-objects.c is very happy to queue pending trees for each commit,
>> even if we're just going to throw them away when we get to
>> process_tree()! I wonder if could be checking revs->tree_objects here
>> and saving ourselves some work.
>
> Indeed, this seems to help quite a bit in the commit-graph case. I thin=
k
> it's worth doing (and is independent of the other patch).

Yeah, I agree this is very much worth doing and is orthogonal to the
other one.

Thanks for spotting it.  I wonder if it was broken like this forever
since the beginning X-<.

>
> -- >8 --
> Subject: list-objects: don't queue root trees unless revs->tree_objects=
 is set
>
> When traverse_commit_list() processes each commit, it queues the
> commit's root tree in the pending array. Then, after all commits are
> processed, it calls traverse_trees_and_blobs() to walk over the pending
> list, calling process_tree() on each. But if revs->tree_objects is not
> set, process_tree() just exists immediately!
>
> We can save ourselves some work by not even bothering to queue these
> trees in the first place. There are a few subtle points to make:
>
>   - we also detect commits with a NULL tree pointer here. But this isn'=
t
>     an interesting check for broken commits, since the lookup_tree()
>     we'd have done during commit parsing doesn't actually check that we
>     have the tree on disk. So we're not losing any robustness.
>
>   - besides queueing, we also set the NOT_USER_GIVEN flag on the tree
>     object. This is used by the traverse_commit_list_filtered() variant=
.
>     But if we're not exploring trees, then we won't actually care about
>     this flag, which is used only inside process_tree() code-paths.
>
>   - queueing trees eventually leads to us queueing blobs, too. But we
>     don't need to check revs->blob_objects here. Even in the current
>     code, we still wouldn't find those blobs, because we'd never open u=
p
>     the tree objects to list their contents.
>
>   - the user-visible impact to the caller is minimal. The pending trees
>     are all cleared by the time the function returns anyway, by
>     traverse_trees_and_blobs(). We do call a show_commit() callback,
>     which technically could be looking at revs->pending during the
>     callback. But it seems like a rather unlikely thing to do (if you
>     want the tree of the current commit, then accessing the tree struct
>     member is a lot simpler).
>
> So this should be safe to do. Let's look at the benefits:
>
>   [before]
>   Benchmark #1: git -C linux rev-list HEAD >/dev/null
>     Time (mean =C2=B1 =CF=83):      7.651 s =C2=B1  0.021 s    [User: 7=
.399 s, System: 0.252 s]
>     Range (min =E2=80=A6 max):    7.607 s =E2=80=A6  7.683 s    10 runs
>
>   [after]
>   Benchmark #1: git -C linux rev-list HEAD >/dev/null
>     Time (mean =C2=B1 =CF=83):      7.593 s =C2=B1  0.023 s    [User: 7=
.329 s, System: 0.264 s]
>     Range (min =E2=80=A6 max):    7.565 s =E2=80=A6  7.634 s    10 runs
>
> Not too impressive, but then we're really just avoiding sticking a
> pointer into a growable array. But still, I'll take a free 0.75%
> speedup.
>
> Let's try it after running "git commit-graph write":
>
>   [before]
>   Benchmark #1: git -C linux rev-list HEAD >/dev/null
>     Time (mean =C2=B1 =CF=83):      1.458 s =C2=B1  0.011 s    [User: 1=
.199 s, System: 0.259 s]
>     Range (min =E2=80=A6 max):    1.447 s =E2=80=A6  1.481 s    10 runs
>
>   [after]
>   Benchmark #1: git -C linux rev-list HEAD >/dev/null
>     Time (mean =C2=B1 =CF=83):      1.126 s =C2=B1  0.023 s    [User: 8=
96.5 ms, System: 229.0 ms]
>     Range (min =E2=80=A6 max):    1.106 s =E2=80=A6  1.181 s    10 runs
>
> Now that's more like it. We saved over 22% of the total time. Part of
> that is because the runtime is shorter overall, but the absolute
> improvement is also much larger. What's going on?
>
> When we fill in a commit struct using the commit graph, we don't bother
> to set the tree pointer, and instead lazy-load it when somebody calls
> get_commit_tree(). So we're not only skipping the pointer write to the
> pending queue, but we're skipping the lazy-load of the tree entirely.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  list-objects.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/list-objects.c b/list-objects.c
> index b5651ddd5b..c837bcaca8 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -370,7 +370,9 @@ static void do_traverse(struct traversal_context *c=
tx)
>  		 * an uninteresting boundary commit may not have its tree
>  		 * parsed yet, but we are not going to show them anyway
>  		 */
> -		if (get_commit_tree(commit)) {
> +		if (!ctx->revs->tree_objects)
> +			; /* do not bother loading tree */
> +		else if (get_commit_tree(commit)) {
>  			struct tree *tree =3D get_commit_tree(commit);
>  			tree->object.flags |=3D NOT_USER_GIVEN;
>  			add_pending_tree(ctx->revs, tree);
