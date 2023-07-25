Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0BEEB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 21:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjGYVQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 17:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGYVQt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 17:16:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6AC19B0
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 14:16:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C4181F220;
        Tue, 25 Jul 2023 17:16:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZnR53wIrx0H9IpwMdWrX/vv3jZi5wI6SYcvqBM
        AGZeo=; b=xISyoT0UE7TX/nmi2ZF/Ts/Y5Pu51j6mZNgiKZLE4RMzhAmNtXj4Yk
        2gyLhcV5Z9DVrsp+DK5uZqdV+PeGfCqfyDP+0rcdRUgR5imoYq6WHFaranMzTFfG
        7Ne/uLxVfDXB8b/8T6NchFCHYUZErPlH1HPHvzZtlhtQp5Ie3mF9U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 141B51F21F;
        Tue, 25 Jul 2023 17:16:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A4CFE1F21E;
        Tue, 25 Jul 2023 17:16:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 12/15] replay: disallow revision specific options and
 pathspecs
References: <20230509175347.1714141-1-christian.couder@gmail.com>
        <20230602102533.876905-1-christian.couder@gmail.com>
        <20230602102533.876905-13-christian.couder@gmail.com>
Date:   Tue, 25 Jul 2023 14:16:43 -0700
In-Reply-To: <20230602102533.876905-13-christian.couder@gmail.com> (Christian
        Couder's message of "Fri, 2 Jun 2023 12:25:30 +0200")
Message-ID: <xmqqy1j3itdw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EA92980-2B30-11EE-8FA8-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +	/*
> +	 * Reject any pathspec. (They are allowed and eaten by
> +	 * setup_revisions() above.) In the future we might accept
> +	 * them, after adding related tests and doc though.
> +	 */
> +	if (revs.prune_data.nr) {
> +		error(_("invalid pathspec: %s"), revs.prune_data.items[0].match);

This made me waste a few minutes wondering if and how I misspelt my
pathspec elements.  If we mean "no pathspec is allowed", we should
say so instead.

> +		usage_with_options(replay_usage, replay_options);
> +	}
> +
>  	/* requirements/overrides for revs */
>  	revs.reverse = 1;
>  	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index a1da4f9ef9..de6e40950e 100755
> --- a/t/t3650-replay-basics.sh
> +++ b/t/t3650-replay-basics.sh
> @@ -80,4 +80,20 @@ test_expect_success 'using replay on bare repo to rebase with a conflict' '
>  	test_expect_code 1 git -C bare replay --onto topic1 B..conflict
>  '
>  
> +test_expect_success 'using replay with (for now) disallowed revision specific option --not' '
> +	test_must_fail git replay --onto main topic2 --not topic1
> +'
> +
> +test_expect_success 'using replay on bare repo with (for now) disallowed revision specific option --first-parent' '
> +	test_must_fail git -C bare replay --onto main --first-parent topic1..topic2
> +'
> +
> +test_expect_success 'using replay with disallowed pathspec' '
> +	test_must_fail git replay --onto main topic1..topic2 A.t
> +'
> +
> +test_expect_success 'using replay on bare repo with disallowed pathspec' '
> +	test_must_fail git -C bare replay --onto main topic1..topic2 -- A.t
> +'
> +
>  test_done
