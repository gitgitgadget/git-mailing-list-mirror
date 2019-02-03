Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E80FA1F453
	for <e@80x24.org>; Sun,  3 Feb 2019 09:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfBCJJH convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 3 Feb 2019 04:09:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33434 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfBCJJH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Feb 2019 04:09:07 -0500
Received: by mail-qk1-f194.google.com with SMTP id d15so6733735qkj.0
        for <git@vger.kernel.org>; Sun, 03 Feb 2019 01:09:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CLo33Jms40JMk0hlF+4ewm3eyO2L4pYtY9m8E/akwHk=;
        b=r6vWDJkvPtpWjNsrIl0V/ayrNqF8U0cXc1ym7PeU9YAYpzYSpLw7YCNjOcjpr+XGMb
         09oU/dwXQVDOt4IM2hhWSNukh5hMaBihbrdLiMiqV+h8QxRscFCuQDfjchsckIcl5aGI
         SWCoeHmcd0ejojeOyILXJFpEWGZ46teNCnzUqMNp1UUiH5iX6KIlw7VrV17yW+cD8eEV
         mKe5cAgUP7ateJe68OWToziJXmIv7wL4Y7ajU+rFJ0FnWYgmGnNkpWXvW5fT3bD7VZ/w
         cLazbOYxt+EJYka+RKGVDW5dvh2BPIMtl3TCugYA2y4inHWcHUcFwDhb4VcHmmPTTWs1
         xw2A==
X-Gm-Message-State: AJcUukdb/SmthiOiwvzdSyMgT58CUuz/Z3NhYmslknILwU7cbfTBwwnG
        U0+KOCNLAWxN/OGoqiZL15zGvAVZRl3g8/2IXm8=
X-Google-Smtp-Source: ALg8bN74KoYlXjmc1/t9d0U1a9ZWpiNBHr2NE4dWh7rofwnct2QQX+ReNyOFtdBgkfR2bc+W0vTX0fmISTNCqNdC+Dc=
X-Received: by 2002:a37:66c1:: with SMTP id a184mr42501138qkc.314.1549184946520;
 Sun, 03 Feb 2019 01:09:06 -0800 (PST)
MIME-Version: 1.0
References: <20190203083545.5877-1-martin.agren@gmail.com>
In-Reply-To: <20190203083545.5877-1-martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Feb 2019 04:08:56 -0500
Message-ID: <CAPig+cRN_Jw_vj5=RWZJWp-Wn6-=Vd9oZKQieMWJ02TjAHWwWg@mail.gmail.com>
Subject: Re: [PATCH] doc-diff: don't `cd_to_toplevel` before calling `usage`
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 3, 2019 at 3:37 AM Martin Ågren <martin.agren@gmail.com> wrote:
> `usage` tries to call $0, which might very well be "./doc-diff", so if
> we `cd_to_toplevel` before calling `usage`, we'll end with an error to
> the effect of "./doc-diff: not found" rather than a friendly `doc-diff
> -h` output. Granted, all of these `usage` calls are in error paths, so
> we're about to exit anyway, but the user experience of something like
> `(cd Documentation && ./doc-diff)` could be a bit better than
> "./doc-diff: not found".
>
> This regressed in ad51743007 ("doc-diff: add --clean mode to remove
> temporary working gunk", 2018-08-31) where we moved the call to
> `cd_to_toplevel` to much earlier. Move it back to where it was, and
> teach the "--clean" code to cd on its own. This way, we only cd once
> we've verified the arguments.

Thanks for spotting this; I wasn't aware of it when crafting ad51743007.

I wonder if a more fruitful, longer-term fix which would save us from
having to worry about this in the future, would be to make
git-sh-setup.sh remember the original $0 before cd_to_toplevel() and
then employ the original value when usage() re-execs with the -h
option. That would also avoid the slightly ugly repeated
cd_to_top_level() and 'tmp' assignment in this patch.

> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
