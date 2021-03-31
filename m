Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D518C43460
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E237B61019
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhCaSF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 14:05:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56853 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbhCaSF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 14:05:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C5B9411DA9A;
        Wed, 31 Mar 2021 14:05:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lOWWXSM1/xim9tSGdD0mFif96uI=; b=frtox5
        iF6UBuCFQaAdAfPeJMRP41iguu0wGShKUYA6CW9nyA2TN99TVVRmQlzJq9E0U7wH
        tpOCRSWu04TwZyuDnkqjc1ZRyk3DTsVn97jigSk+jioPvICr0Ut7iwYnjCPhfsC4
        ZtKT805RflF7JTyMpkqF0w5T3HZWZDiXm/D74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SCbc1aIFj3HSJb4+Sckt2NDu8WiWxwPh
        Z+k3dtJxIbSvELk7H/ra1u9tjLcSnosWSC2xtNa9JiCaf9FIb2f5MGBmAPK4PxY6
        7bCayun5+OJLDDHLtA5U+UNnTV79irBwnoCgGcUouVwGhriQlwlk8bi75MNWReVg
        8jTt9UcwJqo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BEDBB11DA99;
        Wed, 31 Mar 2021 14:05:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE97C11DA98;
        Wed, 31 Mar 2021 14:05:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 10/10] tag: don't misreport type of tagged objects in
 errors
References: <20210308200426.21824-1-avarab@gmail.com>
        <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
        <patch-10.11-a84f670ac24-20210328T021238Z-avarab@gmail.com>
        <xmqq35wdfaw5.fsf@gitster.g>
        <YGRWqX+qF+Rtqr20@coredump.intra.peff.net>
Date:   Wed, 31 Mar 2021 11:05:53 -0700
In-Reply-To: <YGRWqX+qF+Rtqr20@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 31 Mar 2021 07:02:01 -0400")
Message-ID: <xmqqim578agu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCA29D92-924B-11EB-9DC8-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I also think the manual handling of OBJ_NONE in each lookup_* function
> is confusing. They all call object_as_type() because the point of that
> function is both to type-check the struct and to convert it away from
> OBJ_NONE.
>
> If we handled this error there, then I think it would be much more
> natural, because we'd have already covered the OBJ_NONE case, and
> because it's already the place we're emitting the existing error. E.g.:

This makes quite a lot of sense.  If presented with this simple
change and 10-patch series at the same time and are told that the
goal of the changes were more or less the same, I'd pick this one
100% of the time.

> diff --git a/object.c b/object.c
> index 2c32691dc4..e6345541f7 100644
> --- a/object.c
> +++ b/object.c
> @@ -157,7 +157,7 @@ void *create_object(struct repository *r, const struct object_id *oid, void *o)
>  	return obj;
>  }
>  
> -void *object_as_type(struct object *obj, enum object_type type, int quiet)
> +void *object_as_type(struct object *obj, enum object_type type, unsigned flags)
>  {
>  	if (obj->type == type)
>  		return obj;
> @@ -169,10 +169,16 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
>  		return obj;
>  	}
>  	else {
> -		if (!quiet)
> -			error(_("object %s is a %s, not a %s"),
> -			      oid_to_hex(&obj->oid),
> -			      type_name(obj->type), type_name(type));
> +		if (!(flags & OBJECT_AS_TYPE_QUIET)) {
> +			if (flags & OBJECT_AS_TYPE_EXPECT_PARSED)
> +				error(_("object %s is a %s, but was referred to as a %s"),
> +				      oid_to_hex(&obj->oid), type_name(obj->type),
> +				      type_name(type));
> +			else
> +				error(_("object %s referred to as both a %s and a %s"),
> +				      oid_to_hex(&obj->oid),
> +				      type_name(obj->type), type_name(type));
> +		}
>  		return NULL;
>  	}
>  }
>
> -Peff
