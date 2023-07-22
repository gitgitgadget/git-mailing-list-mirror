Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617F2EB64DD
	for <git@archiver.kernel.org>; Sat, 22 Jul 2023 02:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjGVCgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 22:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGVCgf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 22:36:35 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE30ED
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 19:36:32 -0700 (PDT)
Date:   Sat, 22 Jul 2023 02:36:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1689993390; x=1690252590;
        bh=BK8cQ2R5YLxnPyW7wVcqDXY+ui5Z8pbff3w6G/2O0TU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=r29Ip5iXlx2JrQ9Y7ljj751enH0eaaZg5x86UfB9k74mKv22rFDDYy8XlXyX17hFQ
         2My3lLHksjIaThk8iP6buwfutrT4oO2Pv772kBMosqvTnC/VQ5rCov2mFinEM/KW38
         8LGWWx2s9T4SY4UedIg8VEOHb2nQOdjOWohzdvr/xVPTKNkGgL9JqgoUVi+NjrNuU5
         GwchbEQk9U8KcpUYgMq0vEl/JvnpdlcPBksR6YX1eW3cbefnyen4xtthdyFFCnu0vd
         NDvOht5y6DT9iQoFguAvBanqXPrOVBu9s84vFNzToQcJyABoN4WCJGLWHQGIUAAgzQ
         0M8dPgWJlvyuA==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 3/3] t2400: rewrite regex to avoid unintentional PCRE
Message-ID: <axnxvnmo6ekhhccppinji73ivlandwuqs44epmq4pdefm7ukiv@ejz7bee5xjli>
In-Reply-To: <xmqqv8edwb0k.fsf@gitster.g>
References: <20230715025512.7574-1-jacobabel@nullpo.dev> <20230716033743.18200-1-jacobabel@nullpo.dev> <20230721044012.24360-1-jacobabel@nullpo.dev> <20230721044012.24360-4-jacobabel@nullpo.dev> <xmqqv8edwb0k.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/07/21 08:16AM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
>=20
> > Replace all cases of `\s` with ` ` as it is not part of POSIX BRE or ER=
E
> > and therefore not all versions of grep handle it without PCRE support.
>=20
> Good point.  But the patch replaces them with "[ ]" instead, which
> probably is not a good idea for readability.

Using `[ ]` over ` ` is just a personal thing I picked up to keep
myself from forgetting the space was intentional. I can see how that
can come across as confusing though so I'll make sure to update that.

> Technically speaking, there is no regular expression library that
> supports PCRE per-se; treating \S, \s, \d and the like the same way
> as PCRE is a GNU extension in the glibc land, and a simlar "enhanced
> mode" can be requested by passing REG_ENHANCED bit to regcomp(3) at
> runtime in the BSD land including macOS.  I would suggest just
> dropping "without PCRE support" for brevity, as "not all versions of
> grep handle it" is sufficient here.

Good point. Will do.

> [...]
>=20
> Just a single space would be fine without [bracket].  I think older
> tests use (literally) HT and SP inside [], many of them may still
> survive.

Noted.

> > @@ -709,7 +709,7 @@ test_dwim_orphan () {
> >  =09local info_text=3D"No possible source branch, inferring '--orphan'"=
 &&
> >  =09local fetch_error_text=3D"fatal: No local or remote refs exist desp=
ite at least one remote" &&
> >  =09local orphan_hint=3D"hint: If you meant to create a worktree contai=
ning a new orphan branch" &&
> > -=09local invalid_ref_regex=3D"^fatal: invalid reference:\s\+.*" &&
> > +=09local invalid_ref_regex=3D"^fatal: invalid reference: .*" &&
>=20
> Feeding "<something>\+" to BRE (this pattern is later used with
> 'grep' but not with 'egrep' or 'grep -E') and expecting it to mean 1
> or more is a GNU extension,=20

Oh it is. I've really gotta reread the chapters of the POSIX standard
on regex again.

> and in this case "there must be a SP
> after colon" is much easier to see, which is what the updated one
> uses.  Good.
>=20
> By the way, you can drop the ".*" at the end of the pattern, because
> the match is not anchored at the tail end.

Understood.

> >  =09local bad_combo_regex=3D"^fatal: '[a-z-]\+' and '[a-z-]\+' cannot b=
e used together" &&
>=20
> This should also be corrected, I think.
>=20
> =09"fatal: '[a-z-]\{1,\}' and '[a-z-]\{1,\}' cannot be used together"
>=20
> or even simpler,
>=20
> =09"fatal: '[a-z-]*' and '[a-z-]*' cannot be used together"
>=20
> to avoid \+ in BRE (see above). =20

I definitely prefer the latter so I'll update it to use that one.

> "[-a-z]" (to show '-' at the
> beginning) may make it easier to read by letting the hyphen-minus
> stand out more, as we know we are giving two command line option
> names and in a command line option name, the first letter is always
> hyphen-minus.  But that is more of personal taste, not correctness.

Certainly a matter of personal preference but I can see why this
could be preferable so I'll update it to this.

> [...]

