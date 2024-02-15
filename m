Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3CA41
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016894; cv=none; b=gd2cI1eSJsbWpu3/9Qy5wQcOdp9e66+GMPdlt1+YgkMjksq9XdxgVmyk2DeL4RqNDrtJ512ers566aiA/BihJlVhd6MVyotxPWkBkbowxLSjmgeNAvRyRlKLkkROF6Ge4JW3z/DKpQ5O122M+lrsBq/uzAOI41fXuYzhsZ8kxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016894; c=relaxed/simple;
	bh=yG6ICIFqz7pqivmfo173y9KUQIFRYLoT/QNBd1412No=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pYc0DXLQgmLfff9vwTrpaaMPFAFsAQEuuWsTEaDK4kv9grJzADUCn/hOtagzQta6J+hn6t2LGSOP0wGfsE8Pv0VNgAtMRjV9Md73tb7cPmWuRtNl9wgVb2bO8y2l/n7Ons7lyOGXCHrtiSyrHA4y2KYnqSqFEFmQ0BvrXJ/GBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IsApDgzI; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IsApDgzI"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 64B151DDF4E;
	Thu, 15 Feb 2024 12:04:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yG6ICIFqz7pqivmfo173y9KUQIFRYLoT/QNBd1
	412No=; b=IsApDgzIQbXP6i8fjsFCkaSvRi6YTsB1vz0OYW37XG3Prm5eakZN07
	Qt8lXGDu3eAF+162ZEXurmLASa5qq77eArr/7uWpPunlxkty7Ct0RILJrmYP0OE0
	9y+p+36Hgl5rhm4g4rST25j4/nSF3TKZqthipi47lBNh+NYAjxjJk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B9371DDF4D;
	Thu, 15 Feb 2024 12:04:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B56F51DDF4C;
	Thu, 15 Feb 2024 12:04:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git: --no-lazy-fetch option
In-Reply-To: <20240215053056.GD2821179@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 15 Feb 2024 00:30:56 -0500")
References: <xmqq1q9mmtpw.fsf@gitster.g>
	<20240215053056.GD2821179@coredump.intra.peff.net>
Date: Thu, 15 Feb 2024 09:04:51 -0800
Message-ID: <xmqqv86pslos.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 55EDEBC2-CC24-11EE-A6DE-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> On Thu, Feb 08, 2024 at 03:17:31PM -0800, Junio C Hamano wrote:
>
>> Sometimes, especially during tests of low level machinery, it is
>> handy to have a way to disable lazy fetching of objects.  This
>> allows us to say, for example, "git cat-file -e <object-name>", to
>> see if the object is locally available.
>
> That seems like a good feature, but...
>
>> @@ -186,6 +187,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>>  			use_pager = 0;
>>  			if (envchanged)
>>  				*envchanged = 1;
>> +		} else if (!strcmp(cmd, "--no-lazy-fetch")) {
>> +			fetch_if_missing = 0;
>>  		} else if (!strcmp(cmd, "--no-replace-objects")) {
>>  			disable_replace_refs();
>>  			setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);
>
> This will only help builtin commands, and even then only the top-level
> one. If I run "git --no-lazy-fetch foo" and "foo" is a script or an
> alias, I'd expect it to still take effect. Ditto for sub-commands kicked
> off by a builtin (say, a "rev-list" connectivity check caused by a
> fetch).
>
> So this probably needs to be modeled after --no-replace-objects, etc,
> where we set an environment variable that makes it to child processes.

Yuck, I was hoping that we can get away with the tiny change only
for builtins,but you're right.
