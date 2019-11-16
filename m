Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61E271F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 09:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfKPJ1V (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 04:27:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33928 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfKPJ1V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 04:27:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id j18so11832432wmk.1
        for <git@vger.kernel.org>; Sat, 16 Nov 2019 01:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWfXNAUSAdObgP3QXbBu5UimZkWUkxqDnvag2TC65og=;
        b=p7G7WJPqfzuIVh7VySOEhsFZ1Bha1Qc8OZp6NG/Pw6G/OENGMo1VXGxoODXw43vAo0
         M6ElD2pczzC0vp9bXzEu4HBYfwPkU6Yt7/brg3NZdlV0p1E7d+k3uHfTem7rtCR2U/0s
         Rn/FQboAkH0oP/dYwMPuHsYhWtVVRGVeydi4Adr6Gm5dDBogFH6zn/7ttN7LYoC360/k
         EevMFsIX3DjJejdXAuQ12qhfWaDAVAvEWNMCmMaUTHZBhZPJvxKDiRT/gdUHNsq6PHqq
         HTBg3TcWEkTd4sumjJZip2rZIjoYW2CcsIinx2ALS3pW2tUY3J5Hk4pvBziKHvOZOBY9
         ksbQ==
X-Gm-Message-State: APjAAAVY9RxrG33v3tRyVCPAhoRf7gUJ8v5T+vE0uli00IgktacdE5uV
        Cr2n591IjPXoVXAAb1UfXudBksQ243vIePrBctA=
X-Google-Smtp-Source: APXvYqzjI1uoKMSqpiSmtyamgVCRBX7sNSMGptCJGV3EI+rIkWDmzlZ+AokDslJqgUK+k9C58URWpVzmce/XPnmiHpw=
X-Received: by 2002:a1c:3843:: with SMTP id f64mr18255841wma.129.1573896439452;
 Sat, 16 Nov 2019 01:27:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573779465.git.liu.denton@gmail.com> <52836aa59a84bf61781cd3501679011a36ac41e7.1573779465.git.liu.denton@gmail.com>
In-Reply-To: <52836aa59a84bf61781cd3501679011a36ac41e7.1573779465.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 16 Nov 2019 04:27:08 -0500
Message-ID: <CAPig+cT_co53B66P8hKzFai=0HbXHLfNO5-Dbx_qZZa7Vj-4WA@mail.gmail.com>
Subject: Re: [PATCH 12/27] t5317: use ! grep to check for no matching lines
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 14, 2019 at 8:01 PM Denton Liu <liu.denton@gmail.com> wrote:
> Several times in t5317, we would use `wc -l` to ensure that a grep
> result is empty. However, grep already has a way to do that... Its
> return code! Use ! grep in the cases where we are ensuring that there
> are no matching lines.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
> @@ -45,12 +45,7 @@ test_expect_success 'verify blob:none packfile has no blobs' '
>         git -C r1 verify-pack -v ../filter.pack >verify_result &&
> -       grep blob verify_result |
> -       awk -f print_1.awk |
> -       sort >observed &&
> -
> -       nr=$(wc -l <observed) &&
> -       test 0 -eq $nr
> +       ! grep blob verify_result

It's curious that this and other tests were doing so much unnecessary
extra work ('awk' and 'sort'). While it's clear that it's safe to drop
the 'awk' and 'sed' invocations, nevertheless, as a reviewer, I had to
spend extra time digging into it in order to understand why it was
like this in the first place, since I wanted to convince myself that
some earlier change hadn't broken the test in some unnoticed way.

It turns out that these tests were simply born this way[1], doing all
this unnecessary work for no reason, probably due to copy/paste
programming, and it seems no reviewer caught it. Likewise, the
unnecessary work wasn't noticed even when the code was later touched
for various cleanups[2,3].

To save future reviewers (and future readers of the commit history)
the effort of having to convince themselves of the safety of this
change, it might be a good idea to say something in the commit message
about the code's history.

[1]: 9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)
[2]: bdbc17e86a (tests: standardize pipe placement, 2018-10-05)
[3]: 61de0ff695 (tests: don't swallow Git errors upstream of pipes, 2018-10-05)
