Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0783C433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 07:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbhK3HzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 02:55:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56723 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239219AbhK3HzF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 02:55:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8612171BAC;
        Tue, 30 Nov 2021 02:51:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZyLdiE6rCffG
        5jFOz5xVf8rw4UIYKwl5o/NLI9SL5t8=; b=TLulwMT+HFIAOZHRX9Sc0YdYzurS
        uuGWnw5Xf/1SyGwY1lWf9m7NLEHw2pZ9m+iGZSi1MceE2QENkZtnNTywTqmjZkAA
        DQHiHlm4NUtYLPY3FUxmwrSR8ZOkPYDk7egnNyv7qqYYiUAOodCPI3mjVRpgYxhG
        cMMGaAu7va8YRXg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E0A56171BAB;
        Tue, 30 Nov 2021 02:51:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 048C2171BA9;
        Tue, 30 Nov 2021 02:51:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        chooglen@google.com
Subject: Re: [PATCH v4 0/2] Conditional config includes based on remote URL
References: <cover.1634077795.git.jonathantanmy@google.com>
        <cover.1638217387.git.jonathantanmy@google.com>
        <211129.864k7ug02c.gmgdl@evledraar.gmail.com>
Date:   Mon, 29 Nov 2021 23:51:40 -0800
In-Reply-To: <211129.864k7ug02c.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 29 Nov 2021 21:48:16 +0100")
Message-ID: <xmqq4k7u2i9f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5B5AF062-51B2-11EC-9D01-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Nov 29 2021, Jonathan Tan wrote:
>
>> Thanks everyone for your comments. Here's an update.
>
> Just from skimming this (minor) feedback on v3 still applies:
> https://lore.kernel.org/git/211123.86pmqrwtf2.gmgdl@evledraar.gmail.com=
/
>
> I.e. s/hasremoteurl/hasRemoteURL/ etc. in appropriate places.

Is there any appropriate place, though?

"hasremoteurl" is a new directive to be used as the leading part of
<condition> in the name of `includeIf.<condition>.path` variable.
The <condtion> part is case sensitive, and we do not want people to
spell it, and the existing "gitdir", "gitdir/i", and "onbranch", in
mixed cases.

See config.c::include_condition_is_true() function and its use of
skip_prefix_mem() to locate these existing conditions.

It is troubling that this patch is *NOT* extend the implementation
of include_condition_is_true() function (which gives a very clean
abstraction and makes the caller very readable); it instead mucks
with the caller of include_condition_is_true() and adds a parallel
logic that include_condition_is_true() does not know about.  It may
have been an expedite way to implement this, and the result may not
seem to hurt when include_condition_is_true() is called by only one
caller, but I find the resulting code structure unnecessarily ugly.

Can't the body of if (skip_prefix_mem(..."hasremoteurl:", ...)) block
become include_by_remoteurl() function, similar to include_by_foo()
functions include_condition_is_true() already calls?
