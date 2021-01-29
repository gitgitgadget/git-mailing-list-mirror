Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1682AC433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C314B64E0A
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhA2UVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 15:21:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59094 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhA2UVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 15:21:25 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9113994C6;
        Fri, 29 Jan 2021 15:20:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v7PjL6kEGxi/+Gxg/6drZac8t+8=; b=Bn+2xW
        VXYH0qqjCuOF2GwtRQrUbgQmjcXqOE7sfRloh1AnKdx2rRFHJniPF5REpYY9pCTe
        1fdHEXb6dtxBwl5cBTA7P67zpnNzVTo8ETs9Nxj4IK+19nTEYxEJXJ4/0QOt0oH1
        tGBZQftP4cBTm5/cxyTZOZ3kTX84ZH9k2jd9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rScI4UxwQjlMdIFuLEwHLaqKSemM+1zB
        XwBSppSdaJJ61sWTRNivrjifuZGWWw+2/cQBxUPAw+gqw7uRul6DRdWN6jx8qgez
        r+4BJk8RL4/4cCZfx3/pP3/7C+IVcOS+TtvbEqcSQZQX0JKeMAS0yZs4XOPcSfkU
        fCCWHIx560I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B8BA994C4;
        Fri, 29 Jan 2021 15:20:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F2D32994C3;
        Fri, 29 Jan 2021 15:20:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 01/10] packfile: introduce 'find_kept_pack_entry()'
References: <cover.1611098616.git.me@ttaylorr.com>
        <dc7fa4c7a61f657e779e10385d3e8076d6dac36c.1611098616.git.me@ttaylorr.com>
        <xmqqwnvwtqu1.fsf@gitster.c.googlers.com>
        <YBRirz8xAB4Swf8X@coredump.intra.peff.net>
Date:   Fri, 29 Jan 2021 12:20:34 -0800
In-Reply-To: <YBRirz8xAB4Swf8X@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 29 Jan 2021 14:31:59 -0500")
Message-ID: <xmqq7dnvtrzh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71824C06-626F-11EB-8DBC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So the more compelling argument, I think, is something like:
>
>   - you sometimes want to know if object X is any kept packs
>
>   - you can't use find_pack_entry(), because it only gives you the first
>     pack it finds
>
>   - you can walk over all packs and look for the object in each.
>     pack-objects does this. But it's slow, because you are looking in
>     packs you don't care about.
>
>   - so it's helpful for the lookup to know up front which packs are
>     interesting to find objects in and which are not, to avoid looking
>     in the uninteresting ones

That does make sense.
