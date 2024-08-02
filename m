Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449441F94C
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722610875; cv=none; b=sb03ax+qsslNLc0idU8fOkTh/sQ5OnVRUAJEj7wfSlTV+GyjkHOGwjYyLn9gMhJBntMM4q+PQXY82m1nYaCqZlgKYpvlP1f7JN7cin2VjIFLAF3XhO8N8wmNZOEEX/0NWH7NWPai5stE/wyzPSodJB0sD697vj0BKAdglwHUdAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722610875; c=relaxed/simple;
	bh=8sJ6nSLhINgXcX5JjJWHuJJZIJ3t+l3SouX2DmtvNtA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=umOF9qHrxQzkmoOPFutIUaUTOUAyEWV3bbIA9jZsGlpoO3+OfkYswNBF6/JU7n0gOvL1+rv5g5cMsgxrOGs6XBYzcDkYbQObg8hBIrH+sy9lcOzHWOQwF5rTAemxpD5DhDnpkfkd0cd/0P1taT5AywQLxT1p/Ftx2Bwr1XZsPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=knFEISMP; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="knFEISMP"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 29C0C26477;
	Fri,  2 Aug 2024 11:01:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8sJ6nSLhINgXcX5JjJWHuJJZIJ3t+l3SouX2Dm
	tvNtA=; b=knFEISMPbPKIXlQ75790QnQpT+itpLTZua5WqqXzs/2e4+WwJPTpEf
	kr1MRAe0Dq4Q3T8w4K36iVKj//MhQPfblJtoJaVP5qXXvJ/yN4iynV4fFjJf+iBR
	v6OAGpoJOgklMXNmq85yURq4S0MgV0S5vbp6QrK6eD7VLKE+grfKs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 21A0026476;
	Fri,  2 Aug 2024 11:01:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 62C1D26475;
	Fri,  2 Aug 2024 11:01:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH 1/3] set errno=0 before strtoX calls
In-Reply-To: <ZqxqtIJi4-xBL9Sj@tanuki> (Patrick Steinhardt's message of "Fri,
	2 Aug 2024 07:12:20 +0200")
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
	<4dbd0bec40a0f9fd715e07a56bc6f12c4b29a83c.1722571853.git.gitgitgadget@gmail.com>
	<ZqxqtIJi4-xBL9Sj@tanuki>
Date: Fri, 02 Aug 2024 08:01:11 -0700
Message-ID: <xmqq34nngea0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0EE0112E-50E0-11EF-8223-BAC1940A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> It would be great if we could extend those wrappers to cover all of the
> integer types, convert our code base to use them, and then extend our
> "banned.h" banner. I'm of course not asking you to do that in this patch
> series.

A good #leftoverbits material.

> Out of curiosity, why do you hit those errors in your test setup? Do you
> use a special libc that behaves differently than the most common ones?

;-)
