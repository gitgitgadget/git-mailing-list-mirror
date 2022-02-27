Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2AFC433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 19:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiB0Ttm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 14:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiB0Ttl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 14:49:41 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F54220EB
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 11:49:04 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDEED18D23B;
        Sun, 27 Feb 2022 14:49:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hwdLGlGQEhcKyN534Q04cZ+u8NodGAJfClmHy1
        DS1sc=; b=c2r4JJyA6sLFUkcog7yolsNFzdc5IqRNKy3v44cV65BtG5aNPX3hRV
        QTurfUR269ZZHInncoG0PlfyYw1tl1RioyJLegCO+x8v3oEPa5aMsyowQ/cif7LT
        Iv8A9MLvBepssbH23qJEwg79HhAehNQIq+k6koLU+kWELMyXyykRY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E681818D23A;
        Sun, 27 Feb 2022 14:49:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 59AB518D238;
        Sun, 27 Feb 2022 14:48:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Matheus Felipe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Matheus Felipe <matheusfelipeog@protonmail.com>
Subject: Re: [PATCH] fix: include the type flag in the cli docs
References: <pull.1220.git.git.1645853661519.gitgitgadget@gmail.com>
        <f171e157-7dbc-b07e-7164-c62e2427fbe2@gmail.com>
Date:   Sun, 27 Feb 2022 11:48:58 -0800
In-Reply-To: <f171e157-7dbc-b07e-7164-c62e2427fbe2@gmail.com> (Bagas Sanjaya's
        message of "Sun, 27 Feb 2022 11:29:06 +0700")
Message-ID: <xmqqilt03xat.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E60CF2C-9806-11EC-B266-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 26/02/22 12.34, Matheus Felipe via GitGitGadget wrote:
>> From: Matheus Felipe <matheusfelipeog@protonmail.com>
>> When the `git config --global --help` command is invoked,
>> the cli documentation is shown in the terminal with a small
>> error in one of the values of the Type group, which is the
>> absence of the type flag in the `--type` argument.
>> This commit fixes that.
>> 
>
> What about the commit message below?
>
> ```
> The usage help for --type option of `git config` is missing `type`
> in the argument placeholder (`<>`). Add it.
> ```

It is more concise, and at the same time points out the problem
being addressed a lot more explicitly.  Much better.

>> -	OPT_CALLBACK('t', "type", &type, "", N_("value is given this type"), option_parse_type),
>> +	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type"), option_parse_type),
>
>
> The help should be `give the value the specified type`.

I am not sure if this is much of an improvement.

    $ git config --type=bool junk.flag 0
    $ git config junk.flag
    false

uses the type information to turn "0" into "false" before it writes
the value set to the variable to the file, while

    $ git config junk.flag 0
    $ git config junk.flag
    0
    $ git config --type=bool junk.flag
    false

shows that a stored value of "0" can be turned into "false" when
showing.  "Give the value the specified type" does not capture the
essense in either direction.

    Before setting or showing, convert the value to its canonical
    representation according to the given type.

is what we want to convey, but it is quote a mouthful as-is.

Saying "Assume the value is of this type" would strongly imply
"Convert ... to its canonical reporesentation", and the current
"value is given this type" may be a close enough and shorter
approximation of it.  I dunno.

