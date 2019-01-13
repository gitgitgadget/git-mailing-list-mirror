Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10D9E211B4
	for <e@80x24.org>; Sun, 13 Jan 2019 21:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfAMV5y (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Jan 2019 16:57:54 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46284 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfAMV5y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jan 2019 16:57:54 -0500
Received: by mail-qt1-f193.google.com with SMTP id y20so24593930qtm.13
        for <git@vger.kernel.org>; Sun, 13 Jan 2019 13:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpIvqPRSpyJIM0HIH0RN5ZkJgZDBeXf0z1LClJLnhfo=;
        b=itGQoaLSsi5gFDs7idXIy5QhLlSFGwg+b/BAJjxDf1hUIPNCsC3yskGgNB6cYVUxrH
         VJoVXiYhNfGMsFFwppHUuswtMUIMZvhs3pfiSY7fRj+JJp/OrcTXFyHlRa/szk7w3OW7
         AnrD5fWNhSCp9rQp6+jeAbIjsz+rYkS5ivW/D+9m5euox6W9lHAKTUvg7LVxtxM1j0ou
         5ZNBVdrm6UWuvwW5bfjmqFXdm+uJqpxFKc6n1flDBAHi1KBQoD8TWSZLcCmcDBcFkl55
         sNxqIaoEVgLKOxvU3nEeuPh5W/LImM40xyL8staZ5Lc8PwJa3IPByKQAtk3laWdgOjSJ
         XlXQ==
X-Gm-Message-State: AJcUukduCaMt1kcymsDBru83Cmq3wGRw6xigxwjZs29afH/7D3dmz+7F
        pLlC6WXLAvKvdUNlIsYUHH/ad7a+3Mnnq9mAM20=
X-Google-Smtp-Source: ALg8bN4OX+oGYZaImmXWoHAVLShGJjZRVoTpxedO6gHYEmnrD3+ut2xfghiSS9NeV8IZ4vj7PcTlYCNeNVm/Ex2bApk=
X-Received: by 2002:ac8:101a:: with SMTP id z26mr21967077qti.184.1547416673048;
 Sun, 13 Jan 2019 13:57:53 -0800 (PST)
MIME-Version: 1.0
References: <20190113135815.11286-1-luke@diamand.org> <20190113135815.11286-2-luke@diamand.org>
In-Reply-To: <20190113135815.11286-2-luke@diamand.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 13 Jan 2019 16:57:42 -0500
Message-ID: <CAPig+cSPL4vcfWR7Pos91N_SO-qCSBMYFY8vbyHX-POKyyRJpg@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-p4: add failing test for shelved CL update
 involving move
To:     Luke Diamand <luke@diamand.org>
Cc:     Git List <git@vger.kernel.org>,
        vin ku <viniciusalexandre@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vitor Antunes <vitor.hda@gmail.com>, amazo@checkvideo.com,
        aoakley@roku.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 13, 2019 at 8:58 AM Luke Diamand <luke@diamand.org> wrote:
> Updating a shelved P4 changelist where one or more of the files have
> been moved does not work. Add a test for this.

Perhaps this message could give more detail about the actual problem
than the generic "does not work" which provides no useful information.

> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
> diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
> @@ -500,6 +500,12 @@ test_expect_success 'submit --shelve' '
> +last_shelve() {
> +       change=$(p4 -G changes -s shelved -m 1 //depot/... | \
> +               marshal_dump change)
> +       echo $change
> +}

A simpler definition for this function would be:

last_shelve () {
    p4 -G changes -s shelved -m 1 //depot/... | marshal_dump change
}

which will give the same result when you later capture its output with:

    change=$(last_shelve) &&

> @@ -533,12 +539,53 @@ test_expect_success 'submit --update-shelve' '
>         ) &&
>         (
>                 cd "$cli" &&
> -               change=$(p4 -G changes -s shelved -m 1 //depot/... | \
> -                        marshal_dump change) &&
> +               change=$(last_shelve) &&
>                 p4 unshelve -c $change -s $change &&
>                 grep -q updated-line shelf.t &&
>                 p4 describe -S $change | grep added-file.t &&
> -               test_path_is_missing shelved-change-1.t
> +               test_path_is_missing shelved-change-1.t &&
> +               p4 revert ...
> +       )
> +'
