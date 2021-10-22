Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8001FC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 01:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E21A6101C
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 01:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhJVBWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 21:22:03 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:46603 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhJVBWC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 21:22:02 -0400
Received: by mail-ed1-f49.google.com with SMTP id z20so159666edc.13
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 18:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EAZAMg4od3bGCjwQuFKUQmuMk10Z0po/6SAn1abNxMY=;
        b=rJFKDgTwlZ7aAmIyjdrhMRj+54oEHo+3/UgMHXrlTI6JIErN+LW7jn6Un33JSA/jss
         Pj78nDSn9fagG5K7NZSgbp7+pVXUOcvJHkGiPkHB27QnoUpOeb/kdlx1kAKd1tMxl4w4
         FJPWhN2Wufqqp/34JE3vOfgHCfYVEBqMEvapo4iBZJ3/m6lRdJaerhP7+boYX1Has9bq
         25JD7bW5sK/zncDvJNoHyB8vWbUbHseh33tu2NwWRXiU+hxanXw2zJYGvH1dLfyMF+/V
         ljsMxzU/oIwUXWhin7FeLia/smAFvFqBOQpjNAfnGD9xrlMA/tdu0Qn1Hu84MS2kd2eu
         j0pw==
X-Gm-Message-State: AOAM533C41+v0qzzTmWlveMaAca3iq4Qb1QDVXZE8DaMtuEEUEAFV/cO
        YLpEY49y+UlzWmvHhRWHJvqzv53WZt2iPlhIV5CfKeeIbg0lBA==
X-Google-Smtp-Source: ABdhPJx9gWjMxmSZ3etFVFJ2VF3F+tx+JNo6roipRxjNO/MOZcZseuIgzHvUYhx/o7PeBYg4pETd2FARS5fBWPvfzHk=
X-Received: by 2002:a05:6402:1d49:: with SMTP id dz9mr12336662edb.55.1634865585401;
 Thu, 21 Oct 2021 18:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211021222532.463375-1-oystwa@gmail.com> <20211021222532.463375-3-oystwa@gmail.com>
 <CAPig+cQQurJuKieFcnZ8_10CaJA7vZ2kV=S+AaHVX3nhsVUG-Q@mail.gmail.com> <xmqq4k99gava.fsf@gitster.g>
In-Reply-To: <xmqq4k99gava.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Oct 2021 21:19:34 -0400
Message-ID: <CAPig+cTMC0ZAkdzwQ6qu9ra0bjBGDP5wtsqccnbFq+0cdTRiSw@mail.gmail.com>
Subject: Re: [PATCH 2/2] status: print stash info with --porcelain=v2 --show-stash
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 8:30 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> +       test_when_finished "git stash pop && git stash pop" &&
> >
> > If it's indeed important to clean up the stashes when the test
> > finishes, then the test_when_finished() invocation should probably be
> > a bit more robust...
> >
> >> +       git stash -- file_x &&
> >> +       git stash &&
> >
> > ... since, as it is now, if an error occurs between these two
> > git-stash invocations or before them, then there will only be zero or
> > one stashes, so the double stash-pop by test_when_finished() will
> > itself errout out. Better, perhaps to do this:
> >
> >     test_when_finished "git stash pop && git stash pop || :" &&
>
> There is no "I do not care what is in the stash right now, just
> clear all"?

Indeed, I wondered that too but was too lazy to look and I had
forgotten about `git stash clear`, which makes this much simpler:

    test_when_finished "git stash clear" &&
