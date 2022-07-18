Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A9BC433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 15:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbiGRPyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiGRPyH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 11:54:07 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92389631F
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 08:54:05 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6BFFB1BDA3A;
        Mon, 18 Jul 2022 11:54:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d4k9FQPybyPzTApqKm5gPeKKesDkPe6QVkaLGj
        ne/U4=; b=n42YKCu7YBfhOuWXQgXmVOXKb3+CAY5CRTi2Xsto6ZCvxky1NImd1v
        r/nn6A/ye/2Z4Bdt89NBrYGbEm5kQ6WOFqY/0tq6g1g/zK8IGuqK/S9tq+IUiy60
        PBZk8IXwA35a88Q5TcMUjuONSo+PfOPM1VhsOcfrqbPNs1tn8xLS4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 63BF21BDA39;
        Mon, 18 Jul 2022 11:54:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 440CD1BDA35;
        Mon, 18 Jul 2022 11:53:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: write effective filter to trace2
References: <20220715172943.2681492-1-jonathantanmy@google.com>
        <770e3c15-90ea-7d6c-4854-608c0ad8cbaa@jeffhostetler.com>
        <xmqqmtdaz0vt.fsf@gitster.g>
        <de8d38fc-23e3-b876-87e8-7b4193bff44c@jeffhostetler.com>
Date:   Mon, 18 Jul 2022 08:53:58 -0700
In-Reply-To: <de8d38fc-23e3-b876-87e8-7b4193bff44c@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 18 Jul 2022 10:08:42 -0400")
Message-ID: <xmqqr12is9gp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6507BB6-06B1-11ED-9DD9-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> Yeah, the use of "none" gave me pause, but I didn't have a better idea
> at the time.  I guess we have:
> (a) requested, supported, used.
> (b) "none used because the server doesn't support it" and
> (c) "none used because the user didn't request it" cases,
> right?

At these sites where the new traces are added, we cannot detect the
remaining case (d) "requested by the user, asked for the server, but
the server dropped the ball", I think the above covers the possible
cases that are interesting to us entirely.

> Perhaps it would be better to do:
>     if (server_supports_filtering && args->filter_options.choice)
>         trace2_data_string("fetch", r, "filter/effective", spec);
>     else
>         trace2_data_string("fetch", r, "filter/unsupported", spec);
>
> Using two different keywords.
>
> So that the log only contains "filter/effective" when it was actually
> used.  And there is no "filter/effective" event when (for whatever
> reason) it was not in effect.
>
> Then the "filter/unsupported" event helps you with debugging.  Did they
> hit a server that doesn't support filtering or did they have a typo in
> their filter spec?
>
> Then don't emit a message at all for the "not requested" case.  And you
> can use the Git version number to know how to interpret it.  There are
> other places where we don't bother sending messages where the value is
> a zero or empty.

Sounds alright.  We could standardize the other way, which might
make the interpretation of individual trace entries independent of
the context easier, though.

Thanks.
