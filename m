Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49461C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 15:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B2422201
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 15:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uGOKO3hY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389311AbgJNPZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 11:25:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62764 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389297AbgJNPZU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 11:25:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 63F98107D8C;
        Wed, 14 Oct 2020 11:25:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NuTvVptUOac8tUHwEG/UFX8imBg=; b=uGOKO3
        hY37n+tuFZD5BZYxfWvQmJ3cnS2SFBJC+5bd/w2Rl4CYbR0qXZlHGSDaAJQeuICB
        velwqHnh9D1ikmihd7OElywD3T83CS3lS6LlTXvMMS71lcxp364R4dcHV1nbqr6J
        MJOIDGtO4aY2KpKzSUbOKvAycOkvgF4JhZOkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UXaaILO+jnt3O0cPdG9IdyTDRC6jdpvS
        OLZgSJ0ld1tK+muCQD8HT8h1nLJFVaDamJexeO8nm7xTFWWMj1926fdMHP1siEid
        fncVIRsyMf9fSFnwPvfPH8Qrvw6rHAkW6vSmM1d9PU107hoh5cObH4x/XtewkobV
        3KCd0hbsWc0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CD3C107D8B;
        Wed, 14 Oct 2020 11:25:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9F1D8107D8A;
        Wed, 14 Oct 2020 11:25:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sean McAllister <smcallis@google.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Masaya Suzuki <masayasuzuki@google.com>, jrnieder@gmail.com
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
References: <20201013191729.2524700-1-smcallis@google.com>
        <20201013191729.2524700-3-smcallis@google.com>
        <xmqq362hkew3.fsf@gitster.c.googlers.com>
        <CAM4o00e1-5RqKXEVHk9u8JJQNtcKx_tNBpbyD_6B_+Wuw_bD4w@mail.gmail.com>
Date:   Wed, 14 Oct 2020 08:25:15 -0700
In-Reply-To: <CAM4o00e1-5RqKXEVHk9u8JJQNtcKx_tNBpbyD_6B_+Wuw_bD4w@mail.gmail.com>
        (Sean McAllister's message of "Wed, 14 Oct 2020 08:28:12 -0600")
Message-ID: <xmqqmu0oj0dg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76F1B380-0E31-11EB-B0D1-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sean McAllister <smcallis@google.com> writes:

> In the last patch of the series I actually knocked these down to 1
> second because the delay was obnoxious, I agree.  I'll update it so
> that it's done in this patch and I'll move gen_nonce.
> I'll be a little bit delayed with v3 since my workstation decided to
> explode last night :(

Ouch, sorry to hear that.  Be safe ;-)

We are deep in pre-release feature freeze right now anyway, so no
rush.

