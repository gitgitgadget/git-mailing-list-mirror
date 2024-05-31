Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB43357CAC
	for <git@vger.kernel.org>; Fri, 31 May 2024 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166965; cv=none; b=aalMfbyfqZp+wqbafaguyBas0tBzrmxaCfXtXPz80cZP0dUwA0fRbDTKegg69rnuHfmEmkJKFVNesFdaxTdDYJ0yGidYOBZIbAeEmi3RYmtjMMyzCLGrldzgS1dEkBju1NxTa9jA6GkuUQCQGvqS/ifHCjaa2l0BgiVAXXiIKeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166965; c=relaxed/simple;
	bh=yuemrFtvnvPYGXbmgLbNez3GbwhEWlmsk05fe7xYUzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eKMNAy0vrbH8B0Hi6Gcf06dT9qSmOp+ONC2P2GpTa7lnvOEEFKU2slBW8LQ7VzhcJGYkE/0g1fTE17q4OjyZTQ75KzusqE0U5p81iBmh1+FaH66LkYlWRnoNwYRgmnlxgbDary3mOVr9tEptCJDBe8X8wXuydDWUa6knBvWzmGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dYOhnCTE; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dYOhnCTE"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 748CF1A48C;
	Fri, 31 May 2024 10:49:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yuemrFtvnvPYGXbmgLbNez3GbwhEWlmsk05fe7
	xYUzI=; b=dYOhnCTE4RuMIuQBCicXCAQj3gHcyBpKk1OQCjOjaLjTQagxxYPtcE
	hb1sDU6S0++4NDTGVoLfrvDYpw/nq+AXSqABLQdFQ0mmvH/ifE6vLxCIhoE/WlEN
	5D0O4CfiNwCVowzTZsdfFpuv1VgV+kBW+8mvZnznZ5BjJ/l2qFEMc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D2191A48B;
	Fri, 31 May 2024 10:49:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 211B71A48A;
	Fri, 31 May 2024 10:49:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Stefan Metzmacher <metze@samba.org>,  git@vger.kernel.org,  Derrick
 Stolee <stolee@gmail.com>
Subject: Re: safe.directory wildcards
In-Reply-To: <ZlmH1CFZWHokAqso@tanuki> (Patrick Steinhardt's message of "Fri,
	31 May 2024 10:18:28 +0200")
References: <715163c3-8d59-46ef-81bf-1dda10e6570c@samba.org>
	<xmqqplt4zjw7.fsf@gitster.g> <ZlmH1CFZWHokAqso@tanuki>
Date: Fri, 31 May 2024 07:49:18 -0700
Message-ID: <xmqqy17qhw9d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F64D5D7E-1F5C-11EF-B198-8F8B087618E4-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> I am reluctant to use wildmatch() but I would expect that in
>> practice "leading path matches" (in other words, "everything under
>> this directory is OK") is sufficient, perhaps?
>
> Is there any particular reason why you don't want to use wildmatch?

Mostly out of the principle to avoid anything more complex than
absolutely necessary in a security relevant code path.

It is called "superstition" in other languages ;-).
