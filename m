Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7A213A875
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 05:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564376; cv=none; b=tt6UG82qheNTqP9bRBgN/NRiPgQldqfzRJP23JcTGO9G+0Ug3tHjt+IGBzTLAY2fBMoRNUyH1Wy+hGpo/B1VI62fAel6oN1o8+U9BNS2y60HZqc5nqJKCgKs12vXv6fu2HvWI0gKu+ZkmEqwfLD9kx2YPp2t5yXxf20JpLONgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564376; c=relaxed/simple;
	bh=ZcbeGnej9CE8YU4gTL6jfLlkLvLA/IBsYUtbNTAqRw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qOnkeHr6GooWM+ws9vbstFQPHUc3cW1YndgAuR/3aIZKZlCHt3pJc79Dd+qgcpDWklaHOJDeVpV77Led/EQeiRNp90UJ4zZvLqCNrRskg7qu3/Vn71aVbr7kmLSZzEo81BXt9srVZCCCt4nga5Pjm2V0vkZkkd5YmiSFPE7CalE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EziRxg+e; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EziRxg+e"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D167211E8;
	Wed,  5 Jun 2024 01:12:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZcbeGnej9CE8YU4gTL6jfLlkLvLA/IBsYUtbNT
	AqRw4=; b=EziRxg+eAtNoHmZxZLkmkjB9SkfZDT6/637vryO+a5GqoWBaeaQyHe
	mf81CHPLkNU7+pvsIF8Bl1XcIz7t+Mr0Kr1wkk1wnx6bpZK7jD3Y46AdG/dKySHz
	d5D8nyvZnwm6F6ZMu8fBn8O6CVFADT0c/HSqAfYInWNbR2/5nLax4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 04EC8211E7;
	Wed,  5 Jun 2024 01:12:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 20EA6211E6;
	Wed,  5 Jun 2024 01:12:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>, Aaron Plattner
 <aplattner@nvidia.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] credential: clear expired c->credential, unify
 secret clearing
In-Reply-To: <87y17kbavu.fsf@nvidia.com> (Rahul Rameshbabu's message of "Tue,
	04 Jun 2024 15:28:53 -0700")
References: <20240604192929.3252626-1-aplattner@nvidia.com>
	<xmqqo78gtldz.fsf@gitster.g>
	<4521d5ab-c0e8-44d5-90aa-72555681219f@nvidia.com>
	<87y17kbavu.fsf@nvidia.com>
Date: Tue, 04 Jun 2024 22:12:48 -0700
Message-ID: <xmqqfrtsynu7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 411F3200-22FA-11EF-84CA-8F8B087618E4-77302942!pb-smtp21.pobox.com

Rahul Rameshbabu <rrameshbabu@nvidia.com> writes:

>>> Aaron Plattner <aplattner@nvidia.com> writes:
>> ...
>> Rahul (CC'd) and I had a series of patches to add something similar to the
>> current authtype system but hadn't gotten around to sending them to the list
>> before this more flexible mechanism was merged. It's nice that this worked out
>> of the box with minimal adjustment.
>>
>> The credential helper he wrote is specific to the Microsoft "Entra ID" identity
>> provider system, but hopefully it'll be generally useful once this stuff is in a
>> git release. It really cleans up the authentication process over https for sites
>> that support it.
>
> Aaron made a commit to make it work with the authtype/credential
> credential-helper infrastructure that landed in git-next.
>
>   https://github.com/Binary-Eater/git-credential-msal/commit/f71ca9c72ca1a2cf73373de76909f6007ac689cb
>
> The support for authtype excites me since a number of large Git
> providers like GitHub/GitLab/etc. have utilized Authorization Basic
> incorrectly for supporting different authtypes with git previously.
> Hoping they will move away from this practice in the future with this
> enhancement.

Thanks for a huge praise that I do not personally deserve ;-)  Kudos
go to brian and folks who helped reviewing his topic.

