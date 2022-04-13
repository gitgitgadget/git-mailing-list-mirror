Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B02C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 16:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiDMQD1 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 13 Apr 2022 12:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiDMQD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 12:03:26 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81BF26556
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:01:03 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id b15so2957888edn.4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CFzEFBLun14+GOAuRSn4DqKQCVTh6aaxJrwTL1dx1zE=;
        b=4ZM7TSEPVH/qegYo+fNW1t/wsvkwqQ/UyCMRafgNdY+RlHTPO6HqcZQdtzB70yK2SN
         iDwNM4Qz2ghLnmv5CHBi4VcBcbyQy2gdofU7jPTHNfMtQ9/fxRiJNZxjS8g7K0Y0CQFw
         p5gv1gRTqV17qLusctYjvy9HdZSHZOxWPxN+ZUGDngYsk6zkcnH4s04L0ny5igivaB1y
         +cBUlCA0sjAekHLzrPFG8WWTJolXplYL+4aAKnCkKBOdxvvc9QDNa3WPUmuvbvYEaVn/
         KmGFmqTqa1m9RItJiiDJ77PZVROdLp/X730NZwUvsrGSYpB4rU2E+3AZn9puZQu20bgg
         PmoA==
X-Gm-Message-State: AOAM531ESc+Bj31iGMkn1JaS71K0TXjGtyi4GI2SEZ2AD2v9N1dQEMsC
        wSrwBZ/IusV+wA/jodlJL/ofjPAHWXxDY3vIcG6zjq6Phok=
X-Google-Smtp-Source: ABdhPJxSit3g+QZ78hEo2+j+ak7fDjYw/K3zs6QCyouVFqH4nKv0Xh3PEyKOsxI2qJh66AMShmXpPta5f9+6VW8xD0w=
X-Received: by 2002:a50:99cd:0:b0:418:d6c2:2405 with SMTP id
 n13-20020a5099cd000000b00418d6c22405mr44457543edb.342.1649865662306; Wed, 13
 Apr 2022 09:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAKJfoCEgiNvQJGt=rGYTaKQ1i2ihrPmX2Sz3Zxg-y66L+1Qh6g@mail.gmail.com>
 <220413.86v8vdf46n.gmgdl@evledraar.gmail.com>
