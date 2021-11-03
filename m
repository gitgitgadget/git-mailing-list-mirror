Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B4DC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 18:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6F661053
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 18:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhKCSYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 14:24:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62497 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhKCSX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 14:23:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 107F5F413A;
        Wed,  3 Nov 2021 14:21:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/HJcI8dkp2QP
        W6mXUFKtC+l6DFiAcAGAUhMBe567p4A=; b=qWSo73qA8jpfUQ/asqGJ3+bLYj30
        Jj99/vC8KXAFlWhC3eJ4JfuUaElp4mh+KWnp0b5m6y+J60da/TGm9raKDL9Tu+XN
        9ybYs8YPIp4B/ZI7/R9+jOeb7xuXPJnv2UzHJfPmOt9oeLuyzGEaSyywZ/KkTPFL
        85t7n0+wPQKVQjA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07946F4139;
        Wed,  3 Nov 2021 14:21:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2AC7DF4137;
        Wed,  3 Nov 2021 14:21:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] var: add GIT_DEFAULT_BRANCH variable
References: <nycvar.QRO.7.76.6.2111021433010.56@tvgsbejvaqbjf.bet>
        <20211102164434.1005707-1-thomas@t-8ch.de>
Date:   Wed, 03 Nov 2021 11:21:17 -0700
In-Reply-To: <20211102164434.1005707-1-thomas@t-8ch.de> ("Thomas
 =?utf-8?Q?Wei=C3=9Fschuh=22's?=
        message of "Tue, 2 Nov 2021 17:44:34 +0100")
Message-ID: <xmqqa6il6qxu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D72444D6-3CD2-11EC-AED6-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> writes:

> Introduce the builtin variable GIT_DEFAULT_BRANCH which represents the

"builtin" -> "logical", as that is how "git-var" describes these things.

It is totally outside the scope of this patch, but I think we'd
better think of a way to make it clear to the readers of the
documentation that it would not do anything if they did something
like:

    $ GIT_DEFAULT_BRANCH=3Dfoobar git init

I say this is outside the scope because there are other existing
logical variables that are different from the environment variables
that can affect the behaviour of git.

> the default branch name that will be used by git-init.

"git-init" -> "git init", or inside a pair of backquotes, i.e. "`git init=
`".

> Currently this variable is equivalent to
>     git config init.defaultbranch || 'master'
>
> This however will break if at one point the default branch is changed a=
s
> indicated by `default_branch_name_advice` in `refs.c`.
>
> By providing this command ahead of time users of git can make their
> code forward-compatible.

Makes sense.  Thanks for cleanly explaining the motivation.

> Co-developed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

I would use "Helped-by:" here, as I do not want to see one-off
trailers invented left and right.

> diff --git a/builtin/var.c b/builtin/var.c
> index 6c6f46b4ae..d1d82b6c93 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -5,6 +5,7 @@
>   */
>  #include "builtin.h"
>  #include "config.h"
> +#include "refs.h"
> =20
>  static const char var_usage[] =3D "git var (-l | <variable>)";
> =20
> @@ -27,6 +28,17 @@ static const char *pager(int flag)
>  	return pgm;
>  }
> =20
> +static const char *default_branch(int flag)
> +{
> +	const char *name =3D repo_default_branch_name(the_repository, 1);

Calling

        git_default_branch_name(1)

is much shorter and clear.  It's not like using the_repository is
always better.  For a single and simple purpose command like "git
var" that does not run around multiple repositories and do things
in them, sticking to the "we work in _the_ repository given to us"
simple API is better.

> +	if (!name)
> +		die("could not determine the default branch name");
> +
> +	return name;

Should we even die?  What does "init" and "clone" do when they ask
for the same information and get a NULL pointer?

    ... goes and looks ...

They know the call cannot fail that way.  So I would do either

 (1) follow suit and just return whatever we get back from the API
     call to the caller (which knows how to handle a NULL return); or

 (2) call BUG("...")  instead of die().  The name being NULL at this
     point means that git_default_branch_name() returned NULL, which
     the callers do not allow to happen, so it is a BUG for it to
     return NULL, and this caller noticed it.

I only raise the latter as a possibility.  I think just assuming
that name is never NULL like other callers is fine.

Thanks.
