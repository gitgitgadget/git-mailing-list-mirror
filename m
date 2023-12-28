Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4117CD
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 00:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XINM70fl"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CF99218A91;
	Wed, 27 Dec 2023 19:19:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WV7WL2Jjd6Qx7zRzGnacyNikREWHl2ZiFESibN
	+T8Vw=; b=XINM70flayJ7ks/813F9IFxih8V3bsE+uRE/oGWifq1tohYfLd0rKa
	9beDLZbVrjWgPPbpK9jrAM6VtXJBDy1maPplCpCTRXAuTsHmAoxcCUyOzsY7AQaw
	adtZR7RYV58GYvv1ti5tkT4tfNpLFCzI2oMXnuJSK7kyKu+AoBCGo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CA09018A90;
	Wed, 27 Dec 2023 19:19:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6B86C18A89;
	Wed, 27 Dec 2023 19:18:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] sparse-checkout: use default patterns for 'set'
 only !stdin
In-Reply-To: <CABPp-BF3Vqq8Y8+2pQyO7-StUVPR3as+Q_aL+o92ydoJY-8zEw@mail.gmail.com>
	(Elijah Newren's message of "Sat, 23 Dec 2023 23:51:19 -0800")
References: <20231221065925.3234048-1-gitster@pobox.com>
	<20231221065925.3234048-3-gitster@pobox.com>
	<CABPp-BF3Vqq8Y8+2pQyO7-StUVPR3as+Q_aL+o92ydoJY-8zEw@mail.gmail.com>
Date: Wed, 27 Dec 2023 16:18:57 -0800
Message-ID: <xmqq1qb7kwlq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B250740A-A516-11EE-B4E3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Elijah Newren <newren@gmail.com> writes:

>> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
>> index 8f55127202..04ae81fce8 100644
>> --- a/builtin/sparse-checkout.c
>> +++ b/builtin/sparse-checkout.c
>> @@ -837,7 +837,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>>          * non-cone mode, if nothing is specified, manually select just the
>>          * top-level directory (much as 'init' would do).
>>          */
>> -       if (!core_sparse_checkout_cone && argc == 0) {
>> +       if (!core_sparse_checkout_cone && !set_opts.use_stdin && argc == 0) {
>>                 argv = default_patterns;
>>                 argc = default_patterns_nr;
>>         } else {
>> --
>> 2.43.0-174-g055bb6e996
>
> Thanks for catching this; the fix looks good to me.

Actually I am not so sure.

An obvious alternative would be to collect the patterns, either from
the command line or from the standard input, and then use the
default when we collected nothing.

But I guess those who use the standard input should be able to
specify everything fully, so it would probably be OK.
