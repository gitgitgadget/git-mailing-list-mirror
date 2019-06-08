Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A2B91F462
	for <e@80x24.org>; Sat,  8 Jun 2019 00:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfFHAm7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 20:42:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34125 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbfFHAm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 20:42:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id e16so3776525wrn.1
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 17:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgwJzkfcsFOT5sodqC1SY9UiTwCZLwzacbT6lXO1Cxo=;
        b=Nr1sIdByXmoTKYljjL7DHJcu6Azb2TBo1en0PObHOpuoEWrsq08U4HeEzCIQM8f3Es
         9+C47yOYS8Ml7cUZx9ksJ2mJLZOSHIKeZNcMsaP9dN8YluC1f+421MeQZ21eCCubPvSO
         73NDVhtnjwgZAgMLOTt0SmLMNX+m2zc5y2h1q15zO6AxgRnqXALt7fsY8lqM4Q1gwsd3
         BJhNSLCDDMwRaKL/12VcjkU9KXusg1zfBAEIykDBE+zYQ+dxTiQas3tzpVzTR1PgYp+F
         8pifeeBCVdYZXSPLkPskIIR8fw5Qd5n3tzCCQFRg9S1E6MUiA5anMBCCI4voZ1vgqngC
         JnxA==
X-Gm-Message-State: APjAAAVn9+MNptzWI1bwsMe0hFoSmhARtxheJ5Bg87N8gxpc+qYdtnrH
        DdHSgnzFHkONCqMHLOYIqiF/jE0poqCldMkLXxI=
X-Google-Smtp-Source: APXvYqzZ6RlNO24IIrdXlUgnK612sNZzP4yyeFJ07e8O0wn7AH3YkZTtvPDhZj63NthIo02Z8wOfFOvthEHSXL4T8sw=
X-Received: by 2002:adf:f84f:: with SMTP id d15mr35176253wrq.53.1559954577836;
 Fri, 07 Jun 2019 17:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190607225900.89299-1-emilyshaffer@google.com>
In-Reply-To: <20190607225900.89299-1-emilyshaffer@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Jun 2019 20:42:45 -0400
Message-ID: <CAPig+cS7ocDU3fGRPnQZqN+rT1Ujd2b=v5b1p5V6G++XmNPmsQ@mail.gmail.com>
Subject: Re: [PATCH] revision: remove stray whitespace when name empty
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 7, 2019 at 6:59 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> Teach show_object_with_name() to avoid writing a space before a name
> which is empty. Also teach tests for rev-list --objects --filter to not
> require a space between the object ID and name.
> [...]
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> Not sure if making the whitespace optional is the right solution for the
> test, although I couldn't come up with a cleaner approach. Maybe
> something like this would be better, even though handling it in the
> regex is shorter?
>
>   if [[ -z "$name" ]] then

In Git, we avoid Bash-isms. Just use 'test'. And, style is to place
'then' on its own line.

    if test -z "$name"
    then

> diff --git a/revision.c b/revision.c
> @@ -40,7 +40,8 @@ void show_object_with_name(FILE *out, struct object *obj, const char *name)
>  {
> -       fprintf(out, "%s ", oid_to_hex(&obj->oid));
> +       fprintf(out, "%s%s", oid_to_hex(&obj->oid),
> +               strcmp(name, "") == 0 ? "" : " ");
>         for (p = name; *p && *p != '\n'; p++)
>                 fputc(*p, out);
>         fputc('\n', out);

It's subjective, but this starts to be a bit too noisy and unreadable.
An alternative:

    fputs(oid_to_hex(...), out);
    if (*name)
        putc(' ', out);

> diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
> @@ -288,7 +288,7 @@ expect_has () {
>         hash=$(git -C r3 rev-parse $commit:$name) &&
> -       grep "^$hash $name$" actual
> +       grep "^$hash \?$name$" actual

This would be the first use of \? with 'grep' in the test suite. I
would worry about portability. Your suggestion earlier to tailor
'grep' invocation based upon whether $name is empty would be safer.
