Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F342D2082D
	for <e@80x24.org>; Fri,  8 Sep 2017 17:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756654AbdIHRhX (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 13:37:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56965 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756210AbdIHRhW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 13:37:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BF3F95199;
        Fri,  8 Sep 2017 13:37:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aHVZqmcy7a/8Bpugu84h2DCyLxs=; b=GgnhuL
        885dxeyS7bADqI/9qlcULeu8n+GLlm2FlCsGfGldgyvZibhLFnn46CFBGDeK4POk
        DGb7EoSLOgZIr9NxW51WWNHbHCk+thIeqdpqaGh/GWC11REo68UugsUp24dzXCZ0
        jhiWHzBqrkCAlrLK7KmrQGa/qCMirlWuN03tU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XSSXSm2pJNDRH8HfBjtX9Yv3Y59m/YdR
        YZB/kY4UNyAW3dYxZu/Go619Yy78up2Elo+8RHdUxtfaUIPG06qttlSiHWH3CbGA
        nDETqZrCJyiKaN7Y1x/LKewIjA75giyN/8iFLlKj27TiUgcXCyjTwyu7Z/G5bYWu
        OgZwwuG+peM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2339795198;
        Fri,  8 Sep 2017 13:37:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8AB0B95197;
        Fri,  8 Sep 2017 13:37:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?0JLQsNC70LXQvdGC0Lg=?= =?utf-8?B?0L0=?= 
        <valiko.ua@gmail.com>, "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "git shortlog -sn --follow -- <path>" counts all commits to entire repo
References: <CAJrPYn8_n1JD3hL1LSAVz2Khs=dZRVaZ-gpru5AV+ottv5WfAw@mail.gmail.com>
        <CAGZ79kZAeCERKn6he2LzAj97BXEJ5U+Fy4sorAPNmW_XaCS9Vg@mail.gmail.com>
        <20170908051015.ybq4egdrddecl4se@sigill.intra.peff.net>
        <xmqqo9qlzodi.fsf@gitster.mtv.corp.google.com>
        <20170908074910.reoyb47navgsg6kt@sigill.intra.peff.net>
Date:   Sat, 09 Sep 2017 02:37:20 +0900
In-Reply-To: <20170908074910.reoyb47navgsg6kt@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 8 Sep 2017 03:49:10 -0400")
Message-ID: <xmqqbmmlytv3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E5A766E-94BC-11E7-86F7-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah. It depends on exactly how such a fix is made. I think one
> improvement would be to actually bump --follow handling into the
> limit_list() stage, so that we properly handle history simplification
> over followed paths. In which case get_revision() would just never
> return the uninteresting commits, and the current shortlog code would
> Just Work.
>
> That said, I don't think we can go wrong by making shortlog's traversal
> more like log's. Any changes we make to --follow will be aimed at and
> tested with git-log, so the more code they share the more likely it is
> that shortlog won't bitrot.

Both true.  

Using log-tree traversal machinery instead of just get_revision()
would probably mean we would slow it down quite a bit unless we are
careful, but at the same time, things like "git shortlog -G<string>"
would suddenly start working, so this is not just helping the
"--follow" hack.

