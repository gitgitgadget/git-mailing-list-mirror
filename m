Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B634C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 07:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6B5613C3
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 07:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhGJHSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 03:18:41 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:40522 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhGJHSl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 03:18:41 -0400
Received: by mail-ej1-f52.google.com with SMTP id o5so20801026ejy.7
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 00:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6wPpIhG/OqIXFxJhD1iX1r+0nFQRZmBdFJyCQjlWaY=;
        b=UBIPNqWOUp7+VkHOdkGWRzX2v+ESkxKpYC7QeT1MDrLAyjN2ffumIUQvOfP7srQU8D
         8ENWaqf9y/vqQnzvZwEN+iQyQo+kXPi9j828ZWceP+xOdffhSSfuN4GRSYzxw3eoD4CN
         hgoo8oKYJo/nYz+vMJ0QrMltstiilZPweu3JVad709NW48gqT4qx++njCG8Jjhbaj/jV
         1jQXnSwESgZg3Mnb/WpPmb+RdotaWlgiLbzeZoZuNYxp0d7XdXejtr9U4qveDs/bLJQ5
         CpFJm+DnUM81wTRYC4kejqVKg1rmUMCABo0hbT2Bj7H0qqMeMgqKFP69R/zsJqs+f0+d
         B4VA==
X-Gm-Message-State: AOAM5301S9ComjqQ+HEuqhynkJAa+TTmV+UNTXUCU2SN62K51SnDaxD/
        CNVO3Rx4lxZut0FEHKLjk1N2FQOADc3chStBOu8=
X-Google-Smtp-Source: ABdhPJzojCz5DID4raKppGX607p6lupllKlngHnoYIhHVp/gRROzgLQ5MCpmvG86kncS5sRWJY30pSJDwXOb8VNKAtE=
X-Received: by 2002:a17:906:f9c5:: with SMTP id lj5mr20841984ejb.482.1625901355324;
 Sat, 10 Jul 2021 00:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
 <pull.992.v2.git.1625759443.gitgitgadget@gmail.com> <YOf+tANuox4LRD7d@flurp.local>
 <xmqqv95j79ut.fsf@gitster.g>
In-Reply-To: <xmqqv95j79ut.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 10 Jul 2021 03:15:44 -0400
Message-ID: <CAPig+cQyOgQb1zHA49kOT4+2SmTxUjZpfQ-f1ZxV1AwigCz01A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] worktree: teach add to accept --reason with --lock
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stephen Manz via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Stephen Manz <smanz@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 9, 2021 at 12:03 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > The reason I suggested re-purposing `add_opts.keep_locked` is to avoid
> > polluting that structure with members having overlapping meaning, thus
> > reducing the confusion-factor for clients of that structure (assuming
> > that a tri-state `keep_locked` is indeed less confusing). That doesn't
> > preclude adding a new variable or two local to the `add()` function to
> > facilitate keeping `add_opts` pure. For instance, it might be as
> > simple as the below patch.
>
> True.  It is less trivial to construct the command line option
> parser so that --reason=<why> and --lock can be given in any order
> (e.g. they no longer can be a simple OPT_BOOL and OPT_STRING that
> can be given independently but needs some postprocessing like your
> patch did), but it is not rocket science and keeping add_opts struct
> leaner will reduce the risk of runtime confusion, I would think, but
> at the same time, the room for runtime confusion would probably be
> minor to begin with---so I am fine, if the coder cannot cleanly
> write the option parser to do so, with the code as posted.

Although the leaner approach seems "simpler" and more obvious to me,
it is subjective, and I can see how other people might find a
tri-state add_opts::keep_locked confusing. So, I'm fine with it either
way and don't consider it a blocker at all.
