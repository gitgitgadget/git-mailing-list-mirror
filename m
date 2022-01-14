Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71309C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 19:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244179AbiANTvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 14:51:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59275 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbiANTvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 14:51:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26591112656;
        Fri, 14 Jan 2022 14:51:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z51oLzzHuz9LndWsvUvrUUJklOGKGwjCYF3Yiy
        pN/aY=; b=n7AI9GiTUJOMqqDLbAjQieMnpdiNV3OrdfN/A9UF/9GV3pvzlwuD3u
        FO6daEZ7vJtxfKxsbbOEb4bg5BGdPSjexsaOeiiI0VyVV8KuJOXFCmzo3s2gXw+Q
        oTS1k8rl1sPyh4Pm8IN58nAm3MjHi4XTvX/s+/5wisnwIW8ALyZm8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E957112655;
        Fri, 14 Jan 2022 14:51:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CA4F112654;
        Fri, 14 Jan 2022 14:51:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: v2.35.0 DEVELOPER=1 regression
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
        <xmqqlf0w5bbc.fsf@gitster.g>
        <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
        <xmqq4k7j68eg.fsf@gitster.g>
        <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
        <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
        <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
        <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
        <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net>
Date:   Fri, 14 Jan 2022 11:51:14 -0800
In-Reply-To: <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Fri, 14 Jan 2022 01:38:11 +0000")
Message-ID: <xmqqilumayfh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 556472A2-7573-11EC-84E1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> DEVELOPER=1 will now die because its core libraries use C11-specific
>> code:
>>     
>>     archive.c:337:35: error: '_Generic' is a C11 extension [-Werror,-Wc11-extensions]
>>                     strbuf_addstr(&path_in_archive, basename(path));
>>                                                     ^
>>     /usr/include/libgen.h:61:21: note: expanded from macro 'basename'
>>     #define basename(x)     __generic(x, const char *, __old_basename, basename)(x)
>>                             ^
>>     /usr/include/sys/cdefs.h:325:2: note: expanded from macro '__generic'
>>             _Generic(expr, t: yes, default: no)
>>             ^

Wow, that sounds horribly broken.

> I think we had this discussion about FreeBSD before and that's why I
> specifically dropped that option from the main makefile.  We can either
> drop that patch, or we can set it to -std=gnu11 and tell folks setting
> DEVELOPER to use a system released in the last five years.  I think we
> can be a little stricter with what we require in the case of DEVELOPER
> than we might be otherwise.

But that is not being stricter, but looser, no?  I thought that the
point of -std=gnu99 was to allow us to use C99 features while catching
use of language features newer than that, and use of -std=gnu11 will
defeat half the point, wouldn't it?
