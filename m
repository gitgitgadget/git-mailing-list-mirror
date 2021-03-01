Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546A7C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 23:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D2C60240
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 23:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbhCAXcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 18:32:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63084 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245441AbhCAWfH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 17:35:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9719DAC765;
        Mon,  1 Mar 2021 17:34:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Js6aou6o2JFBflEwzjy0iK3WSP8=; b=U/JpCU
        qsj7eMpqETz4gDmoAdRut/E0//EgjJKLYNchUhcDBS0GH806H5XrY22mod4kAJG/
        l6S46J1ijvz8QSY1CWOiDAayIpZDUmCuxTuTK1CUixFrHP+TKe/WXKIngdcbFBgE
        FuLUIeEkN8Khp5S+gC38m0HssXgnbY13fpa8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JpL/mvXojCUU4uKQRniE6IywrHIblJqP
        Rik2BKaI69ecKZy//SFiHHCTWdrmS/b7LWSD4T+OcRcY4VjbBkLRQTCUeuUvZALR
        t3mxl80Em/p86x1YmCafOczpex2/KrxsMjArad5Hkaef9Qg0KVpNdHOJnmg68GlN
        lX8iuCo23F8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8CFD8AC764;
        Mon,  1 Mar 2021 17:34:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12E97AC763;
        Mon,  1 Mar 2021 17:34:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, stolee@gmail.com,
        johannes.schindelin@gmx.de, lilinchao@oschina.cn
Subject: Re: [PATCH v4] builtin/clone.c: add --reject-shallow option
References: <xmqq35xo7yzy.fsf@gitster.g>
        <20210301220319.3426185-1-jonathantanmy@google.com>
Date:   Mon, 01 Mar 2021 14:34:23 -0800
In-Reply-To: <20210301220319.3426185-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 1 Mar 2021 14:03:19 -0800")
Message-ID: <xmqqh7lumrkg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46049034-7ADE-11EB-814A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> This may reject to clone from a shallow repository, but at this
>> point the bulk of the tranfer from the origin repository has already
>> happened, no?  Rejecting after transferring many megabytes feels a
>> bit too late.  That is one of the reasons why I kept hinting that
>> the transport layer needs to be taught an option to reject talking
>> to a shallow counterpart if we want to add this feature [*1*].
>
> Extending the transport layer in this way might not be too difficult in
> the case of native (SSH, git://) protocols and using protocol v0, since
> handshake() in transport.c (called indirectly from
> transport_get_remote_refs()) writes shallow information to a data
> structure that we could potentially expose for the caller to use (before
> it calls transport_fetch_refs(). I couldn't see how remote-using
> protocols (e.g. HTTP) communicate shallow information, though
> (remote-curl.c seems to just keep it for itself), so that will be a more
> difficult task. And of course there's the matter of protocol v2, which I
> discuss below.
>
>> [Footnote]
>> 
>> *1* Looking at Documentation/technical/pack-protocol.txt, "git
>>     fetch" seem to learn if the repository is shallow immediately
>>     upon contacting "upload-pack" during the Reference Discovery
>>     phase (we'd see 'shallow' packets if they are shallow). I
>>     suspect that the right solution would be to teach the codepath
>>     on the "git fetch" side that accepts, parses, and acts on this
>>     packet to optionally stop communication and error out when the
>>     caller asks not to talk with a shallow repository.
>
> This is true with protocol v0, but protocol v2 bundles all shallow
> information (whether coming from the fact that the remote is shallow or
> the fact that the fetcher specified --depth etc.) and sends them
> together with the packfile. It may be possible to stop packfile download
> (saving bandwidth on the client side, at least) once such information is
> returned, though.

So in short, the "we do not want to clone from a shallow upstream"
would not be possible to implement sensibly without significantly
cleaning up the protocol layers first, which makes the whole thing
pretty much moot.

Thanks for a review and insight.


