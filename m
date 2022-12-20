Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67CAC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 23:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbiLTX3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 18:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLTX3m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 18:29:42 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D03C1DA72
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 15:29:41 -0800 (PST)
Date:   Tue, 20 Dec 2022 23:29:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1671578979; x=1671838179;
        bh=iuNjeLPE6icyDVMk0E9/Thz3uQogkpGO28PiKds/kC8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=1VOkaOY9DN/26FOYbApr27qBDrsIT20wnq8bDucNzrr+ONgjAC0IR+e+nM7p+rftj
         +hw9x62ZT1yXFuGn7wvbGW+xDRkFG1kNxd7teg7eLykqKRWcRDYfIPH4av6rvJolty
         0YXPpwSoono/KAN7OLnfdnhZC87ZrSwYSmLvAvifDvytaIOuWjuw3bKElcq8g4stF6
         9xBP1o/wN3rDSg+1ylatNFM1hWv/kVT3rtSIrs4NT2Lh3arbMp8yeFVsPvCeYeA57R
         n5UBNZ1uFSTY1ZVGTjW/mFrkz7EpnhvZIi+vzb+MmjqJUIDJGF29VtcAtbEYRaCbYx
         IZT9qt0wVLvAA==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v5 2/4] worktree add: refactor opt exclusion tests
Message-ID: <20221220232920.wppkxkvuxkcoih4x@phi>
In-Reply-To: <xmqqsfhawwqf.fsf@gitster.g>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221220023637.29042-3-jacobabel@nullpo.dev> <xmqqsfhawwqf.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/20 01:00PM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
>
> > Pull duplicate test code into a function so that additional opt
> > combinations can be tested succinctly.
> >
> > Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> > ---
> >  t/t2400-worktree-add.sh | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
>
> OK.
>
> > +# Helper function to test mutually exclusive options.
> > +test_wt_add_excl() {
>
> Have SP on both sides of (), i.e.
>
> =09test_wt_add_excl () {

Done.

>
> > +=09local opts=3D"$@" &&
> > +=09test_expect_success "'worktree add' with '$opts' has mutually exclu=
sive options" '
> > +=09=09test_must_fail git worktree add $opts
> > +=09'
> > +}
>
> In this particular case with the given arguments, it does not make a
> difference, but make it a habit to think twice if "$*" is what you
> want when you write "$@".  "$@" does a lot more than just concatenate
> $1, $2, ... with SP in between, and the use of $opts in the message
> merely wants the "concatenate with SP" behaviour, which is what "$*"
> is for.

Understood.

>
> I actually would write the above if I were doing this patch:
>
>     test_wt_add_excl () {
> =09test_expect_success "'worktree add' with $* has mutually exclusive opt=
ions" '
> =09=09test_must_fail git worktree add "$@"
> =09'
>     }
>

Changed.

> Notice the use of "$@" on the "git worktree add" invocation?  This
> allows callers of test_wt_add_excl pass parameters with SP in it,
> thanks to the magic "$@".  Again, as I said earlier, for these
> callers ...
>
> > +test_wt_add_excl -b poodle -B poodle bamboo main
> > +test_wt_add_excl -b poodle --detach bamboo main
> > +test_wt_add_excl -B poodle --detach bamboo main
>
> ... the distinction does not matter, but
>
>     helper --lock --reason "my reason with multiple words" bamboo main
>
> must be written with "$@", like so:
>
>     helper () {
> =09git worktree add "$@"
>     }
>
> not
>
>     helper () { # BAD
> =09local opt=3D"$@"
> =09git worktree add $opt
>     }
>
> $opt in this case is a SP-concatenated string
>
> =09opt=3D"--lock --reason my reason with multiple words bamboo main"
>
> and passing it without quotes around it to "git worktree add"
> will give only "my" as the parameter to the option "--reason",
> with three extra words on the comand line.

This makes sense. I'm not the best with shell scripting so I appreciate
the explanation.

