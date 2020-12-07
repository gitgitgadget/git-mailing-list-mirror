Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FB3C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 00:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ADAF207C9
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 00:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgLGADK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 19:03:10 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:33320 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLGADJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 19:03:09 -0500
Received: by mail-ej1-f67.google.com with SMTP id b9so6622355ejy.0
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 16:02:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gDbdzyjZ4hGKbCQxdVVHauGc0BQ1a/XtrRGhxFM3hEE=;
        b=OSPi9GM3pp68ZUzis5NwBRc3WCS5ami+mGGJ8ktcIX0kjwtKlrNUJ5+vXNhWRoN1lS
         N5kfb6NaRnMg6NibGm5jKE5TgvpHpNITOs23+RBoziExDmeOiUNFoSXiTa+LbzS4HS/b
         L1J32pKfCQgzVV9hmJuDcHGcj6qNhqwi8jsLzQRVq3yczZQOKtjjeZTHojA3JoNiO6Ld
         aKHb7+fmo4nA0Q9FJ2/KewKY0lU3OH/jSKHXn31339hXnSBumHdYycErodPAaHlUtA0i
         LDk+4qJb3jwDB4MY+ATwEiYCI4w0VeFUP/ycUNgo5rdxt7uYuzn4TQ3F0K4kp+z+SFyU
         3MHA==
X-Gm-Message-State: AOAM533TeQ3uXxgFRdR4pXqagPpjQQw3G9n3GHkiuhRz4B5XaFGk42ci
        3KVZkSex6SGxhbYOo+6NTPUCdVZ7MEGpy/c16BE=
X-Google-Smtp-Source: ABdhPJzw7V/S5rFLadGSPvw4bk85QB8yHp+Mn8j9A+I/haSANDwSnu7zRymApJh5AbgThsXSceBo6Jq5aNYYkaCDpl8=
X-Received: by 2002:a17:906:4944:: with SMTP id f4mr17135341ejt.231.1607299347713;
 Sun, 06 Dec 2020 16:02:27 -0800 (PST)
MIME-Version: 1.0
References: <20201206225349.3392790-1-sandals@crustytoothpaste.net> <20201206225349.3392790-2-sandals@crustytoothpaste.net>
In-Reply-To: <20201206225349.3392790-2-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 Dec 2020 19:02:16 -0500
Message-ID: <CAPig+cTbtpzwcQPHUgyf=0Oe5h2_=zory2oj9oFEUrdtaRR6ng@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] abspath: add a function to resolve paths with
 missing components
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 6, 2020 at 5:56 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> We'd like to canonicalize paths such that we can preserve any number of
> trailing components that may be missing.  Let's add a function to do
> that, allowing either one or an unlimited number of components to
> canonicalize, and make strbuf_realpath a wrapper around it that allows
> just one component.

This commit message is too barebones. As a justification, "We'd
like..." is insufficient; it doesn't help the reader understand why
this change is desirable.

Further, the lack of explanation about the seemingly arbitrary "one or
infinite" condition confuses the issue. The first question which
popped into this reader's head was "why those two specific choices?".
What makes one missing path component special as opposed to any number
of missing components? (These questions are mostly rhetorical; I can
figure out reasonable answers, but the commit message ought to do a
better job of explaining.)

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> +/*
> + * Just like strbuf_realpath, but allows specifying how many missing components
> + * are permitted.  If many_missing is true, an arbitrary number of path
> + * components may be missing; otherwise, only the last component may be missing.
> + */
> +char *strbuf_realpath_missing(struct strbuf *resolved, const char *path,
> +                             int many_missing, int die_on_error)

This interface feels odd. Why would a caller ever want to call this
function with many_missing=0 when it would be easier, shorter, more
direct to simply call strbuf_realpath()? Is the plan to retire
strbuf_realpath() down the road?

A more orthogonal-feeling interface would be to make this function
_always_ allow any number of missing trailing path components (that
is, drop `many_missing` altogether). Doing so would simplify the
documentation and the signature. If the caller needs the original
behavior of only allowing the final path component to be missing, then
strbuf_realpath() can be used, as usual.

The name of the function is somewhat confusing, especially if you take
the suggestion of dropping the `many_missing` argument. Perhaps a name
such as strbuf_realpath_forgiving() would be more understandable.

Note that the above comments are only about the API. It's perfectly
fine if the two functions share an underlying private implementation
(making them each one-liners calling the actual worker function).
