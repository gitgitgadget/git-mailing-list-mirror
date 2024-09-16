Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905A315B570
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726512981; cv=none; b=O1eFqPr7iZzOk/MjpTTMtjOIr/Ikol7RTAOwowH8Rf5F6xrX+wAWM3I4qjrUXSB2fcAmBq+39JuChBhZFWa1IA7NtMqMejYhyMc1KG4CzrPGOM7YV2zWO+rjbsmV4sGr2IiQRWaxT4nh1UQ24t6l9dTQOQ9TRLKCt5jK8XY87wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726512981; c=relaxed/simple;
	bh=ob5AQVHj2AxPKMH4l8b7MnVQpiBfc4WvFOL0UsF4PFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iXnNPjXGyQ/xw3xv54sPfdnDHeNeIODj0Wyr7Xg6/6IIl2zymKhBtDutsa36cibUHlYd7ufP48tPRdQVGSgQbLnuJXXpa90Jo0GLy/pnLzxvQ4Nj1zyJj6Rv7NcYXEusVkFYclKp6p013qjM3U+USaFSxLwmuVRN4l3484BVu88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AvQjURFH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AvQjURFH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 638AC368C6;
	Mon, 16 Sep 2024 14:56:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ob5AQVHj2AxPKMH4l8b7MnVQpiBfc4WvFOL0Us
	F4PFc=; b=AvQjURFHjTXN4LktmVenxpOa3sjWyHKbwvANjNZOLVNsjYrrH0gjai
	/9+0hthnDVKXVy18wQdRLELW+Zln7+R88Duh8NV/L4MDuqWkv8d0UQPb1zaJGe4q
	7mlOqHAo3hhnhjPmbbseHX7/ljfHIeaJu8ymEnG3t5GCOQp4kK0V4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C674368C5;
	Mon, 16 Sep 2024 14:56:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4F16368C4;
	Mon, 16 Sep 2024 14:56:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] apply: refactor code to drop `line_allocated`
In-Reply-To: <0427cb72507bba7ed62d13a5523fea351a0cb35f.1726470385.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 16 Sep 2024 09:10:09 +0200")
References: <cover.1726470385.git.ps@pks.im>
	<0427cb72507bba7ed62d13a5523fea351a0cb35f.1726470385.git.ps@pks.im>
Date: Mon, 16 Sep 2024 11:56:16 -0700
Message-ID: <xmqqldzrmnqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5AEFF16A-745D-11EF-9900-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Refactor the function to use memmove(3P) instead, which allows us to get
> rid of this double bookkeeping. We call this function at most once per
> image anyway, so this shouldn't cause any performance regressions.

Don't we call remove_first_line() as long as leading is larger than
trailing repeatedly?  Is "at most once" accurate?

As to the correctness, I think nobody takes the address of an
element in the line[] array and expects the address to stay valid
across a call to remove_first_line(), so this should be safe.

Thanks.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  apply.c | 33 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 19 deletions(-)
