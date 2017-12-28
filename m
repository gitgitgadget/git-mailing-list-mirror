Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A27081F406
	for <e@80x24.org>; Thu, 28 Dec 2017 21:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753843AbdL1VNf (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 16:13:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63216 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750967AbdL1VNe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 16:13:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DABEDC622B;
        Thu, 28 Dec 2017 16:13:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lWe1FvoSkyoE
        m+UYbmsrQpYEHsc=; b=tXeQgc3cagjyF2zmA3mLW53zhHHWvsKX1hy+kXSTQOtu
        KmIHUaMmhRTJvS6gtCelMG1MVvWWN2CZyJKCzhZZck+aR5oGSrgzJI1i24uyEfL2
        xHXnMOjpW01sv48PQgu2739dfp7zmv1RZMedYC6KGHbTPuW+9XsXXva3hunHI4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JsMPev
        rhk++S+58bApLOZtc12yNjEmqyhxAi6IuFZJiwnQGy2Di9ubWT56H+8msiJiYHdy
        z8LaWhBJTMEymJ1KeSnE2nhAaRPEvZrq/KeX+E8hQksVKP8DDgx0xsPWQpWL/A/7
        u6xpJdW+AKH2cLP8Z8FuHCSVJ/3wnUllNYtF0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D31D2C622A;
        Thu, 28 Dec 2017 16:13:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C95DC6229;
        Thu, 28 Dec 2017 16:13:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 6/9] bundle: avoid using the rev_info flag leak_pending
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
        <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
        <5fe3b4c8-e48c-1922-f564-e75c5a354cef@web.de>
Date:   Thu, 28 Dec 2017 13:13:32 -0800
In-Reply-To: <5fe3b4c8-e48c-1922-f564-e75c5a354cef@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 25 Dec 2017 18:46:14 +0100")
Message-ID: <xmqq7et6k137.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F5F7D648-EC13-11E7-A7CB-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The leak_pending flag is so awkward to use that multiple comments had t=
o
> be added around each occurrence.  We use it for remembering the
> prerequisites for the bundle.  That is easy, though: We have the
> ref_list named "prerequisites" in the header for just that purpose.

Hmph.

>  int verify_bundle(struct bundle_header *header, int verbose)
>  {
>  ...
>  	struct rev_info revs;
>  	const char *argv[] =3D {NULL, "--all", NULL};
> -	struct object_array refs;
>  	struct commit *commit;
>  	int i, ret =3D 0, req_nr;
>  	const char *message =3D _("Repository lacks these prerequisite commit=
s:");
> =20
>  	init_revisions(&revs, NULL);
>  	for (i =3D 0; i < p->nr; i++) {
>  		struct ref_list_entry *e =3D p->list + i;
>  		struct object *o =3D parse_object(&e->oid);
>  		if (o) {
>  			o->flags |=3D PREREQ_MARK;
>  			add_pending_object(&revs, o, e->name);
>  			continue;
>  		}

We mark the prereq objects with PREREQ_MARK and then ...

>  		if (++ret =3D=3D 1)
>  			error("%s", message);
>  		error("%s %s", oid_to_hex(&e->oid), e->name);
>  	}
>  	if (revs.pending.nr !=3D p->nr)
>  		return ret;
>  	req_nr =3D revs.pending.nr;
>  	setup_revisions(2, argv, &revs, NULL);

... run "rev-list" with "--all" plus these prereq objects, and ...

> ...
>  	i =3D req_nr;
>  	while (i && (commit =3D get_revision(&revs)))
>  		if (commit->object.flags & PREREQ_MARK)
>  			i--;

... let the traversal run until we see all the objects with PREREQ_MARK
set (i.e. those that appear in p->list[]).

> ...
> +	for (i =3D 0; i < p->nr; i++) {
> +		struct ref_list_entry *e =3D p->list + i;
> +		struct object *o =3D parse_object(&e->oid);
> +		assert(o); /* otherwise we'd have returned early */
> +		if (o->flags & SHOWN)
> +			continue;
> +		if (++ret =3D=3D 1)
> +			error("%s", message);
> +		error("%s %s", oid_to_hex(&e->oid), e->name);
> +	}

And then make sure that all of those that appear in p->list[] are
already shown.

Doesn't that mean that these SHOWN and other flags are first given
to the commits at the tip of "--all" refs and propagated down to
those in p->list[]?  Would it be sufficient to clear those that can
be reached from them, like the following?

> =20
>  	/* Clean up objects used, as they will be reused. */
> -	clear_commit_marks_for_object_array(&refs, ALL_REV_FLAGS);
> -
> -	object_array_clear(&refs);
> +	for (i =3D 0; i < p->nr; i++) {
> +		struct ref_list_entry *e =3D p->list + i;
> +		commit =3D lookup_commit_reference_gently(&e->oid, 1);
> +		if (commit)
> +			clear_commit_marks(commit, ALL_REV_FLAGS);
> +	}

I do not think the patch in question changes behaviour.  The set of
objects the code starts the clearing does not change.  So I am more
puzzled by the original than the conversion done with this change.

