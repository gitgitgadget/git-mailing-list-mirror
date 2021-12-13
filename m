Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CC5C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbhLMQCt convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 13 Dec 2021 11:02:49 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:38810 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240313AbhLMQCr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:02:47 -0500
Received: by mail-pg1-f173.google.com with SMTP id y9so1788506pgj.5
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:02:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dJhgVPN4sPqW6yW7TRhLUdZx1v4OL1/KpWXVJmP+b+Y=;
        b=Uw3vjQhawqP3wcAG25iYtJBhCEkedlxKR7TqBHDgFZ1jTJkrduyMHp28VjZBIkbkmw
         8i2owial5loImZhTlKheeyPWGK8Q3pHZsJ4PKar8NsLCw8XQZOeQoI4QWsYjx1p6q9Jv
         hRchY+FyGR4DRqO6Cyyifa1HSmjrQo4BEtU0p1ABMpAMvioHXrOdcqRogkpHvFBUVsMP
         qLDPtmHcn6hEKxtGN5Tk545XEbfbM+VAFahK+SdKftSsyMuQe92G/o5tE1ba8yudpLG/
         1A/mCeTqVRKykXfaZpUmufdn37h5Ok/HAIegAvA56Jh9ziPlNo1AHo7jNkc0ONKt/f2E
         IQJg==
X-Gm-Message-State: AOAM532V1Vdw3cmmVZ0TY4tzxKitdcgR3AgB6IlD21l1aunXjDUOG6Xf
        m+3b6g3csCkVnFRc+PUxgEjawPco+NCF/MulF/E=
X-Google-Smtp-Source: ABdhPJx/GGWHtpTvyqfZafD9t/HffUj5VKm0X4PF3zreXYAHgF6w/pwYb7wFu8l7YGA9MRJ9RUx6IZpjTPCC/4Vcf0I=
X-Received: by 2002:a05:6a00:140d:b0:4a9:5e10:60c2 with SMTP id
 l13-20020a056a00140d00b004a95e1060c2mr34053362pfu.4.1639411367252; Mon, 13
 Dec 2021 08:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20211213063059.19424-1-sunshine@sunshineco.com>
 <20211213063059.19424-6-sunshine@sunshineco.com> <20211213102224.y5psbojmivlxe5px@fs>
 <CAPig+cSKn6wdPKc=b8Xjqy5D=bVdu6FQtYKJuwN2VoV7pEEgHw@mail.gmail.com> <20211213154327.pmhopjbdlkz7dgjh@fs>
In-Reply-To: <20211213154327.pmhopjbdlkz7dgjh@fs>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Dec 2021 11:02:36 -0500
Message-ID: <CAPig+cSXHBMgOUycL0cXuVCb_PJ2=x2w4wUkc7eQQueyk=0Uzw@mail.gmail.com>
Subject: Re: [PATCH 05/15] t/Makefile: optimize chainlint self-test
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 10:43 AM Fabian Stelzer <fs@gigacodes.de> wrote:
> Personally i find the initial for loop variant to be the most readable.
> Ævars makefile targets could be very nice too, but especially:
>
> +$(BUILT_CHAINLINTTESTS): | .build/chainlint
> +$(BUILT_CHAINLINTTESTS): .build/%.actual: %
> +       $(CHAINLINT) <$< | \
> +        sed -e '/^# LINT: /d' >$@ && \
> +       diff -u $(basename $<).expect $@
>
> i find very hard to grasp :/
> I have no idea what is going on here: `<$< |` ?

Ya, that line-noise is an unfortunate combination of shell and
Makefile gobbledygook. The `$<` is effectively the source file (the
file being passed into chainlint.sed), and the rest of it is just
normal shell. `<` is redirection (using the source file `$<` as
stdin), and `|` is the pipe operator (sending the output of
chainlint.sed to another `sed`), and capturing it all via shell `>`
redirection in `$@` which is the Makefile variable for the target
file.

Anyhow, although the commit message tries to sell this change as some
sort of optimization, it's really in preparation for the new chainlint
which wants to check all tests in all files with a single invocation
rather than being invoked over and over and over. The self-test files
also require more preprocessing to work with the new chainlint, so the
implementation of `check-chainlint` gets rather more complex once the
end state is reached. I'll think about it a bit, but at the moment,
I'm still leaning toward this intermediate step as being beneficial to
reaching the end state. However, my opinion could change since the way
this is done here was probably influenced by an earlier iteration of
the new chainlint, but now that the implementation of the new
chainlint is concrete, it may not be especially important to do it
this way.
