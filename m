Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C6D3D564
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757272; cv=none; b=OCVdOPMYTJRodWyzEHINm+NEnu1Il9scQz+Q4LN5n1avPAZ7GWKme74RaGkuw3kkt78uU6mwJQy+2IP2E7XQbvKHsYtPbvD7+bC9U6S+5HycsdpAN1vOl3wIdvOZHr1QhJK9/WJ0HIlYVJ/woLySVMLY/js9e9KqAsR7fAyj4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757272; c=relaxed/simple;
	bh=Eji4NqJAYGyfJ2KiiYQlsTt1XtMvhg+tutoC/fHAG1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MWVfM2A608Q7HhGxNF9WyNQkfiEle8+G93XfR7kcPDNjiliutqri1BoKwktMA1T79WhZWqLIdYbL5YVBYiAy4CZHp9UCXnMfTHPfsfOvDQmruwGCqSKtJX8n0v6onRjI2VCsvAc3BcmaOp084OByWwWiOSWnLwHDKkq4uzs7Kzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZKiI3/Re; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZKiI3/Re"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 67E611F3086;
	Mon, 12 Feb 2024 12:01:09 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Eji4NqJAYGyfJ2KiiYQlsTt1XtMvhg+tutoC/f
	HAG1M=; b=ZKiI3/ReC0PzzT9/y90gKLbFQtSCw0xOjFfwRRIUDSgROGEaKjhjwm
	V90anyVvI1i5pOgbnbANBKb/numQz7Wiq4YyjZ7LrR7MGlTrWcUuULMKNpiAk42S
	CoVR7iUeaJWC9FoJsv07GpZZblDtB8Aij+C7q4jAE1YaAILRIf2Fg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5624F1F3085;
	Mon, 12 Feb 2024 12:01:09 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C09A1F3084;
	Mon, 12 Feb 2024 12:01:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  phillip.wood123@gmail.com,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/5] refs: introduce `is_pseudoref()` and `is_headref()`
In-Reply-To: <ZcoTbRxIaGmTd4fJ@tanuki> (Patrick Steinhardt's message of "Mon,
	12 Feb 2024 13:47:41 +0100")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240211183923.131278-1-karthik.188@gmail.com>
	<20240211183923.131278-2-karthik.188@gmail.com>
	<ZcoTbRxIaGmTd4fJ@tanuki>
Date: Mon, 12 Feb 2024 09:01:06 -0800
Message-ID: <xmqqeddh7h2l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 50C32418-C9C8-11EE-9DC5-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I think it's quite confusing that `is_pseudoref()` not only checks
> whether the refname may be a pseudoref, but also whether it actually
> exists. Furthermore, why is a pseudoref only considered to exist in case
> it's not a symbolic ref? That sounds overly restrictive to me.

I am torn on this, but in favor of the proposed naming, primarily
because is_pseudoref_syntax() was about "does this string look like
the fullref a pseudoref would have?", and the reason why we wanted
to have this new function was we wanted to ask "does this string
name a valid pseudoref?"

 Q: Is CHERRY_PICK_HEAD a pseudoref?
 A: It would have been if it existed, but I see only
    $GIT_DIR/CHERRY_PICK_HEAD that is a symbolic link, and it cannot
    be a pseudoref.

I can certainly see a broken out set of helper functions to check

 - Does this string make a good fullref for a pseudoref?
 - Does a pseudoref with his string as its fullref exist?

independently.  The first one would answer Yes and the second one
would answer No in such a context.

Thanks.

