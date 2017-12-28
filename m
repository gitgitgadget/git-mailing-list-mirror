Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D4061F406
	for <e@80x24.org>; Thu, 28 Dec 2017 21:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753843AbdL1VYK (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 16:24:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64238 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753518AbdL1VYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 16:24:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04BCAC63BB;
        Thu, 28 Dec 2017 16:24:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cJYNxwKcl6Ao
        hiN7OhHEcwKqoIg=; b=pLXlJ7/SZha15V0t/IY9usRbflwCf5gCsCy6whCKz7/F
        gXP68eaEYF5L4Q8lLy6a7VYO8LJsDfpX+i47Z1LXykFp0lY8MNpc9qIhfD3arFS9
        Ll3T8jVrvinmKvJdEN517x1Akz3fJnmgUyYO6wqFYjcmQDPe8h+eLOxVDD2EheU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pA0EQ3
        X9IvySTxNd6BwO1a5IcKbl16XOJF1CXa//3W3dSnpAof2GDO+etIHYu9l+7OvoSR
        uSMO85EDLQb311diBgflCD+0XletzkLUZewrpwjyhT5q3+uIrPHD1pl62HKJaWMg
        TODKPaoqmYiZ3k3pdhI5ci3jXLStj85r171oc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EFD7FC63BA;
        Thu, 28 Dec 2017 16:24:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 694CCC63B8;
        Thu, 28 Dec 2017 16:24:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 7/9] checkout: avoid using the rev_info flag leak_pending
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
        <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
        <fe63ddf2-0b6b-bb26-3550-efdb65968e46@web.de>
Date:   Thu, 28 Dec 2017 13:24:07 -0800
In-Reply-To: <fe63ddf2-0b6b-bb26-3550-efdb65968e46@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 25 Dec 2017 18:47:04 +0100")
Message-ID: <xmqq373uk0lk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7087A0FE-EC15-11E7-9CD9-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index f9f3797e11..afb225ca79 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -790,37 +790,26 @@ static void suggest_reattach(struct commit *commi=
t, struct rev_info *revs)
>  static void orphaned_commit_warning(struct commit *old, struct commit =
*new)
>  {
>  	struct rev_info revs;
>  	struct object *object =3D &old->object;
> -	struct object_array refs;
> =20
>  	init_revisions(&revs, NULL);
>  	setup_revisions(0, NULL, &revs, NULL);
> =20
>  	object->flags &=3D ~UNINTERESTING;
>  	add_pending_object(&revs, object, oid_to_hex(&object->oid));
> =20
>  	for_each_ref(add_pending_uninteresting_ref, &revs);
>  	add_pending_oid(&revs, "HEAD", &new->object.oid, UNINTERESTING);

Somewhat unrelated tangent, but I mention it only because that it
appears that the use of leak-pending is closely associated with the
"are these objects all reachable from some ref?" query.  This one of
course is asking that exact question (and the way to ask that in a
script is "rev-list $objects --not --all" to see if anything comes
out). The one in "bundle" we saw earlier is another one.  Even
though the implementation is quite different, everything_local()
shares the same purpose. =20

I wonder if we want a single unified implementation of this query so
that reinventions do not have to get the details wrong.

The conversion looks obviously correct.  Thanks.
