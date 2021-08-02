Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A52C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B8B60F9C
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhHBR0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:26:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58987 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhHBR0v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 13:26:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FC9CD04BD;
        Mon,  2 Aug 2021 13:26:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EASwqF3XE7FN
        oTKiLzFtQhMS2QE8MY5ogCDZhuIhW9I=; b=vPndB+F9iZPn4004hsMxMBE0ek1F
        41lSdxoZ2XN1KDTKaE0wbCWDvvNWlbB8KOywF+usK9f3dREpPnZANPitEa71p4fp
        1OxrGjbq9BA1WWI/cSSIPjIkegSqzza0xAZvEvb5SGnED7jnzipB2gMl0UpO1K3E
        Mr3BDAvj9YF9zsQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47F29D04BC;
        Mon,  2 Aug 2021 13:26:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D814D04B9;
        Mon,  2 Aug 2021 13:26:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 08/11] reflog expire: don't lock reflogs using
 previously seen OID
References: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
        <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
        <patch-08.11-c9c2da3599-20210726T234237Z-avarab@gmail.com>
Date:   Mon, 02 Aug 2021 10:26:39 -0700
In-Reply-To: <patch-08.11-c9c2da3599-20210726T234237Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 27 Jul
 2021 01:44:24 +0200")
Message-ID: <xmqqeebbwyeo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CBF964C0-F3B6-11EB-960A-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> During reflog expiry, the cmd_reflog_expire() function first iterates
> ...
> I'm leaving behind now-unused code the refs API etc. that takes the
> now-NULL "unused_oid" argument, and other code that can be simplified n=
ow
> that we never have on OID in that context, that'll be cleaned up in
> subsequent commits, but for now let's narrowly focus on fixing the
> "git gc" issue. As the modified assert() shows we always pass a NULL
> oid to reflog_expire() now.

OK.  Nicely described.

>  static int files_reflog_expire(struct ref_store *ref_store,
> -			       const char *refname, const struct object_id *oid,
> +			       const char *refname, const struct object_id *unused_oid,
>  			       unsigned int flags,
>  			       reflog_expiry_prepare_fn prepare_fn,
>  			       reflog_expiry_should_prune_fn should_prune_fn,
> @@ -3049,6 +3049,7 @@ static int files_reflog_expire(struct ref_store *=
ref_store,
>  	int status =3D 0;
>  	int type;
>  	struct strbuf err =3D STRBUF_INIT;
> +	const struct object_id *oid;
> =20
>  	memset(&cb, 0, sizeof(cb));
>  	cb.flags =3D flags;
> @@ -3060,7 +3061,7 @@ static int files_reflog_expire(struct ref_store *=
ref_store,
>  	 * reference itself, plus we might need to update the
>  	 * reference if --updateref was specified:
>  	 */
> -	lock =3D lock_ref_oid_basic(refs, refname, oid,
> +	lock =3D lock_ref_oid_basic(refs, refname, NULL,
>  				  REF_NO_DEREF,
>  				  &type, &err);
>  	if (!lock) {
> @@ -3068,6 +3069,7 @@ static int files_reflog_expire(struct ref_store *=
ref_store,
>  		strbuf_release(&err);
>  		return -1;
>  	}
> +	oid =3D &lock->old_oid;

OK.  That makes it more clear that the object name the locking code
read is what gets used.

> @@ -3111,6 +3113,7 @@ static int files_reflog_expire(struct ref_store *=
ref_store,
>  		}
>  	}
> =20
> +	assert(!unused_oid);
>  	(*prepare_fn)(refname, oid, cb.policy_cb);
>  	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
>  	(*cleanup_fn)(cb.policy_cb);

The preference in this codebase is

	ptr_to_function(params);

over

	(*ptr_to_function)(params);

Once it is written and committed, it is not worth changing, but just
for the record...

THanks.

