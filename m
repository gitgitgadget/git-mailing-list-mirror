Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D89C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 01:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F1922E00
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 01:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbhAGBh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 20:37:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54058 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbhAGBh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 20:37:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D60AFA41E7;
        Wed,  6 Jan 2021 20:37:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bl0B9zoTg5zd6Mclx4Z3fBrhaaM=; b=rlOLiJ
        hiWX+ml+8uXk//kFMXmuvH6Aa7FzTwIpYTd2I0bXr07XJcGsHzVblR/wAB5BqVNU
        y1RtaGe3+aa51ATFY+RXt9Sv2DSCUXtwhbtQfFgoW0x5BFGQhV8zkDvzqXqNZ7qb
        Jrmm+vvRGTAHVz8KgvqpNTxIi/qR2wLy8o7A8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Mjo2c4XRCRZ+7ngHttxf35ZjdJEZ6D06
        n+MMF5z7nJX/1gI7DQjKw/kJMEOFLTf2Pcy3Wuub9ReqsPmfjep+a01bpKkXpsgi
        pTG1iq0nKZoSeZDSFbaX3fR1lcPom9EExcLrDC/+W91AT0JIsYZTHfSc5sylju0a
        uHCVL0FeKjk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC99CA41E2;
        Wed,  6 Jan 2021 20:37:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 565EFA41DD;
        Wed,  6 Jan 2021 20:37:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] revision: trace topo-walk statistics
References: <pull.828.git.1609302714183.gitgitgadget@gmail.com>
Date:   Wed, 06 Jan 2021 17:37:15 -0800
In-Reply-To: <pull.828.git.1609302714183.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 30 Dec 2020 04:31:53
        +0000")
Message-ID: <xmqqh7nto7ck.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFB30E02-5088-11EB-AE30-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/revision.c b/revision.c
> index 9dff845bed6..1bb590ece78 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3308,6 +3308,26 @@ struct topo_walk_info {
>  	struct author_date_slab author_date;
>  };
>  
> +static int topo_walk_atexit_registered;
> +static unsigned int count_explore_walked;
> +static unsigned int count_indegree_walked;
> +static unsigned int count_topo_walked;

The revision walk machinery is designed to be callable more than
once during the lifetime of a process.  These make readers wonder
if they should be defined in "struct rev_info" to allow stats
collected per traversal.

