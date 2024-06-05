Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8300A13A268
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608453; cv=none; b=Mh9pBvr1xK7kR/zJU4obrp/Wd5r7NyxvX0L71ZCB82hCH7ABTTYHH20BPUGTxTD/JpVt19YwmiHzM7fssaEWGoeWaYZTtSZ8z7Y1upbNzxv7yO3ac+8SqvY3OFR4Xc7KJ1o2LhMNqxOpXjCOtc6sTjqHaviegfgvqI2JkW2hfko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608453; c=relaxed/simple;
	bh=pjnLtOgu63UgZp7itubM1b6xfOjp6MMALDKswkRzaVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZxBjm0WAppBWa5NQyjkiDxdko/tdv5gzVe3XlSn8weEtolGJTbPWtP1OZ8CnmdRTInH4DDho+bY12TR3xQEV5WsUMTqqRFCNXEQkdnIge+wfox58qmd30pMSsr4nUGeYnEIvfUFB2OjwSfhCJkYckOIPyGbEwk0BEWQ8Dcm8d8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y8Hl5aoo; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y8Hl5aoo"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 037551B61A;
	Wed,  5 Jun 2024 13:27:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pjnLtOgu63UgZp7itubM1b6xfOjp6MMALDKswk
	RzaVI=; b=Y8Hl5aooh8JQrXses1mDWd+7mLWVgKq3loVA2tpr4jCfFz03Fc4QoZ
	ZHQLLHvvaJrQU+HfGdNXi/GsfkTODSd9oVIwhvG48xuctvS4rK2tShxR+vUo7fsE
	3OeG8n1AxBtZyI3P3M6HBfPsdebdLwqOLQEn7/eFlXAji9jHlhQSQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EF1211B619;
	Wed,  5 Jun 2024 13:27:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 183E81B616;
	Wed,  5 Jun 2024 13:27:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: darcy <acednes@gmail.com>,  phillip.wood@dunelm.org.uk,  darcy via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] date: detect underflow when parsing dates with
 positive timezone offset
In-Reply-To: <7ae05b6a-fb63-4ec7-8006-e968862cc5c7@gmail.com> (Phillip Wood's
	message of "Wed, 5 Jun 2024 14:10:23 +0100")
References: <pull.1726.git.git.1716801427015.gitgitgadget@gmail.com>
	<pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
	<xmqqwmn66zzc.fsf@gitster.g>
	<2d771a72-3021-46db-ac32-e008a7ace34c@gmail.com>
	<67c23773-21a4-4ad5-9b98-5e44578166dd@gmail.com>
	<4574e410-ca1a-495f-9835-14ee3fa454a1@gmail.com>
	<7ae05b6a-fb63-4ec7-8006-e968862cc5c7@gmail.com>
Date: Wed, 05 Jun 2024 10:27:27 -0700
Message-ID: <xmqq1q5bti4g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E23BA91E-2360-11EF-A53C-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for taking a closer look, I wasn't aware of that. Reading
> Peff's reply it seems like timestamp is actually unsigned and as we
> limit the maximum year to 2099 it seems unlikely we'll overflow from
> too larger date after all.

Thanks all.

I haven't seen one question I posed answered, though.  Has
https://git.github.io/htmldocs/SubmittingPatches.html#real-name
been followed in this patch when signing off the patch?

