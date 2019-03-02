Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7185F20248
	for <e@80x24.org>; Sat,  2 Mar 2019 12:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfCBMfL (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 07:35:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35041 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfCBMfL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 07:35:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id t18so645704wrx.2
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 04:35:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7L+lxqggKPPgIEcuTRzpThWiDk4zg1kSrMQy9ruWCqI=;
        b=tZrh2mFVTzII18pl7FZPTzwEVnCwC3YJfvthSHbaL4bG0snrTP9H29Qy9HZSML9sBu
         b9XKwGyaPx8mMwT6V/o1ADH0BYG3+L8albPH2612LcmoSokwpIQHOKueChKvhL2mzeA5
         sMngjZrTDPWk/k+i7vxpBppP7Kd9dcNBs0CAQGyzb06l8nix15XHKK444+U99tm+VUhU
         G2YkJDkfx2dr+BP6qit5A2bgMrLkLpUaPVEN8CjCqsRl0CEFY1I3iNkAPhz/aK0Koy0C
         fsQ+OK8yc2HeQsMIGe6bVXEb5RtOoRlzf8tgu+h7a8LXEn4UxaUMT7pN4MMFHqJt4Wb+
         KaiA==
X-Gm-Message-State: APjAAAUjo+2L68ac31HhQlaMF9Pu0/fgmODVjasz5Wnk7rNW1r0kB0ay
        H7whIQ7PH2utwV3Fx5VnDDcfZyrDiwxPR85HjiU=
X-Google-Smtp-Source: APXvYqwtYUCRbYsA0ZnzXHKoD9+DcmLTl/hkNO6kf4VA3gtSn7n+B9OfwEonLaucY6nzukcU8NqzUPKgzMkvs1BfWbs=
X-Received: by 2002:adf:f149:: with SMTP id y9mr6398439wro.282.1551530109044;
 Sat, 02 Mar 2019 04:35:09 -0800 (PST)
MIME-Version: 1.0
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
In-Reply-To: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 2 Mar 2019 07:34:57 -0500
Message-ID: <CAPig+cQWCSVqXyOmBC9Wn-Ew79H0yGPRJxRiLCMNJjNOUu2yPw@mail.gmail.com>
Subject: Re: [PATCH] builtin/config.c: don't print a newline with --color
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 1, 2019 at 7:41 PM Taylor Blau <me@ttaylorr.com> wrote:
> [...]
> In this case, printing a terminating newline is not desirable. Callers
> may want to print out such a configuration variable in a sub-shell in
> order to color something else, in which case they certainly don't want a
> newline.

It's extra confusing considering that this:

    color=$(git config --get --type=color foo.color)
    echo "${color}hello" >output

works as expected since $(...) swallows the newline, whereas, the case you cite:

    (
    git config --get --type=color foo.color &&
    echo hello
    ) >output

does not.

Illustrating the problem in the commit message by using example code
like the above might (or might not) help the reader understand the
issue more easily. (I had to read the prose description of the problem
a couple times to properly understand it.) Not necessarily worth a
re-roll.

> To do what callers expect, only print a newline when the type is not
> 'color', and print the escape sequence itself for an exact comparison.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/builtin/config.c b/builtin/config.c
> @@ -258,7 +258,8 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
> -       strbuf_addch(buf, term);
> +       if (type != TYPE_COLOR)
> +               strbuf_addch(buf, term);

The reasoning for this conditional is sufficiently subtle that it
might deserve an in-code comment (though, perhaps is not worth a
re-roll).
