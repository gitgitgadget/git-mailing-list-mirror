Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705013B597
	for <git@vger.kernel.org>; Fri, 10 May 2024 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375522; cv=none; b=WSmYw4lxVB/WXeAxYspaWOjRsArv/P6ew8fOIPgklQgRiOBY82HhWxtOFRZ7/yFn9YlY7lf6ssWqacKahAE4HL1eA+OPB+Kfo99l/lT2yX6Htvi9IXMJYXEFfHRUJPuf8h6o8wIY+SJMkSS7R/wafLNxIq54vgYQsACblufnoNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375522; c=relaxed/simple;
	bh=SEaxB6lkYaW1vdYakWNrwilC/q6ukNz59a/Wth5b39w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ixu9QIT655zJwW/F+CV4kHvqoLZb0q79shjuqPMaLlT28GHX5HBjlY7JStLz6rcE4kpXr4joVhgLm8gYSQpPQoacOGnXqyiuqZpVPRZnsW8JsusQbT/eqLpXnfxvwmXkIeCfVcfDNho4gg5mLeQnJg97S13hDbyQEFqhwXsXtog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kjp0wh+K; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kjp0wh+K"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DF44936E70;
	Fri, 10 May 2024 17:12:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SEaxB6lkYaW1vdYakWNrwilC/q6ukNz59a/Wth
	5b39w=; b=kjp0wh+Khi/eZEdhW8eLmeqBvGSIBZpQ0JaCplSd2kKlnJ4YsO5XAq
	0Pat3Hp4O5MIspducAqGivEb2Y4s4rDChwx5G3JixWM/Dx3fyg5DdHPImz2L8m4o
	F/pOvIErGEKPQDHItnnOJjmYryAS+OK/sYgYd31Q0iNAF5z1fKVr8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CD7E636E6F;
	Fri, 10 May 2024 17:12:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 321A036E6E;
	Fri, 10 May 2024 17:11:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 02/11] reftable: consistently pass write opts as value
In-Reply-To: <e6f8fc09c282e620a331a737c30a190107c76996.1715336798.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 10 May 2024 12:29:25 +0200")
References: <cover.1714630191.git.ps@pks.im> <cover.1715336797.git.ps@pks.im>
	<e6f8fc09c282e620a331a737c30a190107c76996.1715336798.git.ps@pks.im>
Date: Fri, 10 May 2024 14:11:55 -0700
Message-ID: <xmqqy18h2wys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EF1BE76A-0F11-11EF-B133-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We sometimes pass the refatble write options as value and sometimes as a
> pointer. This is quite confusing and makes the reader wonder whether the
> options get modified sometimes.
>
> In fact, `reftable_new_writer()` does cause the caller-provided options
> to get updated when some values aren't set up. This is quite unexpected,
> but didn't cause any harm until now.
>
> Refactor the code to consistently pass the options as a value so that
> they are local to the subsystem they are being passed into so that we
> can avoid weirdness like this.

Turning pass-by-reference to pass-by-value of a large structure is a
rather huge hammer to ensure that the structure is not modified
(qualifying the pointer with "const" is).  Consistency is good, but
I am not sure offhand if this is making things consistent in a good
way.
