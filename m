Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B813BAE0
	for <git@vger.kernel.org>; Fri, 10 May 2024 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376335; cv=none; b=GYvDj9/B+05cwEztxvMkXx9yz6mHclFlGNxmOXeZY3i3xSG3ijAtjiQmI4P+XH7HX7EFZPeQBRnRhMjQG11req4RjoTHcZT/Ew8WYUAM+cwIwdS8z+O135u+LSV+l+EvvtqkChBbFmfXHDil38NRM9E046z0X85yl0GRjnvh2L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376335; c=relaxed/simple;
	bh=aXFjtFWmCZDNFG4UWs0rMWajiHXbFQyTuipiGCIgwqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eUurvnsB5rk3hJ0deW2tgmXP/OCdh0fnefGcborOyAH3CqR56MTIDQUww5fN2HzNRzk+q1V4tTaUoRs4Wdm7969hln5H9LLScAEyb8DvfHI6Ltu+ro+YvApxA0NR9K+qkGPB94LGUixEnziORbxSn+LEinq3UUjOo5hDD8oXeRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BqapXjuj; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BqapXjuj"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CAEFA36F0A;
	Fri, 10 May 2024 17:25:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aXFjtFWmCZDNFG4UWs0rMWajiHXbFQyTuipiGC
	Igwqk=; b=BqapXjuj0TU3MrZmGEEDk80w5axzZKgk4xYBTHD+TxbDwvi2wuKr6B
	d+JV+Yv60CYrq4ZUSESex6aK6YySD/ucD7LRAjOcbHoB+WHGiTuk7zXMAWuJtzaj
	r7OvuuZ6aUFfpOrG+rzk1fVhYdPMBAvNc0bKjOqWyAtBflw2eQRHs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C2F0D36F09;
	Fri, 10 May 2024 17:25:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 50FE136F08;
	Fri, 10 May 2024 17:25:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 04/11] reftable/writer: improve error when passed an
 invalid block size
In-Reply-To: <5e7cbb7b193c578f7c946a5077a79421b0ac57f2.1715336798.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 10 May 2024 12:29:35 +0200")
References: <cover.1714630191.git.ps@pks.im> <cover.1715336797.git.ps@pks.im>
	<5e7cbb7b193c578f7c946a5077a79421b0ac57f2.1715336798.git.ps@pks.im>
Date: Fri, 10 May 2024 14:25:28 -0700
Message-ID: <xmqqo79d2wc7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D3C512A0-0F13-11EF-89BE-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The reftable format only supports block sizes up to 16MB. When the
> writer is being passed a value bigger than that it simply calls
> abort(3P), which isn't all that helpful due to the lack of a proper
> error message.
>
> Improve this by calling `BUG()` instead.

As a "git" person, I do not mind this at all.

But doesn't the reftable/ library codebase want to avoid things like
BUG() that are very much tied to our codebase, for the same reason
as it avoids things like xmalloc(), xcalloc(), and ALLOC_GROW()?

We may have crossed the bridge long time ago, though.  We see a
handful calls to BUG() already inside reftable/ directory.
