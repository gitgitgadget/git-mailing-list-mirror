Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 055F11F461
	for <e@80x24.org>; Tue, 27 Aug 2019 20:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbfH0U1i (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 16:27:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54625 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0U1h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 16:27:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB5A8800FD;
        Tue, 27 Aug 2019 16:27:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=64k+69Tcs5xO/66yHs3quyPpgio=; b=fpIdBC
        6NtbK3W4JeaKW+se8PLANYgUv6HYVrMDtLDD1xOfzClI8D06nY/CCSVUC+0QdAJw
        +q6IYsMXxWLNxdriCt31MSOJje3dg4SGiXEqKY/GwRg73M07bq9H3qnsKyE+5FBt
        5WujAdw2+ddZrjMQjAPHciyyf4lRVKUDqm0pE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MklAPfVitxk52oSNrG0pkdDBW2ek2hK4
        pi8fOhtOShKe4NUg4jNHUFPd35SDa9St3rq+2ZcP4TKCAYV2jNT7TCoacqKFFhUh
        FfHg3N/G+tMiImenQ7y0OkKw+ty6qYZb1TjTdjod+Rt38n6aI50arv28pJ+MueCw
        8ebu8uxG3Co=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E456A800FC;
        Tue, 27 Aug 2019 16:27:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1BDF7800FB;
        Tue, 27 Aug 2019 16:27:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: write fetched refs to .promisor
References: <20190826214737.164132-1-jonathantanmy@google.com>
Date:   Tue, 27 Aug 2019 13:27:30 -0700
In-Reply-To: <20190826214737.164132-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 26 Aug 2019 14:47:37 -0700")
Message-ID: <xmqqmufu2w25.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19811D62-C909-11E9-8DD3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> As written in the NEEDSWORK comment, repack does not preserve the
> contents of .promisor files, but I thought I'd send this out anyway as
> this change is already useful for users who don't run repack much.

What do you exactly mean by "much" here?  The comment sounds like it
is saying "running this code once and you'd make the commits and
objects that were depending on the existing promisor invalid", in
which case it would be more like "it is already useful for users
until they run their first repack that destroyes their repository",
but certainly that is not what we want to do, so...

> +test_expect_success 'verify that .promisor file contains refs fetched' '
> +	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
> +	test_line_count = 1 promisorlist &&
> +	git -C srv.bare rev-list HEAD >headhash &&
> +	grep "$(cat headhash) HEAD" $(cat promisorlist) &&
> +	grep "$(cat headhash) refs/heads/master" $(cat promisorlist)
> +'
> +
>  # checkout master to force dynamic object fetch of blobs at HEAD.
>  test_expect_success 'verify checkout with dynamic object fetch' '
>  	git -C pc1 rev-list --quiet --objects --missing=print HEAD >observed &&
