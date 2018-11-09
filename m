Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1E8F1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 06:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeKIQZi convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 9 Nov 2018 11:25:38 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43236 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeKIQZh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 11:25:37 -0500
Received: by mail-yw1-f66.google.com with SMTP id j75-v6so1206464ywj.10
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 22:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p5JuLpgCa0qXykVy4agvYm3x8X1ZNJWSKvieWxSLTck=;
        b=KrcB/8KZzTFAxI+Op+StektgwVUBvzYMZ+yR0gL3+VRTMQVN6N4rvOw1C+oWfmc17L
         LCShA5qNYbGMlZ1sHbLNQ+NE6h0+NnHe+m6LArt85DcQmonbZ13dGg2F+EZa5lLrCi/9
         nKw77D0ACP/3CPv8KnjPWvl3z2rSBmNomXhc+UWMWGznfpLhEnUhSvgl+bI9pUNK9pjE
         lBmiTQv5dS4as6dRLZKJL5Pqbgg1pQGO00dGdqgvFUPXmySCC/rhH4oiB83wcWL5yxeu
         BvmEwexChggy/fXVaRlnbSzby/Eo0Cv5XM4avNlu6BGQFZd4qKtdUCGhX7YBw3GtNhuz
         3o4w==
X-Gm-Message-State: AGRZ1gJiN7rH+Tc443WEk8g5CmSwqN3p/hsqzUmhTSDYeUWJRDejfF5V
        dOXKosbF3wgZPONboUVI/mfXZ//PQZPkN7YmPxc=
X-Google-Smtp-Source: AJdET5cPg3kqg1fHdbpAxXqpRev3g+k4PwsTMUDRST74INOjoK5xMQP8rrRgQRdfIiabkaclXQ3jr9YKX5ZvuXrj5Bw=
X-Received: by 2002:a37:d91:: with SMTP id 139mr4396772qkn.26.1541745988831;
 Thu, 08 Nov 2018 22:46:28 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet>
 <20181107122202.1813-3-avarab@gmail.com> <CAPig+cTeNcn_raJWfEK_C_du1v1KYQFTVmWA9B4DNHAXoFHw-w@mail.gmail.com>
 <87k1ln5hcx.fsf@evledraar.gmail.com>
In-Reply-To: <87k1ln5hcx.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 9 Nov 2018 01:46:17 -0500
Message-ID: <CAPig+cSJ=T_iwPOaxT9T0XK2UYZfvkE_Vx5D__ZLct+z1-p5cg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] range-diff: fix regression in passing along diff options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 8, 2018 at 5:34 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Thu, Nov 08 2018, Eric Sunshine wrote:
> > Looking at diff.c:parse_diff_opt() and enable_patch_output(), rather
> > than introducing this new conditional, I'm thinking that a more
> > correct fix would be:
> >
> >     opts.output_format |= DIFF_FORMAT_PATCH;
> >
> > (note the '|=' operator). This would result in 'opts.output_format'
> > containing (DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT), just as it did
> > prior to 73a834e9e2 when --no-patch was specified.
>
> Maybe I'm misunderstanding, but if you mean this on top:
>
>     -               if (!opts.output_format)
>     -                       opts.output_format = DIFF_FORMAT_PATCH;
>     +               opts.output_format |= DIFF_FORMAT_PATCH;

That is indeed what I mean.

> Then the --stat test I've added here fails, because unlike "diff" the
> "--stat" (and others) will implicitly "--patch" and you need
> "--no-patch" as well (again, unlike with "diff").

This new --stat test also fails with Dscho's original git-range-diff
implementation, even before 73a834e9e2 regressed the --no-patch case.
The commit message seems to sell this patch as a pure regression-fix,
so it feels wrong for it to be conflating a regression fix
(--no-patch) with preparation for potential future improvements to
other options (--stat, etc.).

I could see this as a two-patch series in which patch 1/2 fixes the
regression (with, say, "|="), and patch 2/2 generalizes setting
'opts.output_format' for the future. Alternately, if left as a single
patch, perhaps the commit message could be fleshed out to better
explain that it is doing more than merely fixing a regression (since
it wasn't at all obvious to me, even after digging into the code
earlier to come up with "|=", or now when trying to understand your
response).

> Right now --stat is pretty useless, but it could be made to make sense,
> and at that point (and earlier) I think it would be confusing if
> "range-diff" had different semantics with no options v.s. one option
> like "--stat" v.s. "--stat -p" compared to "diff".

Perhaps this sort of rationale, along with some explanatory examples
could be added to the commit message to help the reader more fully
understand the situation.

Thanks for working on this.
