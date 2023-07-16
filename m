Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2BDC0015E
	for <git@archiver.kernel.org>; Sun, 16 Jul 2023 02:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjGPC4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jul 2023 22:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPC4I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2023 22:56:08 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3631C197
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 19:56:06 -0700 (PDT)
Date:   Sun, 16 Jul 2023 02:55:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1689476163; x=1689735363;
        bh=PxbIT2sbO8Pi6zKMTxA9KopUSacU1xVzjenLErcALes=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=F0gk101P8HalKoStzY2CUktuEc3Lq5shHi0zR/yP6rD/ecLFfR2GzhJyDhWT8inPr
         hNRLxeQqgTdb+zRTvuAYNBQbxxKdrZjrxhOgNDH/ZhdJ57+GhUJV0fUEXjfY9LS2um
         Ri8lbDjMxGzORVjueoNIdobTuvX2bh/slSZOEUMLOkR34MY55/AtckZ4SBZg+9ROTH
         +9lW2qJES9+mpH3el3WGfEXgntYQ2JDGLjUhxP7DbJzWIYourR3c9vkuIj9/x6UMUi
         Y3Oid4+LObJrO5C55Qnoi6z89QDaKpUNKISO55ScJwAVjlaR1L1N8LQFcUZXJXEzLl
         7Rmcu6LxRf6Ow==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [PATCH] t2400: Fix test failures when using grep 2.5
Message-ID: <bj27nq5aputhd66rkqer37vuc7qogpmn6nqyusladdy4k5it7k@u3yvvivrixsy>
In-Reply-To: <xmqqilakll2m.fsf@gitster.g>
References: <20230715025512.7574-1-jacobabel@nullpo.dev> <2e22a23f-576f-7a42-ace8-624a5362d9f4@gmail.com> <vn5sylull5lqpitsanlyan5fafxj5dhrxgo6k65c462dhqjbno@uwghfyfdixtk> <xmqqilakll2m.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/07/15 06:08PM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
>=20
> >> > @@ -998,8 +998,8 @@ test_dwim_orphan () {
> >> >   =09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --sq --path-=
format=3Dabsolute --git-path HEAD) &&
> >>
> >> I'm a bit confused by the --sq here - why does it need to be shell
> >> quoted when it is always used inside double quotes?
> >
> > To be honest I can't remember if this specifically needs to be in
> > quotes or not however I had a lot of trouble during the development of
> > that patchset with things escaping quotes and causing breakages in the
> > tests so if it isn't currently harmful I'd personally prefer to leave
> > it as is.
>=20
> Quoting is sometimes tricky enough that "this happens to work for me
> but I do not know why it works" is asking for trouble in somebody
> else's environment.  If the form in the patch is correct, but tricky
> for others to understand, you'd need to pick it apart and document
> how it works (and if you cannot do so, ask for help by somebody who
> can, or simplify it enough so that you can explain it yourself).

Yes Apologies. That was kind of a cop-out on my part as I was hesitant
to add additional changes that could potentially introduce new issues
to this patch as it is already addressing a fairly obscure issue.

>=20
>     headpath=3D$(git $dashc_args rev-parse --sq --path-format=3Dabsolute =
--git-path HEAD) &&
>=20
> In this case, "--sq" is a noop that only confuses readers, I think,
> and I would drop it if I were you.  "--git-path HEAD" is given by
> this call chain:
>=20
>    builtin/rev-parse.c:cmd_rev_parse()
>    -> builtin/rev-parse.c:print_path()
>       -> transform path depending on the path format
>          -> puts()
>=20
> and nowhere in this chain "output_sq" (which is set by "--sq") is
> even checked.  The transformations are all about relative, prefix,
> etc., and never about quoting.

Understood. I tried running it with `--sq` removed and it seems to
work as you and Phillip expected so I'm adding that to v2.

>=20
> The original test script t2400 (before your patch) does look crappy
> with full of long lines and coding style violations (none of which
> is your fault), and it may need to be cleaned up once this patch
> settles.
>=20
> Thanks.

I may give that cleanup a shot some time down the line if nobody else
takes a crack at it first.

