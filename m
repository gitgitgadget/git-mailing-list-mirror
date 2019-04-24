Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C366C1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 03:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfDXDBs (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 23:01:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54522 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfDXDBr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 23:01:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 70D12617F0;
        Tue, 23 Apr 2019 23:01:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ivFsTc82imf0i4cWZsQdGQv5I48=; b=kGzoTt
        zC2FSZDWryLQvm6CQNfO52y4cZk0kbGzCZFuHXJa4fbMYFpIJNjAKBDJohJxuhUB
        UjIfsivr8dCCCOEP0Y0uZVAsrjHTgsM2b7hmGvKKFrRASrKvAQVyJK1Tp8Z66awc
        1wMdTymHLtmqV/W+btw+Ze0nwOwfAxlwRqVhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RC0OQWdeDOjnzpj/lp5mRWd2vWGkX64i
        Uj2OnIEYoE8qzKlWLocNfXNeXYWwdqA/PE3q4b4s/CQjsdgj87CFuh54WK972DnV
        DjedVbxGaosSTjhoabotVhNClZhvpSZdpUow9CccVEFeM96wkIeFeRYLNcMzXiH1
        sHRl32nZRD0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6937A617EF;
        Tue, 23 Apr 2019 23:01:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 97C47617EE;
        Tue, 23 Apr 2019 23:01:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v2 5/8] Documentation: add Packfile URIs design doc
References: <cover.1550963965.git.jonathantanmy@google.com>
        <cover.1552073690.git.jonathantanmy@google.com>
        <5ce56844d3fb740e29d2f3d4be2ade0b2ad5f7fd.1552073690.git.jonathantanmy@google.com>
        <20190423053130.GA13162@sigill.intra.peff.net>
Date:   Wed, 24 Apr 2019 12:01:42 +0900
In-Reply-To: <20190423053130.GA13162@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 23 Apr 2019 01:31:30 -0400")
Message-ID: <xmqqftq82jjd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4ADADEA4-663D-11E9-AEC5-EE24A11ADF13-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I.e., I think the conversation ought to be more like:
>
>   Server: I support packfile-uris X, Y, Z.
>
>   Client: Great. I'll use URIs X and Z.
>
>   Server: OK, here's your pack, minus any objects I know are in X and Z.
>           I'll send you the objects from Y as normal.

I agree with the overall direction, but I am afraid that the server
advertisement may have to become a lot more complex.

For example, are you assuming in the above example that X, Y and Z
are not overlapping?

Or perhaps X is the whole repository that is quick to access only
from European clients, while Y and Z combined have the same set of
objects that are meant for our Asian friends.  IOW, the server may
expect that the client would say one of three "there is nothing I
can use then", "I am happy with X and won't use Y and Z" or "I'll
use Y and Z then, without X", and no other combinations like "I'll
use X and Z" may make sense.

> And then the client is free to pick and choose. The initial server uri
> list can come in the capabilities list, or it can be a separate request
> once the client sees the server supports packfile-uris and wants to ask
> about them. We may need some way for the server to group the uris so
> that the client knows which ones are alternates of each other (and which
> ones are needed to make a complete set).

I guess what I am saying is that it is not so clear how we can
present the server offered URIs to the client in such a way that the
client (either mechanically, or consulting the human) can make a
useful choice,

