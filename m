Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CA6C47089
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 03:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiLFDX2 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 5 Dec 2022 22:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiLFDX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 22:23:26 -0500
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D61FE090
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 19:23:25 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id f3so12247250pgc.2
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 19:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UUY7ePmRJgWrZTrT8N8NFiNAl+UtZDjGhDhd1j++WQ=;
        b=Y9E+1qbUsITSxjG1cw0WdSUiJBMJobYZuzsmCsJTrNg55emfD7LepHGcka6r8KaTH7
         ni4mBvF4gx/QbWW9+1516qOdZz1ZloaEEExiOQwjhPKO/4Ad2jnBNK8045vanLK0aoF0
         jFwApenZ2hCnAQ6szKauEr9A7LL4LP+RQ9L+1zQxB+PjDVu43DoojftV8STW6Ci3/Anh
         4wlPCwGVvENOVwCs8QMs72238nk0epfQodRojMI6rOl9JPLTqnx0A2swqsV0raRL8KBs
         ecwAxG/Mu60/fbkOzKuWimPPL7B5fvToGBoLnrvvG9GQND2MKhgMOhK/Ce463sId8kMx
         JGfQ==
X-Gm-Message-State: ANoB5plep3Pv3YuH5ZVj+lx+bdEH11BF2SEqVsEohHBZrvaOU8Bg2NyR
        lpxTEYxWrUO0Fu3AGcvqhvKxPvnG6ZHvIyl9PZE=
X-Google-Smtp-Source: AA0mqf6LcLLxyBqu+Py1uOtZEAJq1x6zcvC6GSGxQKhd4d33JT7Uz+02q/mQLqkGRDeBvBqhnAwnD0/HrTkF33F+mBI=
X-Received: by 2002:a63:d43:0:b0:477:66b9:341b with SMTP id
 3-20020a630d43000000b0047766b9341bmr60190685pgn.130.1670297004757; Mon, 05
 Dec 2022 19:23:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1425.git.1668999621.gitgitgadget@gmail.com>
 <97ada2a1202190776ce3989d3841dd47e2702316.1668999621.git.gitgitgadget@gmail.com>
 <221206.86ilipckms.gmgdl@evledraar.gmail.com>
In-Reply-To: <221206.86ilipckms.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Dec 2022 22:23:13 -0500
Message-ID: <CAPig+cSfvgu8XjvmmAkFWe1G1VDRgrcx5GjUhr4xSDqoJ4cZOA@mail.gmail.com>
Subject: Re: [PATCH 3/3] t1509: facilitate repeated script invocations
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 5, 2022 at 9:48 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Mon, Nov 21 2022, Eric Sunshine via GitGitGadget wrote:
> > t1509-root-work-tree.sh, which tests behavior of a Git repository
> > located at the root `/` directory, refuses to run if it detects the
> > presence of an existing repository at `/`. This safeguard ensures that
> > it won't clobber a legitimate repository at that location. However,
> > because t1509 does a poor job of cleaning up after itself, it runs afoul
> > of its own safety check on subsequent runs, which makes it painful to
> > run the script repeatedly since each run requires manual cleanup of
> > detritus from the previous run.
> >
> > Address this shortcoming by making t1509 clean up after itself as its
> > last action. This is safe since the script can only make it to this
> > cleanup action if it did not find a legitimate repository at `/` in the
> > first place, so the resources cleaned up here can only have been created
> > by the script itself.
> >
> > Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> > ---
> > +test_expect_success 'cleanup root' '
> > +     rm -rf /.git /refs /objects /info /hooks /branches /foo &&
> > +     rm -f /HEAD /config /description /expected /ls.expected /me /result
> > +'
>
> Perhaps it would be nice to split this into a function in an earlier
> step, as this duplicates what you patched in 2/3. E.g.:
>
>         cleanup_root_git_bare() {
>                 rm -rf /.git
>         }
>         cleanup_root_git() {
>                 rm -f /HEAD /config /description /expected /ls.expected /me /result
>         }
>
> Then all 3 resulting users could call some combination of those.

I did something like that originally but decided against it in the
end, and went with the simpler "just clean up everything we created"
despite the bit of duplicated cleanup code. After all, this is only a
tiny bit of duplication in a script filled with much worse: for
instance, the `test_foobar_root`, `test_foobar_foo`, and
`test_foobar_foobar` functions are filled with copy/paste code -- not
to mention having rather poor names. So, considering that the script
is probably in need of a major overhaul and modernization at some
point anyhow[1], and because I simply wanted to get the script back
into a working state, I opted for minimal changes.

[1]: That's assuming anyone even cares enough to clean this script up.
It's clearly neglected; the breakage addressed by this series has gone
unnoticed for many months.

> This is an existing wart, but I also wondered why the "expected",
> "result" etc. was needed. Either we could make the tests creating those
> do a "test_when_finished" removal of it, or better yet just create those
> in the trash directory.
>
> At this point we've cd'd to /, but there doesn't seem to be a reason we
> couldn't use our original trash directory for our own state.
>
> The "description" we could then git rid of with "git init --template=".
>
> We could even get rid of the need to maintain "HEAD" etc. by init-ing a
> repo in the trash directory, copying its contents to "/", and then we'd
> know exactly what we needed to remove afterwards. I.e. just a mirror of
> the structure we copied from our just init-ed repo.

Fodder for an eventual overhaul, I suppose.

> But all that's a digression for this series, which I think is good
> enough as-is. I just wondered why we had some of these odd looking
> patterns.

Thanks for reading through the patches.
