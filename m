Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92594C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 20:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EDC622BF3
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 20:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgLUUJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 15:09:45 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:33102 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgLUUJp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 15:09:45 -0500
Received: by mail-ed1-f43.google.com with SMTP id j16so10814935edr.0
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 12:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TEv4Cjm8oH/JJp3whP1YqGaVCUijJ4KMK2wkANwkLNI=;
        b=jTQe5V823hx/vppbfezQdZF5KuMgBmrIoaDpD6hd79eHe2WZUkhJ2zNff+Y+eLMiRr
         ZwKscCeIQyKuqLycbpcsgyaiNp/HW/fybFLMogrxwDLOSRy9x6OSUiElD5JMysyOTflH
         J4y5zLAUZTNUi+pYB2j+c6uf4rIuykomOAozXu1AJ3eXrN429plFQQ80NGsx9x/Z9leC
         yQQgKpqNmF/UwTIi21ptwvoUXED7aJbAVMri9ttOJBjVoRnovlPOm6wU0bxQ6ZelX+81
         CPbEaZwDpwZzqygcb0SPSdKFB66vBoNj1jrB0tetXBUwEe5jhPEE/+p8uORs2/sgqrbH
         TQzA==
X-Gm-Message-State: AOAM530LKVAYXw4y5qmQNY3iIZ9pvD4Q8TzaX87oyoGGu/u8tpASjWZ7
        tVeH8H20z/lzxS7SVmwvxK8Cx8WwbvVISi2tknNGYJFGoEo=
X-Google-Smtp-Source: ABdhPJzyHPXD8SS9zlU3JkZ+AKChyqMSKsYMF5924aW2igQQErYyHG7a6e1jB+AhGH7WRU5e5ukMRo/sYpN5R5puEvc=
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr17549521edu.163.1608581343725;
 Mon, 21 Dec 2020 12:09:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
 <pull.820.v3.git.1608516320.gitgitgadget@gmail.com> <733c674bd1901c931a8917045eb72f661872f462.1608516320.git.gitgitgadget@gmail.com>
 <CAPig+cSaq4vTK7CtvxB2bd0=WTW+d=s0H2RMquyCEf+q0YVn2w@mail.gmail.com> <xmqqa6u7m1bu.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6u7m1bu.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Dec 2020 15:08:52 -0500
Message-ID: <CAPig+cRqa9Y4mEdktdP3d2+PHWanKZ6q6tXfJXEAW9sqcVwHOw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] test-lib-functions: handle --add in test_config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 21, 2020 at 2:00 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Finally, as this is a one-off case, it might be simpler just to drop
> > this patch altogether and open-code the cleanup in the test itself in
> > patch [2/3] rather than bothering with test_config() in that
> > particular case. For example:
> >
> >     test_when_finished "test_unconfig -C two remote.one.push" &&
> >     git config -C two --add remote.one.push : &&
> >     test_must_fail git -C two push one &&
> >     git config -C two --add remote.one.push ^refs/heads/master &&
> >     git -C two push one
>
> That would be my preference, too.  Thanks for carefully and
> patiently reviewing.

I forgot to mention that it likely would be a good idea to at least
mention in the commit message why test_config() is not being used for
that particular case. Perhaps saying something along the lines of "one
test handles config cleanup manually since test_config() is not
prepared to take arbitrary options such as --add" -- or something
along those lines -- would be sufficient. Alternatively, an in-code
comment within the test explaining the open-coding might be more
helpful to people reading the code in the future.
