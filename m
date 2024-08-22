Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCAC28389
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342647; cv=none; b=NcVyM0yEmqrIJPWAPA+YqlwY8qZ292RNUyNDgKBq2n0goLykPpHlnrPAZxwvAY8QFVaTj/kklJY8CqAF1PZzuGo8mE7hgFTQdw48xq+UikyVyCHK3+JqYS7lWbCxMQvhElZMKDy8EvPpIi646QcycUsKC1cbD0EsX497YEYdNdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342647; c=relaxed/simple;
	bh=4ksZrC4+p66mz3gIkJJ7v6vbwYK9/fs2bguQ4d0pOBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X0Fu7+S48g7masT3hjiAg2u0kkx/B3bFoPdsKNt8CbwznAAV3R95FvjZPJ5llCyjif3wnpz9UokfrAVnKpJ2mdv6XtupKHNjmzEZ2zxbeK7DHT/i+xkSVB6NmBhCjZYH/A6ymqtOzkoHj4U/uvyHJ9MU2IGHnnOWLXV3YhK+flQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=u+1vinDA; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u+1vinDA"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5530B198CC;
	Thu, 22 Aug 2024 12:04:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4ksZrC4+p66mz3gIkJJ7v6vbwYK9/fs2bguQ4d
	0pOBA=; b=u+1vinDAT4Y9vLbG9ZhuObaNU2sZJC0lxuMJhnM70ypGohYeOb4/a1
	RrkbkAoOikGEMfBpPfpIQTWu7TDj4IU8Hyf3DcfFNDphDZTzlWsTExvPJdcQ02pY
	imPuU4ChU3VDhdoKdzsgMcIJcpR7wAyqfCP/iRLubT9Xrsos5r8Jo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E676198CB;
	Thu, 22 Aug 2024 12:04:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C9061198C9;
	Thu, 22 Aug 2024 12:04:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 15/20] remote: fix leaking config strings
In-Reply-To: <Zsb0nspisMs1Csl-@tanuki> (Patrick Steinhardt's message of "Thu,
	22 Aug 2024 10:19:42 +0200")
References: <cover.1724159575.git.ps@pks.im>
	<97346d6f944e3587a08d96a5e1b4ead8df8a0bc0.1724159575.git.ps@pks.im>
	<xmqqy14pycyo.fsf@gitster.g> <Zsb0nspisMs1Csl-@tanuki>
Date: Thu, 22 Aug 2024 09:04:00 -0700
Message-ID: <xmqqcym0tuhb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 25E1D338-60A0-11EF-8DFD-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 21, 2024 at 10:58:55AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > @@ -2802,6 +2809,7 @@ void remote_state_clear(struct remote_state *remote_state)
>> >  	for (i = 0; i < remote_state->remotes_nr; i++)
>> >  		remote_clear(remote_state->remotes[i]);
>> >  	FREE_AND_NULL(remote_state->remotes);
>> > +	FREE_AND_NULL(remote_state->pushremote_name);
>> >  	remote_state->remotes_alloc = 0;
>> >  	remote_state->remotes_nr = 0;
>> 
>> As remote_state has two extra structures embedded in it, I wonder if
>> we should be clearing them in this function, but possibly it is
>> cleared elsewhere or perhaps in a later series?
>
> It is not yet part of any subsequent patch series, mostly because I
> didn't happen to stumble over such leaks yet. Both of the rewrites very
> much are leaky though, and would be hit when we use "insteadOf" or
> "pushInsteadOf" configs.

Yes, I was wondering if our test coverage for the feature is
lacking.  In a sense, leaks from these insteadOf configuration
variables are tiny and uninteresting, compared to how much it
bothers me to find us not testing these often used features.
