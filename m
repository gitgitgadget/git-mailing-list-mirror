Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C48DC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA21364F53
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhCQTMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 15:12:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53118 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhCQTMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 15:12:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5679E134E34;
        Wed, 17 Mar 2021 15:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9ldc9GJ2HYlk
        HjcApbH6v6nZjCo=; b=Le0BRKTypvpYmATBsdQIqRRUpkGoFWp2ekxZZbyxJlIL
        CnBrwmQNBaOsi5KfLCNvaOf3LY3+B28yadx6blbIsM6I3LGqK68xbNukzVMPM7Uk
        90CRfM1s5wq3jtiEEthv4mR7+J4czzr/Nc9j05wH1Vilu8HYhaUgl/E25rYZ9VI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Awn7NT
        Y2loIVJJmMDQ5iA4zDWazxHR+wb/OaGflTuMirUKBHdXwHdzO4hY6BdlRfbRzGTY
        XPfIoCcOBZn3rT14ucgYJX79ofnMzKeMJzRBZfkZl1VimK8+Rth+8Jj4qb4gP/jp
        9t9DbNRk0Dky+7xLBGNYkolLbXiuAJVVcFDb0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EC42134E33;
        Wed, 17 Mar 2021 15:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4BD9E134E31;
        Wed, 17 Mar 2021 15:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 22/22] fetch-pack: use new fsck API to printing
 dangling submodules
References: <20210306110439.27694-1-avarab@gmail.com>
        <20210316161738.30254-23-avarab@gmail.com>
Date:   Wed, 17 Mar 2021 12:12:11 -0700
In-Reply-To: <20210316161738.30254-23-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Mar 2021 17:17:38 +0100")
Message-ID: <xmqq5z1pvblg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AE1FC242-8754-11EB-B6FC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 5ad80b85b4..11f0fafd33 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -120,7 +120,7 @@ static int nr_threads;
>  static int from_stdin;
>  static int strict;
>  static int do_fsck_object;
> -static struct fsck_options fsck_options =3D FSCK_OPTIONS_STRICT;
> +static struct fsck_options fsck_options =3D FSCK_OPTIONS_MISSING_GITMO=
DULES;

Hmph, I do not think this is a good way to go.  Specifically,
fsck-cb.c with the definition of what this thing is, and in fsck.h
file the normal "options" initializers being defined quite far away
from where this is defined, it is hard to see what is different
between the normal strict one and MISSING_GITMODULES one.

Rather, it may be far simpler to keep only DEFAULT and STRICT, and
override .error_func at runtime in the codepath(s) that needs to,
which would make it more clear what is going on.  That way, we do
not need the split initializers with _ERROR_FUNC, which is another
reason why the approach taken by this series is not a good idea (it
does not scale---error-func may seem so special to deserve having
two sets of macros that use the default one and leave the member
unspecified, but it won't stay to be special forever).

IOW,

> @@ -1761,7 +1743,6 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
> =20
>  	read_replace_refs =3D 0;
>  	fsck_options.walk =3D mark_link;
> -	fsck_options.error_func =3D print_dangling_gitmodules;

I doubt this hunk is an improvement.

> diff --git a/fsck-cb.c b/fsck-cb.c
> new file mode 100644
> index 0000000000..465a49235a
> --- /dev/null
> +++ b/fsck-cb.c
> @@ -0,0 +1,16 @@
> +#include "git-compat-util.h"
> +#include "fsck.h"
> +
> +int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
> +					   const struct object_id *oid,
> +					   enum object_type object_type,
> +					   enum fsck_msg_type msg_type,
> +					   enum fsck_msg_id msg_id,
> +					   const char *message)
> +{
> +	if (msg_id =3D=3D FSCK_MSG_GITMODULES_MISSING) {
> +		puts(oid_to_hex(oid));
> +		return 0;
> +	}
> +	return fsck_error_function(o, oid, object_type, msg_type, msg_id, mes=
sage);
> +}

As Derrick noticed, I do not know if we want to have a separate file
for this single function.  Shouldn't it be part of builtin/index-pack.c,
or do we want other places to do the same kind of checks?

Thanks.
