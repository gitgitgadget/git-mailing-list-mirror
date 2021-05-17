Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FEFC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 06:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FB361185
	for <git@archiver.kernel.org>; Mon, 17 May 2021 06:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbhEQG5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 02:57:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60252 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhEQG5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 02:57:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FB1F12E443;
        Mon, 17 May 2021 02:56:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jXOxocxqjdlMq7C7R3KFbDVPhwlTVo3MYVa1Qs
        3jG74=; b=L9TRKFS33LK6VdcpqGT8YY4mSJ/NL4RZE7It7d1NkD8gOOOADYGAfj
        LPjfg2OyUuPEXiSIeapFzJ/x+PdPeAB84towltwco8VenZ2ag8ngQGCV4e2LDTXd
        Cm0/c6LjXjdBajX8dDI0oISsNsgNfOm9Yie0jBM+XENf7NQqQ5Nmc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5916C12E442;
        Mon, 17 May 2021 02:56:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A705012E441;
        Mon, 17 May 2021 02:55:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Firmin Martin <firminmartin24@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] t: use test_config whenever possible
References: <20210514065508.247044-1-firminmartin24@gmail.com>
        <20210515152721.885728-1-firminmartin24@gmail.com>
        <20210515152721.885728-3-firminmartin24@gmail.com>
        <xmqqbl9b6zla.fsf@gitster.g>
        <87fsylgadx.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
Date:   Mon, 17 May 2021 15:55:55 +0900
In-Reply-To: <87fsylgadx.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
        (Firmin Martin's message of "Mon, 17 May 2021 08:08:42 +0200")
Message-ID: <xmqqsg2l3l38.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE98BE02-B6DC-11EB-81CC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firmin Martin <firminmartin24@gmail.com> writes:

> fact, I suspect that you misread the diff, cf. the end of the email). 
> I copy here the full test with line number to make sure that we are in
> the same page.

The following is the original test before your patch, right?

>>  415 test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config" '
>>  416     (
>>  417         cd downstream &&
>>  418         git fetch --recurse-submodules
>>  419     ) &&
>>  420     add_upstream_commit &&
>>  421     git config --global fetch.recurseSubmodules false &&
>>  422     head1=$(git rev-parse --short HEAD) &&
>>  423     git add submodule &&
>>  424     git commit -m "new submodule" &&
>>  425     head2=$(git rev-parse --short HEAD) &&
>>  426     echo "From $pwd/." > expect.err.2 &&
>>  427     echo "   $head1..$head2  super      -> origin/super" >>expect.err.2 &&
>>  428     head -3 expect.err >> expect.err.2 &&
>>  429     (
>>  430         cd downstream &&
>>  431         git config fetch.recurseSubmodules on-demand &&
>>  432         git fetch >../actual.out 2>../actual.err

Here we run one "fetch" inside downstream, with a config specific to
the downstream repository; the expectation is that this on-demand
setting is honored, overriding the "global" setting that was set on
line 421.

>>  433     ) &&
>>  434     git config --global --unset fetch.recurseSubmodules &&

And then we discard the "global" setting.

>>  435     (
>>  436         cd downstream &&
>>  437         git config --unset fetch.recurseSubmodules

Oh, I thought I saw there was another fetch before this unset
between 436 and 437, that writes to the same actual.out and
actual.err.

> At this point, I have the feeling that you have misread the diff
> (do correct me If I'm wrong) and saw ...
>>  (
>>      cd downstream &&
>>      git config fetch.recurseSubmodules on-demand &&
>>      git fetch >../actual.out 2>../actual.err
>>  ) &&
>>  git config --global --unset fetch.recurseSubmodules &&
>>  (
>>      cd downstream &&
>>      git fetch >../actual.out 2>../actual.err
>>      git config --unset fetch.recurseSubmodules
>>  ) &&

Exactly.  Thanks and sorry for the noise.
