Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ECCC433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 00:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCA460F26
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 00:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbhKHAuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 19:50:13 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:35576 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhKHAuM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 19:50:12 -0500
Received: by mail-ed1-f41.google.com with SMTP id g14so55255089edz.2
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 16:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sV2r9OAOZo/BOZcSHNgQmhgKUvtkvO2TCvj6pcTWUHY=;
        b=U+1rpHxHP4uKUOYleiXvvTRWR1DOLvVT3uL1xlJmaRflwqstJ0uU6MDBANh7CnmtQi
         RF/vF9YxDB4XiQcW0PiTNkHyW2ldTZ7ZddEEvvL/IgWrkoZMq7yG8hmMeORTO8aSl4n0
         Bko6WF5HVH+cucWbUb41rlmSWGsKmudTZ3H0BuUy2mnGvF4BpYrE5LuZoTJqeS102PfR
         0VBoPZH3lJYbADdTvAkCzYHi//9SJkLuP3Df8O22VaNr5SJoZfZnNNN2iIcaP3e9Nixx
         Xm/I2RLNlS7Ig6t7Kw052m37pUjt5a3UrkJyMfVrCsKZ5/pR+7qRtMvZ1b4CIyJwZoiB
         DTXg==
X-Gm-Message-State: AOAM533L781WW4UZKxXtylVKxb2o3iaEwj91qbVhBkf8yE8ZH2A+DJWT
        Y2Fpd/CslW06r4/EXmDwnXaiBd4iLoKRPr2ZLaY6BV2I99w=
X-Google-Smtp-Source: ABdhPJySbQvJy/JMI1gwpaDeH9QDzlPEY792v0XPImpF4bvpw79SvWDJLEZgp9UoeW7u7+ZjYKPGDmYVruekCoMqLJM=
X-Received: by 2002:aa7:cdc9:: with SMTP id h9mr74757148edw.370.1636332448273;
 Sun, 07 Nov 2021 16:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20211104160959.183402-1-greenfoo@u92.eu> <20211104160959.183402-2-greenfoo@u92.eu>
 <CAJDDKr5KZK3wpox6FJPOL9koPr=k5+qTzZtPPFEmg4iZsvwoog@mail.gmail.com>
In-Reply-To: <CAJDDKr5KZK3wpox6FJPOL9koPr=k5+qTzZtPPFEmg4iZsvwoog@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 7 Nov 2021 19:47:17 -0500
Message-ID: <CAPig+cRiMVzMd5yEZkRvwdAjf-tawGGrSsCBUAVs+pTTw5KunA@mail.gmail.com>
Subject: Re: [PATCH 1/3] vimdiff: new implementation with layout support
To:     David Aguilar <davvid@gmail.com>
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Seth House <seth@eseth.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        rogi@skylittlesystem.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 7, 2021 at 5:42 PM David Aguilar <davvid@gmail.com> wrote:
> On Thu, Nov 4, 2021 at 9:10 AM Fernando Ramos <greenfoo@u92.eu> wrote:
> > +       AUX=$(echo "$LAYOUT" | grep -oe "[A-Z]\+\*")
>
> From Documentatin/CodingGuidelines:
>
> As to use of grep, stick to a subset of BRE (namely, no {m,n},
>    [::], [==], or [..]) for portability.

Also, `grep -o` isn't POSIX.

> > +       if test $(echo $LAYOUT | wc -w) == "1"
> > +       then
> > +               CMD="$CMD | bufdo diffthis"
> > +        else
> > +               CMD="$CMD | tabdo windo diffthis"
> > +       fi
>
> The output of "wc -c" is non-portable. It contains leading whitespace
> on some platforms.
>
> The test expression should be:
>
>    test "$value" = 1
>
> with a single "=" rather than "==".

For clarification, the leading whitespace emitted by some `wc`
implementations is only a problem when encapsulated in a string. For
instance, like this:

    if test "$(... | wc -w)" = "1"

in which case "  1"  won't equal "1". The usage here, however, should
be okay since the output is not quoted.

Quite correct about using "=" (or even "-eq") here rather than "==", though.

> > +       if $base_present
> > +       then
> > +               eval "$merge_tool_path" \
> > +                       -f $FINAL_CMD "$LOCAL" "$BASE" "$REMOTE" "$MERGED"
> > +       else
> > +               [...]
> > +               eval "$merge_tool_path" \
> > +                       -f $FINAL_CMD "$LOCAL" "$REMOTE" "$MERGED"
> > +       fi
> > +
> > +       ret="$?"
> > +       if test "$ret" -eq 0
>
> This should be:
>
>     if test "$ret" = 0

Or simpler, no need for `ret` at all:

    if test $? -eq 0

(or `if test $? = 0` -- either works)

Another (perhaps better) alternative is to assign the result of `eval`
to `ret` at the point of invocation, which lessens the cognitive load
a bit since you don't have to scan backward through the code trying to
figure out what $? refers to.

Also, why is `eval` needed here? Is there something non-obvious going
on? (Genuine question; I didn't trace the code thoroughly to
understand.)

> > +                       eval cp -- \$"$FINAL_TARGET" "$MERGED"
>
> This eval may not be safe when the value contains whitespace or shell
> metacharacters.
>
> I think it might be better to just spell it out and be explicit.
>
> It's more code but it'll be easier to follow:
> [...]
> if test -n "$source_path"
> then
>     cp -- "$source_path" "$MERGED"
> fi

I suspect `--` also needs to be avoided since it is not POSIX.
