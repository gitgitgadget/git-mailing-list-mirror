Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9C51CD2A
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717873091; cv=none; b=otNA7hTTA7BtZzT92MJP84ze5mnlBDOXI8vt8kocEy4nHsoYlVWN4uKkEPrWchzx7CZMTaZ0T012AuIx/ZdbbCOMruse1l/leaCnjDftx+tHCtucrT8dQc/zn1DT49vTTMjL+ZRuQHyWanwbKxD0Gg56C/osIgA5WqGSETanT4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717873091; c=relaxed/simple;
	bh=VG/sqjx1MZnAlcwxC0iO9rLPil8Y8Lr6vhDwsAmJu+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q/o6cVY3cxaafbWbFjyb0QDXkAlVRgRvb1geM36WNMG6buL3TB/F6wotYYe4yXnLuMYWgMuKVyBZpG9W+jYtpJdc7h2d9w7Xc+IrQCMgQRiOOkireAio8jq0pJAhAKc2Tvg98KoezdndCsMjG2uScM6yKyS20OfiDu0aUlxNBD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=q47MCqIJ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q47MCqIJ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D4DAD33288;
	Sat,  8 Jun 2024 14:58:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VG/sqjx1MZnAlcwxC0iO9rLPil8Y8Lr6vhDwsA
	mJu+Q=; b=q47MCqIJ3jPhhnlOH9CgX2SdFI1uW9aCFYWedCEbPhiHCfsdb1GEYY
	sudy5yxkE6a3pjoPk0wXEZ6U9oxkghDpnzOTjQ3MTw6DkyZ87JnnBmGMWg2JjPo2
	YmR4YFHOj7ZhNquykuyNwm8BOwUI3zP9V3hpUkBcP8j7D9Y25kG1I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BDCC033287;
	Sat,  8 Jun 2024 14:58:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6892833286;
	Sat,  8 Jun 2024 14:58:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "darcy via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  darcy <acednes@gmail.com>
Subject: Re: [PATCH v3] date: detect underflow/overflow when parsing dates
 with timezone offset
In-Reply-To: <xmqq1q58ejnw.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	07 Jun 2024 10:40:03 -0700")
References: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
	<pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
	<xmqq1q58ejnw.fsf@gitster.g>
Date: Sat, 08 Jun 2024 11:58:04 -0700
Message-ID: <xmqqcyorcldv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0A5F8180-25C9-11EF-9B29-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> +/* timestamp of 2099-12-31T23:59:59Z, including 32 leap days */
>> +static const time_t timestamp_max = ((2100L - 1970) * 365 + 32) * 24 * 60 * 60 - 1;
>
> I wonder if this should be of timestamp_t type instead, as the check
> is done against *timestamp in parse_date_basic() where *timestamp is
> of type timestamp_t to match?

The CI build on Windows tells me that my worry was warranted.

  https://github.com/git/git/actions/runs/9424299208/job/25964281907#step:4:643

(GitHub seems to show the breakage details only to those who are
logged in, so you'd need to be logged in to visit that link)


  Error: date.c:873:75: integer overflow in expression of type 'long int' results in '-192522496' [-Werror=overflow]
    873 | static const time_t timestamp_max = ((2100L - 1970) * 365 + 32) * 24 * 60 * 60 - 1;
        |                                                                           ^
  Error: date.c:873:1: overflow in constant expression [-Werror=overflow]

