Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6891620248
	for <e@80x24.org>; Sun, 14 Apr 2019 23:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbfDNXVt (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 19:21:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46735 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfDNXVs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 19:21:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so19356830wrw.13
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 16:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15KbyoAuEp7JKBss+HT/jLh9VVNTWqle8V8RpeGck1s=;
        b=Gd7FHVbmoDhN7aNA2u5RpB4h0cos6rwrTgipvZaJkfm1YmLJQhhmuU2t5+Se+Pn2JR
         Y+UhbYc4hZpJ6W1RN5d0EMIkbQPhi1X5tUHZ5uSTy46LSvrabuJSwfBjv9AiXbN0qq3e
         VNUV0Xib84BiQFMLTY0Buc1TN8No9pAfi+ch/PKCySgtd2cWY1yFLkjD2kTimqtyiZX/
         Q1qYb7MBeHJ2CcOIhqs4PUml/U+jWEf4RsE/JS/lNldwKLlL6stUBtpZAp8rfPbKZfkP
         O5dS2OdN1Tz5nDhBJDB9vbsajKUhHjti12iORUrACB3KXM7IecJ7OURaBor7zpGFobOp
         +i4w==
X-Gm-Message-State: APjAAAV0YkrAT5/FrRB/7PmsFxdsk+qV+dnylJz6SBrjz0rMHD6gasaF
        OxrMtGjMTwebw2SZpGvWopMtV5vAzEodfOKTpio=
X-Google-Smtp-Source: APXvYqzafrWf6vmXMBrNNsJV56bPKCdaBFsR0uzS8PJFZlsSONFYqBnLfYxKyHfUQfC+1icPbiCs59hmfGVA5JNiRRg=
X-Received: by 2002:adf:ea45:: with SMTP id j5mr36099031wrn.89.1555284106849;
 Sun, 14 Apr 2019 16:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190411220532.GG32487@hank.intra.tgummerer.com>
 <20190414210933.20875-1-t.gummerer@gmail.com> <20190414210933.20875-3-t.gummerer@gmail.com>
In-Reply-To: <20190414210933.20875-3-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 14 Apr 2019 19:21:35 -0400
Message-ID: <CAPig+cSmh1rCTPj0Y=G4OA3TmoGqVBnj95S+KogOgiDtW_0DiQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] range-diff: don't remove funcname from inner diff
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 14, 2019 at 5:09 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> [...]
> However it can still be useful to have the function name that 'git
> diff' extracts as additional context for the change.
> [...]
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/range-diff.c b/range-diff.c
> @@ -102,9 +102,12 @@ static int read_patches(const char *range, struct string_list *list)
> +               } else if (starts_with(line.buf, "@@ ")) {
> +                       char *skip_lineno = strstr(line.buf + 3, "@@");
> +                       strbuf_remove(&line, 0, skip_lineno - line.buf);

It makes me a bit uncomfortable that this is not checking for NULL
return from strstr() before doing pointer arithmetic (even though the
input is presumably machine-generated).

    if (!skip_lineno)
        BUG(...);

might be appropriate.

> +                       strbuf_addch(&buf, ' ');
> +                       strbuf_addbuf(&buf, &line);
