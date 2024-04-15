Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CEE156F4B
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224811; cv=none; b=KwPUTwFtAllBXwZDjpS4f4i6kHZYMlLoSN9TJvPfi0HpGvuLDWccUczkJ1woSn9fjMEhxUywb4wnxchg+5stfjO3XnQNJVIA+2Bx3eZVfZCWZB0kpsXBlnqfi5IL6VsjL7Ya1El5ng7SqhBoC5QFJF3RjL0Kw6z/deq3jA68nV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224811; c=relaxed/simple;
	bh=8I2WcavbdDO3d+CXBv/vD5dN9IxbUdncI0aw7TotJ7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rq5BSNLUCNIyNmViSWj0GHioXnticudh8aVfWVgvFK4LKkOy8ganjWiuCVk+8d8EKy2oXvcInPIqzUV5nh2jEE6WcCvt4dAHdwIGRqq5MWmr63JCFWdoWo55D1fdzyVbkAqk6aCzhtLg1lQfl0ecFI8QsYGosMZYl/j6Cnhex9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WivQq95m; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WivQq95m"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 13F4C2B3A6;
	Mon, 15 Apr 2024 19:46:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8I2WcavbdDO3d+CXBv/vD5dN9IxbUdncI0aw7T
	otJ7U=; b=WivQq95mHR7OCUgCnSpaJSviNdg6Wl/v6bzAsaE77gdIB8nVBtv22l
	FJtPXwO80iFbDvxjWJz8bmFFkeX+4rGZW0FxiiH+T/uQroFOw1mFK45zauhHgwJ+
	1QNPqZHUqD5YRkEGcgfzGEl0kmKWux4IvI+iVE8jjDXcGWyg3TQxM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CE622B3A5;
	Mon, 15 Apr 2024 19:46:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 134482B3A1;
	Mon, 15 Apr 2024 19:46:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v2] pack-bitmap: gracefully handle missing BTMP chunks
In-Reply-To: <Zh2vhDraCnqw4YFL@nand.local> (Taylor Blau's message of "Mon, 15
	Apr 2024 18:51:48 -0400")
References: <5933a302b581670183a6f3c881f62e96f61ff192.1712642313.git.ps@pks.im>
	<a8251f8278ba9a3b41a8e299cb4918a62df6d1c7.1713163238.git.ps@pks.im>
	<ZhzqeRIcyR3lmBme@tanuki> <xmqqil0io762.fsf@gitster.g>
	<Zh2vhDraCnqw4YFL@nand.local>
Date: Mon, 15 Apr 2024 16:46:44 -0700
Message-ID: <xmqq8r1ei3yz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6B617464-FB82-11EE-A459-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Apr 15, 2024 at 10:41:09AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> >> Helped-by: Taylor Blau <me@ttaylorr.com>
>> >> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> >
>> > Junio, it would be great if we could still land this fix in Git v2.45
>> > given that it is addressing a regression in Git v2.44. This of course
>> > assumes that the current version of this patch looks good to Taylor.
>>
>> Indeed.  It would be nice to see an acked by or something.
>>
>> Will queue, in the meantime.  Thanks for a ping.
>
> I took a look, and I think the patch is good. I have a couple of notes
> on the test that I would prefer to see addressed before merging it down,
> though.

Thanks.
