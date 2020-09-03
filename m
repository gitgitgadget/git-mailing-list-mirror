Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83044C43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD2A20678
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n7LzU41t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgICWBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:01:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52205 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgICWBU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 18:01:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 17DD6E52B8;
        Thu,  3 Sep 2020 18:01:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d6uXU8TX7MdWzuJxDgtoZoFFYKQ=; b=n7LzU4
        1tGqMiyIIonZyadY3pyO2kB4DXM/fClJiWT84K14HQVOlLVgRaIet9vqiCDXStHG
        Fjumt57mejymWBD3ig0EXcY6cHymr/U5euP+bc3//53oUhrrPcV7kUOj+sPyUtfF
        +zsA2QPAkz+ZV91X9toVElTR58UY870viysCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tmPnZ7I1ni7HJp9g2Fn/c6eNDyAIjFGm
        9v4c/6Nl6ZFynjk1bmy4AM1TFu2b+1hiKvaUlGH+RszN24h7hxD+R7LEsFRM6lDX
        TVn0ddlbAw8K/du5IQE4paRSdX6UlxOwgDfb87xGnDHKXJvDGCkBwX836QTnEau9
        h0ppzOqnXPY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 10DFFE52B7;
        Thu,  3 Sep 2020 18:01:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9A57CE52B3;
        Thu,  3 Sep 2020 18:01:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 1/1] remote.c: fix handling of %(push:remoteref)
References: <20200312164558.2388589-1-damien.olivier.robert+git@gmail.com>
        <20200416150355.635436-1-damien.olivier.robert+git@gmail.com>
        <20200416152145.wp2zeibxmuyas6y6@feanor>
Date:   Thu, 03 Sep 2020 15:01:10 -0700
In-Reply-To: <20200416152145.wp2zeibxmuyas6y6@feanor> (Damien Robert's message
        of "Thu, 16 Apr 2020 17:21:45 +0200")
Message-ID: <xmqqv9gu7c61.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB144DE2-EE30-11EA-B90C-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> So this patch does not solve:
> - the memory leak mentioned by Jeff in https://public-inbox.org/git/20200328131553.GA643242@coredump.intra.peff.net/
> - the non correct result in a triangular workflow mentioned in
>   https://public-inbox.org/git/20200406175648.25737-1-damien.olivier.robert+git@gmail.com/
>   (aka v6, with an incomplete fix)
> - the code duplication between branch_get_push_remoteref and remote_get_1
>   (see my answer to Jeff's code mentioned above as to why his approach
>   would give a micro regression).
>
> Luckily I have figured how to solve 2) and 3). Unfortunately I haven't have
> time to work on this since two weeks, so I have just sent the original bug
> fix first so at least this one gets fixed.
>
> This is exactly as v4, except I moved the tests around to make them easier
> to grok.

Anything new on this topic?  No rush, but I'd hate to see a
basically good topic to be left in the stalled state too long.

Thanks.
