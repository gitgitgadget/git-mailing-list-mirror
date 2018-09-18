Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05A9B1F404
	for <e@80x24.org>; Tue, 18 Sep 2018 01:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeIRHA2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 03:00:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38613 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeIRHA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 03:00:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id g197-v6so159747qke.5
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 18:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFOHyezBxY9V2qe7oKvdZcQGjnfoMVaANzAZm6w9mLQ=;
        b=SIGkd8pl/vtiV23g7nPMDh6sxM70lgz7iPlsdtzkcRfsOd5lykQY/oLiTC7WIJcZp4
         ZtnMkdlGsdsErWxfm0pS8JAdKzkJIMbbnLpRydv6fxnbgKL3dX4HP2wMIDxYPD5IZmYx
         ZfXitkwuibS2IxuUybF81jme1ueCIJXHF0iWR4iXXH9ACTVbLiMdxEJV3B3F1fzw6Ky1
         57H6rzqmz914glPolQwyzC9WSxT57Y/Ox4oSBwdFGKEr/0zZcKZ5W9WtO1yVBWck8o6v
         Q7mtQPpUEscONLGv9S1va9F15cM8fxnDiTJKnGK4RYgrxa1L7NSa6jpv9SmuKPxKxIg+
         +w+g==
X-Gm-Message-State: APzg51DGrTxnaiAkleNiVVFYxzjQPZxX2uo49KbSe8a8BvHmeK1Cvmhk
        4ajJ1a0Wd8JwRsn/Ot/JB6KGc/0iF2ecZXSfbNk=
X-Google-Smtp-Source: ANB0VdbBuS4SQSOJPsZLJaLM8AZ12Ah37slcmyLFHUX9Ztz/SJwd9i4uyEKnfMXkCJ+pNkydySLVUBkSIXtvhbn+yrc=
X-Received: by 2002:a37:1298:: with SMTP id 24-v6mr18986403qks.174.1537234225692;
 Mon, 17 Sep 2018 18:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537223021.git.matvore@google.com>
 <12cc68aabf76e08f6214b21df786e61301c8f55e.1537223021.git.matvore@google.com>
In-Reply-To: <12cc68aabf76e08f6214b21df786e61301c8f55e.1537223021.git.matvore@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 17 Sep 2018 21:30:13 -0400
Message-ID: <CAPig+cQchHoWffobw3iGrsmRRPx2LKNu+EvR=t4c5RcV9Cmi9g@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] tests: split up pipes
To:     matvore@google.com
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 6:25 PM Matthew DeVore <matvore@google.com> wrote:
> tests: split up pipes

This title explains the mechanical changes the patch is making but not
the intent. Perhaps reword it to say something like:

    tests: avoid swallowing Git exit code upstream of a pipe

> Some pipes in tests lose the exit code of git processes, which can mask
> unexpected behavior. Split these pipes up so that git commands are at
> the end of pipes rather than the beginning or middle.

Can you say something about how you chose which tests to fix in this
patch? Is this fixing all such cases or only a subset? It looks like
it's only fixing "ls-files" and "verify-pack" invocations. If that's
the case, the commit message should explain that.

Also, missing sign-off.

> ---
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> @@ -51,8 +51,10 @@ pull_to_client () {
> -                       git symbolic-ref HEAD refs/heads/$(echo $heads |
> -                       sed -e "s/^\(.\).*$/\1/") &&
> +                       git symbolic-ref HEAD refs/heads/$(
> +                               echo $heads |
> +                               sed -e "s/^\(.\).*$/\1/"
> +                       ) &&

Why is this change included in the patch? There is no Git invocation
upstream of a pipe here. While the cleanup itself may be desirable, it
doesn't belong in this patch.
