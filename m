Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F360C07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 16:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43AD66127C
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 16:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245719AbhGSQCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 12:02:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64824 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349238AbhGSPuL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 11:50:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A88E2DD777;
        Mon, 19 Jul 2021 12:30:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=a9itxfbZY4Pc
        lvuP5PUbZlM+6fyN43RhlHSWuW5oCAc=; b=l9zwk5VKZYaOu46JvBPalRdqge7x
        O9QUHLcQghjN5irclGTn6LWuYfRH59L5bA9ySNRUN6mUncxG4ziS2gU8RmDVPhKl
        Bd9c8r9aybQvWWpNzQxHncEgahSgyuvgiRoXWyT6AH0+f/9cIib/VMkhjOCNDiIy
        /dNAjoQAL90z2RA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FA61DD776;
        Mon, 19 Jul 2021 12:30:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15F91DD775;
        Mon, 19 Jul 2021 12:30:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 06/11] refs API: pass the "lock OID" to reflog "prepare"
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
        <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
        <patch-06.11-e93465f4137-20210716T140631Z-avarab@gmail.com>
Date:   Mon, 19 Jul 2021 09:30:49 -0700
In-Reply-To: <patch-06.11-e93465f4137-20210716T140631Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 16 Jul
 2021 16:13:02
        +0200")
Message-ID: <xmqqfswanu4m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ADB3060A-E8AE-11EB-A540-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Don't pass the object ID we pass into reflog_expire() back to the
> caller, but rather our locked OID.
>
> As the assert shows these two were the same thing in practice as we'd

It is unclear which assert you refer to, but a call to verify_lock()
near the end of lock_ref_oid_basic() ensures this, I presume?

> exit earlier in this function if we couldn't lock the desired OID, but
> as part of removing the passing of the OID to other functions further
> on I'm splitting up these concerns.
>
> As we'll see in a subsequent commit we don't actually want to assert
> that we locked a given OID, we want this API to do the locking and
> tell us what the OID is, but for now let's just setup the scaffolding
> for that.

OK.  That sounds like a sensible direction to go in.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index af332fa8fe4..ec9c70d79cc 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3098,7 +3098,7 @@ static int files_reflog_expire(struct ref_store *=
ref_store,
>  		}
>  	}
> =20
> -	(*prepare_fn)(refname, oid, cb.policy_cb);
> +	(*prepare_fn)(refname, &lock->old_oid, cb.policy_cb);
>  	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
>  	(*cleanup_fn)(cb.policy_cb);
