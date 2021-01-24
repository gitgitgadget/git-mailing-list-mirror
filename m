Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85FFC433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 08:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5D922838
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 08:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbhAXI1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 03:27:24 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48]:43387 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbhAXIZD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 03:25:03 -0500
Received: by mail-ej1-f48.google.com with SMTP id a10so13586306ejg.10
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 00:24:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JngO+9g5pAYQQtW3Nl4EhQN3WTk6hsWAgv6/jo0RcnM=;
        b=qmc5TW9UVww0aP60aw/aB5lNQ24zJvwiXZjjxQ55UARFB3mWtRzew490+Ruc8eq8Jl
         lg4ZizqVOcWw+a0gGnt3f4F4HHn8xs0rooTM6cM9lzyX2ig6h/OJzzBqkQabShdEWZw4
         pRxVYL5VFtMwSI/R+4IjzmGvXXYJr1BBn6ah51ekX8x/vOmoTLu12GxtGnJs8At21dhF
         uE8QThuW23Y3BNb6HRFXZbI01e30TGLMgw23cIJcyq1mxzkRPJgIGSWmD1uztih63tdx
         Voe+I14l3Lgb4euwWJ+Qp4TG77eSPC4oIL4PevnDdMPH5txuEfH3xlO91gmrvXNePWRP
         bQfw==
X-Gm-Message-State: AOAM5312ibeTsxyXP7GJFPkMQRtyYiYKjfhBPSR8FylJd2/PyRnNK7+C
        SU4gRhePoNQGdXvh00xNMiAeK57k+d6dVgjotxk=
X-Google-Smtp-Source: ABdhPJxp5V+k2Z6pAMEL1DF6ed+TXWF+q+tZZsL+WGOTilz1aOgsRcSf5tH9mAVwCrjNtV4Rooxl2YwY9e+aibG/8DY=
X-Received: by 2002:a17:906:4159:: with SMTP id l25mr365012ejk.311.1611476661919;
 Sun, 24 Jan 2021 00:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-1-rafaeloliveira.cs@gmail.com> <20210119212739.77882-6-rafaeloliveira.cs@gmail.com>
 <be24c164-3d03-145f-abc0-4f41ed225b4e@gmail.com>
In-Reply-To: <be24c164-3d03-145f-abc0-4f41ed225b4e@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 24 Jan 2021 03:24:11 -0500
Message-ID: <CAPig+cS_7P3dCMDiWutuk+ota+NCXyz11XDv_Sgh3BCmVgeTLw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] worktree: teach `list --porcelain` to annotate
 locked worktree
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 6:00 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 19/01/2021 21:27, Rafael Silva wrote:
> >   The porcelain format has a line per attribute.  Attributes are listed with a
> >   label and value separated by a single space.  Boolean attributes (like `bare`
> >   and `detached`) are listed as a label only, and are present only
> > +if the value is true.  Some attributes (like `locked`) can be listed as a label
> > +only or with a value depending upon whether a reason is available.  The first
> > +attribute of a working tree is always `worktree`, an empty line indicates the
> > +end of the record.  For example:
>
> I think it would be helpful to document that the reasons are quoted
> according core.quotePath.

Good idea.

> I'm not sure if it is worth changing this but I wonder if it would be
> easier to parse the output if the names of attributes with optional
> reasons were always followed by a space even when there is no reason,
> otherwise the code that parses the output has to check for the name
> followed by a space or newline. A script that only cares if the worktree
> is locked can parse the output with
> l.starts_with("locked ")
> rather than having to do
> l.starts_with("locked ") || l == "locked\n"

I see where you're coming from with this suggestion, though my
knee-jerk reaction is that it would be undesirable. Even after mulling
it over for a few days, I still haven't managed to convince myself
that it would be a good idea. There are a couple reasons (at least)
for my negative reaction. The primary reason is that the trailing
space is "invisible", and as such could end up being as confusing as
it is helpful for the simple parsing case (taking into consideration
that people often don't consult documentation). The second reason is
that we're already expecting clients to be able to parse C-style
quoting/escaping of the reason, so asking them to also distinguish
between a single token `locked` and a `locked reason-for-lock` seems
like very, very minor extra complexity. (It also just feels a bit
sloppy to have that trailing space, but that's a quite minor concern.)
