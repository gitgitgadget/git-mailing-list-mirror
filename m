Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02302C433EF
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 16:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbiDWQD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbiDWQD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 12:03:26 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB24B1928F
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 09:00:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D06331145B3;
        Sat, 23 Apr 2022 12:00:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cjMcRUKwYP7k
        S0qyAAbhRQ1ZOTGCGIELccZbcbzC5ag=; b=AHMV3e6vroWGYkxv5f+D7tTtxAmM
        Qe88MuwKzGLNwm/FmonBjyYeWvN2tGz5ZYz7FljaPcx6Be0jubyWI0wPFXWHVMO8
        A0h+z7sZyvU7bdAzQZHbM0+cDYVTTwTplGOr0FoTgcmmzzjhdvQ8ceej5gb1bosf
        Q55kPMi6Zwxl5Nw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7ECE1145B2;
        Sat, 23 Apr 2022 12:00:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E52411145AF;
        Sat, 23 Apr 2022 12:00:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: gitk regression in version 2.36.0
References: <AM0PR04MB6019ECF053F1FB7B29D75AB7A5F69@AM0PR04MB6019.eurprd04.prod.outlook.com>
        <xmqqpml82vkd.fsf@gitster.g>
        <737bd2f8-dfd7-6a51-b7f5-33eefa33e975@web.de>
Date:   Sat, 23 Apr 2022 09:00:24 -0700
In-Reply-To: <737bd2f8-dfd7-6a51-b7f5-33eefa33e975@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 23 Apr 2022 12:13:11 +0200")
Message-ID: <xmqqh76j3i3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7D424206-C31E-11EC-9BD0-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> I am reasonably sure that reverting that commit will be the right
>> thing to do.  It is somewhat unfortunate that it would reintroduce
>> resource leaks that having clear_pathspec() in a wrong place (i.e.
>> diff_free()) was covering up.  We should instead need to find the
>> place where a diff_opt struct goes out of scope (after being used
>> for zero or more times, calling diff_free() after each iteration to
>> release resources consumed per-iteration) and call clear_pathspec().
>
> Right; a small memory leak is better than wrong output.

Yeah, it is an absolute requirement to avoid producing wrong output,
and when producing output for 100 or 1000 commits, we should not
leak resources in proportion to the number of these commits
processed, so forgetting to call diff_free() that releases resources
that are required per diff-invocation is also a must.  Compared to
that, cleaning up the resource allocated just once and repeatedly
used while we handle these 100 or 1000 commits, while it is nice to
do so, is of much lower priority, certainly much lower than computing
the right result.

> Finding those places is a bit complicated by diff_options often being
> embedded in struct rev_info, though.

Perhaps, but we should have a resource-releasing helper for rev_info,
so that may be a good place to do so, hopefully.

Thanks

> PS: And I need to learn to download new posts before hitting Send
> (or become faster); sorry for my near-duplicate reply.

Actually this time I very much appreciated an independent validation
of my findings ;-)  Thanks.
