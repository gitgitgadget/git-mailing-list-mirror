Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D85C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 17:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3D361401
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 17:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241066AbhDURdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:33:18 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:46913 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbhDURdR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 13:33:17 -0400
Received: by mail-ed1-f42.google.com with SMTP id h10so50278754edt.13
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 10:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OveSXtKLB03jBGld7jeHHjwq2poYikd24+LBNfez5A=;
        b=P1UrMIMOtWMXXgAgV6MZEtC1RwLggyH06ZbLnVNC5e0o4vl6svlH4QfJK6effWfw+H
         R+RqprarQMCUC+HA+36l66GBJghIfheE6Q3yJsqyhzUJ5UP34/xw3UREV1AZRlByhsOo
         WhXCjV8huGTejqsiFmzauJCBI3kYh9hWL1UNoJifxN6mfpMPFFhiGoGtPZ0xyWo353FI
         wk9x0tbJDzeUwTOf+5tgZEdOh57slpbl3Ze6U2G0Z1vykayPqMb8RlWvkK64G6+tfrHJ
         QXTExx7IBdcyO+jB/p+TfvyIt0sa418/sCbpLbhG4RJpkBizYKMA7UtvPmgQNtVBKPmb
         Jr8w==
X-Gm-Message-State: AOAM533av8ec35JWTVARKc53bn2Wv7XlP5rAno+8Q6bziW0Waeekc0Wr
        JbyJu/vF9WtY79KXBe0ZYoBqhcTTKU0A+dLZH7/HNpsSSIQ=
X-Google-Smtp-Source: ABdhPJxG/meqjsfA20qzv+NXdv9n2OJc6sOr8ZYvn2TlIxozovWtUBi62RjNDdA1hgRq6LhrAJ7VzDJ274D4IWX9OmU=
X-Received: by 2002:a05:6402:1cb9:: with SMTP id cz25mr27899539edb.163.1619026363657;
 Wed, 21 Apr 2021 10:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <YIAAzJTG1UitiWyu@danh.dev> <20210421104102.3409-1-congdanhqx@gmail.com>
 <20210421104102.3409-2-congdanhqx@gmail.com> <CAPig+cSh6VNpWbGPpTqY0rmw7zf9s-kSXSOMYvW94UHOF7t80w@mail.gmail.com>
In-Reply-To: <CAPig+cSh6VNpWbGPpTqY0rmw7zf9s-kSXSOMYvW94UHOF7t80w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 21 Apr 2021 13:32:32 -0400
Message-ID: <CAPig+cS4tkXZLPDEWgEytzEOCR7oGrXyg1CZVKVPSXuJOifLjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] t6402: check exit status of ls-files
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 12:55 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>     count_ls_files 5 -s &&
>     count_ls_files 3 -u &&
>     count_ls_files 1 -u one~HEAD &&
>     ...
>
> The nice thing about having a helper function is that it can clean up
> after itself by not leaving a new file lying around, thus you wouldn't
> have to make adjustments to the expected number of untracked files (as
> mentioned in the commit message). If this is the sort of thing which
> comes up often enough (if there are more such cases beyond the two
> scripts you changed in this series), then it might make sense to
> promote the helper function to test-lib-functions.sh.

The frequency with which this idiom crops up with commands beyond
git-ls-files suggests the more general solution of supporting it
directly in test-lib-functions.sh for any command. For instance:

    test_cmd_line_count = 3 git ls-files -u &&

Or, perhaps, a new mode of test_line_count():

    test_line_count = 3 -c git ls-files -u &&
