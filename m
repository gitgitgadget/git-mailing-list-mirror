Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107D6C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 13:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356173AbiFVNXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 09:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356294AbiFVNXV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 09:23:21 -0400
X-Greylist: delayed 24075 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Jun 2022 06:23:16 PDT
Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B976E3334E
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 06:23:16 -0700 (PDT)
Date:   Wed, 22 Jun 2022 13:23:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1655904193; x=1656163393;
        bh=p/+iypaikVA55YyvvOyBpPkFZLJUvzGR77vSHBqVw1I=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=J0EHzyUtvMjp+6o966xYBoZkIMqaUOHpCUAg/7xcV+oyvAQm8Ga5AmF4tG37sJwKq
         3ceFK9i9rE+fRFYzEHqA/Pb/5sKpv45/SvVx7iiqDq4mZMOf/mcuBF1pPKdGTsxf4r
         CFXgKLo890XObRgkVwJM5sgRVn6i32pjizra66LyPevDBL1+EzIxr93ykqoOFAmTud
         zynxbd97kcRJ3rydaUT2NnczjIAwMIFrUxTTZeb9cvNCgkjpUSvwyDgfTYWuExOVEf
         hrEC51DCaLH3TPFx/kQ4kv9chwzxU977DaPbyUYNCULUSO1GFUmwkGx23fyYcwVxvn
         m8Hj08tzh2KpQ==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   "Carlos L." <00xc@protonmail.com>
Cc:     "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?Martin_=C3=85gren_=5B_=5D?= <martin.agren@gmail.com>,
        "Paul Eggert [ ]" <eggert@cs.ucla.edu>
Reply-To: "Carlos L." <00xc@protonmail.com>
Subject: Re: [PATCH v2] grep: add --max-count command line option
Message-ID: <ScVk65a3K94G-nmKXyUBKC94xIjYgn-W1kSJyb3DasKtGFF0rDJyOkZMmcnVyNH60I717KpBBN83QuMXHuIAYfbmQdxX2Woiw62m0QM6AdE=@protonmail.com>
In-Reply-To: <220622.86mte5knbe.gmgdl@evledraar.gmail.com>
References: <pull.1278.git.git.1655740174420.gitgitgadget@gmail.com> <pull.1278.v2.git.git.1655789777023.gitgitgadget@gmail.com> <220622.86mte5knbe.gmgdl@evledraar.gmail.com>
Feedback-ID: 24333956:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wednesday, June 22nd, 2022 at 12:22, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son <avarab@gmail.com> wrote:

> On Tue, Jun 21 2022, Carlos L. via GitGitGadget wrote:
>
> > From: =3D?UTF-8?q?Carlos=3D20L=3DC3=3DB3pez?=3D 00xc@protonmail.com
> >
> > This patch adds a command line option analogous to that of GNU
> > grep(1)'s -m / --max-count, which users might already be used to.
>
>
> Thanks, this seems useful.
>
> > This makes it possible to limit the amount of matches shown in the
> > output while keeping the functionality of other options such as -C
> > (show code context) or -p (show containing function), which would be
> > difficult to do with a shell pipeline (e.g. head(1)).
>
>
> We start multi-threaded grep workers, how does this code handle races
> between them finding things, this count being incremented, and the "do
> we have sufficient results?" check?
>
> Is it guarded by the relevant mutexes?

AFAICT only a single thread runs on each file via grep_source_1(), and we c=
heck `count`, which is local to this function.

> > + /*
> > + * Optimize out the case where the amount of matches is limited to zer=
o.
> > + * We do this to keep results consistent with GNU grep(1).
> > + */
> > + if (opt.max_count =3D=3D 0)
> > + exit(EXIT_FAILURE);
>
>
> Don't use exit() in cmd_grep(), you should use "return 1".

I'll use return in my follow-up patch, this can be improved afterwards.

> But even better use usage_msg_opt() here, i.e. inform the user why this
> was bad.
>
> Or hrm, it seems GNU grep silently returns 1 here, perhaps --max-count=3D=
0
> is a feature for some?
>
> If this is intentional it's worth documenting and testing it explicitly.

I will add a sentence about this in Documentation/git-grep.txt.

> Re the comments from others about size_t or whatever, it might be better
> here to use OPT_CALLBACK and an unsigned type.
>
> Then just have a "int have_max_count:1", which IMO is more obvious than
> using integer wrap-around to test "didn't provide this flag".

FWIW, I think it's fine to use int and a negative value as an special encod=
ing, max_depth does the same thing. These are per-file matches, so they sho=
uld not go over 2 billion in reasonable use cases.
