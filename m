Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5EEC433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 15:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbiESPQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 11:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240345AbiESPQz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 11:16:55 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06EB60AB0
        for <git@vger.kernel.org>; Thu, 19 May 2022 08:16:52 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85F34119C64;
        Thu, 19 May 2022 11:16:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DI5iWd8brmCEmZSg/ar3+Nw7Dc+SFVQCIO/qxv
        KF8zA=; b=OTn6eKbhf7PMpuSSWBEM4j/b2v3mNykpUnELb7TEbqgw7G5FmXfJkD
        kjSN1zEN6+8r8RdP7PY2u1JkViGbE7xfe4lDzFdDBLzsdkZ5kLBdMv5Is72D6Xmm
        U4WepW06cMMDuNxZCLIcGkpwvMMJZWLaLo/bm/jPLeYsroXmnKXbQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B637119C63;
        Thu, 19 May 2022 11:16:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF8AA119C62;
        Thu, 19 May 2022 11:16:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, derrickstolee@github.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v4 08/17] builtin/pack-objects.c: --cruft without
 expiration
References: <cover.1638224692.git.me@ttaylorr.com>
        <cover.1652915424.git.me@ttaylorr.com>
        <94fe03cc65716b6102e2d71df49d4ae5a1a60dc7.1652915424.git.me@ttaylorr.com>
        <xmqq7d6hsusd.fsf@gitster.g>
Date:   Thu, 19 May 2022 08:16:49 -0700
In-Reply-To: <xmqq7d6hsusd.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        19 May 2022 03:04:18 -0700")
Message-ID: <xmqqv8u1r1r2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5494236-D786-11EC-8275-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> @@ -3870,6 +4034,20 @@ static int option_parse_unpack_unreachable(const struct option *opt,
>>  	return 0;
>>  }
>>  
>> +static int option_parse_cruft_expiration(const struct option *opt,
>> +					 const char *arg, int unset)
>> +{
>> +	if (unset) {
>> +		cruft = 0;
>> +		cruft_expiration = 0;
>> +	} else {
>> +		cruft = 1;
>> +		if (arg)
>> +			cruft_expiration = approxidate(arg);
>> +	}
>> +	return 0;
>> +}
>
> It is somewhat sad that we have to invent this function, instead of
> using parse_opt_expiry_date_cb().

I failed to mention that this one does more than the bog-standard
callback so the latter cannot be reused as-is, and that is what I
meant by "somewhat sad".  If we can find a way to reuse the
parse_opt_expiry_date_cb() for the purpose of the user of this
function that would be ideal, but only if we can do so without
making the caller too unnatural.  Having two separate values, "did
we get --cruft-expiration option?" and "what's the value of it?",
does benefit the current caller and we do not want to twist it just
for not adding a similar callback---that's a tail wagging a dog.

Thanks.

