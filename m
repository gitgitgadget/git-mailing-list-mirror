Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C84EC433E1
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 16:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E321F2080D
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 16:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbgGAQBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:01:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45746 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731519AbgGAQA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 12:00:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id s10so24533750wrw.12
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 09:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNrlFrRZXpIK1gcgDrE4bZpdVw+bW2qrSQQXLzoCics=;
        b=OvroBuLcjyEPvOLVGNrgH+5drhc8yVrS/1ws7JW1TZf2htk4J/EwWb442VMS0fwuye
         LoAmecP1Gmgt4oDMCtZdMAYjwBQAjwlKUZwwqNGIit4i0+oDU/NRKoyGmwANlhw57sET
         TvSVXY10vhdNcQ6GXgXPjhVYokM+GT+u/wnC7f5wCJ+HJ5MoNrXxgEqzr4uiS5z8zil2
         eh/ZRovWvKxMf7fwjMAJTb0Yh7DSxh5h5oMFNMTznhZlASJ9OljCUrveiuu41w7jEfGG
         DsCmVjcrP9frmdd6vtUfrtsOXzt/PEXP19ke+hbrrNFkOfcpcQVS2yd2FF3kSolMZUHj
         rJFA==
X-Gm-Message-State: AOAM531XY0EDpkf6PbVd91G0/xlK1rePQegego39DPv0aMLJ+USZARnc
        z+Ro0YMr6r/FRqnLipPVHBLNFw45t0/hWijaGzLRUl0w
X-Google-Smtp-Source: ABdhPJyIpFSBYXVnajZ2OJYdj4dis0Dz/7bv2qCwtcCN/J7niBNtVOGQly+j6Z0VRVQRjI87AoJ7hBHAXTTYC0QxtkY=
X-Received: by 2002:a5d:44c7:: with SMTP id z7mr29322503wrr.226.1593619256971;
 Wed, 01 Jul 2020 09:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200701093653.3706-1-ben@wijen.net> <20200701093653.3706-2-ben@wijen.net>
In-Reply-To: <20200701093653.3706-2-ben@wijen.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Jul 2020 12:00:45 -0400
Message-ID: <CAPig+cT+cXuM3Asu6+Z25pGV2uRm6K1iAeYVhic9kqk1mS84-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] git clone: check for non-empty directory
To:     Ben Wijen <ben@wijen.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 1, 2020 at 5:46 AM Ben Wijen <ben@wijen.net> wrote:
> When using git clone with --separate-git-dir realgitdir and
> realgitdir already exists, it's content is destroyed.
>
> Extend test to make sure content is left intact
>
> Signed-off-by: Ben Wijen <ben@wijen.net>
> ---
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> @@ -271,7 +271,8 @@ test_expect_success 'fetch from gitfile parent' '
>  test_expect_success 'clone separate gitdir where target already exists' '
>         rm -rf dst &&
> -       test_must_fail git clone --separate-git-dir realgitdir src dst
> +       test_must_fail git clone --separate-git-dir realgitdir src dst &&
> +       test -f realgitdir/config
>  '

This addresses the immediate problem of the directory content being
destroyed, which is good. But, we can future-proof it even more by
also verifying (to some degree) that the existing content has not been
disturbed. Doing so would give us greater confidence against some
future change breaking "realgitdir" in some fashion other than merely
emptying it. For instance, we might do this:

    rm -rf dst &&
    echo foo=bar >realgitdir/config &&
    test_must_fail git clone --separate-git-dir realgitdir src dst &&
    grep foo=bar realgitdir/config

One other observation: To preserve bisectability (git-bisect) of
git.git itself, we want to ensure that the entire test suite still
passes at each point in a patch series. Making this change to the test
in its own patch introduces a failure into the test suite, which is
undesirable. One way to address this shortcoming would be to
temporarily change this test from 'test_must_succeed' to
'test_must_fail', and then flip it back to 'test_must_succeed' in
patch 2/2. A cleaner approach is simply to combine the two patches so
that the fix and updated test are bundled together (which makes sense
anyhow in this case since this patch is so short and need not stand on
its own).
