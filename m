Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B3AC2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 07:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9D961378
	for <git@archiver.kernel.org>; Wed, 26 May 2021 07:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhEZHIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 03:08:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63626 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbhEZHIU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 03:08:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0BC8C5BD7;
        Wed, 26 May 2021 03:06:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a1lA/Iu0+SCYugLZk4v2vdrYipB6kPvt0+JGHx
        JPJSQ=; b=YflKyQmifqC7sWsPrjDHMI1FFg21htF8Vbzykl6dlADIY0TKnfXt+S
        k56Ss+dfvqgZCmwf1DL7NiE0gmHXB4yoZqPY3aesaGD2B3yhHci3gEPQRrcg9n0k
        NYXxzWkR+9GEx3J3LICXM05viO8fZ7GXsX9G8ulBTn6Tw4v32pbm8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 982F7C5BD6;
        Wed, 26 May 2021 03:06:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 23E5FC5BD4;
        Wed, 26 May 2021 03:06:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 0/3] [GSOC][RFC] ref-filter: add contents:raw atom
References: <pull.959.git.1621763612.gitgitgadget@gmail.com>
        <xmqq1r9xndjf.fsf@gitster.g> <xmqq8s42cnyb.fsf@gitster.g>
        <CAOLTT8ReZffY5gznSDD=Fgbt7YTtA5aJWX+f8Q8npcj0OwcuFQ@mail.gmail.com>
Date:   Wed, 26 May 2021 16:06:46 +0900
In-Reply-To: <CAOLTT8ReZffY5gznSDD=Fgbt7YTtA5aJWX+f8Q8npcj0OwcuFQ@mail.gmail.com>
        (ZheNing Hu's message of "Wed, 26 May 2021 14:45:58 +0800")
Message-ID: <xmqqpmxeas8p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF6CF030-BDF0-11EB-8CE4-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> $ printf '%b' "name='a\\\0b\\\0c'\necho -e \"\$name\"" | sh | od -c
> 0000000   a  \0   b  \0   c  \n
> 0000006

This is wrong.  In the above, the variable name does not have a NUL
in it.  It insead has 2-byte sequence "\" and "0" in it, and you are
letting "echo -e" to convert it into binary, which is not portable
at all.

I'd suggest instead to declare that some host languages, like shell,
are not binary-clean and either refuse to process atoms whose values
have NUL in them.  Silently truncating strings at NUL or striping
NULs in strings are also acceptable options if clearly documented.
Claiming that we stuff binaries into variables of the host language,
while not doing so and instead assigning a quoted form, is not good.

I have not thought about Python3 very much.  For the purpose of most
%(placeholders), it is vastly more preferrable to use str (i.e. text
sequence type) as opposed to bytes, as you do not have to .decode()
to use the resulting "string", but even for things like %(refname),
it is not technically kosher to assume that the contents are UTF-8
encoded text, as filenames used to represent refnames are merely a
sequence of bytes except NUL, but for consistency with binary gunk,
we might have to emit everything as bytes.  I dunno.

> In shell or python2/3, we can replace'\0' with "\\0".

Not for shell.  We should declare that it is not supported to feed
binary to shell.
