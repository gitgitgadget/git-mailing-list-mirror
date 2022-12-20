Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDED3C4167B
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 00:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiLTAAl convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 19 Dec 2022 19:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiLTAAi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 19:00:38 -0500
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774DC2705
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:00:37 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id w20so4019462ply.12
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:00:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoQLuF59CMA97eGfE3iMhcfjEtShR/Qy7rM4wEAg4xg=;
        b=BpXIeM+1Do1UNTBudLnC0AJ/d4ZzXZVT3w/T+Ca5GqhJe6lYaE9fZPe2HesXQ7w1v+
         AC/dcdsqxQEsgQDGlZoT64eEVfzLmDxqyv68p3XisZpdPoHJJJTgyZw+VJeP4HCysyZM
         dXrpM4cf4huHJHTUTdde7ZhMBssNbNpbmGxaOSv9Q/jxjS0OroliW+DH7lDQt621yefr
         dS29fFvJXJO3YbQOpuR/NB704VysEAYAg1MEB0I54QC5aYKss/YIv9AkJmgDhmooOUmA
         +Hp3uBEyluaRAhTKAFPQD79CmJjNr1O7c/HrQ1M8dlzPNn0lWGxVnRJS9Lr3QlJjfgwI
         apFQ==
X-Gm-Message-State: ANoB5pkzc7LgzAuaFo5lDg7ihTmKFa8W6bE/x865e5fEDHna/M8gqV5C
        MoOzXkCuMKIJ9aMTrbQiNXMFBfPS2oukrxgCo5g=
X-Google-Smtp-Source: AMrXdXvBaHrS8SLVEoBTbMkfj50vGjFBaMQeUAD+lmLE5TVLoFhPy7Wn2LZnTYDRtdlvyPwqGcEtFO9Zn9X+AWu/bZ4=
X-Received: by 2002:a17:90b:358e:b0:219:b1db:f7e3 with SMTP id
 mm14-20020a17090b358e00b00219b1dbf7e3mr2079915pjb.64.1671494436820; Mon, 19
 Dec 2022 16:00:36 -0800 (PST)
MIME-Version: 1.0
References: <20221205193625.2424202-1-lars@oddbit.com> <20221219224850.2703967-1-lars@oddbit.com>
 <221219.86edsvxank.gmgdl@evledraar.gmail.com>
In-Reply-To: <221219.86edsvxank.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 19 Dec 2022 19:00:25 -0500
Message-ID: <CAPig+cSEtW3TpUkQhNVjM=7WBk-3ZYOCDohsu+AZSpEAPKwk2w@mail.gmail.com>
Subject: Re: [PATCH v4] line-range: fix infinite loop bug with '$' regex
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Lars Kellogg-Stedman <lars@oddbit.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2022 at 6:00 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Dec 19 2022, Lars Kellogg-Stedman wrote:
> > +test_expect_success 'setup tests for zero-width regular expressions' '
> > +     cat >expect <<-EOF
> > +     Modify func1() in file.c
> > +     Add func1() and func2() in file.c
> > +     EOF
> > +'
> > +
> > +test_expect_success 'zero-width regex $ matches any function name' '
> > +     git log --format="%s" --no-patch "-L:$:file.c" >actual &&
> > +     test_cmp expect actual
> > +'
>
> Untested, but as most of this is repeated & would fail if the "setup"
> test is skipped, a one-off function would be better, e.g.:
>
>         test_zerowidth_regex () {
>                 local rx="$1" &&
>                 [...]
>         }
>         test_zerowidth_regex '$'
>         test_zerowidth_regex '^'
>         test_zerowidth_regex '.*'
>
> The change of direction for the fix itself looks good to me (re my
> earlier feedback on a previous round), i.e. that we should fix our own
> code, not forbid '$' in regexes.

It's subjective, of course, but the patch seems "good enough" as-is
and the tests are easy to understand. Therefore, can you clarify for
Lars and other reviewers if you're merely presenting an alternative
approach, or if you consider your suggestion "blocking" and expect a
reroll.
