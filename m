Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110CDC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 02:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241235AbhLACkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 21:40:15 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:36754 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346174AbhLACkN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 21:40:13 -0500
Received: by mail-pl1-f180.google.com with SMTP id u11so16507507plf.3
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 18:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VScFo/8Ys+47myXmbcROt9oWP1yVAdacoU8QfdqUv3E=;
        b=wI+vbmjNvKgcdPR/x+6qvYh74OUt/O4y0SkIe3sYhAMmVCcNjRjHRuPzMiYxib4pG2
         VZoHeNnNiRcjcBsAdQ7lvK4BdznNGhG620MrZENpzeQWiHTJpYhv7spd8sowg6xNF1ZP
         GRAyqrKFDsxJLnNi7Ix9xU1kP1+oPxbIBevE0rNzTkbbLnnjF4wiJ2npMbLn1QVVvMwB
         zisyLQzkK7doE/f7YjHhrNlQntjRFMnjO45YxBpnFfwizKpDwVniBJw4GoXgZqexe7aY
         SqietblBOp43roqUix4+J7NWh7PF+Eqk8YrgBRfFzpVtwbPJDrDqjgKVMPyqOWlKE6L8
         asTA==
X-Gm-Message-State: AOAM532EwtK1UUbz/UL0jKPzjosa+EIgIBqoiMVse5o0mqEf3ntd7GBI
        31DAwXc0ugFGc/ZOFcWiR/OyN1uveQOsPeSHoEWZxufHmnGwrg==
X-Google-Smtp-Source: ABdhPJxEcGiYHaQIXu/fV6Zh8UXmwpQGHylSEArhErXP2LWUYvuv0QbZ6OXqVOZyIvoVIHCG2JYd3O1gYSw86m0krHk=
X-Received: by 2002:a17:902:ac8e:b0:143:6e61:460 with SMTP id
 h14-20020a170902ac8e00b001436e610460mr3655144plr.85.1638326213249; Tue, 30
 Nov 2021 18:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20211130043946.19987-1-sunshine@sunshineco.com>
 <YaXQ/HinYZH1wL7E@coredump.intra.peff.net> <CAPig+cRQqm8Ce29PnkndT47NNxM3UhJv12RZGZZJD-AyGVC7Zw@mail.gmail.com>
 <YaaN0pibKWgjcVk3@coredump.intra.peff.net>
In-Reply-To: <YaaN0pibKWgjcVk3@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 30 Nov 2021 21:36:42 -0500
Message-ID: <CAPig+cT+YfgBG3Aqszp+y7iy_megboECZy3NkMqUjBj7=Z661A@mail.gmail.com>
Subject: Re: [RFC PATCH] vreportf: ensure sensible ordering of normal and
 error output
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 3:47 PM Jeff King <peff@peff.net> wrote:
> On Tue, Nov 30, 2021 at 09:05:54AM -0500, Eric Sunshine wrote:
> > (1) I don't think the practice is documented anywhere, so people --
> > including me when I wrote builtin/worktree.c -- might not know about
> > it. Indeed, we don't seem to be entirely consistent about doing it
> > this way. Randomly picking submodule-helper.c, for instance, I see
> > status-like messages going to stdout:
>
> Yeah, we've definitely not been consistent here. There's no silver
> bullet for this aside from vigilance during review, but probably laying
> out guidelines could help.
>
> Here's a past discussion (that actually goes the other way: somebody
> complaining that stderr should be on stdout!) where I laid out my mental
> model:
>
>   https://lore.kernel.org/git/20110907215716.GJ13364@sigill.intra.peff.net/

Thanks for the reference. I'll take a stab at adding a blurb about
this to CodingGuidelines.

> > (2) With git-worktree being four or five years old, for
> > backward-compatibility concerns, I worry that "that ship has sailed",
> > where 'that' is the freedom to relocate those status-like messages
> > from stdout to stderr. I don't want to break tooling which exists
> > around git-worktree.
>
> IMHO it would be OK to change these. They are, after all, marked for
> translation, so they're not reliably machine-readable anyway. It's
> possible that some script could not be parsing them, but just trying to
> redirect them. Or even keying on content in stderr as a sign of an error
> (as tcl likes to do). But I don't think that's a guarantee we want to be
> bound by.

That's a good point about them being marked for translation. It also
reminds me that we made some reasonably significant changes to this
exact message in 2c27002a0a (worktree: improve message when creating a
new worktree, 2018-04-24), and we didn't hear any complaints, let
alone complaints about tool breakage.

> See 68b939b2f0 (clone: send diagnostic messages to stderr, 2013-09-18)
> for a similar case in the past.

Nice. This and the above make me feel much more comfortable with the
idea of changing git-worktree to send these sorts of messages to
stderr rather than stdout.

> > I'd be happy to be wrong on the second point -- indeed, git-worktree
> > is still marked "experimental" in the man-page, but that may not mean
> > anything this late in the game -- and submit a patch which places
> > git-worktree's status-like messages on stderr instead of stdout.
> > Thoughts?
>
> I'm in favor. :)

Thanks. I'll drop this RFC patch and resubmit with a patch which just
fixes git-worktree to be chatty on stderr instead of stdout.