In-Reply-To: <220413.86v8vdf46n.gmgdl@evledraar.gmail.com>
From:   Jeremy Maitin-Shepard <jeremy@jeremyms.com>
Date:   Wed, 13 Apr 2022 09:00:51 -0700
Message-ID: <CAKJfoCHWYaQGgK1_Wv0j1qW--pwD3=T9A5m8zQJRwwVOrRLx_Q@mail.gmail.com>
Subject: Re: Limitations of ownership checking fox for CVE-2022-24765
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022, 07:28 Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>
>
> On Tue, Apr 12 2022, Jeremy Maitin-Shepard wrote:
>
> > The current fix for CVE-2022-24765 prevents unsafe command execution
> > in some cases but does not address all cases:
> >
> > - Ownership by the current user should not be taken to mean "trusted":
> > the user may have retrieved a directory tree from an untrusted source,
> > including:
> >   - Another version control system (which won't prevent a .git directory)
> >   - Unpacking an archive
> >   - FUSE mounting a remote filesystem
>
> Those would be good to fix, but I don't think it's correct that it's
> within the scope of CVE-2022-24765.
>
> That CVE is specifically about the multi-user case where we'd previously
> pick up another user's .git directory.


I can see the distinction but I would say the CVE addresses a specific
case of the more general problem that commands like `status` for
inspecting a repository aren't safe by default.

By solving the more general problem we also solve the case described
in the CVE.  On the other hand if the more general problem is not
solved then it is still not safe to run `git status` automatically.
The fix for this CVE might give users the impression that it is safe,
when given how most users do things, it is probably not.

> As noted in [1] the solution that got committed does suffer from that
> edge case, but I think [1] also summarizes why that approach was taken.


The argument in the thread seemed to be that by broadly blocking the
multi-user issue, there is less risk of discovering another multi-user
vulnerability.  But since it does nothing to address the more general
issue of `git status` being unsafe to run from untrusted directories,
the real mitigation is to ensure `git status` isn't run automatically
(and carefully inspect any untrusted directories before running it).
And if users employ that mitigation, the additional ownership check
isn't necessary.

Other tools such as direnv and the Emacs dir-locals mechanism have
exactly the same issue of needing to decide whether to trust
configuration files in the current directory.  They solve the issue
with an allowlist.  I'm not aware of any tool that trusts based on
ownership.

>
> A way of mitigating that case is to put something like this in one's
> .bashrc:
>
>         git () {
>                 command git -c core.fsmonitor=false "$@";
>         }
>
> Then, even if you need to use that safe.directory feature you won't be
> vulnerable to someone sneaking up on you and adding this to the
> .git/config of the (presumably core.sharedRepository) repo:
>
>     [core]
>     fsmonitor = rm -rf /


It fixes the current known issue by disabling that feature altogether,
but unlike a hypothetical --safe option it doesn't protect against any
similar config options that may be added in the future (or existing
ones found in the future to be unsafe).

Additionally it doesn't provide a mechanism for allowing specific
commands or specific repositories.

On Wed, Apr 13, 2022 at 7:28 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Apr 12 2022, Jeremy Maitin-Shepard wrote:
>
> > The current fix for CVE-2022-24765 prevents unsafe command execution
> > in some cases but does not address all cases:
> >
> > - Ownership by the current user should not be taken to mean "trusted":
> > the user may have retrieved a directory tree from an untrusted source,
> > including:
> >   - Another version control system (which won't prevent a .git directory)
> >   - Unpacking an archive
> >   - FUSE mounting a remote filesystem
>
> Those would be good to fix, but I don't think it's correct that it's
> within the scope of CVE-2022-24765.
>
> That CVE is specifically about the multi-user case where we'd previously
> pick up another user's .git directory.
>
> Whereas these cases aren't like that in that they:
>
> 1) Require the user to have set up that .git directory themselves, in
>    one way or another.
> 2) ...or for the OS to enforce user permissions so loosely that others
>   can chown files as you.
>
> > Additionally, the current fix requires additional configuration to
> > support existing use cases, and does not provide uses a way to safely
> > execute commands like `git status` or `git log` on untrusted
> > repositories.
>
> Yes, I agree. I.e. that the method of fixing it is all-or-nothing, and
> therefore creates escalation issues that wouldn't occur with a narrower approach.
>
> There was extensive off-list discussion about this, my [1] touches some
> of it. To quote my side of a discussion following-up [1] about the more
> narrow approach:
>
>         An implementation that asks the user to create an opt-in for any and all
>         config will be much less secure for the core.sharedRepository case,
>         which is an edge case my proposed change on top doesn't have.
>
>         That's because we'll refuse to read *any* config (including just that
>         created by "git init"), and then ask the user to opt-in to any *future*
>         config to keep using the repository at all.
>
>         So for the sort of staging environment I mentioned upthread it'll
>         effectively create a vulnerability which we'll still have no practical
>         mitigation for.
>
>         Whereas if we only error on the specific exploitation vector(s) users
>         who're using a repository without such config will never need to opt-in
>         at all, so when someone sneaks up on them later and adds a
>         core.fsmonitor=/path/to/exploit they'll know, and we can show a much
>         more pointed and obvious error to that effect.
>
> As noted in [1] the solution that got committed does suffer from that
> edge case, but I think [1] also summarizes why that approach was taken.
>
> A way of mitigating that case is to put something like this in one's
> .bashrc:
>
>         git () {
>                 command git -c core.fsmonitor=false "$@";
>         }
>
> Then, even if you need to use that safe.directory feature you won't be
> vulnerable to someone sneaking up on you and adding this to the
> .git/config of the (presumably core.sharedRepository) repo:
>
>     [core]
>     fsmonitor = rm -rf /
>
> > I think a better solution would be for git to support a `--safe`
> > option that only runs config-specified commands specifically added to
> > an allowed list, or if the repository itself has been added to
> > safe.directories.
> >
> > Ideally git would default to running in `--safe` mode, but if that is
> > too disruptive at least the option would be available for use in
> > prompt commands, etc.
> >
> > (Please CC me in replies as I'm not subscribed to the list.)
>
> What you're suggesting would be nice, and has been discussed on-list
> before.
>
> But it's fundamentally the same case as "make inspecting an unpacked
> .git [from a tarball] safe", i.e. that we'll currently pick up config
> from it.
>
> The CVE specifically exists because it's subtly different from that
> long-known-about case.
>
> 1. https://lore.kernel.org/git/220412.86h76yglfe.gmgdl@evledraar.gmail.com/
