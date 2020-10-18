Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C0BC433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 20:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7AC20874
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 20:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tXThjnOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgJRUHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 16:07:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56138 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgJRUHa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 16:07:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BD31E0252;
        Sun, 18 Oct 2020 16:07:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gYjUjWEQOTiHsF5hU44TGUP3eEQ=; b=tXThjn
        OpEr3LaWbjp+groZsTUxr3Swj3sjUemef+8mVndw4iXr6yaYE8LK+xklCMwqDNKV
        gybBrGw/w6d/qIxD4VRR+1QU7n5zzdJdpxcKbA6RsTdS+vAuuH5W5UrLDPrmUAP3
        i/GykTeQalXvQaTUrFzqfRK8zZBeJy12deNj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v7CO67UaJQchG/oTbtrvlTRX3oo/WLTu
        fsmNWZwPudFyREOXzyN4A2XJEGHkYPmIpIPnvk+3y9AcKbIkLjbv9cf7nhPnYEEe
        1ma+xP1D3w2XjLp4+oswFo3DgfzCPALPu9ZClRx/JKcAMmF3bOElOoQkMSQvSRmd
        XEqlvrC0F0w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84883E0251;
        Sun, 18 Oct 2020 16:07:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CDDD9E024F;
        Sun, 18 Oct 2020 16:07:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Why does git diff-index show intent-to-add file as "Added"?
References: <20201017162111.gvisfz2daqvhnjmb@yadavpratyush.com>
        <xmqqimb88v35.fsf@gitster.c.googlers.com>
        <55ed2ace-5dfd-55f9-d9a6-da71ff795716@gmail.com>
Date:   Sun, 18 Oct 2020 13:07:24 -0700
In-Reply-To: <55ed2ace-5dfd-55f9-d9a6-da71ff795716@gmail.com> (Phillip Wood's
        message of "Sun, 18 Oct 2020 17:00:57 +0100")
Message-ID: <xmqqo8kz70xv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A956D60-117D-11EB-9135-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> I think it may be sensible for the command to behave as if the i-t-a
>> path does not even exist in the index when it is run with "--cached";
>> I may be missing some subtleties that require us to do something
>> different, but that is what I would think.
>
> If a user runs `add -N file` then if they run `git reset -p` (which
> runs `git diff-index --cached HEAD`) it will ask them if they want to
> remove `file` from the index. If `diff-index --cached` hid i-t-a
> entries we'd lose that or have to get the i-t-a entries another
> way. Having said that it does seem strange for `diff-index --cached`
> to be showing i-t-a entries. Perhaps `diff-index --cached` should
> default to --ita-invisible-in-index?

It probably is a good idea to consider if the implementation of `git
reset -p` is doing a sensible thing, or relying on a buggy behaviour
of "diff-index --cached" (worse yet, broken "diff-index --cached" to
suit its needs) and see if it can be written differently.
