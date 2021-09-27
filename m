Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C37DC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AFD260FBF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbhI0XGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:06:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57012 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhI0XGW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 19:06:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF2CA142448;
        Mon, 27 Sep 2021 19:04:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9L0g9+ifN6OL
        ZGJ2SSm+OhH4CouCq3B6n96Oe3X84rE=; b=jTHnU3jKcUci3l3CmIk+NBPBc51m
        tu5jhoN8T1uESKr8DvxCLL7/iIgZfRhwAstkdUFvvqy8Fv4XV30gedJExjc2x0rK
        A42ngcG368aA7RryuYXrchF9iDoSY9G4eCZVCddiNE9suwMiTK6c81Ta3HteG0uD
        Z6qlM52Z5BHP8Fk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A7073142447;
        Mon, 27 Sep 2021 19:04:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 122E1142445;
        Mon, 27 Sep 2021 19:04:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 4/5] builtin/remote.c: add and use a REF_STATES_INIT
References: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com>
        <patch-v2-4.5-13ef9566903-20210927T125715Z-avarab@gmail.com>
Date:   Mon, 27 Sep 2021 16:04:39 -0700
In-Reply-To: <patch-v2-4.5-13ef9566903-20210927T125715Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 27 Sep
 2021 14:58:44
        +0200")
Message-ID: <xmqq4ka5oc1k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4BC79080-1FE7-11EC-9388-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Use a new REF_STATES_INIT designated initializer instead of assigning
> to the "strdup_strings" member of the previously memzero()'d version
> of this struct.
>
> The pattern of assigning to "strdup_strings" dates back to
> 211c89682ee (Make git-remote a builtin, 2008-02-29) (when it was
> "strdup_paths"), i.e. long before we used anything like our current
> established *_INIT patterns consistently.
>
> Then in e61e0cc6b70 (builtin-remote: teach show to display remote
> HEAD, 2009-02-25) and e5dcbfd9ab7 (builtin-remote: new show output
> style for push refspecs, 2009-02-25) we added some more of these.
>
> As it turns out we only initialized this struct three times, all the
> other uses were of pointers to those initialized structs. So let's
> initialize it in those three places, skip the memset(), and pass those
> structs down appropriately.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/remote.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 7f88e6ce9de..160dd954f74 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -344,6 +344,14 @@ struct ref_states {
>  	int queried;
>  };
> =20
> +#define REF_STATES_INIT { \
> +	.new_refs =3D STRING_LIST_INIT_DUP, \
> +	.stale =3D STRING_LIST_INIT_DUP, \
> +	.tracked =3D STRING_LIST_INIT_DUP, \
> +	.heads =3D STRING_LIST_INIT_DUP, \
> +	.push =3D STRING_LIST_INIT_DUP, \
> +}

So, now everybody owns the string, but ...

>  static int get_ref_states(const struct ref *remote_refs, struct ref_st=
ates *states)
>  {
>  	struct ref *fetch_map =3D NULL, **tail =3D &fetch_map;
> @@ -355,9 +363,6 @@ static int get_ref_states(const struct ref *remote_=
refs, struct ref_states *stat
>  			die(_("Could not get fetch map for refspec %s"),
>  				states->remote->fetch.raw[i]);
> =20
> -	states->new_refs.strdup_strings =3D 1;
> -	states->tracked.strdup_strings =3D 1;
> -	states->stale.strdup_strings =3D 1;

... we used to set up selectively to own.

How would we make sure after this change we are not adding leaks?
Is there a way to do so mechanically?

> -	struct ref_states states;
> +	struct ref_states states =3D REF_STATES_INIT;
>  	struct string_list refs_to_prune =3D STRING_LIST_INIT_NODUP;
>  	struct string_list_item *item;
>  	const char *dangling_msg =3D dry_run
>  		? _(" %s will become dangling!")
>  		: _(" %s has become dangling!");
> =20
> -	memset(&states, 0, sizeof(states));
>  	get_remote_ref_states(remote, &states, GET_REF_STATES);

Like this one, get_remote_ref_states() used to receive states that
are set to borrow strings, but now we get duplicated strings, right?
Are we leaking whatever strings we push to these string lists now?


