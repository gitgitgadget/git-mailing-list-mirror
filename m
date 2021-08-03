Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9325DC4320A
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 21:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A62960F56
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 21:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhHCV3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 17:29:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58290 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhHCV3I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 17:29:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 24684147DD9;
        Tue,  3 Aug 2021 17:28:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6y6Je+OYqxSF
        sAEJG3GEQir+Ny9rOsxwagNciCnK2u0=; b=qmXgMWQhrTcIJLwu5ag7cYTngJDa
        IyumjN+HZ+L9ceTQxRffV9vEq71t1DIdH1jc+l0BxxSnEziIH6+tDQC3LZ+Jvnh4
        8BXy6EN9xVyaW+u6G7MGOcZUiHB2u7XF/60clmv/WrWGaXw3BV65RD86jEebku+O
        ZRRTTntOmH68U10=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D825147DD8;
        Tue,  3 Aug 2021 17:28:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 40728147DD7;
        Tue,  3 Aug 2021 17:28:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2] clone: Allow combining --bare and --origin
References: <8735rsqlal.fsf@evledraar.gmail.com>
        <20210802174944.53745-1-oystwa@gmail.com>
Date:   Tue, 03 Aug 2021 14:28:52 -0700
In-Reply-To: <20210802174944.53745-1-oystwa@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
        message of "Mon, 2 Aug 2021 19:49:44 +0200")
Message-ID: <xmqqv94mtdyj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CDB135A4-F4A1-11EB-860A-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=98ystein Walle <oystwa@gmail.com> writes:

> The constraint on passing both these options simultaneously has been
> present since long before clone was ported to C. At the time no
> configuration referencing the remote repository was written at all in
> bare clones.
>
> Since df61c88979 (clone: also configure url for bare clones, 2010-03-29=
)
> the remote repository is mentioned in the configuration file also for
> bare repos, so it makes sense to allow the user to rename it if they
> wish.

Sounds sensible.

> =C3=86var, I was a bit melodramatic when I wrote "especially useful". I=
 have
> toned the commit message down a bit :-) In truth, I don't personally
> have a use-case for this (I did reach out to the person who asked about
> it in #git but did't get a reply) and have no problems with seeing this
> patch ultimately rejected. It's just a result of me seeing it asked
> about and getting an itch from it. But in my humble opinion this is now
> an "artificial" constraint (for lack of a better term) and should be
> removed on the grounds that there is no reason for it to be there in th=
e
> first place.

Yup, that is exactly my thought when I responded to your v1.

> +test_expect_success '--bare works with -o/--origin' '
> +	git clone --bare --origin=3Dsomewhere parent clone-bare &&
> +	url=3D"$(git -C clone-bare config --local remote.somewhere.url)" &&
> +	test -n "$url" &&
> +	test_must_fail git -C clone-bare config --local remote.origin.url
>  '

It is somewhat unfortunate that we do not say what the name of the
"origin" is anywhere in the resulting configuration file.  The only
way to tell that "--origin somewhere" was used is to notice that
there is only one remote and its name is "somewhere".  Instead of
"usually the thing is called 'origin', so let's make sure it does
not exist", we may want to say "there is only one remote and it is
called somewhere because that is how we named it", i.e.

	git -C clone-bare config --name-only \
		--get-regexp "remote\..*\.url" >actual &&
	echo remote.somewhere.url >expect &&
	test_cmp actual expect

But stepping back a bit, I think this shows another reason why use
of '--origin' with '--bare' as-is may not be so pleasant to use.

In a repository _with_ working tree, this lack of "what is 'origin'
called in this repository?" is not a problem because you'd get these
after cloning:

    [remote "somewhere"]
	url =3D ...
	fetch =3D ...
    [branch "master"]
	remote =3D "somewhere"
	merge =3D refs/heads/master

You can say "git fetch" or "git pull" without the remote name and we
will know which remote to interact with, because our branch knows
which remote to fetch from.

In a bare repository, however, you only get this:

    [remote "somewhere"]
	url =3D ...

I do not think "git fetch" in such a repository knows that it needs
to fetch from 'somewhere', even whe it is the only remote repository
available to us.

We may need a bit _more_ work (e.g. leave an optional configuration
remote.originName =3D "somewhere" when "--bare --origin somewhere" is
used, and teach "git fetch" to pay attention to it, instead of
assuming 'origin') before "--bare --origin somewhere" becomes truly
usable.  And I suspect that "git fetch" is not the only one that
needs such "fix".
