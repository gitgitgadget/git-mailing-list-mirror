Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14BA1F45C
	for <e@80x24.org>; Tue, 13 Aug 2019 22:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfHMWAU (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 18:00:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58983 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfHMWAU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 18:00:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57F6873F9A;
        Tue, 13 Aug 2019 18:00:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5LeipUMMseFOXVMgDksW2SfiMes=; b=Am6Qn5
        8kThddVTpo36Kweo8jp8fy+pMBoxLnBuvfa5RU+bh5UeFEPgFWXXy1UBwxD9FMNY
        bvZVL0nnaoOfK6fBDsFmeXzoPbse8i874/3fnvW8K687egyOYl6xKd/K1rkqfG4l
        QALE+DRd4C4+IUPNf3/VmnCK/QaBP4IlCo9RM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RfeBN+tTCCBEVMIy6hkbYMZxhaxyP7h0
        qDen6esbufO1smWRhXyVpHSEJgxeeHbocnG3DHQVnu8PU9M1d6x50zMsjpwxIAXa
        1WQOxA5GRwHX6HaiEhhZa0jBPk29noAIqpfmebo4l/mfrUCq1f/9kR5fKyTO3LpU
        hmy/OmqP0iU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4DA7173F99;
        Tue, 13 Aug 2019 18:00:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6EF8E73F92;
        Tue, 13 Aug 2019 18:00:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     git@vger.kernel.org, peff@peff.net, e@80x24.org,
        chriscool@tuxfamily.org, jonathantanmy@google.com, tboegi@web.de,
        bwilliams.eng@gmail.com, jeffhost@microsoft.com
Subject: Re: [PATCH v2 5/5] fetch: Make --jobs control submodules and remotes
References: <20190812213448.2649-1-palmer@sifive.com>
        <20190812213448.2649-6-palmer@sifive.com>
Date:   Tue, 13 Aug 2019 15:00:13 -0700
In-Reply-To: <20190812213448.2649-6-palmer@sifive.com> (Palmer Dabbelt's
        message of "Mon, 12 Aug 2019 14:34:48 -0700")
Message-ID: <xmqq7e7g7mky.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB22BBC0-BE15-11E9-8B18-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Palmer Dabbelt <palmer@sifive.com> writes:

> The existing --jobs argument was defined to control the number of jobs
> used for submodule fetching, but it makes more sense to have this
> argument control the number of jobs to be used when fetching from
> multiple remotes as well.
>
> This patch simply changes the --jobs argument parsing code to set both
> max_children_for_{submodules,fetch}, as well as noting this new behavior
> in the documentation.

That's a sensible, if overly careful, transition plan.  This patch
cannot be queued together with the other four, though, for the plan
to be practical.  It probably needs to come a few releases after the
other four hits a release.

A less involved and much more careless transition plan may be to
just declare that "--jobs that only controls submodule fetches is a
bug and it must also affect how fetches from multiple remote
repositories are done" and come directly to this step, without
necessarily introducing options that control them independently.

I have a suspicion that we can afford to go the careless route for
this particular one, if we wanted to, as not may people would care
about controlling these independently.

