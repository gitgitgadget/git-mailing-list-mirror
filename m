Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E105D8E4
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 22:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369792; cv=none; b=DJHrpd0jyjl3r0qqX4vdDmKqPv1ZZ8vyczfs1+cj7IFwRo37VwOJ9ZCRtmD8qQG6C2O+bFTLA7N4SnywqWL5dj3hPtdJLH6MULzqFJ1J8dKtlnjrZEQxvwuDYJ5MkxwuEdu/5tddejPpxp+44AT5qBzl0ffWYEHR3cPs14TF8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369792; c=relaxed/simple;
	bh=S9nbctHucSoQoivqRP5/qw5E7mVz0BdxLDSI6Iq3OCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vBBSo2FtcSfYfydgplu7ePklWwYgAP/Vl33INncPmnndKiQWffDpSGYkYeHhAP24PAP7HtucksGl0Q5RDJICHcAbA1Zc25SYAvOSscQj4X9XAykS6c4N4s+PbUFl5ihX7HA36ehkA9zRIALvB0/VLsGsZqErDOe6adnnx+1b9vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZXAi62FI; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZXAi62FI"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 61B8A22A0F;
	Wed, 13 Mar 2024 18:43:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=S9nbctHucSoQoivqRP5/qw5E7mVz0BdxLDSI6I
	q3OCY=; b=ZXAi62FI51ZCHFxzFfJegc90bWXY0mIyF8DKS/+1GOCwAwEMc5hMVv
	rDTNe96LtnWzeLJcj7sYlybhti5pTg/1iSvgAg8m1FMoMaQnDvWtk33+1yjPfQhZ
	xKnCpXFh/jprV164tZcQLhFiY2iS1o9o+vweF39WJqJp7cQ/29kec=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 466EE22A0E;
	Wed, 13 Mar 2024 18:43:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5DAF822A08;
	Wed, 13 Mar 2024 18:43:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Beat Bolli" <bb@drbeat.li>
Cc: git@vger.kernel.org,  Beat Bolli <dev+git@drbeat.li>,  Michael Osipov
 <michael.osipov@innomotics.com>
Subject: Re: [PATCH v2] date: make "iso-strict" conforming for the UTC timezone
In-Reply-To: <20240313222922.11170-1-dev+git@drbeat.li> (Beat Bolli's message
	of "Wed, 13 Mar 2024 23:29:22 +0100")
References: <xmqqwmq6asrx.fsf@gitster.g>
	<20240313222922.11170-1-dev+git@drbeat.li>
Date: Wed, 13 Mar 2024 15:42:58 -0700
Message-ID: <xmqqmsr169e5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0B753998-E18B-11EE-B404-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Beat Bolli" <bb@drbeat.li> writes:

> ISO 8601-1:2020-12 specifies that a zero timezone offset must be denoted
> with a "Z" suffix instead of the numeric "+00:00". Add the correponding
> special case to show_date() and a new test.
>
> This changes an established output format which might be depended on by
> scripts. The original patch 466fb6742d7f (pretty: provide a strict ISO
> 8601 date format, 2014-08-29) mentioned XML parsers as its rationale,
> which generally have good parsing support, so this change should be
> fine.

"fine." -> "fine for that particular usecase."

Unlike in 2005, we no longer write our features only for our own
single use case that motivated it.  I do not think it is possible
to make this change without breaking some real script, and admitting
this is a breaking change and we are knowingly doing so is probably
better in the longer term.

Saying "this should be fine" in the log will give future developers
room to consider reverting it, and while they are free to make such
a decision based on the reality at their time in the future, we
should give them a data point from our point of view: we know it may
break somebody but we are still doing so knowingly as upside to
adhere to a published standard and help those users who adhere to
the same standard is more valuable then the unfortunate script that
bended themselves to match our earlier mistake.

Thanks.
