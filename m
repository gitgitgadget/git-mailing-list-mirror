Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67A481215
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706038302; cv=none; b=GR6wozudNPhm0q+GTCm9CYZDrLfOY8LBZ0ZysImUJvsAG57Pf+uy5RZx5SvUIPyxn5kMCmdM+fViwMFoSvs4+dUhDD9eJQXMnfuH87NBxLUH/2KUc5M5m/4CdgRr+6bS4Kb5/KzAlq/XkKkPLhxNbveR3g8cGYbK5cRbBAJgC9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706038302; c=relaxed/simple;
	bh=e/lnipFyqy6Nh2YDlaVoDswx67ScE4c2o/a+rm4/nPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sunutrr8oy/Isi+yXkjHxL94XkFZmY9aO2/MfnKnThULESX3R6/bVkl/3c9K1WYMSZf4PwcJwy6TGuNScJyB0/uJjuaFrEui/UXFHM4JdcBfrB6aIxGakvUTfUKJ4WdmLokrRGzs1wlMg+6ocsh2xeHh6jW83c5VALhKbs79mG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XBWhCQmX; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XBWhCQmX"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 71F093315D;
	Tue, 23 Jan 2024 14:31:40 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=e/lnipFyqy6Nh2YDlaVoDswx67ScE4c2o/a+rm
	4/nPg=; b=XBWhCQmXuurSdDPJNw9Jer1e+l4Lg0OrZ6ZKwYs/xunRBpk7pQdB1V
	GEBrlPclhyRyCzXuItCgJXzrz9s31l2yaQBYMJ8VHglicr1W0Ln4JfogQ+KTK2VN
	obcQYuOa4p0iSJyPjBfyCPLcPGLHnr1WGU8dMIKgK9ub7rAS3PDLA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 69F893315C;
	Tue, 23 Jan 2024 14:31:40 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 045643315B;
	Tue, 23 Jan 2024 14:31:36 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] reftable: honor core.fsync
In-Reply-To: <pull.1654.git.git.1706035870956.gitgitgadget@gmail.com> (John
	Cai via GitGitGadget's message of "Tue, 23 Jan 2024 18:51:10 +0000")
References: <pull.1654.git.git.1706035870956.gitgitgadget@gmail.com>
Date: Tue, 23 Jan 2024 11:31:35 -0800
Message-ID: <xmqq34unn8x4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 062F293A-BA26-11EE-B4EA-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This commits adds a flush function pointer as a new member of
> reftable_writer because we are not sure that the first argument to the
> *write function pointer always contains a file descriptor. In the case of
> strbuf_add_void, the first argument is a buffer. This way, we can pass
> in a corresponding flush function that knows how to flush depending on
> which writer is being used.

A comment and a half.

 * Can't the new "how to flush" go to the write-option structure?
   If you represent "no flush" as a NULL pointer in the flush member,
   most of the changes to the _test files can go, no?

 * For a function

	int func(int ac, char **av);

   a literal pointer to it can legally be written as either

	int (*funcp)(int, char **) = &func;
	int (*funcp)(int, char **) = func;

   but it is my understanding that this codebase prefers the latter,
   a tradition which goes back to 2005 when Linus was still writing
   a lot of code, i.e. the identifier that is the name of the
   function, without & in front.

