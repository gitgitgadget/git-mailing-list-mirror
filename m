Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADCDD20248
	for <e@80x24.org>; Wed, 27 Feb 2019 14:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfB0OXp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 27 Feb 2019 09:23:45 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39995 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730104AbfB0OXp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 09:23:45 -0500
Received: by mail-qt1-f196.google.com with SMTP id j36so19323705qta.7
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 06:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XFHaI9SXPLI/OGVqxSLwgLFq5CI91ktg+501IMMsB2Q=;
        b=eyF3AMOV1rRYPsUq3EQpPgxjRosiKLKXAtN6zIiCJ+EP2F90GcF7pKiRpPyfjulN5V
         BdXBWQKzCOmSDdDZNC6zza7dxtxdzsgZQHQ05c5dPzGoyWaJXF871gk5rJpvNkL8gP6w
         oEWjW0yN+REWdoebEgIIZlmoXP+CsLM66AG3sbdY3MEMMKzbZ0lwrrqN7vTglP3yuYZ2
         tTQsvKMABSiZe+MUZUpbLY8bo9hK3Oy4/6SFf+7EOP7MfePet2N8qhDl3BDSl3oxaGP1
         sbfYswD4E8AEsiULkhrSZr/NYRc9KIizvTvQlqTsUWklxFvNi6m6Ea0LaiDLHpoJsuaT
         +Dtg==
X-Gm-Message-State: AHQUAub1YsZflsYkcB66O02EJgiA7Bq899db/RB3wREFLaDWkn/gHPoT
        jv9ByTRUhiensuLrfa5/t4QgkB8POp7sswBwNag=
X-Google-Smtp-Source: AHgI3Ib4RG1Naii8rcE3sG3eRoSGpAU6WPYQFlgxnqyVnEt093VL9IkqEG+CTlfn8rrUvAYsJ/mYPyFaZMlX9gVEqnI=
X-Received: by 2002:ac8:2847:: with SMTP id 7mr1802603qtr.335.1551277423968;
 Wed, 27 Feb 2019 06:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20190221121943.19778-1-pclouds@gmail.com> <20190226105851.32273-1-pclouds@gmail.com>
 <20190226105851.32273-2-pclouds@gmail.com> <20190227120859.GB10305@sigill.intra.peff.net>
In-Reply-To: <20190227120859.GB10305@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 27 Feb 2019 09:23:33 -0500
Message-ID: <CAPig+cRJZBvwsptPOzx3oPSOnt6+uGLoyOr_JbUnku4kdSwdgA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] worktree add: sanitize worktree names
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        hi-angel@yandex.ru, Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 7:09 AM Jeff King <peff@peff.net> wrote:
> On Tue, Feb 26, 2019 at 05:58:51PM +0700, Nguyễn Thái Ngọc Duy wrote:
> > Update 'worktree add' code to remove special characters to follow
> > these rules. The code could replace chars with '-' more than
> > necessary, but it keeps the code simple. In the future the user will
> > be able to specify the worktree name by themselves if they're not
> > happy with this dumb character substitution.
>
> So notably this gets around ".." and ".lock" by just disallowing "."
> entirely. I think I'm OK with that for worktrees. It does make me a
> little nervous to see this new public function, though:
>
> > +int char_allowed_in_refname(int ch) [...]
>
> because it's not entirely accurate, as you noted above. I wonder if we
> could name this differently to warn people that the refname rules are
> not so simple.
>
> If we just cared about saying "is this worktree name valid", I'd suggest
> actually constructing a sample refname with the worktree name embedded
> in it and feeding that to check_refname_format(). But because you want
> to actually sanitize, I don't think there's an easy way to reuse it.
>
> So this approach is probably the best we can do, though I do still think
> it's worth renaming that function (and/or putting a big warning comment
> in front of it).

The above arguments seem to suggest the introduction of a companion to
check_refname_format() for sanitizing, perhaps named
sanitize_refname_format(), in ref.[hc]. The potential difficulty with
that is defining exactly what "sanitize" means. Will it be contextual?
(That is, will git-worktree have differently sanitation needs than
some other facility?) If so, perhaps a 'flags' argument could control
how sanitization is done.
