Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F0F13C3D5
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726606282; cv=none; b=cSjGnlq2uxnFnpHnERJbgA5FItgpLGX2JkAG/CnFe+z/j7D61OTWk5Sg7MJ7N2l2ZX5Dl7vtDURfKiWRbAK/pEU+8fZUmsUJ8KZ5aYRRR6hmqWpPe/JUh/o07Jo6yvvSYqwS6kGFNmgXk9aHudiTbpINJ3ixeMv8VHziW/uRG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726606282; c=relaxed/simple;
	bh=FFEVUbwF1rjGAtINQPe4iFHfx94C5dNNj48lgtXkhcM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V6DusLDfjcCtMp8WR85oTUhFB6+g82QnTuiQc02LA6geCPcfyeLI6UcGHqN4INQGLdtcQdkaKPPVHhN6EKHmxChMnIclNAqBsmYQH/X/7AwL2kktjz/HGuax2+GyUgAtIZkH3nUZSLZumwALtQpyRToHczoKqHzg+tb4sP0ZmzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lXs06vO2; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lXs06vO2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 44C4327D68;
	Tue, 17 Sep 2024 16:51:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FFEVUbwF1rjGAtINQPe4iFHfx94C5dNNj48lgt
	XkhcM=; b=lXs06vO2gpVJwKewpCf9uw4t/hIfpX2eRRjxjM2hBFPnvTADG3ZZP8
	JZhyfLuOPgzNkdfpb4OpXB7SLQjLjosaJSJTPev8J+rB1NuQpLXlZEx8wD5z2gUQ
	VDI2WtgfD4eJZ0iBVOQVs0121rwEv6kKom0hVZLRwZF++CD4eCzFQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CB5D27D67;
	Tue, 17 Sep 2024 16:51:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A8CD327D66;
	Tue, 17 Sep 2024 16:51:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>,  "Johannes Schindelin"
 <Johannes.Schindelin@gmx.de>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,
  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  "Patrick
 Steinhardt" <ps@pks.im>,
  "Christian Schlack" <christian@backhub.co>,  "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v3] set-head: no update without change and better output
 for --auto
In-Reply-To: <D48UGAZA205N.37QFSURUDN3ZS@ferdinandy.com> (Bence Ferdinandy's
	message of "Tue, 17 Sep 2024 22:32:54 +0200")
References: <20240915221055.904107-1-bence@ferdinandy.com>
	<xmqq5xqvo37s.fsf@gitster.g>
	<D48UGAZA205N.37QFSURUDN3ZS@ferdinandy.com>
Date: Tue, 17 Sep 2024 13:51:17 -0700
Message-ID: <xmqq34lyknqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 96998B7A-7536-11EF-99E9-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> On Mon Sep 16, 2024 at 20:36, Junio C Hamano <gitster@pobox.com> wrote:
>
> [snip]
>
>>  - This is inherently racy, isn't it?  We read the _current_ value.
>>    After we do so, but before we write _our_ value, another process
>>    may update it, so we'd end up overwriting the value they wrote.
>
> So I've been thinking my first patch need not be so ambitious. The current
> behaviour is to indiscriminately overwrite remote/HEAD. So what if we dial this
> back a bit, leave the indiscriminate overwrite in place (the added benefit of
> that is pretty small anyway) and only improve the printed output, which was the
> main goal anyway? 

Yes.  You could ignore races and it does not degrade correctness of
the end result (i.e., you will still get the same "oops, that is not
what I wrote, but somebody else overwritten what I wrote" and vice
versa).

Your new messages that try to differenciate "we noticed you are
writing the same so we refrained from doing anything" and "we wrote
this new value" can racily incorrect the same way.  In other words,
the message may claim that we detected a no-op change from value A
to new value A hence we didn't do anything, but after the detection
somebody may have wrote another value B from sideways, so the last
message that hit the end user's eyes may imply the resulting value
ought to be A but it is not because somebody else silently changed
it to B.  If we did not skip writing using racy logic, we would have
written value A and reported that we updated it to value A, but the
other party who silently wrote B may do so after all that happens,
and the end result the user would see is the same (i.e. we tell the
user the last value we expect it to be is A, but the final value is
B).

So, as long as we can explain the behaviour to the end-user well, I
do not care too deeply.  My impression was that avoiding it by just
taking advantage of the atomicity afforded by create_symref() looked
like a low hanging fruit, but that can be done by somebody who are
curious to see how involved such a change actually is and can be
safely left as a #leftoverbit ;-).

Thanks.



