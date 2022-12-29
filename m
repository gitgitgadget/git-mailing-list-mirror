Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50EDC3DA7A
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 20:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiL2UtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 15:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiL2UtL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 15:49:11 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3CD2C1
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 12:49:07 -0800 (PST)
Date:   Thu, 29 Dec 2022 20:48:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1672346945; x=1672606145;
        bh=tvnhIXCevrHAgpvF+wblJPWBXUMoyd3sdQ+hbj2DEg0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=jkNfCWfLBWp3gN+/fI8Y8oshvJTTXkXhT60Oxk1QSdK+m7VyzJUzNsQqOXOnxDqCr
         1A7OXhDNSNFw1XxirGQkWyT/89dA0tdb0UqnqARLz+MDO+qn5LkoQaTkSKMZaZgxBv
         CdJ5X7hwchv4SQ9cmcWO3Ec5pZDs+xJlIRLaeyubRGV5QkY/bYtySgQw7tFNp1XAcC
         J8g94FOv0RovWniuEAkXumZac1rpRudpWmrFQwNKyEeuS/5i/r5iP/0fTqian1Xiiy
         jbUY1R5d2yTyTyLhdB8HMkhzMRc30OVBWVjG+48w+7t3udcoDuUfZDMdgU+fLTSSZA
         Imdp9dtpyVSGA==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v6 2/4] worktree add: refactor opt exclusion tests
Message-ID: <20221229204841.ol3r6z2pfrodv7yx@phi>
In-Reply-To: <xmqqa636mskf.fsf@gitster.g>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev> <20221228061539.13740-3-jacobabel@nullpo.dev> <xmqq5ydvpu1o.fsf@gitster.g> <20221229065142.fmfviwisjmxsey7b@phi> <xmqqa636mskf.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/29 07:07PM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
>
> > Yes for these particular tests that should be acceptable. I tried putti=
ng an
> > alternative together that still provides an avenue for handling quoted
> > arguments without the helper [1]. Would this work?
> >
> > 1. https://lore.kernel.org/git/20221229063823.ij3jjuaar2fsayju@phi/
>
> Do we even need to handle an argument with $IFS whitespaces in it in
> these tests?

No. I was trying to make the change because you had suggested a change in t=
he
last revision [2].

>
> If not, using "$@" where we pass the args to the commands we run,
> and using "$*" where we merely use it for human readable messages,
> would be sufficient.
>

We can't do this because it causes all the existing tests using these funct=
ions
to fail.

---

The diff I showed in [1] passes all the tests and those two tests with quot=
ed
strings were only temporarily added to illustrate that this works. They wou=
ld be
removed from the code prior to the v7 patch.

---

From that diff, we can change $* to $@ (or any quoted variation of $@) such=
 as below:

 test_wt_add_excl () {
 =09test_expect_success "'worktree add' with $* has mutually exclusive opti=
ons" "
-=09=09test_must_fail git worktree add $* 2>actual &&
+=09=09test_must_fail git worktree add \"$@\" 2>actual &&
 =09=09grep -P 'fatal:( options)? .* cannot be used together' actual
 =09"
 }

however this results in the tests failing with:

=09error: bug in the test script: not 2 or 3 parameters to test-expect-succ=
ess

---

If we change back to single quotes and use "$@":

  test_wt_add_excl () {
-=09test_expect_success "'worktree add' with $* has mutually exclusive opti=
ons" "
-=09=09test_must_fail git worktree add $* 2>actual &&
-=09=09grep -P 'fatal:( options)? .* cannot be used together' actual
-=09"
+=09test_expect_success "'worktree add' with $* has mutually exclusive opti=
ons" '
+=09=09test_must_fail git worktree add "$@" 2>actual &&
+=09=09grep -P "fatal:( options)? .* cannot be used together" actual
+=09'
 }

then the tests fail because test_expect_success changes $@ to its own argum=
ents
and the line:

=09test_must_fail git worktree add "$@" 2>actual &&

expands into:

=09test_must_fail git worktree add '
=09=09=09test_must_fail git worktree add "$@" 2>actual &&
=09=09=09grep -P "fatal:( options)? .* cannot be used together" actual
=09=09'

---

Alternatively we could do:

 test_wt_add_excl () {
-=09test_expect_success "'worktree add' with $* has mutually exclusive opti=
ons" "
-=09=09test_must_fail git worktree add $* 2>actual &&
+=09local opts=3D"$@" &&
+=09test_expect_success "'worktree add' with '$opts' has mutually exclusive=
 options" '
+=09=09test_must_fail git worktree add $opts 2>actual &&
 =09=09grep -P 'fatal:( options)? .* cannot be used together' actual
-=09"
+=09'
 }

which would also work however this would just be reverting to the v5
revision [3] where you left your orignal review [2]. This would be
essentually the same change that =C3=86var recommended [4].

---

So from my understanding of the situation, the only two options that pass a=
ll
the existing tests are either:

A: Use the diff in [1] without the two quote example tests included.

B: Revert the changes to how this was done in v5 [3].

Both of these options work with me however option A will allow test authors=
 to
easily escape quotes if new tests needed to be added at some point in the f=
uture.

1. https://lore.kernel.org/git/20221229063823.ij3jjuaar2fsayju@phi/
2. https://lore.kernel.org/git/xmqqsfhawwqf.fsf@gitster.g/
3. https://lore.kernel.org/git/20221220023637.29042-3-jacobabel@nullpo.dev/
4. https://lore.kernel.org/git/221228.868risuf5x.gmgdl@evledraar.gmail.com/

