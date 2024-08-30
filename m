Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6558514E2E1
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725057044; cv=none; b=NU8dijZNDSc7mXfzT3XTegLvaPfh402HsVcmcE7FWWiVEsVTezj0SwKX6buifLlV/7PzFIy8402CcEdQRw47r0kne45qWoClH+7ADlyQk3PpRNKxsCTVq3q/s8HhYeOHs3duaFj9SJtcJKhO9RbNe/LFqFSQ+4LAw7eWjlJ2Jv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725057044; c=relaxed/simple;
	bh=FgTSOeedJ+VR8mlFsg81wLn1DFJx0aptlnIwBds5cW8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nKifuOHDl0K79FeDamCj22Z2+yffOapFdkKn+2aGxx6/DdxJSXOSWIeQwn3h1uffbMugENBfXWkin6H62SHrALGUWrNf+wm7Y1fxnsTqeMEY8EpW93JoqecOIe03fIj+7KnMqJK7HH8yBb9YmjWxGTqKlA30tbqF2IcvMW1A0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=H5sJ4ZC2; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H5sJ4ZC2"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 29D70330F1;
	Fri, 30 Aug 2024 18:30:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FgTSOeedJ+VR8mlFsg81wLn1DFJx0aptlnIwBd
	s5cW8=; b=H5sJ4ZC2ZvDpR38JZz+fxXTo+nkZ6FxMjklb7LlAeQ7oSup761e95u
	BDkfPoc72aeC8wU1jVV2V7oWH4PK8rtViQ9yXawmtYMFCnPr2/Gtpa8ul9MNCnqm
	3oc3TbzOR/SQIUjM6DvGBhIvMS5btNImFYD4/bge6z2MlfKhkhvKo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 21671330F0;
	Fri, 30 Aug 2024 18:30:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B995330EF;
	Fri, 30 Aug 2024 18:30:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/22] upload-pack: fix leaking child process data on
 reachability checks
In-Reply-To: <77023421e189aee6837cea9b25841ea258bc06e3.1724656120.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 26 Aug 2024 09:21:48 +0200")
References: <cover.1724656120.git.ps@pks.im>
	<77023421e189aee6837cea9b25841ea258bc06e3.1724656120.git.ps@pks.im>
Date: Fri, 30 Aug 2024 15:30:39 -0700
Message-ID: <xmqqplppprsg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7CA4463A-671F-11EF-B3FF-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We spawn a git-rev-list(1) command to perform reachability checks in
> "upload-pack.c". We do not release memory associated with the process
> in error cases though, thus leaking memory.

Thanks for plugging this leak dating back in ages.

Both changes look sensible to me.

