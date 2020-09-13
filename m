Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B59C433E2
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 20:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0A721548
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 20:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgIMU62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 16:58:28 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:43653 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgIMU61 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 16:58:27 -0400
Received: by mail-ej1-f68.google.com with SMTP id o8so20363312ejb.10
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 13:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cQafzd64Xa/S0GK0gLIEkiwV868g6/MVQ5P7DZiByek=;
        b=MH8IK1hMAQpNNOMDxwSDpJkuYhl21ojvz/E2oFFDP/QCj2zeUpgQm6RplwLT9jZ9Te
         nSI/KICZrWD9eYSrrG3oDNM5r7QxuItxBVLV2ULH4R20HFEElZJAGCj49tJIpJWqVdaX
         UVwGFDZUY7kAmpSHfIlocMI7DoCCZ97kza98nB/U1li03zdR0yv58efPxTnMNks70VCT
         SKbuGzfLOrf5+ZyuYoPEop68oAqFLDapxHEoAHSFJ6nZz7EBqBh0eovHSkHKpE9G82E1
         VtuDBePeyaOOATi0cY4uE/SblBc81ZE3M49ttvuBULsbAoUjAhXqRTZQISl3TfF6T8RW
         ZW9g==
X-Gm-Message-State: AOAM531ABvxnfEDwSlc2DZ42HIeIuEuEhXL2edvatTMnjT9rsydob9m8
        IvAidM92/daOqnpUik6gl3Z+uKRjZoOG0fjVyi0Fzj2iOoc=
X-Google-Smtp-Source: ABdhPJyWwgjwidt9R7F3PnH0G0qKhbtl+SrF1iNwKMtt+sC/gPUwV14wrwO6gAO5Av4CztZFM+5XrVdTVnMN7iteZqY=
X-Received: by 2002:a17:906:c0d1:: with SMTP id bn17mr11179829ejb.311.1600030705145;
 Sun, 13 Sep 2020 13:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200911185754.64173-3-alipman88@gmail.com> <20200913193140.66906-1-alipman88@gmail.com>
 <20200913193140.66906-2-alipman88@gmail.com>
In-Reply-To: <20200913193140.66906-2-alipman88@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 13 Sep 2020 16:58:14 -0400
Message-ID: <CAPig+cRrgC5vz9S1qDpEjoEvniBLCbuWt=bkpa2fj=suUm3Bog@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] t3201: test multiple branch filter combinations
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 13, 2020 at 3:32 PM Aaron Lipman <alipman88@gmail.com> wrote:
> Add tests covering the behavior of passing multiple contains/no-contains
> filters to git branch, e.g.:
> ---
> diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
> @@ -200,15 +200,51 @@ test_expect_success 'branch --merged with --verbose' '
> +# The next series of tests covers multiple filter combinations
> +test_expect_success 'set up repo for multiple filter combination tests' '
> +       git checkout master &&
> +       git branch | grep -v master | xargs git branch -D &&
> +       git checkout -b feature_a master &&
> +       >feature_a &&
> +       git add feature_a &&
> +       git commit -m "add feature a" &&
> +       git checkout -b feature_b master &&
> +       >feature_b &&
> +       git add feature_b &&
> +       git commit -m "add feature b"
> +'

A few comments:

I didn't examine it too closely, so this may be a silly question, but
is there a reason to start from scratch (by deleting all the branches)
rather than simply using or extending the existing branches like the
other tests do?

If it really does make sense to start from scratch (ignoring the
existing branches), then an alternative would be to create a new
repository and run the tests in that repository instead. Whether or
not doing so makes sense in this case is a judgment call. For
instance:

    test_create_repo features
    (
        cd features
        ...setup stuff...
    )

It's a bit concerning to see output from porcelain git-branch being
fed to 'grep' and 'xargs'. More typically, you would instead rely upon
the (stable) output of a plumbing command. For instance:

    git for-each-ref --format="%(refname:short)" refs/heads/ | ...

In new test code, normally avoid having a Git command upstream of a
pipe since its exit code will be lost. Thus, you might instead write:

    git for-each-ref ... >heads &&
    grep -v master heads | xargs git branch -D &&
