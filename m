Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC48C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 553DD61181
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhKRWcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 17:32:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63012 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhKRWcy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 17:32:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0AFD6168028;
        Thu, 18 Nov 2021 17:29:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FKhFrL44zoj9
        q7TdvZVCsYSnuSodP2RryyKjkKLoNpM=; b=FYu/Q+z2JCVlUahmy1jVN2tgyDRO
        T3x1r9HE1/oByrltwVW/OjOa8pG0VrK+MMwY+iHguzomgAh8zRzCPx8tV2kynLfM
        5tmDlEzFJKoNYt9WWBmM4Js/vbQk8tWd9f45UJ8Zd3aYbQBdvsmOCuIlY+sk6luZ
        Wfv+0zUUHFqhW8g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E37CF168027;
        Thu, 18 Nov 2021 17:29:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4C301168026;
        Thu, 18 Nov 2021 17:29:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, avarab@gmail.com
Subject: Re: [PATCH v4] branch: add flags and config to inherit tracking
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
        <7ad7507f183332cb2b5fdf2eb76fbbc9dd7199ef.1637085915.git.steadmon@google.com>
Date:   Thu, 18 Nov 2021 14:29:50 -0800
In-Reply-To: <7ad7507f183332cb2b5fdf2eb76fbbc9dd7199ef.1637085915.git.steadmon@google.com>
        (Josh Steadmon's message of "Tue, 16 Nov 2021 10:25:31 -0800")
Message-ID: <xmqqbl2hw10h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0BAA1404-48BF-11EC-8FFE-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> I've addressed Glen's feedback from V3. However, this brings up a new
> issue that was not obvious before: "branch.<name>.merge" can be
> specified more than once. On the other hand, the existing tracking setu=
p
> code supports only a single merge entry. For now I'm defaulting to use
> the first merge entry listed in the branch struct, but I'm curious what
> people think the best solution would be. This may be another point in
> favor of =C3=86var's suggestion to reuse the copy-branch-config machine=
ry.

Or we can extend "existing tracking setup code" to support multiple
merge sources.

How does the "git pull" machinery react to them, by the way?  I
think the original intention is to support pulling multiple branches
from the (single) remote configured for the branch with a single
invocation of "git pull", creating an octopus merge, but does it
still work, or nobody uses such a crazy curiosity anymore and it was
once broken and left in non-working state ever since?  What I am
dreaming here is if we can safely ignore all but one of them, taking
the usual "last-one-wins" rule, after some transition period.

> +int parse_opt_tracking_mode(const struct option *opt, const char *arg,=
 int unset) {
> +	if (unset)
> +		*(enum branch_track *)opt->value =3D BRANCH_TRACK_NEVER;
> +	else if (!arg || !strcmp(arg, "direct"))
> +		*(enum branch_track *)opt->value =3D BRANCH_TRACK_EXPLICIT;
> +	else if (!strcmp(arg, "inherit"))
> +		*(enum branch_track *)opt->value =3D BRANCH_TRACK_INHERIT;
> +	else
> +		return error(_("option `--track' expects \"direct\" or \"inherit\"")=
);

According to recent discussion in another thread,

	error(_("option '--%s` expects '%s' or '%s'"),
		"track", "direct", "inherit");

would be more translater friendly, as these three words are not
subject to translation?  I am not sure if it is really worth it,
though.

