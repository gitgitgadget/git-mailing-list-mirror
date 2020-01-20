Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6A1C2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 16:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B843B2073D
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 16:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgATQt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:49:28 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:56162 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgATQt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 11:49:28 -0500
Received: by mail-wm1-f41.google.com with SMTP id q9so4000wmj.5
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 08:49:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLTzFjsCemh+Rn7o0gX95yr1W779LCDiaggCwqq5uAU=;
        b=RrV8v4Hw9b7uxTXLlz+Z5vzKrzjqjv16DfqGQCEXHK+U5YU7PSrANc6pHorL/A6cJZ
         OrfPLg4UVWZyuHTt4YQLXwJyPBP9W27ftcbdLX9nlJ/b5duaNka/8tmCY497F8JkUJbO
         2ztHFPHi4c3U1EVO/e87oIKDMaLenLfXkNzCOxXjk9b7PNO9kbE1rqyMedUVo8B5GNBU
         PbqF9WasYfSOVbN3wJYLmxerAwRN8fi7CBoByib6+jGwactliEybZAdMSthCpF0s/k/5
         oIxAffUZyaJ7YfwAnNCqu0BLO0EEXWk95fxY3wJKJgfcyV4CyWI/kOKoanFQ6mRXpnSi
         M1Pg==
X-Gm-Message-State: APjAAAU4j9LxArMrRIdpv7Wk9XYaV/0JXH9dIBQiZ6Yn51Tc8+dRUNKe
        9rwLuzqP7EdF7YRsqs4KtbGbp3ZgZIKeiCj6Im8=
X-Google-Smtp-Source: APXvYqyVzF1QnYHARx3ZCFqUQOqQv1jsS0MWucoUozlYSvnKkVhoCMYoL0LrV+PvQqQJYRBBSLkSReN2cgE2FIbsSa4=
X-Received: by 2002:a05:600c:21c6:: with SMTP id x6mr211630wmj.177.1579538966704;
 Mon, 20 Jan 2020 08:49:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
 <pull.529.v2.git.1579304283.gitgitgadget@gmail.com> <102fa568dc09c1faa2d36903ccb7e1b285dd50b2.1579304283.git.gitgitgadget@gmail.com>
In-Reply-To: <102fa568dc09c1faa2d36903ccb7e1b285dd50b2.1579304283.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Jan 2020 11:49:15 -0500
Message-ID: <CAPig+cT8t39UvnF2i6CDoHW4kfEGr-CRFxZKOCstCTU0YzrCgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rebase -i: re-fix short SHA-1 collision
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 17, 2020 at 6:38 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> @@ -1264,13 +1264,24 @@ test_expect_success SHA1 'short SHA-1 setup' '
>  test_expect_success SHA1 'short SHA-1 collide' '
>         test_when_finished "reset_rebase && git checkout master" &&
>         git checkout collide &&
> +       colliding_sha1=6bcda37 &&
> +       test $colliding_sha1 = "$(git rev-parse HEAD | cut -c 1-7)" &&

How much do we care that this is introducing new code with git
upstream of a pipe (considering recent efforts to eradicate such
usage)? Same question regarding several other new instances introduce
by this patch.
