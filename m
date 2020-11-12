Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97BBC2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 18:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810802223F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 18:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKLScz convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 12 Nov 2020 13:32:55 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:46373 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgKLScz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 13:32:55 -0500
Received: by mail-ed1-f53.google.com with SMTP id t11so7508319edj.13
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 10:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wW/Pc0ZQRUik9JV1LTbuklNXWzx6gu7ALIdY0B0IpIM=;
        b=HzHjUGi9LwVlz96QLFbPBsyp9BQgZIxPbLw+iZs2/w4nB5vgDchotwEO+jWoiV9hCs
         emfYPb9nOCZqlcQ5qvncVWxZpCok4IMrif5VtbQwYK1MGB2uc6ZIwEn/GHoMlobEmPbz
         ccTvIsmHLMQMopgTa2RIpIiQckBqBAtXGRVe3KOLDGzqucnIzNNx0WqjKopZkDVYtpcW
         fZk8oU7FIkOmhHJ+fxVAp08MoJ2IetsVb8c54z5MojkAX0Cdtg8lj+Dr6rrb9Lni7YKv
         +oJXfUYlCvd+IPpPuyjc+bkHqYEFkey0ww3kdUsX8x+jOb1zZU9UwDQX/7WYbW84thju
         1gjQ==
X-Gm-Message-State: AOAM531xSdj+HdQollAaZ9+ONNC50bEijYEPXmtcjpjjBp60RjBD/Ive
        QJfMe0UyUhU1ZzFyLJmYtDr9CnSAykLucyL2QBM=
X-Google-Smtp-Source: ABdhPJy2Fm272RLGD+0BVTFBaG8m+zYcVPOiG59f1rxS1L3PeHKUTzHPhAacfrh97aNmpISnnP/ze7BmAVpdlYDQXHw=
X-Received: by 2002:aa7:cc0e:: with SMTP id q14mr1209795edt.181.1605205973353;
 Thu, 12 Nov 2020 10:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20201112174353.GD4270@szeder.dev> <xmqqk0uqjw4l.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0uqjw4l.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 12 Nov 2020 13:32:42 -0500
Message-ID: <CAPig+cT1zDT1iqRqO-4U8Rwq7p=MFm5Bkn990AVbxMHqp=knmg@mail.gmail.com>
Subject: Re: git format-patch --range-diff bug?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 12:57 PM Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> >       git range-diff v1...v2 &&
> >       git format-patch -1 --range-diff=v1...v2 v2 &&
>
> The other day I did something similar and ended up with
>
>         git format-patch --range-diff=v1 v1..v2
>
> Would it help not to use the three-dot form?  From my reading of
> "git format-patch --range-diff=<previous>" description, it only
> needs to give a single range (i.e. previous side of series of
> commits) as the other range to be compared are by definition the
> patches you are producing, while v1...v2 syntax is to give two
> ranges with one option.  So...

Indeed. It's not clear (at least to me) how git-format-patch's
--range-diff option should interpret a 3-dot range, thus the
implementation explicitly supports only a single revision or a 2-dot
range, and the documentation reflects this.

It turns out, as you discovered, that the implementation is a bit
deficient in that it doesn't outright reject a 3-dot range, and
instead gets tripped up by:

     int prev_is_range = !!strstr(prev, "..");

which accidentally also matches a 3-dot range, with the result that
the 3-dot range gets passed into the lower-level range-diff machinery
which then forwards the 3-dot range to git-log. The git-range-diff
command, on the other hand, interprets a 3-dot range manually so such
a range doesn't make it down to the lower-level range-diff machinery.

I haven't fully thought it through yet, but at this point, the best
"fix" likely would be for `git format-patch --range-diff` to error out
when it sees a 3-dot range. (Unless there is some other intuitive
interpretation of a 3-dot range which escapes me.)
