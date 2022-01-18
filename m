Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F0CC433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 22:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345052AbiARWzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 17:55:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56519 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344248AbiARWzU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 17:55:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2264102702;
        Tue, 18 Jan 2022 17:55:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tzPpshJsSwio
        fTKW4niHIhyfcQdQ6nnWn4ahyTMgclg=; b=Tzr1wpT00DNRfrDNe/qIW/EAr7Cm
        zbDDXeqWmWTBRxcvjmhtiwWn/PpLxt2aLmiHU2LMgHUkgbcEPo20yU5Gw7PBPFpy
        cMykpNRr0Lgr8cnXVWU+ZJMGsrYAUH6x06xJ6ZyxI8/iawEkEn4wKXtxHtVV9beC
        C+nsFoh0POdZ6CA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9B2A102701;
        Tue, 18 Jan 2022 17:55:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4BF0B102700;
        Tue, 18 Jan 2022 17:55:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v8 09/10] grep: simplify config parsing and option parsing
References: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
        <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
        <patch-v8-09.10-c211bb0c69d-20220118T155211Z-avarab@gmail.com>
        <xmqq8rvcr73v.fsf@gitster.g>
Date:   Tue, 18 Jan 2022 14:55:17 -0800
In-Reply-To: <xmqq8rvcr73v.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        18 Jan 2022 14:50:44 -0800")
Message-ID: <xmqq4k60r6wa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B507040E-78B1-11EC-99EC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> @@ -56,17 +62,22 @@ int grep_config(const char *var, const char *value=
, void *cb)
>>  {
>>  	struct grep_opt *opt =3D cb;
>>  	const char *slot;
>> +	static int ero =3D -1;
>
> Is this new reentrancy issue worth it?  I think it makes the whole
> thing unnecessarily complex, compared to a more na=C3=AFve "we keep tra=
ck
> of the last-one-that-won for grep.extendedRegexp and
> grep.patternType separately during option and config parsing inside
> the grep_opt structure, and then combine the two when we compile the
> pattern string into regexp or pcre object" approach.

Another problem is that there are those corporate server-side folks
who are interested in giving an endpoint that lets clients to ask
performing Git operations (like grep and blame).  Adding more statics
instead of keeping track of dynamic runtime structure like grep_opt
is deliberately making things more difficult for them, isn't it?


