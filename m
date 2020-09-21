Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35F1C41604
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 19:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE6121D91
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 19:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gC5QYJaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgIUTaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:30:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56066 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgIUTaA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 15:30:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DC114FB5C6;
        Mon, 21 Sep 2020 15:29:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oOYZ4lDe9QE303kB4zqhPiT6UWc=; b=gC5QYJ
        aLK2fUssQQKNqzNPA3xvw+1TGlWuwLUdfcKb9SpSwG6/HwaA+7xJg4ZBUKb5SxVb
        rcx6aCGxRukEyZOTdFXc9Vc3bhsFhZgyYzeqScTwrdTUEk2P3elYRRyO+nU1DTHJ
        0BZxp5OkWM+7VHlXBAIqK8+NLYpatqzcJlhQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nQKB/MTxXp37ji8ll7N6jN9EJEyUHA9G
        AiuOaeC/BEKGgsBANL9a0kw/mIgts0u4IUelKJezpEOZn61WwjV/9guaWWFji6Nf
        mCPSQdmCfH/1093eII96ZgSIDT7lLasbHzaY6Q0K+bZVrQ9GVtK5GEa1W6PQD7RF
        v1Eh0E8RvOU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D5AFFFB5C5;
        Mon, 21 Sep 2020 15:29:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 290AFFB5C4;
        Mon, 21 Sep 2020 15:29:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 07/11] maintenance: take a lock on the objects directory
References: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
        <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
        <1a0a3eebb825ac3eabfdd86f82ed7ef6abb454c5.1600366313.git.gitgitgadget@gmail.com>
        <87d02fi75p.fsf@evledraar.gmail.com>
        <368d7c1f-b8b2-8bed-ead4-047019125435@gmail.com>
Date:   Mon, 21 Sep 2020 12:29:54 -0700
In-Reply-To: <368d7c1f-b8b2-8bed-ead4-047019125435@gmail.com> (Derrick
        Stolee's message of "Mon, 21 Sep 2020 09:43:24 -0400")
Message-ID: <xmqqa6xjexn1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4855572-FC40-11EA-A9B5-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> With this as an entry point we'll entirely do away with the old one
>> since we don't use the "gc --auto" entry point.
>
> Users could still erroneously launch two `git gc` commands concurrently
> and that will not use the maintenance.lock file. The GC lock is worth
> keeping around until we redirect the `gc` command to be an alias that
> runs `git maintenance run --task=gc [options]`.

Yes, that is prudent.  And as long as the traditional gc lock stops
the maintenance command from running the gc task, everthing would
work consistently ;-)

Thanks.
