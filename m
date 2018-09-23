Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B51D1F453
	for <e@80x24.org>; Sun, 23 Sep 2018 08:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeIWOiZ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 23 Sep 2018 10:38:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39323 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeIWOiY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 10:38:24 -0400
Received: by mail-qt1-f193.google.com with SMTP id c25-v6so185571qtp.6
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 01:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=abofi4uudZBGznjYX6chUh9Wkb/hKSpl6NL694X6rL4=;
        b=CZT2kWdGjJvW7nb7U1FP49wiCMjpNMFmbTIkgh6GZBs5dBWWw4EgIM9K0992Y+tSSt
         YBv8Z/bbJ0LkRnt43jB+KPIgkuX5uzuJ+QnsFEgVd7OkuWEMxkVJa8NaUu+GDPpqnlm0
         QG473SuhioQUHOjkjilKfS0D7+9ive+Q6uphl+NeiQLbxAkjAepZoQt4RlJAxSvWRB6r
         w3ObOPV/BdYnytqxWTd55k3bF7GJmNSFqZRzR2sWq2XudF330kDJ/Tu+UCJwfrE7qKzo
         WOcd8HqmcVqLuIZKvZsySxO/bElJnVkvZAqUsmQJ29hDeb2LfwxiFOErygF2pjMTELYS
         arTA==
X-Gm-Message-State: ABuFfojh/LmH0l/fZmmeRSlySruNHl51bPgy2IpZNulS87YJn0KKiGeG
        Xjm6mC3KeYfy41yanwrQ0YmCnRbumPwSBhGoS9lxjhAV
X-Google-Smtp-Source: ACcGV612SKcFhi6rOc1QhBPgJLu8ZXaJbUOMNAgTh8bbw4grfxGfgc9GWvz3AEvvXgzwBFpEHr9qbeI1pgr42uKZB2M=
X-Received: by 2002:a0c:b616:: with SMTP id f22-v6mr3353733qve.184.1537692102889;
 Sun, 23 Sep 2018 01:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180922180500.4689-8-pclouds@gmail.com>
In-Reply-To: <20180922180500.4689-8-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 23 Sep 2018 04:41:32 -0400
Message-ID: <CAPig+cTcaS-J5CwNo5RqeZiJYQ9OTt+Qzo08tdDjvZNaVSK2OQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] fsck: check HEAD and reflog from other worktrees
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 22, 2018 at 2:05 PM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> fsck is a repo-wide operation and should check all references no
> matter which worktree they are associated to.
>
> Reported-by: Jeff King <peff@peff.net>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> @@ -101,6 +101,45 @@ test_expect_success 'HEAD link pointing at a funny place' '
> +test_expect_success 'HEAD link pointing at a funny object (from different wt)' '
> +       test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
> +       test_when_finished "rm -rf .git/worktrees wt" &&
> +       git worktree add wt &&
> +       mv .git/HEAD .git/SAVED_HEAD &&
> +       echo 0000000000000000000000000000000000000000 >.git/HEAD &&

Perhaps use $ZERO_OID here instead of hardcoded "0..." string to play
friendly with brian's bc/hash-independent-tests (in 'next'). Same for
following test.

> +       # avoid corrupt/broken HEAD from interfering with repo discovery
> +       test_must_fail git -C wt fsck 2>out &&
> +       cat out &&

Unneeded 'cat'. Debugging cruft? Same for other tests.

> +       grep "main/HEAD: detached HEAD points" out

This message doesn't get localized, so no need for test_i18ngrep(). Okay.

> +'
