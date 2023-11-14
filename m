Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D86405EB
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HXZkzKEI"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2E2F1
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 09:03:22 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DA5A1C4658;
	Tue, 14 Nov 2023 12:03:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2yMjvxgE+R53tv7pajUxiddnAMuULZWV6B3tcn
	FbMhU=; b=HXZkzKEI+CuR0gY3l3LzAgCwSo3Kby9PxIrdR7Xo2MzAjSlp58dBVk
	wjrAi5F8EgJ6ERh6bGhjnDLeXEPBM7+mRvqMNHG99IXn/tT5O+6D0106xEPUEXMt
	9Zj0c1Jrh21c3gHEca68ooB2yP8pnEwdgTuPsIC9a/+f150WHkrSA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5681D1C4657;
	Tue, 14 Nov 2023 12:03:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 723B61C4652;
	Tue, 14 Nov 2023 12:03:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Arthur Chan
 <arthur.chan@adalogics.com>
Subject: Re: [PATCH v3] fuzz: add new oss-fuzz fuzzer for date.c / date.h
In-Reply-To: <pull.1612.v3.git.1699959186146.gitgitgadget@gmail.com> (Arthur
	Chan via GitGitGadget's message of "Tue, 14 Nov 2023 10:53:05 +0000")
References: <pull.1612.v2.git.1699892568344.gitgitgadget@gmail.com>
	<pull.1612.v3.git.1699959186146.gitgitgadget@gmail.com>
Date: Wed, 15 Nov 2023 02:03:19 +0900
Message-ID: <xmqqv8a4xo6g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B71BA33E-830F-11EE-8995-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      ++	tmp_data = (int8_t*)data;
>      ++	tz = *tmp_data++;
>      ++	tz = (tz << 8) | *tmp_data++;
>      ++	tz = (tz << 8) | *tmp_data++;

This has a funny skew towards negative number.  Any time MSB of the
one of the three bytes is set, tz becomes negative.  Worse, a byte
taken from *tmp_data that has its MSB on will _wipe_ what was read
in tz so far, because its higher order bits above 8th bit are sign
extended.  If the incoming data is evenly distributed, 7/8 of the
time, you'd end up with a negative number in tz, no?

I think you can and should pick bytes with uint8_t pointer to avoid
sign extending individual bytes and sign extend the resulting number
at the end.  Or if it is too cumbersome to do so, using "int16_t tz"
and filling it with two bytes from *data will sign extend itself
when we pass it to show_date() as a parameter of type "int", which
may be the easiest to code, I suspect.

Thanks.

