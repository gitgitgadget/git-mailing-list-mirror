Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AC8155335
	for <git@vger.kernel.org>; Mon, 13 May 2024 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617362; cv=none; b=syZZccSJKcQjqqIzamPgqMAQxj34SlG8buyNFqyZi95ndQsYEJh7X8cPltu8sxdsLlBrnKoFdBLxMcadhXlelpoxJOMOaO2lZN8ELZqh5AshEHNspbRdTh3ihpfksXRIs2G6zerVer9KAmfnip7WrtFlm1iUYMd5VHIqW79W7X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617362; c=relaxed/simple;
	bh=YpWRlkPtvWp/0mv7skWt+8fd4jw/HhvikuAcxmCMSFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WAiiO7wuxbZ4gK3ujlRUzZnaroPlopAb5v/8SEhQ+eoNVB/GLP0eo/YyiQVf9oJf1DG3/RXGTLbrwwcSNDfNLWy9tLEZHJ5fmC/he3z+FMCEU7mCAdeHeP1d05tUm8uVvf1T8tqVhTjg/5PWBhm76ib9d3FKl+ySoc53N4fHU1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=irrgbS32; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="irrgbS32"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F123226243;
	Mon, 13 May 2024 12:22:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YpWRlkPtvWp/0mv7skWt+8fd4jw/HhvikuAcxm
	CMSFQ=; b=irrgbS32PqctfcocZdRuR0UiJGd3c2C2Ok9bNdKaO5EuaQJ0Fkl0gV
	jrE+go3ITDunChvoxAmqwmoV+a1zxlPD9DOouQSbQrHfrIhCS+mHKrsouvIGLoAV
	QXl247k5r2BfzUeO4QDuPdeD6Nkq7rWg09FieGjhLxB+667Y1oBSM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E701526242;
	Mon, 13 May 2024 12:22:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 510E326241;
	Mon, 13 May 2024 12:22:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 10/11] reftable: make the compaction factor configurable
In-Reply-To: <ZkHHIgyeWq9FCYuq@tanuki> (Patrick Steinhardt's message of "Mon,
	13 May 2024 09:54:10 +0200")
References: <cover.1714630191.git.ps@pks.im> <cover.1715336797.git.ps@pks.im>
	<9d4c1f034038df2ae232b6665a0d9d7ee5833c5f.1715336798.git.ps@pks.im>
	<xmqqy18h1fm4.fsf@gitster.g> <ZkHHIgyeWq9FCYuq@tanuki>
Date: Mon, 13 May 2024 09:22:38 -0700
Message-ID: <xmqqmsotheb5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 04405A74-1145-11EF-BE21-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> So this may be good enough for now, and when we gain the ability to
> parse floats we may convert this to accept floats, as well. An
> alternative would be to convert this to percent, where the default value
> would be 200. That should give sufficient flexibility without having to
> introduce floats.

There already is an established way to specify float with arbitrary
precision on the command line if we limit the value to 0..1, by the
way.

https://lore.kernel.org/git/Pine.LNX.4.58.0505191516350.2322@ppc970.osdl.org/

It is amusing to revisit an ancient discussion thread.  I can see,
on the same thread in the discussion following that message, that
back in May 2005, we were discussing "intent to add" that did not
get invented until mid 2008 already ;-).
