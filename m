Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECBAEEB5
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851612; cv=none; b=WzuVZHjWqOifPsHheetRb7/QiPdTPoHKh0BGPeMz21uYcEOldwUbBRr+FKT10ATXZ5JdpIoE0Pi6D/5D2EyV2P3SAVMuSVHIDr4NnBR5dDZTa/xmPkjtb6FHrwrnTqjj/cvjzIeVipO3Z1fIM4dPppars3i/sJbNoKF45aK0bQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851612; c=relaxed/simple;
	bh=oM0EjMM9e9tybldPfD8iUX0fiCnhpLuQwV0SGb9or6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mjDWVoHs2GhF6qJEVUKO26FrXfQnLExnyoz3/UWEp598Ynyo5sg2JtmZmerdfshG7Cpc6m/CE4U2H5JXOAkufa8AT1y1HSmQzF4KK0KGgepF4eSy7o66SCxdFWP0sBLlqGqqA1W8rDtk3teYv3Rox3XvJFonPsCTVCdnniO+cxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xQkKeuHD; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xQkKeuHD"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 55D0E35F9D;
	Fri, 20 Sep 2024 13:00:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oM0EjMM9e9tybldPfD8iUX0fiCnhpLuQwV0SGb
	9or6w=; b=xQkKeuHDkL5hA4UJluPdhnfxJctHzQ4xClooWjJZTNQjgsC+EQt3Mh
	t82dac9KAtuI8ISbBPxTVL/SiU9dwfg0mqg+yo1n+TBMYBh7thwJO59iPPSjaCTl
	B9yz4z6/6f3bWhLOzXSYKetdzh9C/jJ8bsEY396DyV1TphV25goD4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DAF5B35F9A;
	Fri, 20 Sep 2024 13:00:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7446135F93;
	Fri, 20 Sep 2024 13:00:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/23] builtin/pull: fix leaking "ff" option
In-Reply-To: <747c9a76a288d6fbfad85203e0bccaaf4b6db282.1726484308.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 16 Sep 2024 13:45:52 +0200")
References: <cover.1726484308.git.ps@pks.im>
	<747c9a76a288d6fbfad85203e0bccaaf4b6db282.1726484308.git.ps@pks.im>
Date: Fri, 20 Sep 2024 10:00:04 -0700
Message-ID: <xmqq4j6a45wr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C95EE644-7771-11EF-9F7B-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The `opt_ff` field gets populated either via `OPT_PASSTHRU` via
> `config_get_ff()` or when `--rebase` is passed. So we sometimes end up
> overriding the value in `opt_ff` with another value, but we do not free
> the old value, causing a memory leak.

Good eyes.

I have to wonder if it will come back and bite us again that
OPT_PASSTHRU does not pass through but creates a new copy, while
OPT_STRING borrows from the argv[].  I guess that we could check in
parse_options_check() if the address of the same variable is passed
to both OPT_PASSTHRU (giving it a piece of memory we are responsible
for freeing) and OPT_STRING (giving it a piece of memory borrowed
from argv[], and would trigger a failure if given to free()).

In an extremely longer run, I wonder if it becomes necessary for us
to also make OPT_STRING to make a copy (which means strings that
come from the configuration and from parsing the command line
arguments are all allocated ones that we are responsible to free).

Thanks.
