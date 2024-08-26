Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA26198A02
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693332; cv=none; b=GLJC17rB2FY+IJdSm3hyObrNPEWRwLnfjhZGgPvdOKHCRhubJlijsRRT6qAy6kwjm600504gMwgHLOUokEewuXketqlNudgnOJnEvTBuumfvYGgn+Muc1t3HJBWb35L38y2gNyxWhqYVN0AXcyBXoYWq9b7eUyyvcu08mP5/h/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693332; c=relaxed/simple;
	bh=ap9ZQ+CC6HkdMtSZUrgR2yGyJhzz4WepKi1HAUKjDGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PHkGP2cCOwUbMrbIOSOpJmWkIanI03oyToXxWBYS8rHXbaKUxObSUfb0cnFXZ6HTCgbcKOcccqFyWmDBtKRn1+mojCTMSK27VkEOww9eg6LWkGVFiFSagTO5AgD6a4z6xlYOkBd+zFcd5uZE3K4K3YpH07rZmLepnktRcmSXJkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WibDXCVS; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WibDXCVS"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 507102AFAE;
	Mon, 26 Aug 2024 13:28:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ap9ZQ+CC6HkdMtSZUrgR2yGyJhzz4WepKi1HAU
	KjDGk=; b=WibDXCVSc2jw8jIKrueq1zg0kSQQFkojmQBbeJgSQvGz+/CtYaj/ye
	bMjFkW04Te1urY+PLpesE1f9Uxv0F0KB1Mmc2OeipzwC0/jP4AY2DprLTxawhppj
	Uyihtn/HkVLqfmp4gjdf5uURleDaQfkk9+Hk/nV4oC3wnuNZey09c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 491442AFAD;
	Mon, 26 Aug 2024 13:28:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B05032AFAC;
	Mon, 26 Aug 2024 13:28:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tao Klerks <tao@klerks.biz>
Cc: git <git@vger.kernel.org>
Subject: Re: Sensible way to see what objects are being fetched just-in-time
 in a partial clone?
In-Reply-To: <CAPMMpog7=ZnhJhrgZFwzRZibLtK1-LyOhsrp5c4O85ocRFDZxw@mail.gmail.com>
	(Tao Klerks's message of "Mon, 26 Aug 2024 18:38:29 +0200")
References: <CAPMMpog7=ZnhJhrgZFwzRZibLtK1-LyOhsrp5c4O85ocRFDZxw@mail.gmail.com>
Date: Mon, 26 Aug 2024 10:28:48 -0700
Message-ID: <xmqqv7znjir3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A828C210-63D0-11EF-A637-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Tao Klerks <tao@klerks.biz> writes:

> This was a sucky process though - and I was very surprised that I
> couldn't see what was being fetched (what the stdin content to the
> just-in-time fetch calls were) with any of the trace env vars that I
> was able to find documented: GIT_TRACE, GIT_CURL_VERBOSE,
> GIT_TRACE_PERFORMANCE, GIT_TRACE_PACK_ACCESS, GIT_TRACE_PACKET,
> GIT_TRACE_PACKFILE, GIT_TRACE_SETUP, GIT_TRACE_SHALLOW

Yeah, lazy fetch codepath seems to be, eh, not quite well polished
yet.

I am kind of surprised that there is no trace2() events around
promisor_remote_get_direct() or its callers.  Perhaps it is a good
idea to add one to log how often it is triggered, and how large a
batch the callers of the function is making?

Unlike the diff machinery, blame does not have a prefetch machinery.
I am glad that somebody is looking at it.
