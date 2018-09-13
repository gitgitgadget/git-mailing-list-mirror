Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5C5C1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 23:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeINFBb (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 01:01:31 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44358 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeINFBb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 01:01:31 -0400
Received: by mail-qt0-f194.google.com with SMTP id k38-v6so7142387qtk.11
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 16:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgwzO/cm8MbtsV2mwWRdNYx7wnu09BXribjNVs77NZI=;
        b=EYsvkIEfz08dDRFgpaI3ImB1FExsXoi49dCnvXXpKQh74kX/jrmoSZwfeq/arVKOdP
         CMLYWvz/Cf/U4Fbmo//yiwoLCcyXDRhxmo7ZympnMW7VNrKcLkGeOovtzOOM4kMOfJ5z
         c7SuvIbXIBGw357dAitAl88rM9TJHRdueulFOo70LhHZY2Ph6/6roFsY54pos/IvzO77
         PZ7kAviMgFkZPVQ1P87m4YK/HI0tsEReG0LF43aQFw6YkXTTYNWa5xbTlsUf8EALLjUx
         r6hwl7dlbrYjnOFWvWfQVGC7yN3yTcNVzEanVasrIT7O6wQvhjXXcFvsn0yoygZkgGfI
         BA2g==
X-Gm-Message-State: APzg51CfHyo9EVIICvDtKUy5BboIXc8sP3R7DFWMcgP8kzRzUhqTm788
        lzo2cSSKlnu9szMtGhVRXL7T/rsauLrNZKXVzfUWp5Iy
X-Google-Smtp-Source: ANB0Vda48la5g0dVbTx0mIpmuNeKm2kXtluTaf/PtnYZnsBxYzYinGc2MtN6gUwSrIF7yr6/Bo2oLQfBuur7N+QmvE4=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr7103766qtd.101.1536882588191;
 Thu, 13 Sep 2018 16:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180912101029.28052-1-phillip.wood@talktalk.net> <20180912101029.28052-3-phillip.wood@talktalk.net>
In-Reply-To: <20180912101029.28052-3-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 13 Sep 2018 19:49:36 -0400
Message-ID: <CAPig+cTGYWoW+YiW5tJVPZVie3zsG+pmQiV7k+es-=y9e4=RZw@mail.gmail.com>
Subject: Re: [PATCH 2/3] add read_author_script() to libgit
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 12, 2018 at 6:11 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> Add read_author_script() to sequencer.c based on the implementation in
> builtin/am.c and update read_am_author_script() to use
> read_author_script(). The sequencer code that reads the author script
> will be updated in the next commit.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> diff --git a/builtin/am.c b/builtin/am.c
> @@ -305,39 +279,16 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
>  static int read_am_author_script(struct am_state *state)
>  {

This function returns 'int'...

>         const char *filename = am_path(state, "author-script");
> +       if (read_author_script(filename, &state->author_name,
> +                              &state->author_email, &state->author_date, 1))
> +               exit(128);

...but only ever exit()s...

> +       return 0;

... or returns 0.

>  }

It's a little disturbing that it now invokes exit() directly rather
than calling die() since die() may involve extra functionality before
actually exiting.

What if, instead of exit()ing directly, you drop the conditional and
instead return the value of read_author_script():

    return read_author_script(...);

and let the caller deal with the zero or non-zero return value as
usual? (True, you'd get two error messages upon failure rather than
just one, but that's not necessarily a bad thing.)

A possibly valid response is that such a change is outside the scope
of this series since the original code shared this odd architecture of
sometimes returning 0, sometimes -1, and sometimes die()ing.
