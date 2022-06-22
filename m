Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB22EC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 16:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359864AbiFVQC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 12:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359269AbiFVQCx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 12:02:53 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9848C6
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:02:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 24A951AA47C;
        Wed, 22 Jun 2022 12:02:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Mwwg3ewUS0rL
        ryE/w1K+LPNZzo76ZnHt5zOiKlj7Dbc=; b=tJhEDBuxtvvbrk4zTlEUDshgrEKN
        wuZCDQGBlT0mkeO4DFen0J/x/7Kt6OeG6ZWZzcBy8IV0UWIZEydRSEzbQFQm+/2P
        CfK2tc1xmCqPA5WAJPCtvX2AnXn0442JLeHj2rjXI8+mYenlMr/mK3TwlNOs9UIr
        rstaxX1IKIBjjyg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C41E1AA47B;
        Wed, 22 Jun 2022 12:02:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AC4D91AA479;
        Wed, 22 Jun 2022 12:02:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] cocci: add and apply a rule to find "unused"
 variables
References: <patch-1.1-7d90f26b73f-20220520T115426Z-avarab@gmail.com>
        <cover-v2-0.2-00000000000-20220621T223954Z-avarab@gmail.com>
        <patch-v2-1.2-d14036521ab-20220621T223954Z-avarab@gmail.com>
Date:   Wed, 22 Jun 2022 09:02:45 -0700
In-Reply-To: <patch-v2-1.2-d14036521ab-20220621T223954Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 22 Jun
 2022 00:44:02
        +0200")
Message-ID: <xmqqsfnw65zu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C1F25602-F244-11EC-897E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +identifier INIT_ASSIGN1 =3D~ "^get_worktrees$";
> +// strbuf_init(&I, ...) etc.
> +identifier INIT_CALL1 =3D~ "^[a-z_]*_init$";
> +// stbuf_release(), string_list_clear() etc.

strbuf?

> +identifier REL1 =3D~ "^[a-z_]*_(release|clear|free)$";
> +// release_patch(), clear_pathspec() etc.
> +identifier REL2 =3D~ "^(release|clear|free)_[a-z_]*$";
> +@@

I am hesitant to see this broad set of patterns that could match
init/release functions (and possible false positive matches).

Especially given that it ended up finding only 4 instances, all of
the same "STRBUF_INIT" followed by "strbuf_release()", which means
that all other possible matches, when they actually are found, will
be seen by developers who are not necessarily familiar with these
rules before they are inspected by those who are for correctness.

It would be nice to have a step that catch only strbuf_init(),
STRBUF_INIT, strbuf_release(), and nothing else, possibly with
another step with concrete function names, with other "presumably
functions whose name match this loose pattern are all release
functions" patterns in a separate follow-up patch so that the last
one can easily be reverted.

> +// .. A declaration like "struct strbuf buf;"...
> +(
> +- T I;
> +// ... or "struct STRBUF buf =3D STRBUF_INIT;" ...
> +|
> +- T I =3D INIT;
> +)

Presumably, if either of the above followed by foo_release(I) should
be caught, then we should catch "T I =3D { 0 };" followed by a release
as well.  Initialization "T I =3D { 1, };" for a type without _INIT
macro is also the same story.

Given that, do we even need to limit the forms of declaration?  The
only thing we care about is that I is new in this scope, and I is
not used otherwise, in a way other than (1) calling _init() function
on it, or (2) calling _release() function on it, before leaving the
scope, right?

Thanks.
