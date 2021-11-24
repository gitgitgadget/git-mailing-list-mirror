Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F216C433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 06:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhKXGEJ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 24 Nov 2021 01:04:09 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:41768 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbhKXGEE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 01:04:04 -0500
Received: by mail-ed1-f45.google.com with SMTP id g14so5183710edb.8
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 22:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aRdwwKbd4z/VO5JUahyzHA0WE87uTkVdAMqmgHHipDk=;
        b=AiBPDC4ClCR2InvNmXCeQlWH12DLp+tEyD53HbVpfGEe+Vympxo9igAsKODso3KuaM
         QtHzspeN23JfLQaut6KQhrUBAp1vMz+x7rZFlngQWkioVU7WKpV9l5pthQUGshY/GKKG
         pfh4+DCO+m/vK35ZIsrOiLtetS/HiY7k2g5JjmwQk43AugEjI6bm8uAt8KZl5KO8Amya
         xuC/J+Jn4DLvfNGaro55yWpnTRWRiezJ1Z0nQzitXOyXaZgeQd5mIbfxtFZek6PfJHUF
         kEjXLxCjf4XPZc8gtmhYgCwla/9vMthw48mAKd/5M+U6UOyunCRO/ocYvlyvX/b53fbX
         y00Q==
X-Gm-Message-State: AOAM533/kqm6TEJ+SwwjZcNuo2gBEbn0KC+G0j3/lrchXUhd+mDAXM5S
        KpsbxOYL1fea3wX7Sy5ns1lVymyrmClhMRvw3Sc=
X-Google-Smtp-Source: ABdhPJxF2ZEsbAJjXrLW/KpbAOCaUXLebQduAXiklplJ/7rSLpaza6ryWSAsdrFvJ6K4sH7wNpd5xoVME1Y0NbDoYdY=
X-Received: by 2002:a05:6402:50ca:: with SMTP id h10mr20571120edb.70.1637733654323;
 Tue, 23 Nov 2021 22:00:54 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
 <patch-v2-1.9-9cc220ce5a3-20211123T115551Z-avarab@gmail.com>
 <CAPig+cStZp=AOPHW8i7AqwDOV6djYzHC6GmcVeb=4PUj5bjvAw@mail.gmail.com> <xmqqy25e48u5.fsf@gitster.g>
In-Reply-To: <xmqqy25e48u5.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Nov 2021 01:00:43 -0500
Message-ID: <CAPig+cRMYiCvq7=ESSk7+PM50p4PeoKFat+w9svXMxsCHA6HEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] worktree: remove redundant NULL-ing of "cp.argv
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 8:54 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > ... At best, following this change,
> > git-worktree is only working "by accident" if the underlying
> > child_process::args.v doesn't get reallocated between run_command()
> > invocations. Relying upon this "by accident" behavior feels rather
> > unsafe.
>
> The pattern with or without NULLing is
>         /* cp.argv = NULL */
>         strvec_clear(&cp.args);
>         push to cp.args
>
> and strvec_clear() frees the underying array, and the first push
> will reallocates from NULL, so there is no guarantee that cp.argv
> in the first use that used to be pointing at cp.args that has
> already been freed is still valid.

Indeed, so this is even worse than I thought. I was somewhat pressed
for time when I wrote the review, thus didn't look at the
implementation of strvec_clear(), and incorrectly thought that it only
reset its `nr` member to 0 but kept the array allocated (much like
strbuf_reset()). That's why I thought it was only working "by
accident". But, as you point out, strvec_clear() does free its
allocated array (much like strbuf_release()), so -- with this patch
applied -- each subsequent run_command() invocation is _definitely_
accessing the dangling pointer in child_process::argv, and that
dangling pointer would (in the "best" case) be referencing the
original populated value of child_process::args, not the repopulated
value. So, even if it didn't crash outright, it would just re-run the
same command three times (unless by chance it reallocated the same
memory it had freed earlier.)

> Thanks for spotting this.  Has this patch ever been tested with
> sanitizer?  Do we have gap in test coverage?

The question about potential gap in test coverage is a good one.
Maybe, by chance it reallocated the same memory that it had earlier
freed, thus did indeed work "by accident". Another possibility is that
Ævar only ran the tests after applying the full patch series, in which
case this dangling-pointer bug would be gone, rather than running the
tests after each patch.
