Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264811EA6F
	for <git@vger.kernel.org>; Thu,  2 May 2024 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668606; cv=none; b=Yf4iyogY6cXAYxFWLTsdo/vLvEZODR40l484BA+MeeQg8+k+qnXTZ19ndfPlWsoHE3cUUUNgTbrT7JyZoGZ0L0ohGCpGJBEwfjQ7DDJcgY2iUoUV0DyBQK7rC3tEohs2GSD4WNa2pkjf9eol9RIwdo3KhDUZsRFG9MLGX5MCErs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668606; c=relaxed/simple;
	bh=1Jj0Hoqu5CnFHwK93dKv/CU0xpQz0ov8O4alKTD3VVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L3S/CczcvkIe4cqPlvLkjgYPxYcVLMXBuemk9Lr4Mde0mJC2iE06/nmBAdecwXRXDXAVQgMlRtj6R2dX1/+8bEdFLeDMKh+yOa9d1piE405CRFc5NsftJqdx7U4STYBYp+nBYkfbGn2e+SfW0/3xbzVCpNRYzuD4186M5GOB1j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kzSs6Dmf; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kzSs6Dmf"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D5F631FA1;
	Thu,  2 May 2024 12:50:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1Jj0Hoqu5CnFHwK93dKv/CU0xpQz0ov8O4alKT
	D3VVM=; b=kzSs6Dmf7tltSnYTwC1QhHfRx0vtjN1zkSAIdSavPCDJrl6CoHn1DP
	pookH6qdU69JGfbfm5iscozxlVli2hk0HLvDkk27l5ZVuQPnxZuOivYD4Bb4n1lz
	i8/PrbS96OgLPFrk6ha7KqN1tzmj+HiWaSrCUJ2Vp+eGz4V38BhbU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 54CB431FA0;
	Thu,  2 May 2024 12:50:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 460B531F9C;
	Thu,  2 May 2024 12:50:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  christian.couder@gmail.com,
  git@vger.kernel.org
Subject: Re: [PATCH v5 2/7] files-backend: extract out `create_symref_lock()`
In-Reply-To: <ZjNFBZOlcQNVYm8O@tanuki> (Patrick Steinhardt's message of "Thu,
	2 May 2024 09:47:17 +0200")
References: <20240426152449.228860-1-knayak@gitlab.com>
	<20240501202229.2695774-1-knayak@gitlab.com>
	<20240501202229.2695774-3-knayak@gitlab.com>
	<xmqq7cgdjig4.fsf@gitster.g> <ZjNFBZOlcQNVYm8O@tanuki>
Date: Thu, 02 May 2024 09:49:58 -0700
Message-ID: <xmqq8r0sf9ah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 03CA4E64-08A4-11EF-A4B7-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, May 01, 2024 at 03:06:19PM -0700, Junio C Hamano wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>> 
>> > +	if (!fdopen_lock_file(&lock->lk, "w"))
>> > +		return error("unable to fdopen %s: %s",
>> > +			     get_lock_file_path(&lock->lk), strerror(errno));
>> > +
>> > +	if (fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target) < 0)
>> > +		return error("unable to fprintf %s: %s",
>> > +			     get_lock_file_path(&lock->lk), strerror(errno));
>> 
>> error() is end-user facing, so "fprintf" is probably a bit too
>> precise?  "fprintf" -> "write to"
>> 
>> Also we may want to make them (not just this new message but other
>> error() messages in related code paths) localizable but that is
>> probably beyond the scope of this topic.
>
> It only occurred to me now, but shouldn't we also support passing in a
> `struct strbuf *err` here? The transactional code doesn't want us to
> print error messages to `stderr`, but always supplies a buffer.

Sounds sensible.  Thanks.
