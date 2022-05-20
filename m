Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD0EC433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 20:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiETUyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 16:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiETUym (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 16:54:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F242F19320C
        for <git@vger.kernel.org>; Fri, 20 May 2022 13:54:41 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6149E19CE66;
        Fri, 20 May 2022 16:54:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hn678xU5BOvaMZrdNnk4/PvQXAmsUwpfIl1Xbt
        Cp1YE=; b=qysjH21bdUBAWIZiS4YcenJbRAeb+sFL/hAaNjWcmirP0JwZD3kzg6
        W+JPxGrQGwvLERFNtPuu2dIhKmD+uXDRYNhFMoimCTIpbGStIx50PevhZD0dhKHO
        i8ZWHtg2hr0BA2tieoka5xiHVMla0QwmpSmjKF/UEJofGpQeWxLJE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 58B8019CE65;
        Fri, 20 May 2022 16:54:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.111.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 057E119CE64;
        Fri, 20 May 2022 16:54:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, vdye@github.com
Subject: Re: [PATCH 2/3] t7703: demonstrate object corruption with
 pack.packSizeLimit
References: <cover.1653073280.git.me@ttaylorr.com>
        <08da02fa74c211ae1019cb0a9f4e30cc239e1ab9.1653073280.git.me@ttaylorr.com>
Date:   Fri, 20 May 2022 13:54:36 -0700
In-Reply-To: <08da02fa74c211ae1019cb0a9f4e30cc239e1ab9.1653073280.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 20 May 2022 15:01:48 -0400")
Message-ID: <xmqqmtfbgc1f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FDF40C6-D87F-11EC-BB15-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> When this happens in just the right circumstances, it is possible to
> remove a pack that we just wrote, leading to object corruption.
>
> Luckily, this is quite difficult to provoke in practice (for a couple of
> reasons):

I'd call it unlucky that it is hard to trigger, actually ;-) With a
system like Git with more than a few handful of users, even an issue
that is hard-to-trigger is bound to hit somebody every day, but it
it is hard to trigger without the right condition, it is hard to
debug.

Thanks for finding and fixing (presumably we need a call to keep the
list sorted at the right places?)

>   - we ordinarily write just one pack, so `names` usually contains just
>     one entry, and is thus sorted
>   - when we do write more than one pack (e.g., due to `--max-pack-size`)
>     we have to: (a) write a pack identical to one that already
>     exists, (b) have that pack be below the split line, and (c) have
>     the set of packs written by `pack-objects` occur in an order which
>     tricks `string_list_has_string()`.
>
> Demonstrate the above scenario in a failing test, which causes `git
> repack --geometric` to write a pack which occurs below the split line,
> _and_ fail to recognize that it wrote that pack.
>
> The following patch will fix this bug.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  t/t7703-repack-geometric.sh | 47 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
> index 91bb2b37a8..2cd1de7295 100755
> --- a/t/t7703-repack-geometric.sh
> +++ b/t/t7703-repack-geometric.sh
> @@ -7,6 +7,7 @@ test_description='git repack --geometric works correctly'
>  GIT_TEST_MULTI_PACK_INDEX=0
>  
>  objdir=.git/objects
> +packdir=$objdir/pack
>  midx=$objdir/pack/multi-pack-index
>  
>  test_expect_success '--geometric with no packs' '
> @@ -230,4 +231,50 @@ test_expect_success '--geometric chooses largest MIDX preferred pack' '
>  	)
>  '
>  
> +test_expect_failure '--geometric with pack.packSizeLimit' '
> +	git init pack-rewrite &&
> +	test_when_finished "rm -fr pack-rewrite" &&
> +	(
> +		cd pack-rewrite &&
> +
> +		test-tool genrandom foo 1048576 >foo &&
> +		test-tool genrandom bar 1048576 >bar &&
> +
> +		git add foo bar &&
> +		test_tick &&
> +		git commit -m base &&
> +
> +		git rev-parse HEAD:foo HEAD:bar >p1.objects &&
> +		git rev-parse HEAD HEAD^{tree} >p2.objects &&
> +
> +		# These two packs each contain two objects, so the following
> +		# `--geometric` repack will try to combine them.
> +		p1="$(git pack-objects $packdir/pack <p1.objects)" &&
> +		p2="$(git pack-objects $packdir/pack <p2.objects)" &&
> +
> +		# Remove any loose objects in packs, since we do not want extra
> +		# copies around (which would mask over potential object
> +		# corruption issues).
> +		git prune-packed &&
> +
> +		# Both p1 and p2 will be rolled up, but pack-objects will write
> +		# three packs:
> +		#
> +		#   - one containing object "foo",
> +		#   - another containing object "bar",
> +		#   - a final pack containing the commit and tree objects
> +		#     (identical to p2 above)
> +		git repack --geometric 2 -d --max-pack-size=1048576 &&
> +
> +		# Ensure `repack` can detect that the third pack it wrote
> +		# (containing just the tree and commit objects) was identical to
> +		# one that was below the geometric split, so that we can save it
> +		# from deletion.
> +		#
> +		# If `repack` fails to do that, we will incorrectly delete p2,
> +		# causing object corruption.
> +		git fsck
> +	)
> +'
> +
>  test_done
