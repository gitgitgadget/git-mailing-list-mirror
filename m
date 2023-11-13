Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2439C3D975
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 23:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JEUtzLPR"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC508F
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 15:27:38 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A54EB1C1ACD;
	Mon, 13 Nov 2023 18:27:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5TJ7dxkWZiGZUYIHBI+hlxhrx2obQVofJeCsgt
	x6y60=; b=JEUtzLPRizsfvBJhMYwHaaXSS/zss8jrqhWKJJrzCLzbvL1RdZq0hI
	MmUOPQf6oJvsBtQwkMzAq//bLX6dEHtZm+7neKKzMK6M2pi2lwY9BhMUiW/hVLRj
	VMvstaj2tTKADbhjl4Ai5XUj9rc3jRjNBVqWIUBF1cXctBilWBYKw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A2C11C1ACC;
	Mon, 13 Nov 2023 18:27:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E83E61C1AC9;
	Mon, 13 Nov 2023 18:27:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Arthur Chan <arthur.chan@adalogics.com>
Subject: Re: [PATCH v2] fuzz: add new oss-fuzz fuzzer for date.c / date.h
In-Reply-To: <pull.1612.v2.git.1699892568344.gitgitgadget@gmail.com> (Arthur
	Chan via GitGitGadget's message of "Mon, 13 Nov 2023 16:22:48 +0000")
References: <pull.1612.git.1699724379458.gitgitgadget@gmail.com>
	<pull.1612.v2.git.1699892568344.gitgitgadget@gmail.com>
Date: Tue, 14 Nov 2023 08:27:33 +0900
Message-ID: <xmqq4jhp5j4q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 39A3BDD0-827C-11EE-80FA-25B3960A682E-77302942!pb-smtp2.pobox.com

"Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);

It is somewhat annoying that everybody has to repeat this twice
here, but it is not your fault X-<.

> +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
> +{
> +	int local;
> +	int num;
> +	uint16_t tz;

tz offset can be negative, so uint16_t is not appropriate.  See
date.c:gm_time_t() that is eventually called from show_date().

> +	char *str;
> +	timestamp_t ts;
> +	enum date_mode_type dmtype;
> +	struct date_mode *dm;
> +
> +	if (size <= 4)
> +		/*
> +		 * we use the first byte to fuzz dmtype and local,
> +		 * then the next three bytes to fuzz tz	offset,
> +		 * and the remainder (at least one byte) is fed
> +		 * as end-user input to approxidate_careful().
> +		 */
> +		return 0;
> +
> +	local = !!(*data & 0x10);
> +	dmtype = (enum date_mode_type)(*data % DATE_UNIX);
> +	if (dmtype == DATE_STRFTIME)
> +		/*
> +		 * Currently DATE_STRFTIME is not supported.
> +		 */
> +		return 0;

There is an off-by-one error above, as modulo DATE_UNIX will never
yield DATE_UNIX.  Presumably we could do something silly like

	tmp = *data % DATE_UNIX;
	if (DATE_STRFTIME <= tmp)
		tmp++;
	dmtime = (enum date_mode_type)tmp;

to pick values from [0..DATE_UNIX) and then shift everything above
DATE_STRFTIME by one to create a hole there and fill DATE_UNIX at
the same time, without wasting a sample by returning.

> +	data++;
> +	size--;
> +
> +	tz = *data++;
> +	tz = (tz << 8) | *data++;
> +	tz = (tz << 8) | *data++;
> +	size -= 3;

If your tz is 16-bit wide, then we do not have to eat three bytes
here, do we?

You never answered my question on your intention.  Is "tz"
considered attacker controlled (and needs to be fuzzed including
invalid values)?

> +	str = (char *)malloc(size + 1);
> +	if (!str)
> +		return 0;
> +	memcpy(str, data, size);
> +	str[size] = '\0';
> +
> +	ts = approxidate_careful(str, &num);
> +	free(str);
> +
> +	dm = date_mode_from_type(dmtype);
> +	dm->local = local;
> +	show_date(ts, (int16_t)tz, dm);
> +
> +	date_mode_release(dm);
> +
> +	return 0;
> +}
>
> base-commit: dadef801b365989099a9929e995589e455c51fed

Thanks.
