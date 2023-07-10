Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ED5EB64DA
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 20:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjGJUJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 16:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjGJUJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 16:09:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A7B13E
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 13:09:55 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FC2918CC90;
        Mon, 10 Jul 2023 16:09:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OEZAhagxIp2gIu3MrKp2Dgo2HzBFSiCCOKEuX5
        C1atI=; b=PagirkKMPwVUM5uHoBZki9kQ0TDnx2Vqq1Q7d8SWyu8YLVLSBv3QGb
        a92nDOWsaLMnkwB5WzdwJ8cF+vOnRMQ9Hw8hRovRXMuplAI4UirAs0dBgPwV4Lna
        DxsWdZxshTz2Ft4v92bsSv6YNcJOsSSt8sOAlmDr90YDQ6J8K0qLI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1756918CC8F;
        Mon, 10 Jul 2023 16:09:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7611F18CC8E;
        Mon, 10 Jul 2023 16:09:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 1/2] builtin/repack.c: only repack `.pack`s that exist
References: <cover.1689017830.git.me@ttaylorr.com>
        <f14a88f1075093c870cd1d53b4e0cea10d5ab67d.1689017830.git.me@ttaylorr.com>
Date:   Mon, 10 Jul 2023 13:09:50 -0700
In-Reply-To: <f14a88f1075093c870cd1d53b4e0cea10d5ab67d.1689017830.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 10 Jul 2023 15:37:15 -0400")
Message-ID: <xmqqedlf4jg1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA6A968C-1F5D-11EE-851A-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Add a check to see if the .pack file exists before adding it to the list
> for repacking. This will stop a number of maintenance failures seen in
> production but fixed by deleting the .idx files.

When we are adding we'd eventually add both and something that lack
one of them will eventually become complete and will be part of the
repacking once that happens.  When we are removing (because another
repack has about to finish), removing either one of them will make
the pack ineligible, which is OK.  If somebody crashed while adding
or removing and ended up leaving only one, not both, on the
filesystem, ignoring such a leftover stuff would be the least
disruptive for automation.  Makes sense.

> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index af79266c58..284954791d 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -213,16 +213,16 @@ test_expect_success 'repack --keep-pack' '
>  	test_create_repo keep-pack &&
>  	(
>  		cd keep-pack &&
> -		# avoid producing difference packs to delta/base choices
> +		# avoid producing different packs due to delta/base choices

OK.

>  		git config pack.window 0 &&
>  		P1=$(commit_and_pack 1) &&
>  		P2=$(commit_and_pack 2) &&
>  		P3=$(commit_and_pack 3) &&
>  		P4=$(commit_and_pack 4) &&
> -		ls .git/objects/pack/*.pack >old-counts &&
> +		find .git/objects/pack -name "*.pack" -type f | sort >old-counts &&
>  		test_line_count = 4 old-counts &&
>  		git repack -a -d --keep-pack $P1 --keep-pack $P4 &&
> -		ls .git/objects/pack/*.pack >new-counts &&
> +		find .git/objects/pack -name "*.pack" -type f | sort >new-counts &&
>  		grep -q $P1 new-counts &&
>  		grep -q $P4 new-counts &&
>  		test_line_count = 3 new-counts &&

I do not think "sort" in both of these added lines is doing anything
useful.  Does the test break without this hunk and if so how?

> @@ -239,14 +239,51 @@ test_expect_success 'repack --keep-pack' '
>  			mv "$from" "$to" || return 1
>  		done &&
>  
> +		# A .idx file without a .pack should not stop us from
> +		# repacking what we can.
> +		touch .git/objects/pack/pack-does-not-exist.idx &&

	>.git/objects/pack/pack-does-not-exist.idx &&

> +		find .git/objects/pack -name "*.pack" -type f | sort >packs.before &&
>  		git repack --cruft -d --keep-pack $P1 --keep-pack $P4 &&
> +		find .git/objects/pack -name "*.pack" -type f | sort >packs.after &&
>  
> -		ls .git/objects/pack/*.pack >newer-counts &&
> -		test_cmp new-counts newer-counts &&
> +		test_cmp packs.before packs.after &&


I'd say the changes from "ls" to "find" in the earlier hunk is
excusable in the name of consistency with this updated on, if the
use of "sort" matters in this hunk, but as "ls" gives a consistent
output unless you say "ls (-U|--sort=none)", I am not sure if we
need "sort" in this hunk, either.  So, I dunno.

"before vs after" does look like an improvement over "new vs newer".

> +test_expect_success 'repacking fails when missing .pack actually means missing objects' '
> +	test_create_repo idx-without-pack &&
> +	(
> +		cd idx-without-pack &&
> +
> +		# Avoid producing different packs due to delta/base choices
> +		git config pack.window 0 &&
> +		P1=$(commit_and_pack 1) &&
> +		P2=$(commit_and_pack 2) &&
> +		P3=$(commit_and_pack 3) &&
> +		P4=$(commit_and_pack 4) &&
> +		find .git/objects/pack -name "*.pack" -type f | sort >old-counts &&
> +		test_line_count = 4 old-counts &&
> +
> +		# Remove one .pack file
> +		rm .git/objects/pack/$P2 &&
> +
> +		find .git/objects/pack -name "*.pack" -type f |
> +			sort >before-pack-dir &&
> +
> +		test_must_fail git fsck &&
> +		test_must_fail git repack --cruft -d 2>err &&
> +		grep "bad object" err &&
> +
> +		# Before failing, the repack did not modify the
> +		# pack directory.
> +		find .git/objects/pack -name "*.pack" -type f |
> +			sort >after-pack-dir &&
> +		test_cmp before-pack-dir after-pack-dir
> +	)
> +'

Ditto for the use of "find | sort" vs "ls", but otherwise it looks
like it is testing the right thing.

Thanks.
