Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61236C433E6
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 05:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1446C2389B
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 05:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbhAUF6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 00:58:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51396 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731077AbhAUDTX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 22:19:23 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BADC97B74;
        Wed, 20 Jan 2021 22:18:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CjqJlEusIoqVhSprfehdi466C6Q=; b=TuS6Bz
        FzO+1ujlToOIp3eOd0M8fZMTLswe3KvUcg+Owt7wiNXdftPBGqSLSJGrIYcxpf9I
        fBtCp0SROFtddXuYl8nxN3ZBuZ+VChx3HzljP4dhE37teOl/uj3kZXmkfdiED1Bm
        YoMWqG1nf346cBA0mIJfriqdytzSMaEfcgQLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aJ0VHbZtR9KHb+0g/ynRafThE3ps3ZFt
        Zmy6/x6VkeC/0BffXqLEV7t6JgewC4U+xHWl0iCUP1mLAeOmkh4TeMPwXCPhQSv8
        EzlcqLsqgUJra6LqJnsttbrZtPdEMpKSsyeC17afgflk9eyqez9FXYQTZaGWxWQT
        9oovj6nWDcE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6160297B72;
        Wed, 20 Jan 2021 22:18:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B320497B71;
        Wed, 20 Jan 2021 22:18:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 5/7] worktree: teach `list --porcelain` to annotate
 locked worktree
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
        <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
        <20210119212739.77882-6-rafaeloliveira.cs@gmail.com>
        <be24c164-3d03-145f-abc0-4f41ed225b4e@gmail.com>
Date:   Wed, 20 Jan 2021 19:18:33 -0800
In-Reply-To: <be24c164-3d03-145f-abc0-4f41ed225b4e@gmail.com> (Phillip Wood's
        message of "Wed, 20 Jan 2021 11:00:35 +0000")
Message-ID: <xmqqsg6vc706.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57E15532-5B97-11EB-9DFE-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> l.starts_with("locked ")
> rather than having to do
> l.starts_with("locked ") || l == "locked\n"

l.regexp_matches("^locked[\s\n]")?

Jokes aside, isn't the "space separated list" meant to be used more
like:

    attrs = l.splitAtEach(" ")
    if "locked" in attrs:
	... yeah it is locked ...
    if "broken" in attrs:
	... ouch, it is broken ...

so I am not sure if having always a trailing whitespace is a good
idea to begin with (the last element may become an empty string if
the splitting is done naively).

