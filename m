Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC79C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 23:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF90610CB
	for <git@archiver.kernel.org>; Wed, 19 May 2021 23:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhESXde (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 19:33:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56867 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhESXdd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 19:33:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6756D22A5;
        Wed, 19 May 2021 19:32:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wuNYly407gZB+I2Qv5pzZ4rtDEMOd9xhkru8rc
        fvZx0=; b=Nhd2qXvywnaclLqu+ZKx6O8Jg7mZvoqC5FWEhXoDftR38mufYml9YH
        hXJokI26NkMXr4ZgHIHO+xCKGi6i/8IhZtOep4x6QfP5BI9NQrb3UC6inxuU8rRh
        Mbl9UxVLhtuipyO/Vb1WRtujbdb63r7MWRPw4SVHXCP1wIVLDjO88=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC020D22A4;
        Wed, 19 May 2021 19:32:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59C9CD22A3;
        Wed, 19 May 2021 19:32:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <YKWHo9gZNp+i3fH9@google.com>
Date:   Thu, 20 May 2021 08:32:11 +0900
In-Reply-To: <YKWHo9gZNp+i3fH9@google.com> (Jonathan Nieder's message of "Wed,
        19 May 2021 14:48:19 -0700")
Message-ID: <xmqqmtsqwb9g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FE9CC7A-B8FA-11EB-9FD3-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Sergey Organov wrote:
>
>> Fix long standing inconsistency between -c/--cc that do imply -p, on
>> one side, and -m that did not imply -p, on the other side.
>>
>> After this patch
>>
>>   git log -m
>>
>> will start to produce diffs without need to provide -p as well,
>
> Personally I don't ever use -m without -p and --first-parent, so in
> that sense this feels like a change in the right direction.
>
> Does this also affect the plumbing command "git diff-tree"?  I'm
> guessing "no" because diff-tree already generates a diff by default,
> but it seems worth spelling out in the commit message to prevent
> worries about the effect on scripts that expect stable plumbing
> behavior.

This is about "log" from the "rev-list" family, not "diff" to
compare two endpoints, so "git diff" won't be affected, and "git
diff-tree" is not affected, either.


