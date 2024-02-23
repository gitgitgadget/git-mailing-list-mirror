Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DAE12BEA0
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712606; cv=none; b=FQHQYcwJGAuDteZc4H0NP7ZUGR65AHZEiU7losG5AO9zAnGemBCNuyA0DrMh7GaMS+1PI/s3f2P1qmI1UcaQYpuTUn78mpCWcWzmdj7JcY1UejDxyZ2JfVfJezCO/44Ww02nAC3Jkw8L42sRYkXk2BX13TjfWZ/PoXMzaGN7P40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712606; c=relaxed/simple;
	bh=kXVwk9SIOaTY4RzqUBl0Y6vWLw2dNRc5zs/y37jc/yg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WNrjawbrRK9uGTfsR4pD9mlf8GvmWJntKGok6SSMUt0dgAHWhSpDa7hOeSqKiPFp1Gbco6Tdo1DQlSjYh/teHyLsws4iMus3Aqpg6R3So+bkn2CXZK2pdaLrRpjXQtTpAvmDQXE8TW9Jdex7m/rk91bPGiS1MblP6xepplkitME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zwh1wCH1; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zwh1wCH1"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A0F9822E38;
	Fri, 23 Feb 2024 13:23:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kXVwk9SIOaTY4RzqUBl0Y6vWLw2dNRc5zs/y37
	jc/yg=; b=Zwh1wCH17Xww//6L4a8bRcpmCP3336S1zyOxRZ5fv2XsAvD4gOm9BI
	VybU4QcgEh3i3aNObgva4Hjot0PJ2551tAdZF49PmLX6B4D1owIqJq3s3GU1ZKnm
	CLy7ZcObFJDhMKBXhGIIdsvYE7G2vaiT/6jBqqaO6nEmWuFvVPrEw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 996A922E37;
	Fri, 23 Feb 2024 13:23:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CA0E222E36;
	Fri, 23 Feb 2024 13:23:20 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 0/6] merge-tree: handle missing objects correctly
In-Reply-To: <pull.1651.v4.git.1708677266.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 23 Feb 2024 08:34:19
	+0000")
References: <pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
	<pull.1651.v4.git.1708677266.gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 10:23:19 -0800
Message-ID: <xmqq4jdzt4yw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9F788824-D278-11EE-9359-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> I recently looked into issues where git merge-tree calls returned bogus data
> (in one instance returning an empty tree for non-empty merge parents). By
> the time I had a look at the corresponding repository, the issue was no
> longer reproducible, but a closer look at the code combined with some manual
> experimenting turned up the fact that missing tree objects aren't handled as
> errors by git merge-tree.

Looking good.  Will replace.  Thanks.

