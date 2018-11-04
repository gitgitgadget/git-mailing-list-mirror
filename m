Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E27D61F453
	for <e@80x24.org>; Sun,  4 Nov 2018 04:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbeKDNZ4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 08:25:56 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37281 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbeKDNZz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 08:25:55 -0500
Received: by mail-qk1-f194.google.com with SMTP id 131so9564090qkd.4
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 21:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ginzG3SfdZpCd9/F/n7j2n1hTQrhXjAaMcPcXUG/eek=;
        b=FMxkWIy7yZucsge02TV0kk09ljIHrePamirQ1HyZrroa0iKRsKW1jbHq/obM99mo+6
         ITr0POS370nHiuiLNvnpqDP1vn6CdRL7cKiXpEKnWcL49O7+/ayanwt1BorWAJ33A1ZM
         ntV7UUiproVURS1qs5hebSuV2u47ENl7rJR3i2O038nMiK/rGV87Om+pN3xKWB+LVkxI
         OIYv8/rlz7kBRgbMTn9gcrAx8b3xiIpSxuG97d41ELx71hBVJ7c3b1/X3K1FD6qGSpMi
         KylvQCOEEuIXx+UIqPD1T7oFcu9qKN+tPUrYpWAwX74dEofkhQXFK58ebr3e4JKpg1Ak
         HNsw==
X-Gm-Message-State: AGRZ1gL8KBZMtFyNBbfVOdiMMybvj5y5taUIru+Rn5NcZdQoIU5oVhCx
        kV6Wtfd5YZkGLRWMkoAFOhL1rZzrF1GuLn246JI=
X-Google-Smtp-Source: AJdET5f2A7qhlnnwG5SRLMa8lw9G/UrKi0UKH79qDWrf7+rQjw7/lGenyLFBOUUitzLZZiRNb5uewCpV8+5tADkCz/k=
X-Received: by 2002:a37:5e42:: with SMTP id s63mr13782062qkb.220.1541304745612;
 Sat, 03 Nov 2018 21:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
 <20181031101556.27169-1-phillip.wood@talktalk.net> <20181031101556.27169-3-phillip.wood@talktalk.net>
In-Reply-To: <20181031101556.27169-3-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 4 Nov 2018 00:12:13 -0400
Message-ID: <CAPig+cRBwkKGtzY6CwZiKb1mef0a-9F+O24d0R8ZfsRb5ssUbA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] am: improve author-script error reporting
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 6:16 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> diff --git a/builtin/am.c b/builtin/am.c
> @@ -308,6 +312,7 @@ static int read_author_script(struct am_state *state)
> +       int i, name_i = -2, email_i = -2, date_i = -2, err = 0;
> @@ -326,14 +331,38 @@ static int read_author_script(struct am_state *state)
> +       for (i = 0; i < kv.nr; i++) {
> +               if (!strcmp(kv.items[i].string, "GIT_AUTHOR_NAME")) {
> +                       if (name_i >= 0)
> +                               name_i = error(_("'GIT_AUTHOR_NAME' already given"));
> +                       else
> +                               name_i = i;
> +               }
> +               ...
> +       }
> +       if (name_i == -2)
> +               error(_("missing 'GIT_AUTHOR_NAME'"));
> +       ...
> +       if (date_i < 0 || email_i < 0 || date_i < 0 || err)
>                 goto finish;
> +       state->author_name = kv.items[name_i].util;
> +       ...
>         retval = 0;
>  finish:
>         string_list_clear(&kv, !!retval);

Junio labeled the "-2" trick "cute", and while it is optimal in that
it only traverses the key/value list once, it also increases cognitive
load since the reader has to spend a good deal more brain cycles
understanding what is going on than would be the case with simpler
(and less noisily repetitive) code.

An alternative would be to make the code trivially easy to understand,
though a bit more costly, but that expense should be negligible since
this file should always be tiny, containing very few key/value pairs,
and it's not timing critical code anyhow. For instance:

static char *find(struct string_list *kv, const char *key)
{
    const char *val = NULL;
    int i;
    for (i = 0; i < kv.nr; i++) {
        if (!strcmp(kv.items[i].string, key)) {
            if (val) {
                error(_("duplicate %s"), key);
                return NULL;
            }
            val = kv.items[i].util;
        }
    }
    if (!val)
        error(_("missing %s"), key);
    return val;
}

static int read_author_script(struct am_state *state)
{
    ...
    char *name, *email, *date;
    ...
    name = find(&kv, "GIT_AUTHOR_NAME");
    email = find(&kv, "GIT_AUTHOR_EMAIL");
    date = find(&kv, "GIT_AUTHOR_DATE");
    if (name && email && date) {
        state->author_name = name;
        state->author_email = email;
        state->author_date = date;
        retval = 0;
    }
    string_list_clear&kv, !!retval);
    ...
