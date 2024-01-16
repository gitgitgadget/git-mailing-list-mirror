Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7FA18E06
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BlEkRSLb"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9AA783FF38;
	Tue, 16 Jan 2024 11:44:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H2lBokssu9o9PmdQ5ttTV+wVE6+NPw5ZgtH3mN
	pYoL8=; b=BlEkRSLbKra3FCzf1vFmslJ979Ll6z9TEee1hX7mCfnhaibJsfCWX7
	SQcai0UwbCfx+Vj8JKR0fQy4dMU0NtZrh2NlFqo3+D7fBpmrcl5wQe4miFcuWprg
	e8Iua6CGAO92C9bno6JV50m7Xm/I2nbi/7MffBVnltVspcqoGvxHQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 93CED3FF37;
	Tue, 16 Jan 2024 11:44:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 44E353FF36;
	Tue, 16 Jan 2024 11:44:19 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Han-Wen Nienhuys
 <hanwenn@gmail.com>
Subject: Re: [PATCH v2 2/5] reftable/stack: refactor reloading to use file
 descriptor
In-Reply-To: <20240116151447.GD2119690@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 16 Jan 2024 10:14:47 -0500")
References: <cover.1704714575.git.ps@pks.im> <cover.1704966670.git.ps@pks.im>
	<36b9f6b6240686cc5b0a761b889614fc31f01d34.1704966670.git.ps@pks.im>
	<20240114101424.GA1196682@coredump.intra.peff.net>
	<ZaUC-WevQqOj31u9@tanuki>
	<20240116151447.GD2119690@coredump.intra.peff.net>
Date: Tue, 16 Jan 2024 08:44:17 -0800
Message-ID: <xmqqv87t1b4u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7E55FDFA-B48E-11EE-AE48-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

>> So overall this works as intended, even though I would not consider it
>> to be the cleanest way to handle this. Unless you or others think that
>> this should be refactored I'll leave it as-is for now though.
>
> Thanks for confirming. I think we can leave your patch as-is. If
> anything, I would say that stat_validity_update() should check for "fd <
> 0" itself. Not because I think fstat() is unlikely to behave differently
> on some platform, but simply because it more clearly documents the
> expectation.

Thanks, I agree with your point that we should avoid calling system
functions that take a file descriptor with a known-invalid (like
negative) one.
