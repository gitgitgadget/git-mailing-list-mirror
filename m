Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C32E1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 10:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfKHKOu (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 05:14:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53488 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbfKHKOu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 05:14:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id x4so5546437wmi.3
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 02:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++EwRw/7pFWBOySxsCclNMivUebof7iZ5RlUBFChxgw=;
        b=amlrozauSkvnGesfOjyFwNCbyFBwu+a3+XM4dlZQFnJ/HFvd9CDWUiak7Oh/sSWw+S
         dGi9fsYcuZ7U8EUz8kDxfIVyX4S8Y3lnaQryyUr8fwDSpuw53Ce5Vi/RM/WIe8yEk7Ao
         uZoQHrKyDg/AxkITW2uolhx+MpzVrgQwX6OPsIaaS5oin0CPEy2cvfFG39Wedhklw4se
         8FFuF/e7lPJE/PcIwizRmw19KvzH/t4MWKib0OeoxWaTrCZFsGUKx8dlxs7bt6OAhx1g
         ZnRHbKyOt3clbg6NJtC+tYF0cDNhrL3dSmdUAmQfFs8yv72QxvVPg160slLfILIkv0SJ
         zrlg==
X-Gm-Message-State: APjAAAU8tNE0/OKICgQQS9ggD2d0/5kIB74RPxKeNdKJRxTaExCTsYMw
        P+eP3XmwDeWY8lHnAqerENxlxtlJ668eMULbIL0hxXqG
X-Google-Smtp-Source: APXvYqze2mn3zjJRd93nGI/FBDOYkDSEACC8jh9JaMJ/Eo4iRMtjKVASWPxLqKE1pebDLma/XtSfk+slxCh+7+HA0qU=
X-Received: by 2002:a1c:3843:: with SMTP id f64mr7051913wma.129.1573208069397;
 Fri, 08 Nov 2019 02:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20191017162826.1064257-1-pjones@redhat.com> <20191017162826.1064257-2-pjones@redhat.com>
 <CAPig+cS6SzLdgmzffNkg72YSiDQ9eQRqTK12NsraKpGbkJFY_w@mail.gmail.com> <20191018194317.wvqphshpkfskvkyh@redhat.com>
In-Reply-To: <20191018194317.wvqphshpkfskvkyh@redhat.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 Nov 2019 05:14:18 -0500
Message-ID: <CAPig+cTExu1+XyhUaq=yY09CAK6NN_BQViQETU8_fbGxu3jWzg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Make "git branch -d" prune missing worktrees automatically.
To:     Peter Jones <pjones@redhat.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[cc:+duy]

On Fri, Oct 18, 2019 at 3:43 PM Peter Jones <pjones@redhat.com> wrote:
> On Thu, Oct 17, 2019 at 01:28:09PM -0400, Eric Sunshine wrote:
> > Echoing SEZDER's comment on patch 1/2, this behavior is an intentional
> > design choice and safety feature of the worktree implementation since
> > worktrees may exist on removable media or remote filesystems which
> > might not always be mounted; hence, the presence of commands "git
> > worktree prune" and "git worktree remove".
>
> Okay, I see that use case now - I hadn't realized there was an
> intentional design decision here, and honestly that's anything but clear
> from the *code*.

It can indeed sometimes be difficult to get a high-level functional
overview by examining code in isolation. In this case, at least,
git-worktree documentation tries to be clear about the "why" and "how"
of the pruning behavior (which is not to say that the documentation --
or the code -- can't be improved to communicate this better).

> It's surprising, for example, that my patches didn't break a single
> test case.

Tests suites are never perfect, and an attempt to prune a dangling
worktree by deleting a branch likely never occurred to the
git-worktree implementer(s).

> > These minor implementation comments aside, before considering this
> > patch series, it would be nice to see a compelling argument as to why
> > this change of behavior, which undercuts a deliberate design decision,
> > is really desirable.
>
> Okay, so just for clarity, when you say there's a deliberate design
> decision, which behavior here are you talking about? If you mean making
> "lock" work, I don't have any issue with that. If you mean not cleaning
> up when we do other commands, then I don't see why that's a concern -
> after all, that's exactly what "lock" is for.

To clarify, I'm talking about Duy's deliberate design decision to
model git-worktree auto-pruning after Git's own garbage-collection
behavior. That model includes, not only explicit locking, but a grace
period before dangling worktree administrative files can be pruned
automatically (see the gc.worktreePruneExpire configuration).

The point of git-worktree's grace period (just like git-gc's grace
period) is to avoid deleting potentially precious information
permanently. For instance, the worktree-local "index" file might have
some changes staged but not yet committed. Under the existing model,
those staged changes are immune from being accidentally deleted
permanently until after the grace period expires or until they are
thrown away deliberately (say, via "git worktree prune --expire=now").

> Assuming it is the "lock" behavior we're talking about, I don't think I
> actually have any intention of breaking this design decision, just
> making my workflow (without "lock") nag at me less for what seem like
> pretty trivial issues.

The ability to lock a worktree is an extra safety measure built atop
the grace period mechanism to provide a way to completely override
auto-pruning; it is not meant as an alternate or replacement safety
mechanism to the grace period, but instead augments it. So, a behavior
change which respects only one of those safety mechanisms but not the
other is likely flawed.

And, importantly, people may already be relying upon this behavior of
having an automatic grace period -- without having to place a worktree
lock manually -- so changing behavior arbitrarily could break existing
workflows and result in data loss.

> I can easily accommodate "git worktree lock". What bugs me though, is
> that using worktrees basically means I have to replace fairly regular
> filesystem activities with worktree commands, and it doesn't seem to be
> *necessary* in any way. And I'm going to forget. A lot.
>
> To me, there doesn't seem to be any reason these need to behave any different:
>
> $ git worktree add foo foo
> $ rm -rf foo
> vs
> $ git worktree add foo foo
> $ git worktree remove foo
>
> And in fact the only difference right now, aside from some very
> minuscule storage requirements that haven't gotten cleaned up, is the
> first one leaves an artifact that tells it to give me errors later until
> I run "git worktree prune" myself.

I understand the pain point, but I also understand Duy's motivation
for being very careful about pruning worktree administrative files
automatically (so as to avoid data loss, such as changes already
staged to a worktree-local "index" file). While the proposed change
may address the pain point, it nevertheless creates the possibility of
accidental loss which Duy was careful to avoid when designing worktree
mechanics. Although annoying, the current behavior gives you the
opportunity to avoid that accidental loss by forcing you to take
deliberate action to remove the worktree administrative files.

Perhaps there is some way to address the pain point without breaking
the fundamental promise made by git-worktree about being careful with
worktree metadata[*], but the changes proposed by this patch series
seem insufficient (even if the patch is reworked to respect worktree
locking). I've cc:'d Duy in case he wants to chime in.

[*] For instance, perhaps before auto-pruning, it could check whether
the index is recording staged changes or conflict information, and
only allow auto-pruning if the index is clean. *But* there may be
other ways for information to be lost permanently (beyond a dirty
"index") which don't occur to me at present, so this has to be
considered carefully.
