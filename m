Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841F4C8B
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715273515; cv=none; b=n0JkjWlO9N3uLqKUfXhAACBbBxCBTNN3NtTuI9oM0r/CDDXx9AAwYJtHbdVcX1RuU+zoHVBkU1tFTMf86e+rDiOJIxFrAYe56kVk7AFw9NBXdbdxwuUe/TA0/gh8nbf02sdjfrQ5DipMDmsD39oGN/1qR0O3vqxSuBD2CRWmQhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715273515; c=relaxed/simple;
	bh=5+k5HdWuy3exBtsDaVoZ8uAcUxbG3Fq65pPXxOSHfvE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K3QDzwau+jhTqOJ/vSmSM8xM8QC0Jf/n9N6acZF0CLWKcxLrD61y4UinPIYgx2ZAVXWYWflOzaAELA+Ld+xJG4R9k4nCP+0vm24a9ugQncxHqOsXB+VPNZbjkaEaAz5idoPQdtcLu5B8fvVSNPQfeOhEhz3Evwbzs00hVnXByG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=o208851M; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o208851M"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 47AF037935;
	Thu,  9 May 2024 12:51:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5+k5HdWuy3exBtsDaVoZ8uAcUxbG3Fq65pPXxO
	SHfvE=; b=o208851Mt1JG1mY7MWajr2GQrTId31Irgaj+H51yd352UVq+o+OYnN
	0RVW9mbkxKx7aeIXraiid4nmi4fy5tgtoxG+vVTkJ22HKogwcp6zfiF84pJdPkwq
	6zArCiMW4FUXE6P8i9J37NNfTz+4SNzpCZt8zqz+5b0ELlrZQV5zA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FDFA37934;
	Thu,  9 May 2024 12:51:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE8CA37933;
	Thu,  9 May 2024 12:51:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/4] http: add the ability to log progress
In-Reply-To: <20240509163414.GA1708095@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 May 2024 12:34:14 -0400")
References: <20240508124453.600871-1-toon@iotcl.com>
	<20240508124453.600871-3-toon@iotcl.com>
	<20240509163414.GA1708095@coredump.intra.peff.net>
Date: Thu, 09 May 2024 09:51:51 -0700
Message-ID: <xmqqbk5fudw8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6FB21668-0E24-11EF-8EFA-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> On Wed, May 08, 2024 at 02:44:51PM +0200, Toon Claes wrote:
>
>> @@ -1457,6 +1458,9 @@ struct active_request_slot *get_active_slot(void)
>>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
>>  	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
>>  	curl_easy_setopt(slot->curl, CURLOPT_RANGE, NULL);
>> +	curl_easy_setopt(slot->curl, CURLOPT_NOPROGRESS, 1L);
>> +	curl_easy_setopt(slot->curl, CURLOPT_XFERINFODATA, NULL);
>> +	curl_easy_setopt(slot->curl, CURLOPT_XFERINFOFUNCTION, NULL);
>
> These last two CURLOPTs appeared in 7.32.0, but our INSTALL doc claims
> to support back to 7.21.3. Before that you're supposed to use
> PROGRESSFUNCTION instead, which has a slightly different signature. I
> think you could support both, though it would also be OK to just disable
> this extra progress for antique curl.
>
> It might also be reasonable to just bump to 7.32.0 as our minimum. The
> last bump was recent via c28ee09503 (INSTALL: bump libcurl version to
> 7.21.3, 2024-04-02), and the version picked there was arbitrary-ish (it
> was something we had happened to depend on accidentally). 7.32.0 is
> itself almost 11 years old now.

The last bump was 7.19.5 (May 2009, 14.9 years) to 7.21.3 (Dec 2010,
13.3 years).  As 10 is a nice round number, we may even be able to
pick randomly a slightly newer one, say, 7.35.0 (Mar 2014, 10.0
years).

It is in a sense an inferiour way to pick the minimum dependency
than the choice of 7.32.0, which is backed by "we use this and that,
which appeared in that version", of course.

But being able to update mechanically without thinking is tempting,
and as long as the horizon is sufficiently long, such an approach
would not have a huge downside.

Thanks.
