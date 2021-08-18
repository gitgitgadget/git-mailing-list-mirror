Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCFAC4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 21:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B64F7610A3
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 21:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhHRVFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 17:05:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52465 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbhHRVFw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 17:05:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 24C6515F4A0;
        Wed, 18 Aug 2021 17:05:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=n33ofd0ieevU
        WVSo/ZMJbmi3JAUkm4inNPEzFXQpjdg=; b=LAIFSXtKRQsTvxg2yACon+WuBYeB
        HUa8iH4tAeUYwe8BoA3s1FPawu16UeFdiC9hlrZaDCiKHNSefh9EMWqMu3GEOSRG
        m0bhUeJMa4F7iCG1O3X41Bbj8cKKk4iTzKaqKCBPedYfaLEs3ldWHOMhSRWXy0Pd
        CExKTH0Xjq4mz2k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 090A515F49F;
        Wed, 18 Aug 2021 17:05:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C12E415F49C;
        Wed, 18 Aug 2021 17:05:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 09/11] reflog expire: don't lock reflogs using
 previously seen OID
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
        <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
        <patch-09.11-60d6cf342fc-20210716T140631Z-avarab@gmail.com>
        <CAFQ2z_MhNgimn=7qcu-G823X=yTRT3xXrDP7qRiELShXY9A3AA@mail.gmail.com>
Date:   Wed, 18 Aug 2021 14:05:12 -0700
In-Reply-To: <CAFQ2z_MhNgimn=7qcu-G823X=yTRT3xXrDP7qRiELShXY9A3AA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 17 Aug 2021 15:35:01 +0200")
Message-ID: <xmqqlf4y4g6v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FB38A148-0067-11EC-B195-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Fri, Jul 16, 2021 at 4:13 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> -                       status |=3D reflog_expire(e->reflog, &e->oid, =
flags,
>> +                       status |=3D reflog_expire(e->reflog, NULL, fla=
gs,
>>                                                 reflog_expiry_prepare,
>
> this causes reflog_expiry_prepare() to be called with a NULL oid. I'm
> seeing a crash in do_lookup_replace_object() because of this in
> t0031-reftable.sh.

Yeah, given that reflog_expire() is documented to take "oid is the
old value of the reference", the change looks bogus to me too.

=C3=86var, what is going on here?

Thanks.
