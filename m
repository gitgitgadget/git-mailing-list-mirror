Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025ACC0015E
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 23:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbjHOXSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 19:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240583AbjHOXSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 19:18:09 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DCFD1
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 16:18:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 74F2230737;
        Tue, 15 Aug 2023 19:18:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JfUpDtlKlji/cqX80CNFTxxqt0TNOcvue3mrWn
        b5HcE=; b=WdfKDrGLjTHMANKahu6ZDu9QL0jq1rJYFrOncE1z7+OEGIj2XEJNkM
        8acLVx/iv0PYD7dwCYdD8iaaEQcwRizescbfVaYLwvxj3/aYqn9CuOhZgM/bi3u4
        /nOwTOotN+JHghnmGcIv5rbsVIKsxmy0ooZ7bmyGCUfkXyyPLn8ic=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D3FD30736;
        Tue, 15 Aug 2023 19:18:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0767D30735;
        Tue, 15 Aug 2023 19:18:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/8] Repack objects into separate packfiles based on
 a filter
References: <20230808082608.582319-1-christian.couder@gmail.com>
        <20230812000011.1227371-1-christian.couder@gmail.com>
        <xmqqv8dhjfgm.fsf@gitster.g> <ZNvxg7BVJ+C5XFY4@nand.local>
        <xmqqjztwgcnc.fsf@gitster.g> <ZNwFlcS3SOS9h77N@nand.local>
Date:   Tue, 15 Aug 2023 16:18:02 -0700
In-Reply-To: <ZNwFlcS3SOS9h77N@nand.local> (Taylor Blau's message of "Tue, 15
        Aug 2023 19:09:09 -0400")
Message-ID: <xmqqfs4jhp3p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC2B48AC-3BC1-11EE-83F5-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> But why is that tree marked in the first place? It's because we attempt
> to rebuild the bitmap from the existing .bitmap file, but fail part of
> the way through (when we look up the first blob object in the reposition
> table). But that happens *after* we see the tree object, so its bit
> position is marked, even though we didn't rebuild a complete bitmap.

So, there is another bug lurking, other than the lack of "combining
filtered repack and bitmaps are explicitly forbidden" logic?  We see
the tree object, we immediately mark it as "done" even we are not,
then we finish in failure and the "done" mark is left behind?  Do we
need two bits, "under review" and "done", or something then?

> But it does seem suspect that we rebuild right into ent->bitmap, so we
> may want to consider doing something like:
>
> --- >8 ---
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index f6757c3cbf..f4ecdf8b0e 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -413,15 +413,19 @@ static int fill_bitmap_commit(struct bb_commit *ent,
>
>  		if (old_bitmap && mapping) {
>  			struct ewah_bitmap *old = bitmap_for_commit(old_bitmap, c);
> +			struct bitmap *remapped = bitmap_new();
>  			/*
>  			 * If this commit has an old bitmap, then translate that
>  			 * bitmap and add its bits to this one. No need to walk
>  			 * parents or the tree for this commit.
>  			 */
> -			if (old && !rebuild_bitmap(mapping, old, ent->bitmap)) {
> +			if (old && !rebuild_bitmap(mapping, old, remapped)) {
> +				bitmap_or(ent->bitmap, remapped);
> +				bitmap_free(remapped);
>  				reused_bitmaps_nr++;
>  				continue;
>  			}
> +			bitmap_free(remapped);
>  		}
>
>  		/*
> --- 8< ---
>
> on top.
>
> Applying that patch and then rerunning the tests with the appropriate
> TEST variables causes the 'git repack' to fail as expected, ensuring
> that the containing test passes.

Interesting.
