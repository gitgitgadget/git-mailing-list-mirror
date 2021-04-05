Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233C2C433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA70261394
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbhDERlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 13:41:14 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:34581 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbhDERlL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 13:41:11 -0400
Received: by mail-ej1-f47.google.com with SMTP id b7so17912190ejv.1
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 10:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Su6716KuD044Tl+yZFFhKAG3dUGKpJF8bhb4zwSXqSk=;
        b=Mn5/aGRDCmym3h5W94BlpS+9LyBDKzv0MNZ3KBW9nJFStA10xJHrAQVGQ4T5/dZwgN
         fsKXRcVGfz3J1aS8MZg8Vkx/wIff6NjGJr/GWJpACKOVN8XqhHWu0svXDSeWXwAL+ags
         Kq9rOiqL/fFXKpEEjFX49se68hWwdLxR7ZXGPMksWy01WO1i79KLByendSG4AarZvOqU
         1OiN6rwlhlKvbCHuHQBy1DTd3gR5i84YJtqzChPoc47mmDyi2bB4iSnrjbTdxBrTxKrB
         Ktprck4rI+AtNrxMVFwADRAG6I0qQg3kxKIdsN4KqGDL3+rRuNwbBZogFOVUjAJts/bZ
         YoYA==
X-Gm-Message-State: AOAM5311DxP+1ZDRwyLX3++gLdhVju1MOtL66/Kee78zRXZBk4/Sj9h6
        VnXAnGKm852TkirgFE24K3bA8WLqkVWKuwSQvEo=
X-Google-Smtp-Source: ABdhPJyn2FZRVckbshDXDmCJMlkTol9ZDJaZV3diQvlLMd0o3efUmfGE8KikFuVQdnkfw7HOd+J5UDPLZguGxTWsx7g=
X-Received: by 2002:a17:907:76b3:: with SMTP id jw19mr28928343ejc.202.1617644445224;
 Mon, 05 Apr 2021 10:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <e10007e1cf8ff0005295f648b9489c11a9427122.1617627856.git.gitgitgadget@gmail.com>
 <20210405165740.brevvzc7hiyg2wj4@brm-x62-17.us.oracle.com>
In-Reply-To: <20210405165740.brevvzc7hiyg2wj4@brm-x62-17.us.oracle.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Apr 2021 13:40:34 -0400
Message-ID: <CAPig+cSfzpynO5es+B4=7_Dz-qTHNXpDeUVxs7z5yffQFgWU=A@mail.gmail.com>
Subject: Re: [PATCH 3/5] refspec: output a refspec item
To:     Tom Saeger <tom.saeger@oracle.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 5, 2021 at 12:58 PM Tom Saeger <tom.saeger@oracle.com> wrote:
> On Mon, Apr 05, 2021 at 01:04:13PM +0000, Derrick Stolee via GitGitGadget wrote:
> > +const char *refspec_item_format(const struct refspec_item *rsi)
> > +{
> > +     static struct strbuf buf = STRBUF_INIT;
> > +
> > +     strbuf_reset(&buf);
>
> is this even needed?

This is needed due to the `static` strbuf declaration (which is easy
to overlook).

> > +     if (rsi->matching)
> > +             return ":";
> > +
> > +     if (rsi->negative)
> > +             strbuf_addch(&buf, '^');
> > +     else if (rsi->force)
> > +             strbuf_addch(&buf, '+');
> > +
> > +     if (rsi->src)
> > +             strbuf_addstr(&buf, rsi->src);
> > +
> > +     if (rsi->dst) {
> > +             strbuf_addch(&buf, ':');
> > +             strbuf_addstr(&buf, rsi->dst);
> > +     }
> > +
> > +     return buf.buf;
>
> should this be strbuf_detach?

In normal circumstances, yes, however, with the `static` strbuf, this
is correct.

However, a more significant question, perhaps, is why this is using a
`static` strbuf in the first place? Does this need to be optimized
because it is on a hot path? If not, then the only obvious reason why
`static` was chosen was that sometimes the function returns a string
literal and sometimes a constructed string. However, that's minor, and
it would feel cleaner to avoid the `static` strbuf altogether by using
strbuf_detach() for the constructed case and xstrdup() for the string
literal case, and making it the caller's responsibility to free the
result. (The comment in the header file would need to be updated to
say as much.)
