Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EDD2AF09
	for <git@vger.kernel.org>; Mon, 13 May 2024 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640162; cv=none; b=uDd6DrmJDZt3XSWETEG7y2kOPcyGDyFgix6qD/vaOZgmpO/75H9M1VHg4Omc3Hqo1dXmvh9Di8P1KpQKN6S6aQk+6ibb8Lw3TlkN2thczaBVmf8BqPumAoVXNLHaDC1xWgqycrdFKoi2L4zzhQxtFMZe6SdJ/4A2UGXgkbBtKf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640162; c=relaxed/simple;
	bh=cqAjKEv7Hnn34fovs9yhQDX411GVvim0UuNXydKQxX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JDPEGfPxy2yN7d9l9Cn0KHC1VTNzmAU2zgZgs9lfEVTCT6YgiE7Mb7ZwNIiqbFQwc+iJRHfcv0JfLGZx0eik7X7VvuV/khfAhiSDeXbBcm0eMLdQVhPMSUz8994HRDVjr+JHGrD9umIkkCV/7iFOPBqYWr5lGFypH1YjAeVPbq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ve6MVv6Q; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ve6MVv6Q"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76CD137087;
	Mon, 13 May 2024 18:42:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cqAjKEv7Hnn34fovs9yhQDX411GVvim0UuNXyd
	KQxX4=; b=ve6MVv6QzkV63X6HGgdRntKbz80Pyjl5qq1dMh8bGuuArQsZjDAIhy
	54P5Vni+8ecDbzkndgyHfJHAlmzS2BqoqJH5DkhxIiJS2kXard9C3fq6wAkBYtI1
	tJ1PDHGrVQVrGO6kYN8Qi2SEOa8DmsDXdvfA1dvoNdTWZLFtdtQp0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EEEB37086;
	Mon, 13 May 2024 18:42:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB7A437085;
	Mon, 13 May 2024 18:42:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 07/11] reftable: use `uint16_t` to track restart
 interval
In-Reply-To: <05e8d1df2d9921426b803d71b22ba3dba188836c.1715336798.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 10 May 2024 12:29:51 +0200")
References: <cover.1714630191.git.ps@pks.im> <cover.1715336797.git.ps@pks.im>
	<05e8d1df2d9921426b803d71b22ba3dba188836c.1715336798.git.ps@pks.im>
Date: Mon, 13 May 2024 15:42:37 -0700
Message-ID: <xmqqv83hcp0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 19CFF766-117A-11EF-AAA9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The restart interval can at most be `UINT16_MAX` as specified in the
> technical documentation of the reftable format. Furthermore, it cannot
> ever be negative. Regardless of that we use an `int` to track the
> restart interval.
>
> Change the type to use an `uint16_t` instead.

Not wrong per-se, but this one is more or less a Meh, as we know we
do not work on 16-bit platforms anyway.
