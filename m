Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5924DC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E238206CC
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK0Cmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:42:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34294 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfK0Cmx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 21:42:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so24864082wrr.1
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 18:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMKTTpE/Rc918oqflBVxGiw/BcGPipvQdqzWibzUwSA=;
        b=O1gqHeJoorUflxjGD7qm1PkFy0MXOp26dJWWe20sWhhuq0Xmutiq8JRN0Et7h61Jbu
         L/Z+W7mQfmyemtjf2iRY/+bT07nT5zh+z24gHZdcv3GKVT9Yc5aAkrLB00SeGEvmecBs
         bAmB5ReRtFJ8Ht39k5EONvJhvLteSpp32W8pqv9wK2N/jnBQaMeiQlJbsSgzmou1WwCU
         n/Z1FOhNhaRS/ocJLxxHsJNVK2YoheRrXEjz5Pq6U47/GVf4+fynBl1vaV6/YFYrTDmq
         XaQwaSC8YYK/s8ttW7Yhyc+EDudv5saDPNjIvZ7WsPjycrt6tdxwOGqrTCNkUVk3qUNa
         vqGQ==
X-Gm-Message-State: APjAAAWorPHo0O3MS7C6ujjthDBibX7W8D+RmGG+rK+kbVqNcbFHqd5C
        Rs6v8HsxLuC6xGJVZsmW4e6sGl+i4r4+YgZVDig=
X-Google-Smtp-Source: APXvYqwuaaIg7zZ0/Owu5jkuM6h4QPJFo4Io2CEZMS3Y6poxksrcrjqLjpcs+bcGgqHEtoF/7MEykpg+jyZSy71wQg4=
X-Received: by 2002:adf:c611:: with SMTP id n17mr41176273wrg.317.1574822570439;
 Tue, 26 Nov 2019 18:42:50 -0800 (PST)
MIME-Version: 1.0
References: <CAPTJ0XEcMJEwPBEL4akncJ_A5XwyQyKL95fpf2tC0rNXJK65Og@mail.gmail.com>
 <cover.1574820308.git.liu.denton@gmail.com> <15e6ccb2037d1e27b461d2344a13ebf1d5e10136.1574820308.git.liu.denton@gmail.com>
In-Reply-To: <15e6ccb2037d1e27b461d2344a13ebf1d5e10136.1574820308.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Nov 2019 21:42:39 -0500
Message-ID: <CAPig+cSH36aPwUDhtkiknpSsas-osCVnJ=cyNUzOgKXdvOCnmw@mail.gmail.com>
Subject: Re: [PATCH 5/5] rebase: fix `format.useAutoBase` breakage
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Biesinger <cbiesinger@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 26, 2019 at 9:09 PM Denton Liu <liu.denton@gmail.com> wrote:
> With `format.useAutoBase = true`, running rebase resulted in an
> error when an upstream was't set:

s/was't/wasn't/

>         fatal: failed to get upstream, if you want to record base commit automatically,
>         please use git branch --set-upstream-to to track a remote branch.
>         Or you could specify base commit by --base=<base-commit-id> manually
>         error:
>         git encountered an error while preparing the patches to replay
>         these revisions:
>
>             ede2467cdedc63784887b587a61c36b7850ebfac..d8f581194799ae29bf5fa72a98cbae98a1198b12
>
>         As a result, git cannot rebase them.
>
> Fix this by always passing `--no-base` to format-patch from rebase so
> that the effect of `format.useAutoBase` is negated.
>
> Reported-by: Christian Biesinger <cbiesinger@google.com>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
