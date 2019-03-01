Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4680B20248
	for <e@80x24.org>; Fri,  1 Mar 2019 20:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfCAUxz (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 15:53:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34250 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCAUxz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 15:53:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so27299492wrg.1
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 12:53:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmQwrEFOPHsvdl1hfv0WQ4LoKPHAzQVWCmVgSQwzlvA=;
        b=eMSZaIE5YTmVYxhlwoCO9g0i0qunmF+pjOP877qieCvcmyNlBGvUbDW144OIC94tZr
         Xgr1lDZP8zCDyqx/U9ReUG/GFp8MDHxikuyQf25SIWxDH6nNQxnk5JPVLd3dwdCF/snI
         4sbzNmvVjqh4eS2v53C5blX8a7JZwYFVYeiVpEedbDjnwmmv67Z+CmEsY23EdyftBnHx
         6OJjHmWWTSxm4UGb4IbtPqblAWPdFyVz7fpqhk6jO38YtvIbpc2MPCcNLb3vIrvG9Usm
         InGD+23bKBi6WKshaDjbcpZsMoupOCCjZBdx4nzAL525ITNrLzI1yZ2EYOJ4TiJvSDp/
         Ixog==
X-Gm-Message-State: APjAAAUt51ZsrszTZCFj3MOk09evRnAfETRzY81ms8X8uiJH6OlqGgnI
        DGj0vpub+YabE7QQf6fBDNT9a5Mwap2ughsrIog=
X-Google-Smtp-Source: APXvYqy9Mp7hnYpvq7zXfI+8FSI7ATdmL9spcfE3BrJ1XYNUIh3smXxZX9vu9jxIVp2lGBdFTupGXNAVNtnpNZB3afw=
X-Received: by 2002:adf:c7c6:: with SMTP id y6mr4620414wrg.217.1551473633433;
 Fri, 01 Mar 2019 12:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20190301171304.2267-1-brandon1024.br@gmail.com> <20190301190954.GG30847@sigill.intra.peff.net>
In-Reply-To: <20190301190954.GG30847@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Mar 2019 15:53:43 -0500
Message-ID: <CAPig+cQoZQCTAzaDiaAdAvSqHBHSoapDoVLjPtpKjCEVSBL57g@mail.gmail.com>
Subject: Re: [PATCH v2] commit-tree: utilize parse-options api
To:     Jeff King <peff@peff.net>
Cc:     Brandon Richardson <brandon1024.br@gmail.com>,
        Git List <git@vger.kernel.org>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 1, 2019 at 2:10 PM Jeff King <peff@peff.net> wrote:
> On Fri, Mar 01, 2019 at 01:13:04PM -0400, Brandon Richardson wrote:
> > +     if((!unset) && (!arg)) \
> > +             BUG("option callback does not expect negation and requires an argument"); \

Peff didn't highlight this, but compare your use of macro arguments
against his...

> +/*
> + * Similar to the assertions above, but checks that "arg" is always non-NULL.
> + * I.e., that we expect the NOARG and OPTARG flags _not_ to be set. Since
> + * negation is the other common cause of a NULL arg, this also implies
> + * BUG_ON_OPT_NEG(), letting you declare both assertions in a single line.
> + */
> +#define BUG_ON_OPT_NOARG(unset, arg) do { \
> +       BUG_ON_OPT_NEG(unset); \
> +       if (!(arg)) \
> +               BUG("option callback require an argument"); \
> +} while (0)

Note, in particular how Peff used !(arg) rather than (!arg) in your
patch. This distinction is subtle but important enough to warrant
being called out. The reason that Peff did it this way (the _correct_
way) is that, as a macro argument, 'arg' may be a complex expression
rather than a simple boolean. for instance, a caller could conceivably
invoke the macro as:

    BUG_ON_OPT_NOARG(unset, foo || bar)

Let's say that 'foo' and 'bar' are both true. With Peff's version,
when the macro is expanded, that expression becomes:

    !(true || true)

which evaluates to false as expected and intended. With your version,
it expands to:

    (!true || true)

which evaluates to true (since ! has higher precedence than ||), which
is a very different and very unexpected (and likely wrong) result.
