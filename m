Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4151C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 17:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42A26117A
	for <git@archiver.kernel.org>; Mon,  3 May 2021 17:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhECRIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 13:08:47 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:42511 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbhECRCs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 13:02:48 -0400
Received: by mail-ej1-f50.google.com with SMTP id y7so8920505ejj.9
        for <git@vger.kernel.org>; Mon, 03 May 2021 10:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lwGTyPuLKTWUfQlQxEW4Q2iAILwUjIowCKN889McITw=;
        b=diX/8BIyExqVxEacE/dljOilf7wxIUHGWqD0T38KM/JYhBRRL3/6fqNV8hDKb1p1lL
         POjFLTwIxIt17LUr+zg1PZO+59Yw/QpYmQmYh76M/AYseJX8V6PftcMeAJsELz+XDyfQ
         clgfxZuyVFrXXHT0cCkjOyl4GrDuTUnwjCKnnHh8rDyymvLy5k6pylfKMbUt3wz3XqaE
         +yJ61vhOKam3NHTkYYJ12puKEMrHUbNXYvWRSmuohY8gPfuEDGhocE0PjTJt0PmjYhsd
         0f3cR1wIfOEWD2xZ017/DE8d8nIK6HJzRcfVncjqdHSzqRd7IyNvc6SwOS5ah9CVgtZn
         O/NQ==
X-Gm-Message-State: AOAM531YzBFQ9Au91WXel31uP6q7uJrekSAg98R9O73AnaL6TYRb4sJv
        jKWJtp93n3zGdJ3rkRMX8kFQOX75e0uCz6s+eD5+u7gfo/0hAQ==
X-Google-Smtp-Source: ABdhPJxdmK56cK/ahyNnqZ5nC+Z/fOTqyc/JHffOrEyvdcThMuPxSY5e64WtEfTn0K+NySAvKEXpQuLPaV6aMTmIf/0=
X-Received: by 2002:a17:906:87cc:: with SMTP id zb12mr18154083ejb.138.1620061313532;
 Mon, 03 May 2021 10:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
 <pull.724.v4.git.1602782524.gitgitgadget@gmail.com> <dd9237927395ef69663ab376a2da74da4654c495.1602782524.git.gitgitgadget@gmail.com>
 <cda4f200-2400-e915-e995-36eea2a27c11@ahunt.org>
In-Reply-To: <cda4f200-2400-e915-e995-36eea2a27c11@ahunt.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 May 2021 13:01:42 -0400
Message-ID: <CAPig+cToeuq7S1176ze7kX9krjK1rGMOM-JDznF_Fr_qV09qWw@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] for-each-repo: run subcommands on configured repos
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not Stolee and hadn't even looked at this code before, but I'll
jump in with a couple comments...

On Mon, May 3, 2021 at 12:11 PM Andrzej Hunt <andrzej@ahunt.org> wrote:
> On 15/10/2020 19:21, Derrick Stolee via GitGitGadget wrote:
> > +static int run_command_on_repo(const char *path,
> > +                            void *cbdata)
> > +{
> > +     int i;
> > +     struct child_process child = CHILD_PROCESS_INIT;
> > +     struct strvec *args = (struct strvec *)cbdata;
>
> I was curious there's a strong reason for declaring args as void *
> followed by this cast? The most obvious answer seems to be that this
> probably evolved from a callback - and we could simplify it now?

Agreed, the `void*` cbdata doesn't make sense here.

> > +     strvec_pushl(&child.args, "-C", path, NULL);
> > +
> > +     for (i = 0; i < args->nr; i++)
> > +             strvec_push(&child.args, args->v[i]);
>
> So here we're copying all of args - and I don't see any way of avoiding
> it since we're adding it to child's arg list.

... (dot dot dot)

> > +int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
> > +{
> > +     struct strvec args = STRVEC_INIT;
> > +     for (i = 0; i < argc; i++)
> > +             strvec_push(&args, argv[i]);
>
> But why do we have to copy all of argv 1:1 into args here, only to later
> pass it to run_command_on_repo() which, as described above, copies the
> entire input again? I suspect this was done to comply with
> run_command_on_repo()'s API (which takes strvec) - does that seem
> plausible, or did I miss something?
>
> Which brings me to the real reason for my questions: I noticed we "leak"
> args (this leak is of no significance since it happens in cmd_*, but
> LSAN still complains, and I'm trying to get tests running leak-free). My
> initial inclination was to strvec_clear() or UNLEAK() args - but if we
> can avoid creating args in the first place we also wouldn't need to
> clear it later.
>
> My current proposal is therefore to completely remove args and pass
> argc+argv into run_command_on_repo() - but I wanted to be sure that I
> didn't miss some important reason to stick with the current approach.

An alternative to all this copying would be to take advantage of
child_process.argv which is owned by the caller, thus does not get
freed automatically by run_command(). This would allow you to re-use
the same argument vector for all calls. And you don't need
run_command_on_repo() at all. Something like this in
cmd_for_each_repo(), untested and typed directly in email:

    struct child_process child = CHILD_PROCESS_INIT;

    for (i = 0; !result && i < values->nr; i++) {
        const char *d = chdir(values->items[i].string);
        if (chdir(d))
            die_errno(_("cannot chdir to '%s'"), d);
        child.git_cmd = 1;
        child.argv = argv;
        result = run_command(&child);
    }

This assumes that argv[] is correctly NULL-terminated after
parse_options() -- I didn't check, but expect it to be so. If not,
it's easy enough to copy argv[] into `args` once and then
strvec_clear(&args) at the end of the function.

The one downside is that trace output wouldn't be as helpful (I think)
because you wouldn't see an explicit "-C <dir>", but I suppose the
tracing machinery can be invoked manually to address this.
