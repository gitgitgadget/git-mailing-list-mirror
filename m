Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9472FC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 15:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbhKWPaR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 23 Nov 2021 10:30:17 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:45609 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbhKWPaR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 10:30:17 -0500
Received: by mail-ed1-f42.google.com with SMTP id y12so93738867eda.12
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 07:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xGdUYhxQhJ9IV4ioCGgdh+i2I4SSK63Jc50UnqFgK0s=;
        b=uFIN3wX4RJA4oHR0uloCl4o0By5wbkJufv4IOwPOdaMf7T+PDZeS7nE8NdTniUyNt7
         Dcaen0q52OlYyH88v9KVDN328rpLIDmnUVvkuxStxClV43ZXjiEk0Wq1460roWKyCCPM
         r7XC4OiJDHrc30+0p1IJouMxUFT8go6v3ID9WDLl1ShX4uUu0e4/d+4Jr0LYJ8GRVKga
         QccsEngZjOKVFTIApLl6xrc2WGlU57pWUsg/6C+yuh2QyqyeWNmoUZW69l0mEDWDmvcl
         +WhRihkDddK0QSsJInLY8StNhfqFyjclqg13SU4mjZECuWnDhh0oEiz/L3vB9Ng8t9If
         vGHw==
X-Gm-Message-State: AOAM5328d05FOPrMFe0F9b9HGU2i+gpVxgk1BrSIaimB48O3eVcSKDv+
        9aPXV/SdHiLFou80qmW1CtbieSNNvfXQwCrrHd4=
X-Google-Smtp-Source: ABdhPJyGU7yRIO2ehkC3zsjLtwySPzfvtaQdPnwYR9OW1QLN3bYbjQxE/EEGccI4ofZxrx6EmZW9QfgYxfbW7i6TlCM=
X-Received: by 2002:a17:907:a426:: with SMTP id sg38mr8702661ejc.392.1637681227880;
 Tue, 23 Nov 2021 07:27:07 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com> <patch-v2-1.9-9cc220ce5a3-20211123T115551Z-avarab@gmail.com>
In-Reply-To: <patch-v2-1.9-9cc220ce5a3-20211123T115551Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Nov 2021 10:26:56 -0500
Message-ID: <CAPig+cStZp=AOPHW8i7AqwDOV6djYzHC6GmcVeb=4PUj5bjvAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] worktree: remove redundant NULL-ing of "cp.argv
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Enzo Matsumiya <ematsumiya@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 7:08 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> The clearing of "argv" was added in 7f44e3d1de0 (worktree: make setup
> of new HEAD distinct from worktree population, 2015-07-17) when the
> "cp" variable wasn't initialized. It hasn't been needed since
> 542aa25d974 (use CHILD_PROCESS_INIT to initialize automatic variables,
> 2016-08-05).
>
> Let's remove it to make a later change that gets rid of the "argv"
> member from "struct child_process" smaller.

Let me preface with the caveat that (due to lack of time) I haven't
dug into this deeply and I haven't been following changes to the
run_command() machinery closely, so what I say below may be
inaccurate, but...

Although it will be safe to drop these builtin/worktree.c assignments
when the series eventually removes the child_process::argv member, I
think that the commit message is misleading (or outright wrong), and
that this change so early in the series potentially breaks
git-worktree, leaving it in a state where it works only "by accident".

The reason that this code repeatedly clears `cp.argv` is that the `cp`
structure is reused for multiple run_command() invocations (which, in
retrospect, is pretty ugly since worktree.c is too familiar with the
internals of run-command). The reason that `cp.argv` needs to be
cleared between each invocation is due to this code from
start_command():

    if (!cmd->argv)
         cmd->argv = cmd->args.v;

worktree.c re-populates child_process::args between run_command()
invocations and needs to clear child_process::argv to ensure that the
latter gets re-initialized from child_process::args each time. The use
of CHILD_PROCESS_INIT does not change anything in regard to the
requirement; child_process::argv still needs to be cleared between
run_command() invocations.

As to why this change so early in the series potentially breaks
git-worktree: with the removal of these assignments,
child_process::argv now _always_ points at the _initial_ value of
child_process::args.v even though that vector gets cleared between
run_command() invocations. At best, following this change,
git-worktree is only working "by accident" if the underlying
child_process::args.v doesn't get reallocated between run_command()
invocations. Relying upon this "by accident" behavior feels rather
unsafe.

I think perhaps the simplest thing to do is merely to squash this
patch into the patch which ultimately removes the child_process::argv
member (and the removal of these lines from worktree.c probably
doesn't even need mention in the commit message -- or maybe just a
minor mention).

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index d22ece93e1a..7264a5b5de0 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -355,7 +355,6 @@ static int add_worktree(const char *path, const char *refname,
>                 goto done;
>
>         if (opts->checkout) {
> -               cp.argv = NULL;
>                 strvec_clear(&cp.args);
>                 strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
>                 if (opts->quiet)
> @@ -390,7 +389,6 @@ static int add_worktree(const char *path, const char *refname,
>                         cp.stdout_to_stderr = 1;
>                         cp.dir = path;
>                         cp.env = env;
> -                       cp.argv = NULL;
>                         cp.trace2_hook_name = "post-checkout";
>                         strvec_pushl(&cp.args, absolute_path(hook),
>                                      oid_to_hex(null_oid()),
> --
> 2.34.0.831.gd33babec0d1
