Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CE9C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8D561059
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347859AbhIIXNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:13:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54613 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbhIIXNi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:13:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E278F0EB6;
        Thu,  9 Sep 2021 19:12:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eegOlAqz/bjg
        AuU6Y74m7KWo8Q+I0lj8m9A90MudB1U=; b=JdxWUZSt9S426N5k4nHJf9P5MEBj
        BrliwoxhShtMTDos2tPuG+fHDvmvcPP95K8YwWk6fPQmg0E43qVKZkdokFAWNded
        //6rHWBt0YV5VOp6mWqsMlisRoTha3ePEgMv+8u6/uwhcwMeGSuctOBq5tlCG704
        fWS1tLwC7Oi0xPs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46B4FF0EB5;
        Thu,  9 Sep 2021 19:12:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4528F0EB4;
        Thu,  9 Sep 2021 19:12:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 2/5] http: correct curl version check for
 CURLOPT_PINNEDPUBLICKEY
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
        <patch-2.5-511534ce17a-20210908T152807Z-avarab@gmail.com>
        <YTkNdGk28UJnSDVt@coredump.intra.peff.net>
Date:   Thu, 09 Sep 2021 16:12:26 -0700
In-Reply-To: <YTkNdGk28UJnSDVt@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 8 Sep 2021 15:22:28 -0400")
Message-ID: <xmqqv939wdgl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 65F0B75C-11C3-11EC-9F4C-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 08, 2021 at 05:31:53PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> In aeff8a61216 (http: implement public key pinning, 2016-02-15) a
>> dependency and warning() was added if curl older than 7.44.0 was used,
>> but the relevant code depended on CURLOPT_PINNEDPUBLICKEY, introduced
>> in 7.39.0.
>
> According to the manpage for CURLOPT_PINNEDPUBLICKEY, it looks like
> support for various formats and implementations was phased in. In
> particular, 7.44.0 picked up sha256 support (I guess for a fingerprint?
> I've never used this feature) for most major implementations.
>
> But in terms of compiling, all we care about is that the constant is
> there. So I think the cutoff point you found is what we want. Presumabl=
y
> when the file format isn't supported we'd get some error, though it's
> not clear if that would come during the actual curl_*_perform(), or if
> we should be checking the curl_easy_setopt() result.

If we were evaluating a patch to add support for pinnedpublickey
afresh back in, say, 2017, perhaps we cared enough about the
distinction between 7.39 and 7.44 (Nov 2014 and Aug 2015,
respectively), but I'd say cut-off at 7.44 for this, once it is
written and committed in our codebase, is good enough for us.

If the code originally had cut-off at 7.39 and we were raising the
floor to 7.44 with "sha256 weren't usable before that version" as
the justification, it would be a totally different situation and it
may be worth the code change, but I am not sure if going backwards
is worth it.

So, I dunno.

Thanks.
