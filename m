Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AAE450EE
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195949; cv=none; b=jVvBjYetUqmn7inaC0wY1RHFNMz8fhI+6MkGFOoY39e2FXf2zxcjYncKhd2BDSBlwyEiaCJbEtSnrzm5TbjRaXpfciLt0Q53vuYoXyn+IST/d7hr9w1vnIxzQsvTQEyy67P7FKQicNw30wQudcHBjb6pSpSYcYHGO/8Mz+XxNBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195949; c=relaxed/simple;
	bh=iaV1eJTRQXJsbVZIjDTQ8UFPiDIKCfhuRbcoM5bQmgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AtOzfZx47vB7uSupstD+o5OGp5QFF1KLYdHhWGZWRkBsHCwKFiQ3jPSIOJLWGb/FRo5EagWlpaP5HucJumfpnW8G9A5GJWYIbEt5KPLN8N1wRFD6ln84RExvBshvJp8UXGpTW3TZ3GWBTDjNq0Dt4moTIT74clVKM5N0fA8Lmz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cGJ/KGy+; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cGJ/KGy+"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D5E9119CF4;
	Tue, 24 Sep 2024 12:39:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iaV1eJTRQXJsbVZIjDTQ8UFPiDIKCfhuRbcoM5
	bQmgw=; b=cGJ/KGy+zyq35L07FMdlxh6ZLQ6Jo9Rk3z/HhFuhweKbzeV+BpkNtC
	oQ2NQs/WpakSCbKFdsT8Bi33Ha9M8pjgUdFDdNVxkMPQzfOC+XHDA789Y+55WgNX
	bELa5hNE6z3PGYEwkbXW707+b6w2Khx8ciJtdNVkBqITT5JzZa7cQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CD52F19CF3;
	Tue, 24 Sep 2024 12:39:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2588919CF1;
	Tue, 24 Sep 2024 12:39:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Edward Thomson <ethomson@edwardthomson.com>,
    Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH 04/22] reftable/basics: handle allocation failures in
 `reftable_calloc()`
In-Reply-To: <ZvJSyT8OsUVLln4A@pks.im> (Patrick Steinhardt's message of "Tue,
	24 Sep 2024 07:48:57 +0200")
References: <cover.1726489647.git.ps@pks.im>
	<e6ded75f630ea309d5b76126560a0ec3d526bf71.1726489647.git.ps@pks.im>
	<xmqqed5cajd5.fsf@gitster.g> <ZvJSyT8OsUVLln4A@pks.im>
Date: Tue, 24 Sep 2024 09:39:04 -0700
Message-ID: <xmqqy13huhuf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 83CC23CE-7A93-11EF-8A95-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In any case, there's another, bigger elephant in the room: `struct
> strbuf`. I will have to introduce a reftable-specific buffer type for
> this such that we can handle allocation failures here, too.

Oh, that one.

If you are letting your callers to register allocation callbacks,
you'd want to make sure any code you use, in cluding strbuf, would
take pieces of memory from and return them to the registered
allocation routines.

> While the
> alternative would be to amend `struct strbuf` itself to do that, I don't
> quite think that we should do it in "core" Git itself for now.

Punting is of course an option, but what do the "libification" folks
want to see happen (Emily Cc'ed, not necessarily because she
personally did work in libification, but she knows who is responding
to the list this week)?  Wouldn't we eventually want these common
things not to die but to gracefully fail?
