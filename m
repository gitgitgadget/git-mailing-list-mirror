Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9DB11F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 01:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfJ2BkE (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 21:40:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52508 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfJ2BkE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 21:40:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A6FF6A8D26;
        Mon, 28 Oct 2019 21:40:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8uHy03/Hhvz0ueH/Q6tZgCRVTrU=; b=FDlY3N
        aXlOSinbhayL3OB8qEQryBhv63DlkxvhESGWdviv8EDma/1fzX5Ur8ljNDzGf56e
        ODBP8OM7ZGagzSzkhLxQCVqevBQgfKvPLf/pnr8OCh66IiD/WJaQ2Y37j1Y3yUh2
        Gn0Vt79QYjuRL16mvC3D2+L+WwH18Lpc0Cdtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OhYWBQz8KwD5Dq0mA+fkc9Gz1H0U6+c5
        rcZd0D2IVXJecWOfRkYpm0uO89p/p+Jlujxi5IIXoyeEitbzHxsvCuCTw760vxBl
        bLvAFU7zQ5V2EntCz5SLDv4XYhn74dT0+/GKj6qViVOvtTAOyjaNGVnwwkKgB1/v
        sQVNLhFhtYc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F87DA8D25;
        Mon, 28 Oct 2019 21:40:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C1E2FA8D20;
        Mon, 28 Oct 2019 21:39:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Subject: Re: [PATCH v3] fetch: delay fetch_if_missing=0 until after config
References: <xmqqv9sdeeif.fsf@gitster-ct.c.googlers.com>
        <20191025174129.194010-1-jonathantanmy@google.com>
Date:   Tue, 29 Oct 2019 10:39:57 +0900
In-Reply-To: <20191025174129.194010-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 25 Oct 2019 10:41:29 -0700")
Message-ID: <xmqqh83s8h3m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0501E2F8-F9ED-11E9-8117-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> > Instead, we can control whether a region of code lazy-fetches...
>> 
>> The approach "from here to there, we can set global to forbid
>> lazy-fetch" may prolong the life support of the quick-and-dirty
>> mechanism, but it has to assume you can say "from here to there"; it
>> would mean that we cannot go multi-threaded until we get off of it.
>
> By "from here to there", I meant, for example, creating a struct
> repository in cmd_fetch() that has fetch_if_missing=0, then passing that
> repository to fetch_pack() (once fetch_pack() and all functions it calls
> support a repository object).

I know---but that means the struct cannot be shared among threads
that are calling object layer, some of which want to lazily fetch
missing objects while others only want to check the existence, at
the same time.

Compared to that, judicious use of OBJECT_INFO_SKIP_FETCH_OBJECT and
other flags by callers can tell the underlying machinery why we are
interested in the object, which I think is the right direction to go
in the longer term.  What I am not certain about is if we are ready
to move to the right direction for the longer term, or we should still
be relying on the big-hammer global bit for expediency a bit longer.
