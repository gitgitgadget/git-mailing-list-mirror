Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62058C12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 17:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2987261241
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 17:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhGUQ7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 12:59:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53373 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhGUQ7m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 12:59:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BA4AEFCD7;
        Wed, 21 Jul 2021 13:40:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8PrzCmdlPD5D
        h50R9OD9v/V/sClRqd0InvBbxTo1QIQ=; b=aITZ3mtnauyw1CZ1j5kMsroUIWLC
        xT3jI6YUwtt1piZIFaAT5H6WX1di81aKGFupF2jyVzGvZ0HDBcq5W/U9xgenDXPq
        GBSp6lJbJu68RP5HEhqNSIFwI6nKgdlP+WODGdLX9gxjRtLpR6k6gMewPiLgBZey
        qRdhGnbtoZnc0kU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23380EFCD6;
        Wed, 21 Jul 2021 13:40:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 950FEEFCD5;
        Wed, 21 Jul 2021 13:40:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 06/12] refs API: pass the "lock OID" to reflog "prepare"
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
        <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
        <patch-06.12-295594fe8ae-20210720T102051Z-avarab@gmail.com>
Date:   Wed, 21 Jul 2021 10:40:16 -0700
In-Reply-To: <patch-06.12-295594fe8ae-20210720T102051Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Jul
 2021 12:24:11
        +0200")
Message-ID: <xmqq35s7efb3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B690A15E-EA4A-11EB-9658-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  static void reflog_expiry_prepare(const char *refname,
> -				  const struct object_id *oid,
> +				  struct object_id *locked_oid,
>  				  void *cb_data)
>  {
>  	struct expire_reflog_policy_cb *cb =3D cb_data;
> @@ -361,7 +361,7 @@ static void reflog_expiry_prepare(const char *refna=
me,
>  		cb->unreachable_expire_kind =3D UE_HEAD;
>  	} else {
>  		cb->tip_commit =3D lookup_commit_reference_gently(the_repository,
> -								oid, 1);
> +								locked_oid, 1);
>  		if (!cb->tip_commit)
>  			cb->unreachable_expire_kind =3D UE_ALWAYS;
>  		else
> diff --git a/refs.h b/refs.h
> index 48970dfc7e0..c009707438d 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -796,7 +796,7 @@ enum expire_reflog_flags {
>   * expiration policy that is desired.
>   *
>   * reflog_expiry_prepare_fn -- Called once after the reference is
> - *     locked.
> + *     locked. Called with the OID of the locked reference.
>   *
>   * reflog_expiry_should_prune_fn -- Called once for each entry in the
>   *     existing reflog. It should return true iff that entry should be
> @@ -806,7 +806,7 @@ enum expire_reflog_flags {
>   *     unlocked again.
>   */
>  typedef void reflog_expiry_prepare_fn(const char *refname,
> -				      const struct object_id *oid,
> +				      struct object_id *lock_oid,
>  				      void *cb_data);

The files_reflog_expire() helper still takes const oid but it can
tolerate this change because it uses the lockfile API as its
implementation detail, and passes &(lock->old_oid) (which is no
longer a const).

But do we expect that all backends to take an on-filesystem lock via
the lockfile API and pass it down to prepare_fn?

This obviously breaks the latest round of reftable topic, as it
still wants this type to take const oid, and I do not think using
on-filesystem lock as if we are using the files backend is not a
good solution.




