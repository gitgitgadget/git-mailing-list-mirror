Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54793C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 21:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0117E206F9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 21:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LYP++9KT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbgKYVPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 16:15:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50225 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYVPP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 16:15:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68C319F46B;
        Wed, 25 Nov 2020 16:15:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=brcv2vRDC9YEJbh7Zx81qfUGywM=; b=LYP++9
        KTo/OwPC5SGXWUQhzw+lqFc/5N6w2t6cfarclWpUyovWmMm32IKOgOoHd93pvvX0
        Z9CxtepLQd1t6eg6CCzzFn7VExoeELnGzGUmn0OgluF0yl2aJi53qZ6dh7y+ZyT8
        iZvGfDGEpPlRu8du8FrJQrvxMY//vAeOSXsXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hkcC2ZxkPMRVbQxbcB8a002ywqfqKzis
        GFEM8Q+dbMJRI+83yD6/y1Ogelwuarmxsc7SpFnpL0yNmvKvjlWQLkVDatjAyMHp
        eOpxyoFbD37vQNC8ddpev0KM4ZOrTi1JnGxnGygHRnDv5QO7EpptwcvGOTgubVwS
        2Fw+qzU5oOU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22C459F469;
        Wed, 25 Nov 2020 16:15:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 649629F467;
        Wed, 25 Nov 2020 16:15:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 1/2] packfile.c: protect against disappearing indexes
References: <cover.1606324509.git.me@ttaylorr.com>
        <cee25cc1ca5bc3371e32099980f28b623c1349d5.1606324509.git.me@ttaylorr.com>
Date:   Wed, 25 Nov 2020 13:15:07 -0800
In-Reply-To: <cee25cc1ca5bc3371e32099980f28b623c1349d5.1606324509.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 25 Nov 2020 12:17:28 -0500")
Message-ID: <xmqq7dq9dtpg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BC44D8C-2F63-11EB-B951-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> In 17c35c8969 (packfile: skip loading index if in multi-pack-index,
> 2018-07-12) we stopped loading the .idx file for packs that are
> contained within a multi-pack index.
>
> This saves us the effort of loading an .idx and doing some lightweight
> validity checks by way of 'packfile.c:load_idx()', but introduces a race
> between processes that need to load the index (e.g., to generate a
> reverse index) and processes that can delete the index.

Ah, OK.  And demonstration using %(objectsize:disk) makes perfect
sense given the above explanation.

> These two together effectively revert 17c35c8969, and avoid the race
> explained above.
>
> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  packfile.c                  | 19 ++-----------------
>  t/t5319-multi-pack-index.sh | 24 ++++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 19 deletions(-)

Makes sense.  Thanks.

> diff --git a/packfile.c b/packfile.c
> index 0929ebe4fc..8d7f37a5f6 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -514,19 +514,8 @@ static int open_packed_git_1(struct packed_git *p)
>  	ssize_t read_result;
>  	const unsigned hashsz = the_hash_algo->rawsz;
>  
> -	if (!p->index_data) {
> -		struct multi_pack_index *m;
> -		const char *pack_name = pack_basename(p);
> -
> -		for (m = the_repository->objects->multi_pack_index;
> -		     m; m = m->next) {
> -			if (midx_contains_pack(m, pack_name))
> -				break;
> -		}
> -
> -		if (!m && open_pack_index(p))
> -			return error("packfile %s index unavailable", p->pack_name);
> -	}
> +	if (open_pack_index(p))
> +		return error("packfile %s index unavailable", p->pack_name);
>  
>  	if (!pack_max_fds) {
>  		unsigned int max_fds = get_max_fd_limit();
> @@ -567,10 +556,6 @@ static int open_packed_git_1(struct packed_git *p)
>  			" supported (try upgrading GIT to a newer version)",
>  			p->pack_name, ntohl(hdr.hdr_version));
>  
> -	/* Skip index checking if in multi-pack-index */
> -	if (!p->index_data)
> -		return 0;
> -
>  	/* Verify the pack matches its index. */
>  	if (p->num_objects != ntohl(hdr.hdr_entries))
>  		return error("packfile %s claims to have %"PRIu32" objects"
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index ace469c95c..d4607daec1 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -138,7 +138,7 @@ test_expect_success 'write midx with one v2 pack' '
>  
>  compare_results_with_midx "one v2 pack"
>  
> -test_expect_success 'corrupt idx not opened' '
> +test_expect_success 'corrupt idx reports errors' '
>  	idx=$(test-tool read-midx $objdir | grep "\.idx\$") &&
>  	mv $objdir/pack/$idx backup-$idx &&
>  	test_when_finished "mv backup-\$idx \$objdir/pack/\$idx" &&
> @@ -149,7 +149,7 @@ test_expect_success 'corrupt idx not opened' '
>  	test_copy_bytes 1064 <backup-$idx >$objdir/pack/$idx &&
>  
>  	git -c core.multiPackIndex=true rev-list --objects --all 2>err &&
> -	test_must_be_empty err
> +	grep "index unavailable" err
>  '
>  
>  test_expect_success 'add more objects' '
> @@ -755,4 +755,24 @@ test_expect_success 'repack --batch-size=<large> repacks everything' '
>  	)
>  '
>  
> +test_expect_success 'load reverse index when missing .idx' '
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(
> +		cd repo &&
> +
> +		git config core.multiPackIndex true &&
> +
> +		test_commit base &&
> +		git repack -ad &&
> +		git multi-pack-index write &&
> +
> +		git rev-parse HEAD >tip &&
> +		idx=$(ls .git/objects/pack/pack-*.idx) &&
> +
> +		mv $idx $idx.bak &&
> +		git cat-file --batch-check="%(objectsize:disk)" <tip
> +	)
> +'
> +
>  test_done
