Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C69EC19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 17:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbiHCR75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbiHCR74 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 13:59:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347BCBE28
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 10:59:55 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AC1714BF71;
        Wed,  3 Aug 2022 13:59:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vVGUZr78V1z1
        MrAfEizmSkXYEiylnkzY0lC6iFS/jUE=; b=IQvb/cb1s30UpQp0yjFFjSwOOi+m
        0gl3cWR5AL0AsaeISVaT1TMrjnnLvAhGp304djqj5hrbGxlM6RuFDyVqp8covHqL
        J/TcDpwYJpIoNcnjTrEr2oPfg3lC3CeM3WgvnAme5f8bE4DD1RrLY/dpyr84fPn3
        C4y/U+k+FJV27Xc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 515D514BF70;
        Wed,  3 Aug 2022 13:59:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AEFAE14BF6F;
        Wed,  3 Aug 2022 13:59:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/6] log: refactor "rev.pending" code in cmd_show()
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
        <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
        <patch-v3-4.6-fd474666e7c-20220802T152925Z-avarab@gmail.com>
Date:   Wed, 03 Aug 2022 10:59:52 -0700
In-Reply-To: <patch-v3-4.6-fd474666e7c-20220802T152925Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 2 Aug
 2022 17:33:14
        +0200")
Message-ID: <xmqqo7x19pif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 13B8EE1A-1356-11ED-AE3A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor the juggling of "rev.pending" and our replacement for it
> amended in the preceding commit so that:
> ...
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> Helped-by: Jeff King <peff@peff.net>

List trailer lines chronologically, please.

This does not look wrong per-se, but given that we might want to
rethink the way the original rev_info is reused inside the loop,
as I mentioned in my review of the previous step, this change may be
irrelevant in the longer term.

I may have said this earlier, but once we start using the "prepare a
blank one, copy it to clear another" pattern, we should stop using
memcpy() and use structure assignment, especially if we are trying to
make our intent clear.

> @@ -745,12 +743,19 @@ int cmd_show(int argc, const char **argv, const c=
har *prefix)
>  		case OBJ_COMMIT:
>  		{
>  			struct object_array old;
> +			struct object_array blank =3D OBJECT_ARRAY_INIT;
> =20
>  			memcpy(&old, &rev.pending, sizeof(old));
> -			rev.pending.nr =3D rev.pending.alloc =3D 0;
> -			rev.pending.objects =3D NULL;
> +			memcpy(&rev.pending, &blank, sizeof(rev.pending));
> +
>  			add_object_array(o, name, &rev.pending);
>  			ret =3D cmd_log_walk_no_free(&rev);
> +
> +			/*
> +			 * No need for
> +			 * object_array_clear(&pending). It was
> +			 * cleared already in prepare_revision_walk()
> +			 */
>  			memcpy(&rev.pending, &old, sizeof(rev.pending));
>  			break;
>  		}
