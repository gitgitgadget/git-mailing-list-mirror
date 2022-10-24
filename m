Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E37C67871
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 23:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJXXk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 19:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJXXkl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 19:40:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DF319420D
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 14:59:32 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE597140E7B;
        Mon, 24 Oct 2022 17:59:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ithlrSdX0Z6nrbx25VaWhZ2utmHYyT4DkqoF+e
        6MkDA=; b=xMjNgMgzV+9s5jIjnNOajyfYfa16+wp62UbtbddGxg37rDxu+75x0V
        9ivm2y1cdhBwUlnKFh5Rvc93ueIqZWOKnTtk9da7i8/PP2Px96li0UU6WDe2Vpjb
        npNB5g0DgUd6YCsTeT2HotHflTNtLrSokg9xDInInSzl7kPWNwf0Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5187140E7A;
        Mon, 24 Oct 2022 17:59:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10D7A140E78;
        Mon, 24 Oct 2022 17:59:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jacob Stopak <jacob@initialcommit.io>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/7] shortlog: introduce `--group=<format>`
References: <cover.1665448437.git.me@ttaylorr.com>
        <cover.1666637725.git.me@ttaylorr.com>
Date:   Mon, 24 Oct 2022 14:59:03 -0700
In-Reply-To: <cover.1666637725.git.me@ttaylorr.com> (Taylor Blau's message of
        "Mon, 24 Oct 2022 14:55:26 -0400")
Message-ID: <xmqqwn8orihk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1443342C-53E7-11ED-912D-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here is one more very tiny reroll of my series to implement arbitrary
> pretty formats as shortlog `--group`'s, based on a suggestion from Jacob
> Stopak.
>
> There are only a couple of changes from last time: one to rebase onto
> the current tip of 'master', and another to address a bug in 4/7 (which
> was resolved by the end of the series, but now works consistently
> throughout the series).
>
> This was pointed out by Peff in [1], and he indicated there:
>
>> It's hard to care too much, since the end result of the series is
>> correct, and you'd end up just removing that part of the line in
>> the final patch. So I could go either way on re-rolling.

One "huh?" is that the final patch in this round hasn't changed from
the last round, so the check for HAS_MULTI_BITS(log->groups) remains
in the final result.

IOW, after replacing the previous series with this round,

    $ git diff @{1}
    diff --git c/builtin/shortlog.c w/builtin/shortlog.c
    index 27b057940d..27a87167e1 100644
    --- c/builtin/shortlog.c
    +++ w/builtin/shortlog.c
    @@ -207,7 +207,7 @@ static void insert_records_from_trailers(struct shortlog *log,

     static int shortlog_needs_dedup(const struct shortlog *log)
     {
    -	return log->format.nr > 1 || log->trailers.nr;
    +	return HAS_MULTI_BITS(log->groups) || log->format.nr > 1 || log->trailers.nr;
     }

     static void insert_records_from_format(struct shortlog *log,

is the difference in the end result.

