Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776C0C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 22:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468D26525A
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 22:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhCHWPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 17:15:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50725 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhCHWPL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 17:15:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C74C13766B;
        Mon,  8 Mar 2021 17:15:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=h/QTkRzgsX4M
        EjbfECnHDZMVMgw=; b=cHas9o5ijw/XvYV8mMtMarhzg1sD9rSntXlDANWVrIgU
        0GcoMVT8wuzUsJiJ+mmr2hk5mfMLQEu4HV6qZau3OycESDYscK/SxPwOQWGe5iOz
        ikUrF/jiOSSpbJjSErZ17wGIIAdOcocSbCLGGEsgO4V2rHSU0xNVjgFSsplOBU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CKj2A0
        a9zBU89lSu0py1/rJKMo0WxgBrUXJfB8UOwLSHvHIHnNmN1XAfWuXJLuRsN+YSXi
        1IXMKc8roMw4QOise0dHOobd7iycvaoAp66qaXXaPtiu0z95+Iz+P6eRoAI4nHOw
        /VZmS4JxvyqeejjmdGbPoJKzpgYiRyfF0KjrU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 24C9A13766A;
        Mon,  8 Mar 2021 17:15:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 64814137669;
        Mon,  8 Mar 2021 17:15:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/7] object.c: add a utility function for "expected type
 X, got Y"
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
        <20210308200426.21824-6-avarab@gmail.com>
Date:   Mon, 08 Mar 2021 14:15:05 -0800
In-Reply-To: <20210308200426.21824-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 8 Mar 2021 21:04:24 +0100")
Message-ID: <xmqqsg5547iu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BD7B4DB0-805B-11EB-934C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor various "Object X is not Y" error messages so that they use
> the same message as the long-standing object_as_type() error
> message. Now we'll consistently report e.g. that we got a commit when
> we expected a tag, not just that the object is not a tag.

This one is quite nice.  There might be some i18n fallout to do this
at this low layer, but everything should be manageable (i.e. we can
just tell the users "don't parse the die() message---they are meant
for humans") immediately, and in the longer term, we probably would
want to move away from dying at this low level anyway and instead
return an error for the higher layer to deal with.

> +static const char *oid_is_a_X_not_a_Y =3D N_("object %s is a %s, not a=
 %s");
> +
>  const char *type_name(unsigned int type)
>  {
>  	if (type >=3D ARRAY_SIZE(object_type_strings))
> @@ -159,6 +161,36 @@ void *create_object(struct repository *r, const st=
ruct object_id *oid, void *o)
>  	return obj;
>  }
> =20
> +static int oid_is_type_or(const struct object_id *oid,
> +			  enum object_type want,
> +			  enum object_type type,
> +			  int err)

"err" is usually called "gently" in this codebase, isn't it?

> +{
> +	if (want =3D=3D type)
> +		return 0;
> +	if (err)
> +		return error(_(oid_is_a_X_not_a_Y),
> +			     oid_to_hex(oid), type_name(type),
> +			     type_name(want));

Just a style thing, but breaking line after oid like you did on the
other "!err" side makes it a lot more readable.

> +	else
> +		die(_(oid_is_a_X_not_a_Y), oid_to_hex(oid),
> +		    type_name(type), type_name(want));
> +}
