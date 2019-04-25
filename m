Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4E4F1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 19:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDYThK (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 15:37:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42462 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYThK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 15:37:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so953268wrx.9
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 12:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVem67hInoiK6caTIehoXvU51QHJ3OZPHTqYN0nAaW4=;
        b=gAKkcwW4Cv36krcySklTxoRflU/HJyosUBOr161iWuHFDLm/pQ2pfI+Jgz/3FPa1cF
         sKtm31CMSzm+5f9n8d75ufevxd5lA+gRCNCeOm0eNI1qXSpipkeHFnBIe/iuD8v77tcH
         C5JEB19atQW1b2LUqoXKSBCYJkPwxxoVynbNLrr4B8RNJxckGKbdRSnteJDQTgVwZqG1
         tsm8kBVJXfz2E5l93swUeIauuUAd84JPzHXI8s3RjLfTViXVJcfixhVpGyO3KCbp6F/K
         a36PKcYZ/GS67Yfioj2EB1ck3lKBJs5WUwsPoAvpWxBwn1B7WfU+7ztZeS3O/TfByKo+
         gQLw==
X-Gm-Message-State: APjAAAUXuNrRFsjR2qpPxTD9xxXtXfwzaMTC0IUEnCwEeiGhtGnTnHfe
        6CZVpLFgWU9CaxPF9ZUkoMiMRIsxlpNFxMFyyO0=
X-Google-Smtp-Source: APXvYqzscUmd5ISjXtzn7FrTZWiEwDToSyxxf6HUVM5X6xd5jVFynmG2zpLlYTSzYSjigsieLC905J0wcqUW/VqZCYw=
X-Received: by 2002:adf:f68c:: with SMTP id v12mr10870213wrp.40.1556221028626;
 Thu, 25 Apr 2019 12:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190425155118.7918-1-newren@gmail.com> <20190425155118.7918-3-newren@gmail.com>
In-Reply-To: <20190425155118.7918-3-newren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 25 Apr 2019 15:36:57 -0400
Message-ID: <CAPig+cRaOAX+Yap+SiPjEoPRcH9z5qTHV6KPGGwN2LfPfxyA8Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] fast-import: support 'encoding' commit header
To:     Elijah Newren <newren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 11:51 AM Elijah Newren <newren@gmail.com> wrote:
> Since git supports commit messages with an encoding other than utf-8,
> allow fast-import to import such commits.  This may be useful for folks
> who do not want to reencode commit messages from an external system, and
> may also be useful to achieve reversible history rewrites (e.g. sha1sum
> <-> sha256sum transitions or subtree work) with git repositories that
> have used specialized encodings in their commit history.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/fast-import.c b/fast-import.c
> @@ -2607,6 +2608,9 @@ static void parse_new_commit(const char *arg)
>         if (!committer)
>                 die("Expected committer but didn't get one");
> +       if (skip_prefix(command_buf.buf, "encoding ", &encoding)) {
> +               read_next_command();
> +       }

Style nit: unnecessary braces

> @@ -2670,9 +2674,13 @@ static void parse_new_commit(const char *arg)
>         strbuf_addf(&new_data,
>                 "author %s\n"
> -               "committer %s\n"
> -               "\n",
> +               "committer %s\n",
>                 author ? author : committer, committer);
> +       if (encoding)
> +               strbuf_addf(&new_data,
> +                       "encoding %s\n",
> +                       encoding);
> +       strbuf_addf(&new_data, "\n");

Alternately:

    strbuf_addch(&new_data, '\n');

> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> @@ -3299,4 +3299,24 @@ test_expect_success !MINGW 'W: get-mark & empty orphan commit with erroneous thi
> +test_expect_success 'X: handling encoding' '
> +       test_tick &&
> +       [...]
> +       git cat-file -p encoding | grep $(printf "\360") &&
> +       git log -1 --format=%B encoding | grep $(printf "\317\200")

This script is already full of instances of Git commands upstream of
pipes, so this usage is consistent (despite recent work to eliminate
such situations). Okay.
