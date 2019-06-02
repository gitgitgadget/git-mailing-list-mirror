Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EF6B1F462
	for <e@80x24.org>; Sun,  2 Jun 2019 07:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfFBHH5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 03:07:57 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:36380 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfFBHH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 03:07:56 -0400
Received: by mail-ua1-f51.google.com with SMTP id 94so5386354uam.3
        for <git@vger.kernel.org>; Sun, 02 Jun 2019 00:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h683FC4S5lyJ6047H1RbK6fOXJMFXdmTv184ut8iEes=;
        b=HnfdjXqLZxChDMJMjD6BCNUWGNna0z3O2BoQZXpkyzIuVW17HsMr8TyuvsCj88mKNw
         7SZX6bXf3pCdq64b1fVog4WLfjayrv5yBepWIPfc7apyhgkOhkLgaExo1zCDhFPmZs9g
         v1KbvpPxf838xS9Q76MbkOWLGhjuIRXEliTt0d4RmUcE5IQatO7aMx3QXN0eNoJgOxcm
         2lDNIlTlkDkl+zEopfGo43eAW7FRyBu6zVoTJRXM5/togy48yzzvk8npuDaopYmaKFx5
         5rRP7jfhKQoT6GehapOK//1BgauSrlg+UYAVaJGKoLR2EHglqj6hgh/QRcLRFVDZ5jr7
         TEOg==
X-Gm-Message-State: APjAAAU79kd6hq8loSEZRY3a4xJGeiKCgewlgaoykDMTO7RbL/JsV4my
        d+iR26qBPyZZ11pxwY/isc5Ow4cldBAFrYDxxmA=
X-Google-Smtp-Source: APXvYqx3Vb7sOTsPpMhH9gv6A2pwPvyCljU91Btp2c/5Mnd1GqwlklydvjTt3wqDMfAoFF28Py/KFE1wga+YaVSX0yo=
X-Received: by 2002:ab0:b87:: with SMTP id c7mr3522655uak.101.1559459275635;
 Sun, 02 Jun 2019 00:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <ad2ff81a-d75e-1ac4-07d0-c807a2ed9e36@gmx.de>
In-Reply-To: <ad2ff81a-d75e-1ac4-07d0-c807a2ed9e36@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 2 Jun 2019 03:07:45 -0400
Message-ID: <CAPig+cSsNQDe-3GLnmvA+EPior=RSPETJDjkCc7X1qi6gWSGDQ@mail.gmail.com>
Subject: Re: worktree add already exists
To:     Ingo Wolf <ingo.wolf@gmx.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 27, 2019 at 11:32 AM Ingo Wolf <ingo.wolf@gmx.de> wrote:
> $ ls -a barework
> ./  ../  test.txt
> $ git -C bare worktree add --no-checkout ../barework
> Preparing worktree (new branch 'barework')
> fatal: '../barework' already exists
> $ git -C bare branch
>    barework
> * master
> Why this doesn't just work and if not why is barework branch made then,
> why at all ?

It is by design that "git worktree add" (in general) fails if the
target directory already exists and is non-empty. This is consistent
with how "git clone" behaves. As for why your particular use-case
isn't directly supported, it's likely that nobody has yet asked for
it, and nobody thought about this particular case when --no-checkout
was added (which came some time after basic "git worktree add" itself
was implemented).

It is an accident of implementation that the new branch gets created
before "git worktree add" errors out due to the existing non-empty
directory (and, likely, nobody complained about it, so it went
unnoticed). This particular issue probably can be easily fixed now
that the logic for checking if the target directory can be a valid
worktree has been factored out of the code which actually creates the
new directory[1].

[1]: 45059e6468 (worktree: prepare for more checks of whether path can
become worktree, 2018-08-28)

> I would like to attach an existing dir to git (make it a workdir) and
> then update the index with git reset and checkin the differences.

I haven't thought through the possible ramifications, but the actual
implementation might be as simple as changing this code in
builtin/worktree.c:validate_worktree_add():

    if (file_exists(path) && !is_empty_dir(path))
        die(_("'%s' already exists"), path);

to:

    if (opts->checkout && file_exists(path) && !is_empty_dir(path))
        die(_("'%s' already exists"), path);

or something.
