Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597BAC4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 01:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiLBBdT convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 1 Dec 2022 20:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiLBBdR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 20:33:17 -0500
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E6FCEF99
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 17:33:15 -0800 (PST)
Received: by mail-pg1-f178.google.com with SMTP id 6so3177048pgm.6
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 17:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UwP14m0EcX48zMwayQpOblLwTbuOGOIecpjcfFZJhM=;
        b=hrRscEM1OBhteMkAtKZJ7WOPl8kFehzguh+GtoJbHIvNm3MYJBheGRHluVNd/awMo7
         EV924phCApkaTyewpwvEUlgceE7yTRO7zyWRzZdH1sLtBAq/JTBuLTfifO22rFxXaDZ1
         4GtzLKkFZP5QMUU5ClLlzIutb67aXutGNnjXADPjsy2qbHhKzMFy/WM8WXPBf0moLhEk
         5ezuDoiPuXuKkfxt2k16GJvQJIfdeCLb0dgcu3NExzH+vF/iuYaJ7ev9lmRSBwuvbR9N
         hJsMtaGAS8+A2asuzTtfNe4lD9xh/9N6noWZ0rOVh3k/T5hkymGtACE13EEl3TCFA/Wn
         sfTA==
X-Gm-Message-State: ANoB5pm+WJvoRmWOR1KqEByqoB+T3OPTNfKwa7Iruxcr+xRdD4IDwnJV
        xqlZey40P9ewuZjZyPjiu8jHY2SQb/6J73G5nq8=
X-Google-Smtp-Source: AA0mqf6qPg3kwdkjPC+zeiw2K8KwkrSiPg77j8iDdgMJsLXJ4K2ZdtpfdL5EuG6+Qb0W2lh3VP3DUbN7QSC39+wMFnQ=
X-Received: by 2002:a05:6a00:18a9:b0:572:6da6:218e with SMTP id
 x41-20020a056a0018a900b005726da6218emr50665249pfh.1.1669944794610; Thu, 01
 Dec 2022 17:33:14 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com> <patch-v2-4.8-c36060934a6-20221202T000227Z-avarab@gmail.com>
In-Reply-To: <patch-v2-4.8-c36060934a6-20221202T000227Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 1 Dec 2022 20:33:03 -0500
Message-ID: <CAPig+cTfx4QYBdtSomPRM+BpW+3ELqaQxD7okKhXzykVkyH9NA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] test-lib-functions: add and use test_cmp_cmd
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 1, 2022 at 7:07 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Add a "test_cmp_cmd" helper for the common pattern discussed in the
> documentation being added here to "t/test-lib-functions.sh".

I'm somewhat "meh" on this, at least as it's sold here. Perhaps if it
was sold as producing better diagnostic report for:

    test "$something" = "$(git blah)"

which covers many of the "fixes" in this patch then I'd be less jaded...

> By using this in we'll catch cases where "git" or "test-tool"
> errors (such as segfaults or abort()) were previously hidden, and we'd
> either pass the test, or fail in some subsequent assertion.

...which, I suppose, may be what this paragraph is saying, but it's
not immediately obvious.

Minor subjective stuff aside...

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> +# test_cmp_cmd is a convenience helper for doing the more verbose:
> +#
> +#      echo something >expect &&
> +#      <some-command-and-args> >actual &&
> +#      test_cmp expect actual
> +#
> +# As:
> +#
> +#      test_cmp_cmd something <some-command-and-args>
> +test_cmp_cmd () {
> +       local expect="$1" &&
> +       shift &&
> +       printf "%s\n" "$expect" >expect &&
> +       "$@" >actual 2>err &&
> +       test_must_be_empty err
> +       test_cmp expect actual
> +}

I do find it concerning that this clobbers 'actual', 'expect', and
'err', which are common enough names. I'd suggest using names unique
to this function (perhaps 'test_cmp_cmd.actual',
'test_cmp_cmd.expect', etc.).

I think you also need to document the fact that it expects stderr
output to be empty.
